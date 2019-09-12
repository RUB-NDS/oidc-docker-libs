`eLearningSSO` is not public and therefore not included here. If you do have permissions to access the project and want to run the tests, proceed as follows:

1. Clone the `eLearningSSO` git repo into the directory containing this Readme file,

  ```
  git clone https://github.com/RUB-NDS/eLearningSSO.git
  ```

2. run `./init.sh`, which will copy some config files and compile the required modules from the `eLearningSSO` project using `mvn`. Note that Java and Maven must be installed for this step to succeed.

3. You can now run the `testrunner.py -t TestTargets/eLearning/testconfig.yml` from the parent folder as usual to automatically start the containers and run the configured tests.
