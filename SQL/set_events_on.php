<?php

include 'conn2.php';

 $sql=$conn->query("SET GLOBAL event_scheduler=ON");

echo json_encode('OK');

?> 
