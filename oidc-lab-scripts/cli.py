#!/usr/bin/env python3

import os
import sys
import argparse
import cmd2
from cmd2 import style, fg, with_argparser, with_category

from api.op import OpTest
from api.rp import RpTest


class Cli(cmd2.Cmd):
    DEFAULT_CATEGORY = 'General'

    def __init__(self):
        # TODO make professos api configurable
        self.professos_url = "http://localhost:8888/api"

        # add shortcuts
        shortcuts = dict(cmd2.DEFAULT_SHORTCUTS)
        shortcuts.update({'ll': 'list', 'ls': 'list'})

        super().__init__(use_ipython=True,
                         multiline_commands=['orate'],
                         persistent_history_file='history.dat',
                         persistent_history_length=1000,
                         shortcuts=shortcuts)

        self.intro = style('Starting Control Center for Professos!', fg=fg.green, bold=True)
        self.prompt = 'cli> '
        self.default_category = 'Others'

        self._testModule = None

    list_parser = cmd2.Cmd2ArgumentParser('list')
    list_parser.add_argument('target', choices=['op', 'rp'], help='')

    @with_argparser(list_parser)
    @with_category(DEFAULT_CATEGORY)
    def do_list(self, ns: argparse.Namespace):
        """ show available configurations """
        cfg_path = "config/" + ns.target

        self.poutput("\nAvailable configurations:")
        self.poutput("==========================\n")
        for cfg in os.listdir(cfg_path):
            self.poutput(cmd2.style(cfg, fg=cmd2.fg.green))

    load_parser = cmd2.Cmd2ArgumentParser('load')
    load_parser.add_argument('target', choices=['op', 'rp'])
    load_parser.add_argument('name', type=str)

    @with_argparser(load_parser)
    @with_category('Command Loading')
    def do_load(self, ns: argparse.Namespace):
        """ load a OP/RP config, further specific commands will be available afterwards """
        cfg_path = "config/" + ns.target + "/" + ns.name + "/professos.json"
        if not os.path.exists(cfg_path):
            self.perror(cmd2.style('No {} target named {} found!'.format(ns.target, ns.name), fg=cmd2.fg.red))
            return

        if self._testModule:
            self.unregister_command_set(self._testModule)
            self._testModule = None

        if ns.target == 'op':
            self._testModule = OpTest(self, ns.name)
        else:
            self._testModule = RpTest(self, ns.name)

        try:
            self.register_command_set(self._testModule)
            self.poutput('')
            self.prompt = 'cli>> {}> {}> '.format(ns.target, ns.name)
            self.do_start("")
        except ValueError:
            self.poutput('Module already loaded')

    @with_category('Command Loading')
    def do_unload(self, ns: argparse.Namespace):
        """ unloads current loaded OP/RP config """
        if self._testModule:
            self.unregister_command_set(self._testModule)
            self._testModule = None
            self.poutput('Module unloaded')
            self.prompt = 'cli> '


if __name__ == '__main__':
    print("[*] Professos CLI started")
    app = Cli()
    sys.exit(app.cmdloop())
