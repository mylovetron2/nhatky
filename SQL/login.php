<?php

include 'conn.php';

//$conn->set_charset("latin1");

$user=$_POST['username'];
$pass=$_POST['password'];

$sql="SELECT * FROM users WHERE username='".$user."' and password='".$pass."'";

//$result=array();

if ($result=mysqli_query($conn,$sql)){
    $rowcount=mysqli_num_rows($result);
    mysqli_free_result($result);
}

//$rowcount=0;

if($rowcount==1)
    echo json_encode('Success');
else
    echo json_encode('fail');

?>
