import requests
import json
import time
import os
import base64

from pathlib import Path
from api.commands import Commands
from api.settings.testconfig import TestConfig


class Rest(Commands):

    def __init__(self, cli, target_type, target_name):
        super().__init__()
        self.cli = cli
        self.profapi = cli.professos_url
        self.target_type = target_type
        self.target_name = target_name
        self.config = TestConfig()
        self.testId = ""
        self.testObj = None
        self.initialized = False
        self.config_dir = "config/" + self.target_type + "/" + self.target_name
        self.result_dir = "results/" + self.target_type + "/" + self.target_name
        self.session_dir = ""
        self.session_name = 'default'
        self.config.load_json(self.config_dir + "/config.json")

    @property
    def session_name(self):
        return self.__session_name

    @session_name.setter
    def session_name(self, value):
        self.__session_name = value
        self.session_dir = self.result_dir + '/' + self.__session_name

    def show_config(self):
        self.cli.poutput('-'*20)
        self.cli.poutput('Session: {}'.format(self.session_name))
        self.cli.poutput('-'*20)
        self.cli.poutput('')
        self.cli.poutput('Discovery is {} [{}]'.format('enabled' if self.config.discovery else 'disabled', 'config discovery'))
        self.cli.poutput('Dynamic Client Registration is {} [{}]'.format('enabled' if self.config.dynamic else 'disabled', 'config dynamic'))
        self.cli.poutput('Professos {} expose API before test [{}]'.format('does' if self.config.pre_expose else 'does not', 'config pre_expose'))
        self.cli.poutput('')

        if len(self.testId):
            self.cli.poutput('Professos Test ID is {}'.format(self.testId))

        if len(self.config.test_id):
            self.cli.poutput('Test ID is {} [{}]'.format(self.config.test_id, 'config test_id'))
        else:
            self.cli.poutput('Test ID is currently not set [{}]'.format('config test_id'))
        if len(self.config.skip_tests):
            self.cli.poutput('Following tests will be skipped: {} [{}]'.format(self.config.skip_tests, 'config skip_tests'))
        else:
            self.cli.poutput('No tests will be skipped [{}]'.format('config skip_tests'))
        self.cli.poutput('')

    def create(self):
        url = self.profapi + '/' + self.target_type + '/create-test-object'

        if len(self.config.test_id):
            header = {"Content-type": "application/x-www-form-urlencoded"}
            payload = "test_id=" + self.config.test_id
            response = requests.post(url, data=payload, headers=header)
        else:
            response = requests.post(url)
        if response.status_code != 200:
            raise requests.RequestException('POST {} Error {}'.format(url, response.status_code))
        response_json = json.loads(response.text)
        self.testId = response_json["TestId"]
        self.testObj = response_json

        self.cli.poutput("Create new test plan: TestId = {}".format(self.testId))

    def delete(self):
        if len(self.testId) == 0 or not self.initialized:
            return
        url = self.profapi + '/delete-test-object'
        header = {"Content-type": "application/x-www-form-urlencoded"}
        payload = "test_id=" + self.testId
        response = requests.post(url, data=payload, headers=header)
        if response.status_code != 200 and response.status_code != 204:
            raise requests.RequestException('POST {} Error {}'.format(url, response.status_code))
        self.cli.poutput("Delete test plan ID: {}".format(self.testId))

    def set_config(self):
        url = self.profapi + '/' + self.target_type + '/' + self.testId + '/config'
        header = {"Content-Type": "application/json"}
        jsonFile = open(self.config_dir + "/professos.json", "r+")
        jsoncfg = json.load(jsonFile)

        payload = self.testObj["TestConfig"]
        payload.update(jsoncfg)

        response = requests.post(url, json=payload, headers=header)
        if response.status_code != 200 and response.status_code != 204:
            raise requests.RequestException('POST {} Error {}'.format(url, response.status_code))
        self.cli.poutput("Updated config: {}".format(json.dumps(payload, indent=4)))

    def get_config(self):
        url = self.profapi + '/' + self.target_type + '/' + self.testId + '/config'
        header = {"Content-Type": "application/json"}

        response = requests.get(url, headers=header)
        if response.status_code != 200:
            raise requests.RequestException('GET {} Error {}'.format(url, response.status_code))
        self.cli.poutput("{}".format(json.dumps(response.json(), indent=4)))

    def expose_discovery(self, id=0):
        testStep = self.testObj["TestReport"]["TestStepResult"][id]

        test = testStep['StepReference']['Name']
        url = self.profapi + '/' + self.target_type + '/' + self.testId + '/expose/' + test

        response = requests.post(url)
        if response.status_code != 200 and response.status_code != 204:
            raise requests.RequestException('POST {} Error {}'.format(url, response.status_code))

    def learn(self):
        url = self.profapi + '/' + self.target_type + '/' + self.testId + '/learn'
        header = {"Content-type": "application/json"}

        jsonFile = open(self.config_dir + "/professos.json", "r+")
        jsoncfg = json.load(jsonFile)

        if not len(self.config.test_id) and self.target_type == 'rp':
            jsoncfg['HonestUserNeedle'] = jsoncfg['HonestUserNeedle'].replace('CHANGE_TEST_ID', self.testId)
            jsoncfg['EvilUserNeedle'] = jsoncfg['EvilUserNeedle'].replace('CHANGE_TEST_ID', self.testId)

        payload = self.testObj["TestConfig"]
        payload.update(jsoncfg)

        self.cli.poutput("Learn: {}".format(json.dumps(payload, indent=4)))

        response = requests.post(url, json=payload, headers=header)
        if response.status_code != 200:
            raise requests.RequestException('POST {} Error {}'.format(url, response.status_code))
        self.initialized = True

        result = response.json()
        if result["TestStepResult"]["Result"] != "PASS":
            self.cli.poutput("Learn failed: {}".format(json.dumps(response.json(), indent=4)))
            raise requests.RequestException("Test Failed")

    def runAllTests(self):
        for i, item in enumerate(self.testObj["TestReport"]["TestStepResult"]):
            if self.config.skip_tests:
                if i not in self.config.skip_tests:
                    self.runTest(i)
                else:
                    self.cli.poutput('=' * 80)
                    self.cli.poutput("Skip Test [{}]: {}".format(i,
                                                      self.testObj["TestReport"]["TestStepResult"][i]['StepReference'][
                                                          'Name']))
            else:
                self.runTest(i)

    def runTest(self, id, exportTest=False):
        if self.config.pre_expose:
            self.expose_discovery(id)
            time.sleep(1)   # give professos a little bit time to expose
        print('=' * 80)
        testStep = self.testObj["TestReport"]["TestStepResult"][id]

        test = testStep['StepReference']['Name']

        print("Run Test Step [{}]: {}".format(id, test), end='')

        url = self.profapi + '/' + self.target_type + '/' + self.testId + '/test/' + test
        header = {"Content-type": "application/json"}

        response = requests.post(url, headers=header)
        if response.status_code != 200:
            print()
            raise requests.RequestException('POST {} Error {}'.format(url, response.status_code))
        result = response.json()
        result_status = result['Result']
        print(" - {}".format(result_status))
        if not exportTest:
            return
        directory = self.session_dir + "/test" + str(id)
        if not os.path.exists(directory):
            os.makedirs(directory)
        for path in Path(directory).glob("*"):
            if path.is_file():
                path.unlink()

        with open("{}/result.json".format(directory), "w") as file:
            file.write(json.dumps(result['LogEntry'], indent=4))

        cnt = 0
        for entry in result['LogEntry']:
            if entry["Screenshot"]:
                cnt += 1
                with open("{}/screenshot{}.png".format(directory, cnt), "wb") as file:
                    file.write(base64.b64decode(entry["Screenshot"]["Data"]))

        if result_status != 'PASS':
            for entry in result['LogEntry']:
                date = time.localtime(entry['Date'])
                print("{}: {}".format(time.strftime("%H:%M:%S", date), entry['Text']))
                if entry["CodeBlock"]:
                    print("{}".format(json.dumps(entry['CodeBlock'], indent=2)))
                if entry["HttpRequest"]:
                    print("{}".format(json.dumps(entry['HttpRequest'], indent=2)))
                if entry["HttpResponse"]:
                    print("{}".format(json.dumps(entry['HttpResponse'], indent=2)))
                print('-' * 80)

    def export(self):
        url = self.profapi + '/' + self.target_type + '/' + self.testId + '/export-json'
        header = {"Content-Type": "application/json"}

        response = requests.get(url, headers=header)
        if response.status_code != 200:
            raise requests.RequestException('GET {} Error {}'.format(url, response.status_code))

        if not os.path.exists(self.session_dir):
            os.makedirs(self.session_dir)

        with open(self.session_dir + "/result.json", "w") as file:
            json.dump(response.json(), file)
