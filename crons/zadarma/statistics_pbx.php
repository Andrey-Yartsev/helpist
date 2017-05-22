<?php

ini_set('display_errors', 1);

include_once 'include.php';
include_once 'Call.php';
include_once 'CallRecord.php';
include_once 'CallsUpdate.php';

print '<pre>';

(new CallsUpdate(
    new \Zadarma_API\Client(KEY, SECRET)
))->update();