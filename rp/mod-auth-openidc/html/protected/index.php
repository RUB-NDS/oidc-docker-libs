<html>
  <body>
    <h1>Hello, <?php echo($_SERVER['REMOTE_USER']) ?></h1>
    <pre><?php print_r(array_map("htmlentities", apache_request_headers())); ?></pre>
    <a href=<?php echo "/protected/redirect_uri?logout=https%3A%2F%2F" .  $_SERVER['SERVER_NAME'] . "%2Flogout.html"; ?> >Logout</a>
  </body>
</html>
