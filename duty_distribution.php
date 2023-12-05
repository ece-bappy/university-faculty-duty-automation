<!-- duty_distribution.php -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Duty Distribution</title>
    <style>/* Add this to your CSS file */
.custom-table {
    /* Add your custom styles here */
    width: 90%;
    margin: 0 auto;
    border-collapse: collapse;
}

.custom-table th, .custom-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

.custom-table  td:nth-child(2) {
      width: 30%;
    }

.par{
    width:90%;
     margin:0 auto;
}

@media print {
      button {
        display: none;
      }
    }
.custom-section {
    /* Add your custom styles for the section here */
    margin-bottom: 20px;
    border: 1px solid #ddd;
    padding: 10px;
}

.btn_ptr{
    width:100%;
    display:flex;
    justify-content:center;
}
.btn_ptr button{
    width:30%;
    height:35px;
    background:#ddd;
    margin: 0 auto;
    margin-bottom:40px;
}



</style>
    <!-- Add your styles or include external CSS if needed -->
</head>

<body>
    <h2 align="center">Duty Distribution</h2>

    <?php
    $servername = "localhost";
    $username   = "root";
    $password   = "";
    $dbname     = "rhmvi";

    $conn = new mysqli($servername, $username, $password, $dbname);
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Fetch data from routine table
    $sql = "SELECT * FROM routine";
    $result = $conn->query($sql);

   // ... (previous code)

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $courseCode = $row['course_code'];
        $date = $row['date'];

        // Fetch totStudents using a separate query
        $sqlTotStudents = "SELECT totStudents FROM routine WHERE course_code = '$courseCode'";
        $resultTotStudents = $conn->query($sqlTotStudents);

        // Check if exactly one row is returned
        if ($resultTotStudents->num_rows == 1) {
            $rowTotStudents = $resultTotStudents->fetch_assoc();
            $totStudents = $rowTotStudents['totStudents'];

            // Call the stored procedure final_exam for each course_code
            $sqlCallProcedure = "CALL final_exam($totStudents)";
            $conn->query($sqlCallProcedure);
            echo "<div class='custom-section'>";
            // Display course details and the corresponding date
            echo "<p class='par'>Course Code: $courseCode | Date: $date</p>";

            // Load data from examduty table
            $sqlExamDuty = "SELECT * FROM examduty";
            $resultExamDuty = $conn->query($sqlExamDuty);

            if ($resultExamDuty->num_rows > 0) {
                // Display the examduty table
                echo "<table border='1' cellspacing='0' class='custom-table' >";
                echo "<tr><th>ID</th><th>Name</th><th>Department</th><th>Designation</th><th>Role</th></tr>";

                while ($rowExamDuty = $resultExamDuty->fetch_assoc()) {
                    echo "<tr>";
                    echo "<td>{$rowExamDuty['ID']}</td>";
                    echo "<td>{$rowExamDuty['Name']}</td>";
                    echo "<td>{$rowExamDuty['dept']}</td>";
                    echo "<td>{$rowExamDuty['designation']}</td>";
                    echo "<td>{$rowExamDuty['role']}</td>";
                    echo "</tr>";
                }

                echo "</table>";
            } else {
                echo "No duties assigned for $courseCode.";
            }
            echo "</div>"; 
        } else {
            echo "Error: Invalid number of rows returned for totStudents for $courseCode.";
        }
    }
} else {
    echo "No records found";
}




    $conn->close();
    ?>

<div class="btn_ptr">
<button  onclick="printPage()">Print Page</button>
</div>





<script>
    function printPage() {
      window.print();
    }
  </script>

</body>

</html>
