<?php
$servername = "localhost";
$username   = "root";
$password   = "";
$dbname     = "exam";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// count of on_day_list
$on_day_list[]=array();
array_shift($on_day_list);

$sql_on_day_search="SELECT * FROM `calender` WHERE  `day_type`='on'";
$result_on_day_search=mysqli_query($conn, $sql_on_day_search);
if($result_on_day_search->num_rows>0) {

    while($row_each_on_day=$result_on_day_search->fetch_assoc()) {
        $on_day=$row_each_on_day['date'];
        array_push($on_day_list, $on_day);
    }
}
print_r($on_day_list);
echo('<br>');



$conn->close();
