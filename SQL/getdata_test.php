<?php

include 'conn.php';

header("Content-Type: text/html; charset=UTF-8");
$conn->set_charset("utf8");
// $sql=$conn->query("SELECT CONVERT(CAST(CONVERT(noidungcv1 USING LATIN1) AS BINARY) USING UTF8) as noidungcv1, 
// 					CONVERT(CAST(CONVERT(noidungcv2 USING LATIN1) AS BINARY) USING UTF8) as noidungcv2,
// 					ngaynk
// 					FROM `nhatky_iso` ORDER BY stt ASC limit 1");



while($fetchdata=$sql->fetch_assoc()){

	$result[]=$fetchdata;
}


echo json_encode($result);

    //echo "test";
?> 
