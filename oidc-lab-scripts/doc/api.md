# Export
```
Type: GET
Url:  /{rp|op}/{testId}/export-json
Returns:
    Json:
        "Content-type": "application/json"
```

# Create Testplan

```
Type: POST
Url:  /{rp|op}/create-test-object 
Header: "Content-type": "application/x-www-form-urlencoded"
Param: test_id=YourTestId (optional)
Returns: "Content-type": "application/json"
```

# Delete Testplan
```
Type: POST
Url:  /delete-test-object 
Header: "Content-type": "application/x-www-form-urlencoded"
Param: test_id=YourTestId (optional)
```

# Learn
```
Type: POST
Url:  /{rp|op}/{testId}/learn
Header: "Content-type": "application/json"
Payload: "TestConfig"
Returns: "Content-type": "application/json"
```

# Run Test
```
Type: POST
Url:  /{rp|op}/{testId}/expose/{stepId}
Header: "Content-type": "application/json"
Returns: "Content-type": "application/json"
```

# Run Test
```
Type: POST
Url:  /{rp|op}/{testId}/test/{stepId}
Header: "Content-type": "application/json"
Returns: "Content-type": "application/json"
```


# Get Config
```
Type: GET 
Url:  /{rp|op}/{testId}/config
Returns: "Content-type": "application/json"
```

# Set Config
```
Type: POST 
Url:  /{rp|op}/{testId}/config
Header: "Content-type": "application/json"
Payload: "TestConfig"
```

