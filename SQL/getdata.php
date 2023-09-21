<?php

include 'conn.php';

 header("Content-Type: text/html; charset=UTF-8");
 $conn->set_charset("utf8");
 $user=$_POST['username'];
 $query = "SELECT hoten FROM users WHERE username = '".$user."'";
 $result = mysqli_query($conn, $query);
 $row = mysqli_fetch_assoc($result);
 $hoten = $row['hoten'];


$sql=$conn->query("SELECT CONVERT(CAST(CONVERT(noidungcv1 USING LATIN1) AS BINARY) USING UTF8) as noidungcv1,  
					CONVERT(CAST(CONVERT(noidungcv2 USING LATIN1) AS BINARY) USING UTF8) as noidungcv2,
					ngaynk as sort_date,
					CONCAT(ELT(DAYOFWEEK(ngaynk), 'CN', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'),'/',date_format(ngaynk,'%d-%m-%Y')) as ngaynk,
					stt
					FROM `nhatky_iso` WHERE hoten='".$hoten."' ORDER BY sort_date DESC limit 62");

//$sql=$conn->query("SELECT noidungcv1 FROM nhatky_iso WHERE hoten=(SELECT hoten From users WHERE username='khanhnd')");

$result=array();

while($fetchdata=$sql->fetch_assoc()){

	$result[]=$fetchdata;
}


echo json_encode($result);

?> 
