As this IdentityServer4 setup does not support dynamic client registration, it is required to set a custom TestId in PrOfESSOS or to adjust the TestID in `professos.json` configuration.

To set a custom TestID when using PrOfESSOS' webb-frontent, navigate to the OP-Verifier, open the developer console in the browser and run
```
OPIV.createTestPlan("OP-TestPlan","test_id=test-id-identityServer4")
```

In this example, a new TestObject will be created with the TestID set to `test-id-identityServer4`. 
