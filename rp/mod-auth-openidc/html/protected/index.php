<html>
  <body>
    <h1>Hello, <?php echo($_SERVER['REMOTE_USER']) ?></h1>
    <pre><?php
        $claims = array_map("htmlentities", apache_request_headers());
        echo("<h2> Full claims </h2>");
        print_r($claims);
        echo("<h2> Full claims </h2>");
        echo("{sub=" . $claims["OIDC_CLAIM_sub"] . ", iss=" . $claims["OIDC_CLAIM_iss"] . "}");
    ?></pre>
    <a href=<?php echo "/protected/redirect_uri?logout=https%3A%2F%2F" .  $_SERVER['SERVER_NAME'] . "%2Flogout.html"; ?> >Logout</a>
  </body>
</html>
