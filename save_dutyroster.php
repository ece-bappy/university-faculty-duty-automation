<!-- save_dutyroster.php -->
<?php
$servername = "localhost";
$username   = "root";
$password   = "";
$dbname     = "rhmvi";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $students = $_POST['students'];

    foreach ($students as $courseCode => $numStudents) {
        // Update totStudents in the routine table
        $sql = "UPDATE routine SET totStudents = $numStudents WHERE course_code = '$courseCode'";
        $conn->query($sql);
    }

    echo "Duty Rooster saved successfully!";
} else {
    echo "Invalid request";
}

$conn->close();
?>
