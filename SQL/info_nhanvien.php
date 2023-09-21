<?php

include 'conn.php';

 header("Content-Type: text/html; charset=UTF-8");
 $conn->set_charset("utf8");
 $hoten=$_POST['hoten'];
 $query = "SELECT ngaynk as sort_date,date_format(ngaynk,'%d-%m-%Y') as ngaynk, CONVERT(CAST(CONVERT(CONCAT(noidungcv1,' ',noidungcv2) USING LATIN1) AS BINARY) USING UTF8) as noidungcv1 FROM nhatky_iso WHERE hoten =CONVERT(CAST(CONVERT('".$hoten."' USING UTF8) AS BINARY) USING LATIN1) ORDER BY sort_date DESC limit 30";
 
//  $result = mysqli_query($conn, $query);
//  $row = mysqli_fetch_assoc($result);
//  $hoten = $row['hoten'];


$sql=$conn->query($query);

//$sql=$conn->query("SELECT noidungcv1 FROM nhatky_iso WHERE hoten=(SELECT hoten From users WHERE username='khanhnd')");

$result=array();

while($fetchdata=$sql->fetch_assoc()){

	$result[]=$fetchdata;
}


echo json_encode($result);

?> 
