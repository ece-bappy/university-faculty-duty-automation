<!DOCTYPE HTML>
<html>

<head>
  <style>
    div {
      margin: auto;
      border: 3px solid green;
      padding: 10px;
      height: 500px;
      width: 500px;
      background-color: powderblue;
    }
  </style>
</head>

<body>



  <h2 align="center">Select the Menu to Create Exam Routine</h2>
  <div>
    <form align="center" method="post" action="exam_routine_show.php">



      Degree:<br>
      <select name="degree">
        <option value="CSE">CSE</option>
        <option value="ECE">ECE</option>
        <option value="EEE">EEE</option>

      </select>


      <br><br>
      Level: <br><select name="level">
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>

        <br><br>
      </select>
      <br>
      Semester: <br><select name="semester">
        <option value="I">I</option>
        <option value="II">II</option>
        <br><br>
      </select>
      <br>
      Start Date Index:<input type="number" name="date_index">
      <br><br>
      <a><input type="submit" name="submit" value="Submit"> </a>
    </form>
  </div>
</body>

</html>