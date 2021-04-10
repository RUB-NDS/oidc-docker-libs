from api.rest import Rest


class RpTest(Rest):
    def __init__(self, cli, configname):
        super().__init__(cli, "rp", configname)
