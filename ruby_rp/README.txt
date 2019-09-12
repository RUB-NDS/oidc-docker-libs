Spend some time on this but could not get it running...

The RP fails to parse the JWKS response from PrOfESSOS with a "KidNotFound" exception. Tried to track this down through the openid_connect gem and into the json-jwt gem but were not able to find the root cause :/ 
Afaik, a kid is not mandatory and I was not able to figure whether and where the ruby sample RP attempted to parse a kid in the JWKS response. 

----


Trying to use the demo instances on Heroku provided by the dev, i.e., go to 
 https://connect-rp.herokuapp.com/ and enter https://connect-op.herokuapp.com in the form and press "Discover" results in a "bad_request" error on the OP's authorization page.

 
The OP seems to work but only provides a single user account ("Fake Account"). 
