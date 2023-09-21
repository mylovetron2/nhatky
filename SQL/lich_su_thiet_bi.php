<?php

include 'conn_ltd.php';

 //header("Content-Type: text/html; charset=UTF-8");
 //$conn->set_charset("utf8");
 $thiet_bi_id=$_POST['thiet_bi_id'];
 $query = "SELECT ngayth,CONCAT(honghoc,'<br>',khacphuc) as honghoc FROM `view_lichsu_baoduong` WHere thiet_bi_id=".$thiet_bi_id." Order by ngayth DESc";
 
$sql=$conn->query($query);

$result=array();

while($fetchdata=$sql->fetch_assoc()){

	$result[]=$fetchdata;
}


echo json_encode($result);

?> 
