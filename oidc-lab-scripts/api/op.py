from api.rest import Rest


class OpTest(Rest):
    def __init__(self, cli, configname):
        super().__init__(cli, "op", configname)
