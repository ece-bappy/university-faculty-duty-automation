<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Duty Rooster</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Add your styles or include external CSS if needed -->

    <style>
        .custom-section {
    margin-bottom: 20px;
    border: 1px solid #ddd;
    padding: 10px;
    width:60%;
    margin: 0 auto;
    display:flex;
    flex-direction:column;
    justify-content:center;
}
.custom-section p{
    text-align:center;
}


.custom-section input{
    text-align:center;
    width:20%;
    height:40px;
    margin: 0 auto;
}

.button-container {
        text-align: center; /* Adjust as needed */
        margin-top: 20px;   /* Add spacing between buttons */
    }

    .button-container button {
        /* Add common styles for both buttons */
        margin: 5px; /* Adjust as needed */
    }

 input[type="number"]::-webkit-inner-spin-button,
 input[type="number"]::-webkit-outer-spin-button {
      -webkit-appearance: none;
      margin: 0;
    }


</style>
</head>

<body>
    <h2 align="center">Insert Student Number For Each Exam:</h2>

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

    if ($result->num_rows > 0) {
        // Output data of each row
        while ($row = $result->fetch_assoc()) {
            $courseCode = $row['course_code'];
            $date = $row['date'];
            $totStudents = $row['totStudents'];
            echo "<div class='custom-section'>";
            // Display course details and add input field for totStudents
            echo "<p>Course Code: $courseCode | Date: $date </p>";
            echo "<p for='$courseCode'>Number of Students:</p>";
            echo "<input type='number' id='$courseCode' name='students[$courseCode]' value='$totStudents'><br>";
            echo "</div>"; 
        }

        // Add a save button
     
    } else {
        echo "No records found";
    }

    

    $conn->close();
    ?>


<div class="button-container">
    <button class="btn_save" onclick="saveDutyRooster()">Save Changes</button>
    <a href="duty_distribution.php" target="_blank"><button>Create Duties</button></a>
</div>


    <script>
        function saveDutyRooster() {
            // You can use JavaScript/jQuery to gather the input values and send them to a PHP script for saving
            // For simplicity, let's assume you have jQuery included in your project
            // Make sure to include jQuery in your HTML if you don't have it yet

            var students = {};

            // Get values from input fields
            $("input[type=number]").each(function() {
                var courseCode = $(this).attr('id');
                var numStudents = $(this).val();
                students[courseCode] = numStudents;
            });

            // Send data to a PHP script for saving (you need to create this script)
            $.post("save_dutyroster.php", { students: students }, function(response) {
                alert(response); // Display a message or handle the response accordingly
            });
        }
    </script>
</body>

</html>
