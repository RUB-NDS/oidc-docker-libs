# oidc-lab professos cli

The command line interface is based on CMD2 python package.
It provides an interface to communicate with professos rest api.

Furthermore in folder pentest are some simple scripts to intercept and change
requests via a mitm proxy server script.

## Prerequisite

* oidc-lab
* (optional) mitm proxy server installed in oidc-lab
* Python 3
```
pip install -r requirements.txt
```

## Usage

Start the cli:
```
./cli.py
```

Command "help" could be used to get some further usage informations per available command

### Quickstart

Load and run a complete test. Generated could be found afterwards in results/mitreid-client/default/report/index.html
```
load rp mitreid-client
full_test
```

### Run tests

To run same tests as in full_test run:
```
load rp mitreid-client
create
learn
run --all
export
report
```

### Manual tests

Run manual tests, mitm proxy server script must be loaded in oidc-lab
```
load op mitreid-server
create
learn
run_pyscript pentest/mitreid-server-redirect.py
run 48
export
report
```
