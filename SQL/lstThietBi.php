<?php

include 'conn_ltd.php';

 //header("Content-Type: text/html; charset=UTF-8");
 //$conn->set_charset("utf8");
 //$user=$_POST['username'];
 $query = "SELECT thiet_bi_id,CONCAT(ma_so,'-',somay) as tenthietbi FROM view_lichsu_baoduong GROUp BY thiet_bi_id";

$sql=$conn->query($query);

$result=array();

while($fetchdata=$sql->fetch_assoc()){

	$result[]=$fetchdata;
}


echo json_encode($result);

?> 
