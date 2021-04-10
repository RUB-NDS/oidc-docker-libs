import os
import json


class TestConfig(object):

    def __init__(self):
        self.discovery = True
        self.dynamic = True
        self.pre_expose = False
        self.static_id = False  # marker if test_id was set in a config file and may not be overridden
        self.test_id = ""
        self.skip_tests = ""

    def load_json(self, file):
        if not os.path.exists(file):
            return None
        with open(file, 'r') as jsonData:
            data = json.load(jsonData)
            self.test_id = data.get('test_id', "")
            # if test_id was set, deactivate possibility to assign a new value
            self.static_id = True if data.get('test_id') != "" else False
            self.skip_tests = data.get('skip_tests', "")
            self.discovery = data.get('discovery', True)
            self.dynamic = data.get('dynamic', True)
            self.pre_expose = data.get('pre_expose', False)

    @property
    def discovery(self):
        return self.__discovery

    @discovery.setter
    def discovery(self, value):
        self.__discovery = value

    @property
    def dynamic(self):
        return self.__dynamic

    @dynamic.setter
    def dynamic(self, value):
        self.__dynamic = value

    @property
    def pre_expose(self):
        return self.__pre_expose

    @pre_expose.setter
    def pre_expose(self, value):
        self.__pre_expose = value

    @property
    def test_id(self):
        return self.__test_id

    @test_id.setter
    def test_id(self, value):
        if self.static_id:
            return
        self.__test_id = value

    @property
    def static_id(self):
        return self.__static_id

    @static_id.setter
    def static_id(self, value):
        self.__static_id = value

    @property
    def skip_tests(self):
        return self.__skip_tests

    @skip_tests.setter
    def skip_tests(self, value):
        if value != "":
            self.__value = [int(x) for x in value.split(",")]
        else:
            self.__skip_tests = value
