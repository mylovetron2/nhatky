<?php

include 'conn.php';

 header("Content-Type: text/html; charset=UTF-8");
 $conn->set_charset("utf8");
 //$user=$_POST['username'];
 $query = "SELECT CONVERT(CAST(CONVERT(hoten USING LATIN1) AS BINARY) USING UTF8) as hoten FROM users WHERE hoten !=''";
 
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
