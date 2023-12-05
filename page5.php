<!DOCTYPE html>
<html>
<head>
    <title>Exam Duty Table</title>
</head>
<body>
    <center>
    <h1>Exam Duty Table</h1>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $examDate = $_POST["exam_date"];
        $numExams = (int)$_POST["num_exams"];

        // Connect to the MySQL database
        $conn = new mysqli("localhost", "root", "", "rhmvi");

        // Check for database connection errors
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        // Display the Exam Date
        echo "<p>Exam Date: $examDate</p>";

        // Loop through the selected number of exams
        for ($i = 1; $i <= $numExams; $i++) {
            $courseCode = $_POST["course_code_" . $i];
            $studentSize = $_POST["students_size_" . $i];

            // Call the dutyDist procedure for each student size
            $sql = "CALL final_exam($studentSize)";
            if ($conn->query($sql) === TRUE) {
                echo " ";

                // Display the Exam Duty table for the current exam and student size
                $sql = "SELECT * FROM examDuty";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    echo "<h2>Exam Duty for Exam $courseCode (Student Size: $studentSize)</h2>";
                    echo "<table border='1' cellspacing='0'>";
                    echo "<tr><th>ID</th><th>Name</th><th>Dept</th><th>Designation</th><th>Role</th></tr>";
                    while ($row = $result->fetch_assoc()) {
                        echo "<tr>";
                        echo "<td>" . $row["ID"] . "</td>";
                        echo "<td>" . $row["Name"] . "</td>";
                        echo "<td>" . $row["dept"] . "</td>";
                        echo "<td>" . $row["designation"] . "</td>";
                        echo "<td>" . $row["role"] . "</td>";
                        echo "</tr>";
                    }
                    echo "</table>";
                } else {
                    echo "No records found for Exam $i (Student Size: $studentSize)<br>";
                }
            } else {
                echo "Error for Exam $i (Student Size: $studentSize): " . $sql . "<br>" . $conn->error;
            }
        }

        // Close the database connection
        $conn->close();
    }
    ?>

    <!-- Button to Print the Page -->
    <button onclick="window.print()">Print Page</button>

    <!-- Button to Go Back to Index Page -->
    <a href="final.php"><button>Go Back</button></a>
    </center>
</body>
</html>
