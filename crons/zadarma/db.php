<?php

include_once('../../configuration.php');
$mysqli = new mysqli($db_host, $db_username, $db_password, $db_name);
if ($mysqli === false) {
    throw new Exception("error connect BD");
}
return $mysqli;