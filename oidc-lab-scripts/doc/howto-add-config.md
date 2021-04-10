# HOWTO add new RP/OP configurations

1.) Create a new folder in config/op or config/rp. The folder name is also the name in the CLI.
```shell script
mkdir -p config/op/YourNewOPServer
```

2.) Next create a config file "professos.json" in this folder. Configuration could be copied from PrOfESSOS Web Gui 
 or created manually.

OP Configuration:
```json
{
  "UrlOPTarget": "https://gravitee/am/profnet/oidc/",
  "OPMetadata": "",
  "AccessToken1": "",
  "AccessToken2": "",
  "User1Name": "alice",
  "User2Name": "bob",
  "User1Pass": "W0nderland",
  "User2Pass": "Und3rland",
  "LoginScript": "var username = document.getElementById(\"username\");\nusername.value = \"§current_user_username§\";\n\nvar password = document.getElementById(\"password\");\npassword.value = \"§current_user_password§\";\n\nvar submitBtn = document.querySelector(\"div > button\");\nsubmitBtn.click();",
  "ConsentScript": "var authBtn = document.getElementsByName(\"user_oauth_approval\")[1]\nauthBtn.click();\n",
  "Client1Config": "",
  "Client2Config": ""
}
```

RP Config must be slightly changed. For RPs without a fix TestID **iss** for HonestUserNeedle and EvilUserNeedle it is
required to add the placeholder "CHANGE_TEST_ID" which is afterwards automatically replaced by the CLI.

```json
{
  "UrlClientTarget": "https://php-oidc-rp/",
  "InputFieldName": "identifier",
  "SeleniumScript": "var opUrl = document.querySelector(\"input[name='identifier']\");\nopUrl.value = \"§browser-input-op_url§\";\nopUrl.form.submit();\n",
  "FinalValidUrl": "https://php-oidc-rp/index.php/loginok",
  "HonestUserNeedle": "{sub=honest-op-test-subject, iss=https://honest-idp.professos/CHANGE_TEST_ID}",
  "EvilUserNeedle": "{sub=evil-op-test-subject, iss=https://attack-idp.professos/CHANGE_TEST_ID}",
  "ProfileUrl": "https://php-oidc-rp/index.php/profile"
}
```

3.) (optional) add a config.json to your newly created RP/OP configuration folder.

```json
{
  "test_id": "yourStaticTestId",
  "discovery": true,
  "dynamic": true,
  "pre_expose": false
}
```

* **test_id**: A static testID name, also PrOfESSOS will generate a random test id by calling "create"
* If **discovery** or **dynamic** registration is not supported by the OP/RP it could be disabled
* **pre_expose**: For some RPs it is necessary to expose PrOfESSOS OP backend before test will run.