import os
import shutil
import json

from jinja2 import Template


class ReportGenerator(object):

    def __init__(self, report_dir, output_dir):
        self.output_dir = output_dir
        self.template_dir = "api/report/template"
        self.report_dir = report_dir
        self.data = None

    def load_export(self, reportName):
        export = self.report_dir + "/" + reportName
        if not os.path.exists(export):
            raise FileNotFoundError
        with open(export) as file:
            self.data = json.load(file)

    def generate(self, name):
        if not os.path.exists(self.output_dir):
            os.makedirs(self.output_dir)

        style_dir = "/style"
        if not os.path.exists(self.output_dir+style_dir):
            shutil.copytree(self.template_dir + style_dir, self.output_dir + style_dir)

        with open('{}/index.html'.format(self.template_dir)) as file:
            template = Template(file.read())
            template.stream(title=name, results=self.data).dump("{}/index.html".format(self.output_dir))
