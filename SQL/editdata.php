<?php

include 'conn.php';

header("Content-Type: text/html; charset=UTF-8");
$conn->set_charset("latin1");

$stt=$_POST['stt'];
$noidungcv1=$_POST['noidungcv1'];
$noidungcv2=$_POST['noidungcv2'];

$conn->query("update nhatky_iso set 
                                    noidungcv1='".$noidungcv1."',
                                    noidungcv2='".$noidungcv2."'
              where stt='".$stt."'
            ");

?>
