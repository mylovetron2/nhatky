<?php

include 'conn.php';

header("Content-Type: text/html; charset=UTF-8");


$ngaynk=$_POST['ngaynk'];
$user=$_POST['username'];
$noidungcv1=$_POST['noidungcv1'];
$noidungcv2=$_POST['noidungcv2'];

$query = "SELECT hoten FROM users WHERE username = '".$user."'";
$result = mysqli_query($conn, $query);
$row = mysqli_fetch_assoc($result);
$hoten_latin = $row['hoten'];
//$hoten='Nguyễn Duy Khanh';
$result -> free_result();


$query = "SELECT hoten FROM view_users WHERE username = '".$user."'";
$result = mysqli_query($conn, $query);
$row = mysqli_fetch_assoc($result);
$hoten = $row['hoten'];
//$hoten='Nguyễn Duy Khanh';
$result -> free_result();


 //$query = "SELECT ngaynk FROM view_nhatky_iso WHERE ngaynk = '".$ngaynk."' and hoten='".$hoten."'";
$query2 = "SELECT count(ngaynk) as count FROM nhatky_iso WHERE hoten='".$hoten_latin."' and date_format(ngaynk,'%d-%m-%Y') = '".$ngaynk."'";
$result2 = mysqli_query($conn, $query2);
$row2 = mysqli_fetch_assoc($result2);
$count = $row2["count"];
// $count=0;
$resultR=[];


if($count==0)  // ngay chua ton tai
{
        $conn->set_charset("latin1");
        $query = "SELECT max(stt) as max FROM nhatky_iso";
        $result = mysqli_query($conn, $query);
        $row = mysqli_fetch_assoc($result);
        $stt = $row['max']+1;

        $old_date=explode('-',$ngaynk);
        $new_date=$old_date[2].$old_date[1].$old_date[0];
        $manhatky=$new_date.'-'.$hoten_latin;

         $conn->query("INSERT into nhatky_iso(stt,manhatky,ngaynk,hoten,noidungcv1,noidungcv2,
                        `gio1`, `gio2`, `gio3`, `gio4`, `gio5`, `gio6`, `gio7`, `gio8`, 
                        `gio9`, `gio10`,`noidungcv3`, `noidungcv4`, `noidungcv5`, `noidungcv6`, 
                        `noidungcv7`, `noidungcv8`, `noidungcv9`, `noidungcv10`, `tentbcv1`, `tentbcv2`, 
                        `tentbcv3`, `tentbcv4`, `tentbcv5`, `tentbcv6`, `tentbcv7`, `tentbcv8`, `tentbcv9`, 
                        `tentbcv10`, `ghichu1`, `ghichu2`, `ghichu3`, `ghichu4`, `ghichu5`, `ghichu6`, `ghichu7`, 
                        `ghichu8`, `ghichu9`, `ghichu10`
                ) 
                values('".$stt."','".$manhatky."',STR_TO_DATE('".$ngaynk."', '%d-%m-%Y'),'".$hoten_latin."', '".$noidungcv1."','".$noidungcv2."',
                        '7h15-11h15','13h45-16h40','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''
                
                )");

        $resultR['message']="success";
}
else
        $resultR['message']="fail";
        ///header('Content-Type: application/json');
echo json_encode($resultR);
        //echo http_response_code( 201 );
?>
