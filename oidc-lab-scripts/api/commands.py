import os
import argparse
import cmd2
import requests
import sys
from cmd2 import CommandSet, with_argparser, with_category, with_default_category
from datetime import datetime

from api.report.generator import ReportGenerator


@with_default_category('Session')
class Commands(CommandSet):
    CATEGORY_SESSION = 'Session'
    CATEGORY_COMMANDS = 'Session Commands'

    def __init__(self):
        super().__init__()

    def do_listsessions(self, ns: argparse.Namespace):
        """ show all sessions """
        self.cli.poutput("\nAvailable sessions:")
        self.cli.poutput("==========================\n")
        if not os.path.exists(self.result_dir):
            return
        for session in os.listdir(self.result_dir):
            if session == self.session_name:
                self.cli.poutput(cmd2.style('* ' + session, fg=cmd2.fg.green, bold=True))
            else:
                self.cli.poutput(cmd2.style(session, fg=cmd2.fg.green))

    session_start_parser = cmd2.Cmd2ArgumentParser(CATEGORY_SESSION)
    session_start_parser.add_argument('--timestamp', action='store_true', help='')
    session_start_parser.add_argument('--name', type=str)

    @with_argparser(session_start_parser)
    def do_start(self, ns: argparse.Namespace):
        """ start a new session """
        if not ns.name and not ns.timestamp:
            self.session_name = 'default'
        elif ns.name:
            self.session_name = ns.name
        elif ns.timestamp:
            self.session_name = datetime.now().isoformat(timespec='minutes')
        self.cli.poutput("Start session {}".format(self.session_name))
        if not os.path.exists(self.session_dir):
            os.makedirs(self.session_dir)

    session_resume_parser = cmd2.Cmd2ArgumentParser(CATEGORY_SESSION)
    session_resume_parser.add_argument('name', type=str)

    @with_argparser(session_resume_parser)
    def do_resume(self, ns: argparse.Namespace):
        """ resume a session """
        if not os.path.exists(self.result_dir + '/' + ns.name):
            self.cli.poutput(cmd2.style('No session found with name {}'.format(ns.name), fg=cmd2.fg.red))
        else:
            self.session_name = ns.name

    config_parser = cmd2.Cmd2ArgumentParser(CATEGORY_SESSION)
    config_parser.add_argument('--show', action='store_true', help='')
    config_parser.add_argument('--get', action='store_true', help='')
    config_parser.add_argument('--set', action='store_true', help='')
    config_parser.add_argument('variable', nargs='?', help='')

    @with_argparser(config_parser)
    def do_config(self, ns: argparse.Namespace):
        if not ns.show and not ns.get and not ns.set:
            self.show_config()
        elif ns.show:
            self.show_config()
        elif ns.get:
            self.cli.poutput('Get {}'.format(ns.get))
        elif ns.set:
            self.cli.poutput('Set {}'.format(ns.set))
            try:
                (k, v) = ns.variable.split("=", 2)
                print('{} = {}'.format(k,v))
            except ValueError as ex:
                self.cli.poutput('Set must be set as Key=Value')
        else:
            self.cli.perror("")

    @with_category(CATEGORY_COMMANDS)
    def do_report(self, args):
        """ generates a human readable report from a json export """
        report = ReportGenerator(self.session_dir, self.session_dir + '/report')
        report.load_export("result.json")
        report.generate(self.target_name)

    @with_category(CATEGORY_COMMANDS)
    def do_create(self, args):
        """ create a new professos test id """
        try:
            self.create()
        except requests.RequestException as e:
            self.cli.poutput("Received error from Professos?")

    @with_category(CATEGORY_COMMANDS)
    def do_delete(self, args):
        """ removes Test Id from professos """
        self.delete()

    @with_category(CATEGORY_COMMANDS)
    def do_set_config(self, args):
        """ set a configuration for professos """
        self.set_config()

    @with_category(CATEGORY_COMMANDS)
    def do_get_config(self, args):
        """ get configuration and client id """
        self.get_config()

    expose_parser = cmd2.Cmd2ArgumentParser(CATEGORY_COMMANDS)
    expose_parser.add_argument('--test', type=int, help='')

    @with_category(CATEGORY_COMMANDS)
    @with_argparser(expose_parser)
    def do_expose(self, ns: argparse.Namespace):
        """ creates a test specific professos backend, for simple tests this could be used to do manual tests """
        try:
            if not self.config.discovery:
                self.set_config()
            if ns.test:
                self.expose_discovery(ns.test)
            else:
                self.expose_discovery(0)
        except requests.RequestException as e:
            print("Received error from Professos")
            print(str(e))

    @with_category(CATEGORY_COMMANDS)
    def do_learn(self, args):
        """ learn should be executed after creation """
        self.learn()

    @with_category(CATEGORY_COMMANDS)
    def do_export(self, args):
        """ exports json result to result directory """
        self.export()

    run_parser = cmd2.Cmd2ArgumentParser(CATEGORY_COMMANDS)
    run_parser.add_argument('--all', action='store_true', help='')
    run_parser.add_argument('--show', action='store_true', help='show test result in console')
    run_parser.add_argument('test_nr', nargs='?', help='')

    @with_category(CATEGORY_COMMANDS)
    @with_argparser(run_parser)
    def do_run(self, ns: argparse.Namespace):
        """ runs a test, create and learn must be called before """
        if ns.all:
            self.runAllTests()
        else:
            self.runTest(int(ns.test_nr), exportTest=ns.show)

    @with_category(CATEGORY_COMMANDS)
    def do_full_test(self, args):
        """ starts a complete test """
        self.do_create("")
        self.do_learn("")
        self.do_run("--all")
        self.do_export("")
        self.do_report("")
