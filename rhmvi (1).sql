-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2023 at 12:25 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rhmvi`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `distDuty` (IN `students_size` INT)   BEGIN
    DECLARE done INT DEFAULT 0;
    
    -- Delete existing data in the examDuty table
    DELETE FROM examDuty;
    
    -- Find a random chief supervisor from Professors or Associate Professors
    SET @chief_supervisor_id = (
        SELECT teachers_ID
        FROM teachers
        WHERE Designation IN ('Professor', 'Associate Professor')
        ORDER BY RAND()
        LIMIT 1
    );
    
    -- Get the chief supervisor's designation
    SET @chief_supervisor_designation = (
        SELECT Designation
        FROM teachers
        WHERE teachers_ID = @chief_supervisor_id
    );
    
    -- Insert the chief supervisor into the examDuty table
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @chief_supervisor_id, Name, 'CSE', @chief_supervisor_designation, 'chief supervisor'
    FROM teachers
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Calculate the number of supervisors based on students_size
    SET @num_supervisors = CEIL(students_size / 15);
    
    -- Insert random teachers as supervisors
    SET @i = 1;
    
    WHILE @i <= @num_supervisors DO
        SET @supervisor_id = (
            SELECT teachers_ID
            FROM teachers
            WHERE Designation NOT IN ('chief supervisor', 'supervisor')
            ORDER BY RAND()
            LIMIT 1
        );
        
        -- Get the supervisor's designation
        SET @supervisor_designation = (
            SELECT Designation
            FROM teachers
            WHERE teachers_ID = @supervisor_id
        );
        
        INSERT INTO examDuty (ID, Name, dept, designation, role)
        SELECT @supervisor_id, Name, Dept, @supervisor_designation, 'supervisor'
        FROM teachers
        WHERE teachers_ID = @supervisor_id;
        
        SET @i = @i + 1;
    END WHILE;
    
    -- Insert a random helper
    SET @helper_id = (
        SELECT helper_ID
        FROM helper
        ORDER BY RAND()
        LIMIT 1
    );
    
    -- Get the helper's designation
    SET @helper_designation = (
        SELECT Designation
        FROM helper
        WHERE helper_ID = @helper_id
    );
    
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @helper_id, Name, Dept, @helper_designation, 'helper'
    FROM helper
    WHERE helper_ID = @helper_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `duty11` (IN `students_size` INT)   BEGIN
    DECLARE done INT DEFAULT 0;
    
    -- Clear the existing data in the examDuty table
    DELETE FROM examDuty;
    
    -- Find a random chief supervisor from Professors or Associate Professors
    SELECT teachers_ID, Designation INTO @chief_supervisor_id, @chief_supervisor_designation
    FROM teachers
    WHERE Designation IN ('Professor', 'Associate Professor')
    ORDER BY RAND()
    LIMIT 1;
    
    -- Insert the chief supervisor into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @chief_supervisor_id, Name, 'CSE', @chief_supervisor_designation, 'chief supervisor'
    FROM teachers
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Calculate the number of supervisors based on students_size
    SET @num_supervisors = FLOOR(students_size / 15);
    
    -- Insert random teachers as supervisors
    SET @i = 1;
    
    WHILE @i <= @num_supervisors DO
        SELECT teachers_ID, Designation INTO @supervisor_id, @supervisor_designation
        FROM teachers
        WHERE Designation NOT IN ('chief supervisor', 'supervisor')
        ORDER BY RAND()
        LIMIT 1;
        
        -- Insert the supervisor into the examDuty table with the correct designation
        INSERT INTO examDuty (ID, Name, dept, designation, role)
        SELECT @supervisor_id, Name, Dept, @supervisor_designation, 'supervisor'
        FROM teachers
        WHERE teachers_ID = @supervisor_id;
        
        SET @i = @i + 1;
    END WHILE;
    
    -- Insert a random helper
    SELECT helper_ID, Designation INTO @helper_id, @helper_designation
    FROM helper
    ORDER BY RAND()
    LIMIT 1;
    
    -- Insert the helper into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @helper_id, Name, Dept, @helper_designation, 'helper'
    FROM helper
    WHERE helper_ID = @helper_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `duty12` (IN `students_size` INT)   BEGIN
    DECLARE done INT DEFAULT 0;
    
    -- Delete existing data in the examDuty table
    DELETE FROM examDuty;
    
    -- Find a random chief supervisor from Professors or Associate Professors
    SELECT teachers_ID, Designation INTO @chief_supervisor_id, @chief_supervisor_designation
    FROM teachers
    WHERE Designation IN ('Professor', 'Associate Professor')
    ORDER BY RAND()
    LIMIT 1;
    
    -- Insert the chief supervisor into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @chief_supervisor_id, Name, 'CSE', @chief_supervisor_designation, 'chief supervisor'
    FROM teachers
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Increase the dutyCount of the chief supervisor
    UPDATE teachers
    SET dutyCount = dutyCount + 1
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Calculate the number of supervisors based on students_size
    SET @num_supervisors = FLOOR(students_size / 15);
    
    -- Insert random teachers as supervisors
    SET @i = 1;
    
    WHILE @i <= @num_supervisors DO
        SELECT teachers_ID, Designation INTO @supervisor_id, @supervisor_designation
        FROM teachers
        WHERE Designation NOT IN ('chief supervisor', 'supervisor')
        ORDER BY RAND()
        LIMIT 1;
        
        -- Insert the supervisor into the examDuty table with the correct designation
        INSERT INTO examDuty (ID, Name, dept, designation, role)
        SELECT @supervisor_id, Name, Dept, @supervisor_designation, 'supervisor'
        FROM teachers
        WHERE teachers_ID = @supervisor_id;
        
        -- Increase the dutyCount of the supervisor
        UPDATE teachers
        SET dutyCount = dutyCount + 1
        WHERE teachers_ID = @supervisor_id;
        
        SET @i = @i + 1;
    END WHILE;
    
    -- Insert a random helper
    SELECT helper_ID, Designation INTO @helper_id, @helper_designation
    FROM helper
    ORDER BY RAND()
    LIMIT 1;
    
    -- Insert the helper into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @helper_id, Name, Dept, @helper_designation, 'helper'
    FROM helper
    WHERE helper_ID = @helper_id;
    
    -- Increase the dutyCount of the helper
    UPDATE helper
    SET dutyCount = dutyCount + 1
    WHERE helper_ID = @helper_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dutyCycle` (IN `students_size` INT)   BEGIN
    DECLARE done INT DEFAULT 0;
    
    -- Delete existing data in the examDuty table
    DELETE FROM examDuty;
    
    -- Find a random chief supervisor from Professors or Associate Professors
    SET @chief_supervisor_id = (
        SELECT teachers_ID
        FROM teachers
        WHERE Designation IN ('Professor', 'Associate Professor')
        ORDER BY RAND()
        LIMIT 1
    );
    
    -- Insert the chief supervisor into the examDuty table
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @chief_supervisor_id, Name, 'CSE', 'Professor', 'chief supervisor'
    FROM teachers
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Calculate the number of supervisors based on students_size
    SET @num_supervisors = CEIL(students_size / 15);
    
    -- Insert random teachers as supervisors
    SET @i = 1;
    
    WHILE @i <= @num_supervisors DO
        SET @supervisor_id = (
            SELECT teachers_ID
            FROM teachers
            WHERE Designation NOT IN ('chief supervisor', 'supervisor')
            ORDER BY RAND()
            LIMIT 1
        );
        
        INSERT INTO examDuty (ID, Name, dept, designation, role)
        SELECT @supervisor_id, Name, Dept, Designation, 'supervisor'
        FROM teachers
        WHERE teachers_ID = @supervisor_id;
        
        SET @i = @i + 1;
    END WHILE;
    
    -- Insert a random helper
    SET @helper_id = (
        SELECT helper_ID
        FROM helper
        ORDER BY RAND()
        LIMIT 1
    );
    
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @helper_id, Name, Dept, Designation, 'helper'
    FROM helper
    WHERE helper_ID = @helper_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dutyDist` (IN `students_size` INT)   BEGIN
    DECLARE done INT DEFAULT 0;
    
    -- Delete existing data in the examDuty table
    DELETE FROM examDuty;
    
    -- Find a random chief supervisor from Professors or Associate Professors with the least dutyCount
    SELECT teachers_ID, Designation, Dept INTO @chief_supervisor_id, @chief_supervisor_designation, @chief_supervisor_dept
    FROM teachers
    WHERE Designation IN ('Professor', 'Associate Professor')
    ORDER BY dutyCount ASC, RAND()
    LIMIT 1;
    
    -- Insert the chief supervisor into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @chief_supervisor_id, Name, @chief_supervisor_dept, @chief_supervisor_designation, 'Chief Supervisor'
    FROM teachers
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Increase the dutyCount of the chief supervisor
    UPDATE teachers
    SET dutyCount = dutyCount + 1
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Calculate the number of supervisors based on students_size
    SET @num_supervisors = FLOOR(students_size / 15);
    
    -- Insert random teachers as supervisors with the least dutyCount
    SET @i = 1;
    
    WHILE @i <= @num_supervisors DO
        SELECT teachers_ID, Designation, Dept INTO @supervisor_id, @supervisor_designation, @supervisor_dept
        FROM teachers
        WHERE Designation NOT IN ('Chief Supervisor', 'Supervisor')
        ORDER BY dutyCount ASC, RAND()
        LIMIT 1;
        
        -- Insert the supervisor into the examDuty table with the correct designation
        INSERT INTO examDuty (ID, Name, dept, designation, role)
        SELECT @supervisor_id, Name, @supervisor_dept, @supervisor_designation, 'Supervisor'
        FROM teachers
        WHERE teachers_ID = @supervisor_id;
        
        -- Increase the dutyCount of the supervisor
        UPDATE teachers
        SET dutyCount = dutyCount + 1
        WHERE teachers_ID = @supervisor_id;
        
        SET @i = @i + 1;
    END WHILE;
    
    -- Find a random helper with the least dutyCount
    SELECT helper_ID, Designation INTO @helper_id, @helper_designation
    FROM helper
    ORDER BY dutyCount ASC, RAND()
    LIMIT 1;
    
    -- Insert the helper into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @helper_id, Name, NULL, @helper_designation, 'Helper'
    FROM helper
    WHERE helper_ID = @helper_id;
    
    -- Increase the dutyCount of the helper
    UPDATE helper
    SET dutyCount = dutyCount + 1
    WHERE helper_ID = @helper_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `examdutygen` (IN `students_size` INT)   BEGIN
    DECLARE done INT DEFAULT 0;
    
    -- Delete existing data in the examDuty table
    DELETE FROM examDuty;
    
    -- Find a random chief supervisor from Professors or Associate Professors with the least dutyCount
    SELECT teachers_ID, Designation, Dept INTO @chief_supervisor_id, @chief_supervisor_designation, @chief_supervisor_dept
    FROM teachers
    WHERE Designation IN ('Professor', 'Associate Professor')
    ORDER BY dutyCount ASC, RAND()
    LIMIT 1;
    
    -- Insert the chief supervisor into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @chief_supervisor_id, Name, @chief_supervisor_dept, @chief_supervisor_designation, 'chief supervisor'
    FROM teachers
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Increase the dutyCount of the chief supervisor
    UPDATE teachers
    SET dutyCount = dutyCount + 1
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Calculate the number of supervisors based on students_size
    SET @num_supervisors = FLOOR(students_size / 15);
    
    -- Insert random teachers as supervisors with the least dutyCount
    SET @i = 1;
    
    WHILE @i <= @num_supervisors DO
        SELECT teachers_ID, Designation, Dept INTO @supervisor_id, @supervisor_designation, @supervisor_dept
        FROM teachers
        WHERE Designation NOT IN ('chief supervisor', 'supervisor')
        ORDER BY dutyCount ASC, RAND()
        LIMIT 1;
        
        -- Insert the supervisor into the examDuty table with the correct designation
        INSERT INTO examDuty (ID, Name, dept, designation, role)
        SELECT @supervisor_id, Name, @supervisor_dept, @supervisor_designation, 'supervisor'
        FROM teachers
        WHERE teachers_ID = @supervisor_id;
        
        -- Increase the dutyCount of the supervisor
        UPDATE teachers
        SET dutyCount = dutyCount + 1
        WHERE teachers_ID = @supervisor_id;
        
        SET @i = @i + 1;
    END WHILE;
    
    -- Find a random helper with the least dutyCount
    SELECT helper_ID, Designation INTO @helper_id, @helper_designation
    FROM helper
    ORDER BY dutyCount ASC, RAND()
    LIMIT 1;
    
    -- Insert the helper into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @helper_id, Name, NULL, @helper_designation, 'helper'
    FROM helper
    WHERE helper_ID = @helper_id;
    
    -- Increase the dutyCount of the helper
    UPDATE helper
    SET dutyCount = dutyCount + 1
    WHERE helper_ID = @helper_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `examRot` (IN `students_size` INT)   BEGIN
    DECLARE done INT DEFAULT 0;
    
    -- Delete existing data in the examDuty table
    DELETE FROM examDuty;
    
    -- Find a random chief supervisor from Professors or Associate Professors with the least dutyCount
    SELECT teachers_ID, Designation, Dept INTO @chief_supervisor_id, @chief_supervisor_designation, @chief_supervisor_dept
    FROM teachers
    WHERE Designation IN ('Professor', 'Associate Professor')
    ORDER BY dutyCount ASC, RAND()
    LIMIT 1;
    
    -- Insert the chief supervisor into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @chief_supervisor_id, Name, @chief_supervisor_dept, @chief_supervisor_designation, UCASE('chief supervisor')
    FROM teachers
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Increase the dutyCount of the chief supervisor
    UPDATE teachers
    SET dutyCount = dutyCount + 1
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Calculate the number of supervisors based on students_size
    SET @num_supervisors = FLOOR(students_size / 15);
    
    -- Insert random teachers as supervisors with the least dutyCount
    SET @i = 1;
    
    WHILE @i <= @num_supervisors DO
        SELECT teachers_ID, Designation, Dept INTO @supervisor_id, @supervisor_designation, @supervisor_dept
        FROM teachers
        WHERE Designation NOT IN ('chief supervisor', 'supervisor')
        ORDER BY dutyCount ASC, RAND()
        LIMIT 1;
        
        -- Insert the supervisor into the examDuty table with the correct designation
        INSERT INTO examDuty (ID, Name, dept, designation, role)
        SELECT @supervisor_id, Name, @supervisor_dept, @supervisor_designation, UCASE('supervisor')
        FROM teachers
        WHERE teachers_ID = @supervisor_id;
        
        -- Increase the dutyCount of the supervisor
        UPDATE teachers
        SET dutyCount = dutyCount + 1
        WHERE teachers_ID = @supervisor_id;
        
        SET @i = @i + 1;
    END WHILE;
    
    -- Find a random helper with the least dutyCount
    SELECT helper_ID, Designation INTO @helper_id, @helper_designation
    FROM helper
    ORDER BY dutyCount ASC, RAND()
    LIMIT 1;
    
    -- Insert the helper into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @helper_id, Name, NULL, @helper_designation, UCASE('helper')
    FROM helper
    WHERE helper_ID = @helper_id;
    
    -- Increase the dutyCount of the helper
    UPDATE helper
    SET dutyCount = dutyCount + 1
    WHERE helper_ID = @helper_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `final_exam` (IN `students_size` INT)   BEGIN
    DECLARE done INT DEFAULT 0;
    
    -- Delete existing data in the examDuty table
    DELETE FROM examDuty;
    
    -- Find a random chief supervisor from Professors or Associate Professors with the least dutyCount
    SELECT teachers_ID, Designation, Dept INTO @chief_supervisor_id, @chief_supervisor_designation, @chief_supervisor_dept
    FROM teachers
    WHERE Designation IN ('Professor', 'Associate Professor')
    ORDER BY dutyCount ASC, RAND()
    LIMIT 1;
    
    -- Insert the chief supervisor into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @chief_supervisor_id, Name, @chief_supervisor_dept, @chief_supervisor_designation, CONCAT(UCASE(LEFT('Chief Supervisor', 1)), LCASE(SUBSTRING('Chief Supervisor', 2)))
    FROM teachers
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Increase the dutyCount of the chief supervisor
    UPDATE teachers
    SET dutyCount = dutyCount + 1
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Calculate the number of supervisors based on students_size
    SET @num_supervisors = FLOOR(students_size / 15);
    
    -- Insert random teachers as supervisors with the least dutyCount
    SET @i = 1;
    
    WHILE @i <= @num_supervisors DO
        SELECT teachers_ID, Designation, Dept INTO @supervisor_id, @supervisor_designation, @supervisor_dept
        FROM teachers
        WHERE Designation NOT IN ('Chief Supervisor', 'Supervisor')
        ORDER BY dutyCount ASC, RAND()
        LIMIT 1;
        
        -- Insert the supervisor into the examDuty table with the correct designation
        INSERT INTO examDuty (ID, Name, dept, designation, role)
        SELECT @supervisor_id, Name, @supervisor_dept, @supervisor_designation, CONCAT(UCASE(LEFT('Supervisor', 1)), LCASE(SUBSTRING('Supervisor', 2)))
        FROM teachers
        WHERE teachers_ID = @supervisor_id;
        
        -- Increase the dutyCount of the supervisor
        UPDATE teachers
        SET dutyCount = dutyCount + 1
        WHERE teachers_ID = @supervisor_id;
        
        SET @i = @i + 1;
    END WHILE;
    
    -- Find a random helper with the least dutyCount
    SELECT helper_ID, Designation INTO @helper_id, @helper_designation
    FROM helper
    ORDER BY dutyCount ASC, RAND()
    LIMIT 1;
    
    -- Insert the helper into the examDuty table with the correct designation
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @helper_id, Name, NULL, @helper_designation, CONCAT(UCASE(LEFT('Helper', 1)), LCASE(SUBSTRING('Helper', 2)))
    FROM helper
    WHERE helper_ID = @helper_id;
    
    -- Increase the dutyCount of the helper
    UPDATE helper
    SET dutyCount = dutyCount + 1
    WHERE helper_ID = @helper_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateExamDuty` (IN `students_size` INT)   BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE chief_supervisor_name VARCHAR(255);
    DECLARE num_supervisors INT;
    DECLARE i INT;
    
    -- Find a random chief supervisor from Professors or Associate Professors
    SELECT Name INTO chief_supervisor_name
    FROM teachers
    WHERE Designation IN ('Professor', 'Associate Professor')
    ORDER BY RAND()
    LIMIT 1;
    
    -- Insert the chief supervisor into the examDuty table
    INSERT INTO examDuty (Name, dept, designation, role)
    VALUES (chief_supervisor_name, 'CSE', 'Professor', 'chief supervisor');
    
    -- Calculate the number of supervisors based on students_size
    SET num_supervisors = CEIL(students_size / 15);
    
    -- Insert random teachers as supervisors
    SET i = 1;
    WHILE i <= num_supervisors DO
        INSERT INTO examDuty (Name, dept, designation, role)
        SELECT Name, Dept, Designation, 'supervisor'
        FROM teachers
        WHERE Designation NOT IN ('chief supervisor', 'supervisor')
        ORDER BY RAND()
        LIMIT 1;
        SET i = i + 1;
    END WHILE;
    
    -- Insert a random helper
    INSERT INTO examDuty (Name, dept, designation, role)
    SELECT Name, Dept, Designation, 'helper'
    FROM helper
    ORDER BY RAND()
    LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateExamDutyWithIDs` (IN `students_size` INT)   BEGIN
    DECLARE done INT DEFAULT 0;
    
    -- Find a random chief supervisor from Professors or Associate Professors
    SET @chief_supervisor_id = (
        SELECT teachers_ID
        FROM teachers
        WHERE Designation IN ('Professor', 'Associate Professor')
        ORDER BY RAND()
        LIMIT 1
    );
    
    -- Insert the chief supervisor into the examDuty table
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @chief_supervisor_id, Name, 'CSE', 'Professor', 'chief supervisor'
    FROM teachers
    WHERE teachers_ID = @chief_supervisor_id;
    
    -- Calculate the number of supervisors based on students_size
    SET @num_supervisors = CEIL(students_size / 15);
    
    -- Insert random teachers as supervisors
    SET @i = 1;
    
    WHILE @i <= @num_supervisors DO
        SET @supervisor_id = (
            SELECT teachers_ID
            FROM teachers
            WHERE Designation NOT IN ('chief supervisor', 'supervisor')
            ORDER BY RAND()
            LIMIT 1
        );
        
        INSERT INTO examDuty (ID, Name, dept, designation, role)
        SELECT @supervisor_id, Name, Dept, Designation, 'supervisor'
        FROM teachers
        WHERE teachers_ID = @supervisor_id;
        
        SET @i = @i + 1;
    END WHILE;
    
    -- Insert a random helper
    SET @helper_id = (
        SELECT helper_ID
        FROM helper
        ORDER BY RAND()
        LIMIT 1
    );
    
    INSERT INTO examDuty (ID, Name, dept, designation, role)
    SELECT @helper_id, Name, Dept, Designation, 'helper'
    FROM helper
    WHERE helper_ID = @helper_id;
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `calender`
--

CREATE TABLE `calender` (
  `id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `day_type` varchar(255) DEFAULT NULL,
  `day` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `calender`
--

INSERT INTO `calender` (`id`, `date`, `day_type`, `day`) VALUES
(1, '2023-01-01', 'on', NULL),
(2, '2023-01-02', 'on', NULL),
(3, '2023-01-03', 'on', NULL),
(4, '2023-01-04', 'on', NULL),
(5, '2023-01-05', 'on', NULL),
(6, '2023-01-06', 'off', NULL),
(7, '2023-01-07', 'off', NULL),
(8, '2023-01-08', 'on', NULL),
(9, '2023-01-09', 'on', NULL),
(10, '2023-01-10', 'on', NULL),
(11, '2023-01-11', 'on', NULL),
(12, '2023-01-12', 'on', NULL),
(13, '2023-01-13', 'off', NULL),
(14, '2023-01-14', 'off', NULL),
(15, '2023-01-15', 'on', NULL),
(16, '2023-01-16', 'on', NULL),
(17, '2023-01-17', 'on', NULL),
(18, '2023-01-18', 'on', NULL),
(19, '2023-01-19', 'on', NULL),
(20, '2023-01-20', 'off', NULL),
(21, '2023-01-21', 'off', NULL),
(22, '2023-01-22', 'on', NULL),
(23, '2023-01-23', 'on', NULL),
(24, '2023-01-24', 'on', NULL),
(25, '2023-01-25', 'on', NULL),
(26, '2023-01-26', 'off', NULL),
(27, '2023-01-27', 'off', NULL),
(28, '2023-01-28', 'off', NULL),
(29, '2023-01-29', 'on', NULL),
(30, '2023-01-30', 'on', NULL),
(31, '2023-01-31', 'on', NULL),
(32, '2023-02-01', 'on', NULL),
(33, '2023-02-02', 'on', NULL),
(34, '2023-02-03', 'off', NULL),
(35, '2023-02-04', 'off', NULL),
(36, '2023-02-05', 'on', NULL),
(37, '2023-02-06', 'on', NULL),
(38, '2023-02-07', 'on', NULL),
(39, '2023-02-08', 'on', NULL),
(40, '2023-02-09', 'on', NULL),
(41, '2023-02-10', 'off', NULL),
(42, '2023-02-11', 'off', NULL),
(43, '2023-02-12', 'on', NULL),
(44, '2023-02-13', 'on', NULL),
(45, '2023-02-14', 'on', NULL),
(46, '2023-02-15', 'on', NULL),
(47, '2023-02-16', 'on', NULL),
(48, '2023-02-17', 'off', NULL),
(49, '2023-02-18', 'off', NULL),
(50, '2023-02-19', 'off', NULL),
(51, '2023-02-20', 'on', NULL),
(52, '2023-02-21', 'off', NULL),
(53, '2023-02-22', 'on', NULL),
(54, '2023-02-23', 'on', NULL),
(55, '2023-02-24', 'off', NULL),
(56, '2023-02-25', 'off', NULL),
(57, '2023-02-26', 'on', NULL),
(58, '2023-02-27', 'on', NULL),
(59, '2023-02-28', 'on', NULL),
(60, '2023-03-01', 'on', NULL),
(61, '2023-03-02', 'on', NULL),
(62, '2023-03-03', 'off', NULL),
(63, '2023-03-04', 'off', NULL),
(64, '2023-03-05', 'on', NULL),
(65, '2023-03-06', 'on', NULL),
(66, '2023-03-07', 'on', NULL),
(67, '2023-03-08', 'off', NULL),
(68, '2023-03-09', 'on', NULL),
(69, '2023-03-10', 'off', NULL),
(70, '2023-03-11', 'off', NULL),
(71, '2023-03-12', 'on', NULL),
(72, '2023-03-13', 'on', NULL),
(73, '2023-03-14', 'on', NULL),
(74, '2023-03-15', 'on', NULL),
(75, '2023-03-16', 'on', NULL),
(76, '2023-03-17', 'off', NULL),
(77, '2023-03-18', 'off', NULL),
(78, '2023-03-19', 'on', NULL),
(79, '2023-03-20', 'on', NULL),
(80, '2023-03-21', 'on', NULL),
(81, '2023-03-22', 'on', NULL),
(82, '2023-03-23', 'on', NULL),
(83, '2023-03-24', 'off', NULL),
(84, '2023-03-25', 'off', NULL),
(85, '2023-03-26', 'off', NULL),
(86, '2023-03-27', 'on', NULL),
(87, '2023-03-28', 'on', NULL),
(88, '2023-03-29', 'on', NULL),
(89, '2023-03-30', 'on', NULL),
(90, '2023-03-31', 'off', NULL),
(91, '2023-04-01', 'off', NULL),
(92, '2023-04-02', 'on', NULL),
(93, '2023-04-03', 'on', NULL),
(94, '2023-04-04', 'on', NULL),
(95, '2023-04-05', 'on', NULL),
(96, '2023-04-06', 'on', NULL),
(97, '2023-04-07', 'off', NULL),
(98, '2023-04-08', 'off', NULL),
(99, '2023-04-09', 'on', NULL),
(100, '2023-04-10', 'on', NULL),
(101, '2023-04-11', 'on', NULL),
(102, '2023-04-12', 'on', NULL),
(103, '2023-04-13', 'on', NULL),
(104, '2023-04-14', 'off', NULL),
(105, '2023-04-15', 'off', NULL),
(106, '2023-04-16', 'off', NULL),
(107, '2023-04-17', 'off', NULL),
(108, '2023-04-18', 'off', NULL),
(109, '2023-04-19', 'off', NULL),
(110, '2023-04-20', 'off', NULL),
(111, '2023-04-21', 'off', NULL),
(112, '2023-04-22', 'off', NULL),
(113, '2023-04-23', 'off', NULL),
(114, '2023-04-24', 'off', NULL),
(115, '2023-04-25', 'off', NULL),
(116, '2023-04-26', 'off', NULL),
(117, '2023-04-27', 'off', NULL),
(118, '2023-04-28', 'off', NULL),
(119, '2023-04-29', 'off', NULL),
(120, '2023-04-30', 'off', NULL),
(121, '2023-05-01', 'off', NULL),
(122, '2023-05-02', 'on', NULL),
(123, '2023-05-03', 'on', NULL),
(124, '2023-05-04', 'off', NULL),
(125, '2023-05-05', 'off', NULL),
(126, '2023-05-06', 'off', NULL),
(127, '2023-05-07', 'on', NULL),
(128, '2023-05-08', 'on', NULL),
(129, '2023-05-09', 'on', NULL),
(130, '2023-05-10', 'on', NULL),
(131, '2023-05-11', 'on', NULL),
(132, '2023-05-12', 'off', NULL),
(133, '2023-05-13', 'off', NULL),
(134, '2023-05-14', 'on', NULL),
(135, '2023-05-15', 'on', NULL),
(136, '2023-05-16', 'on', NULL),
(137, '2023-05-17', 'on', NULL),
(138, '2023-05-18', 'on', NULL),
(139, '2023-05-19', 'off', NULL),
(140, '2023-05-20', 'off', NULL),
(141, '2023-05-21', 'on', NULL),
(142, '2023-05-22', 'on', NULL),
(143, '2023-05-23', 'on', NULL),
(144, '2023-05-24', 'on', NULL),
(145, '2023-05-25', 'on', NULL),
(146, '2023-05-26', 'off', NULL),
(147, '2023-05-27', 'off', NULL),
(148, '2023-05-28', 'on', NULL),
(149, '2023-05-29', 'on', NULL),
(150, '2023-05-30', 'on', NULL),
(151, '2023-05-31', 'on', NULL),
(152, '2023-06-01', 'on', NULL),
(153, '2023-06-02', 'off', NULL),
(154, '2023-06-03', 'off', NULL),
(155, '2023-06-04', 'on', NULL),
(156, '2023-06-05', 'on', NULL),
(157, '2023-06-06', 'on', NULL),
(158, '2023-06-07', 'on', NULL),
(159, '2023-06-08', 'on', NULL),
(160, '2023-06-09', 'off', NULL),
(161, '2023-06-10', 'off', NULL),
(162, '2023-06-11', 'on', NULL),
(163, '2023-06-12', 'on', NULL),
(164, '2023-06-13', 'on', NULL),
(165, '2023-06-14', 'on', NULL),
(166, '2023-06-15', 'on', NULL),
(167, '2023-06-16', 'off', NULL),
(168, '2023-06-17', 'off', NULL),
(169, '2023-06-18', 'on', NULL),
(170, '2023-06-19', 'on', NULL),
(171, '2023-06-20', 'on', NULL),
(172, '2023-06-21', 'on', NULL),
(173, '2023-06-22', 'on', NULL),
(174, '2023-06-23', 'off', NULL),
(175, '2023-06-24', 'off', NULL),
(176, '2023-06-25', 'off', NULL),
(177, '2023-06-26', 'off', NULL),
(178, '2023-06-27', 'off', NULL),
(179, '2023-06-28', 'off', NULL),
(180, '2023-06-29', 'off', NULL),
(181, '2023-06-30', 'off', NULL),
(182, '2023-07-01', 'off', NULL),
(183, '2023-07-02', 'off', NULL),
(184, '2023-07-03', 'off', NULL),
(185, '2023-07-04', 'off', NULL),
(186, '2023-07-05', 'off', NULL),
(187, '2023-07-06', 'off', NULL),
(188, '2023-07-07', 'off', NULL),
(189, '2023-07-08', 'off', NULL),
(190, '2023-07-09', 'on', NULL),
(191, '2023-07-10', 'on', NULL),
(192, '2023-07-11', 'on', NULL),
(193, '2023-07-12', 'on', NULL),
(194, '2023-07-13', 'on', NULL),
(195, '2023-07-14', 'off', NULL),
(196, '2023-07-15', 'off', NULL),
(197, '2023-07-16', 'on', NULL),
(198, '2023-07-17', 'on', NULL),
(199, '2023-07-18', 'on', NULL),
(200, '2023-07-19', 'on', NULL),
(201, '2023-07-20', 'on', NULL),
(202, '2023-07-21', 'off', NULL),
(203, '2023-07-22', 'off', NULL),
(204, '2023-07-23', 'on', NULL),
(205, '2023-07-24', 'on', NULL),
(206, '2023-07-25', 'on', NULL),
(207, '2023-07-26', 'on', NULL),
(208, '2023-07-27', 'on', NULL),
(209, '2023-07-28', 'off', NULL),
(210, '2023-07-29', 'off', NULL),
(211, '2023-07-30', 'on', NULL),
(212, '2023-07-31', 'on', NULL),
(213, '2023-08-01', 'on', NULL),
(214, '2023-08-02', 'on', NULL),
(215, '2023-08-03', 'on', NULL),
(216, '2023-08-04', 'off', NULL),
(217, '2023-08-05', 'off', NULL),
(218, '2023-08-06', 'on', NULL),
(219, '2023-08-07', 'on', NULL),
(220, '2023-08-08', 'on', NULL),
(221, '2023-08-09', 'on', NULL),
(222, '2023-08-10', 'on', NULL),
(223, '2023-08-11', 'off', NULL),
(224, '2023-08-12', 'off', NULL),
(225, '2023-08-13', 'on', NULL),
(226, '2023-08-14', 'on', NULL),
(227, '2023-08-15', 'off', NULL),
(228, '2023-08-16', 'on', NULL),
(229, '2023-08-17', 'on', NULL),
(230, '2023-08-18', 'off', NULL),
(231, '2023-08-19', 'off', NULL),
(232, '2023-08-20', 'on', NULL),
(233, '2023-08-21', 'on', NULL),
(234, '2023-08-22', 'on', NULL),
(235, '2023-08-23', 'on', NULL),
(236, '2023-08-24', 'on', NULL),
(237, '2023-08-25', 'off', NULL),
(238, '2023-08-26', 'off', NULL),
(239, '2023-08-27', 'on', NULL),
(240, '2023-08-28', 'on', NULL),
(241, '2023-08-29', 'on', NULL),
(242, '2023-08-30', 'on', NULL),
(243, '2023-08-31', 'on', NULL),
(244, '2023-09-01', 'off', NULL),
(245, '2023-09-02', 'off', NULL),
(246, '2023-09-03', 'on', NULL),
(247, '2023-09-04', 'on', NULL),
(248, '2023-09-05', 'on', NULL),
(249, '2023-09-06', 'off', NULL),
(250, '2023-09-07', 'on', NULL),
(251, '2023-09-08', 'off', NULL),
(252, '2023-09-09', 'off', NULL),
(253, '2023-09-10', 'on', NULL),
(254, '2023-09-11', 'off', NULL),
(255, '2023-09-12', 'on', NULL),
(256, '2023-09-13', 'off', NULL),
(257, '2023-09-14', 'on', NULL),
(258, '2023-09-15', 'off', NULL),
(259, '2023-09-16', 'off', NULL),
(260, '2023-09-17', 'on', NULL),
(261, '2023-09-18', 'on', NULL),
(262, '2023-09-19', 'on', NULL),
(263, '2023-09-20', 'on', NULL),
(264, '2023-09-21', 'on', NULL),
(265, '2023-09-22', 'off', NULL),
(266, '2023-09-23', 'off', NULL),
(267, '2023-09-24', 'on', NULL),
(268, '2023-09-25', 'on', NULL),
(269, '2023-09-26', 'on', NULL),
(270, '2023-09-27', 'on', NULL),
(271, '2023-09-28', 'off', NULL),
(272, '2023-09-29', 'off', NULL),
(273, '2023-09-30', 'off', NULL),
(274, '2023-10-01', 'on', NULL),
(275, '2023-10-02', 'on', NULL),
(276, '2023-10-03', 'on', NULL),
(277, '2023-10-04', 'on', NULL),
(278, '2023-10-05', 'on', NULL),
(279, '2023-10-06', 'off', NULL),
(280, '2023-10-07', 'off', NULL),
(281, '2023-10-08', 'on', NULL),
(282, '2023-10-09', 'on', NULL),
(283, '2023-10-10', 'on', NULL),
(284, '2023-10-11', 'on', NULL),
(285, '2023-10-12', 'on', NULL),
(286, '2023-10-13', 'off', NULL),
(287, '2023-10-14', 'off', NULL),
(288, '2023-10-15', 'on', NULL),
(289, '2023-10-16', 'on', NULL),
(290, '2023-10-17', 'on', NULL),
(291, '2023-10-18', 'on', NULL),
(292, '2023-10-19', 'on', NULL),
(293, '2023-10-20', 'off', NULL),
(294, '2023-10-21', 'off', NULL),
(295, '2023-10-22', 'off', NULL),
(296, '2023-10-23', 'off', NULL),
(297, '2023-10-24', 'off', NULL),
(298, '2023-10-25', 'off', NULL),
(299, '2023-10-26', 'off', NULL),
(300, '2023-10-27', 'off', NULL),
(301, '2023-10-28', 'off', NULL),
(302, '2023-10-29', 'on', NULL),
(303, '2023-10-30', 'on', NULL),
(304, '2023-10-31', 'on', NULL),
(305, '2023-11-01', 'on', NULL),
(306, '2023-11-02', 'on', NULL),
(307, '2023-11-03', 'off', NULL),
(308, '2023-11-04', 'off', NULL),
(309, '2023-11-05', 'on', NULL),
(310, '2023-11-06', 'on', NULL),
(311, '2023-11-07', 'on', NULL),
(312, '2023-11-08', 'on', NULL),
(313, '2023-11-09', 'on', NULL),
(314, '2023-11-10', 'off', NULL),
(315, '2023-11-11', 'off', NULL),
(316, '2023-11-12', 'on', NULL),
(317, '2023-11-13', 'on', NULL),
(318, '2023-11-14', 'on', NULL),
(319, '2023-11-15', 'on', NULL),
(320, '2023-11-16', 'on', NULL),
(321, '2023-11-17', 'off', NULL),
(322, '2023-11-18', 'off', NULL),
(323, '2023-11-19', 'on', NULL),
(324, '2023-11-20', 'on', NULL),
(325, '2023-11-21', 'on', NULL),
(326, '2023-11-22', 'on', NULL),
(327, '2023-11-23', 'on', NULL),
(328, '2023-11-24', 'off', NULL),
(329, '2023-11-25', 'off', NULL),
(330, '2023-11-26', 'on', NULL),
(331, '2023-11-27', 'on', NULL),
(332, '2023-11-28', 'on', NULL),
(333, '2023-11-29', 'on', NULL),
(334, '2023-11-30', 'on', NULL),
(335, '2023-12-01', 'off', NULL),
(336, '2023-12-02', 'off', NULL),
(337, '2023-12-03', 'on', NULL),
(338, '2023-12-04', 'on', NULL),
(339, '2023-12-05', 'on', NULL),
(340, '2023-12-06', 'on', NULL),
(341, '2023-12-07', 'on', NULL),
(342, '2023-12-08', 'off', NULL),
(343, '2023-12-09', 'off', NULL),
(344, '2023-12-10', 'on', NULL),
(345, '2023-12-11', 'on', NULL),
(346, '2023-12-12', 'on', NULL),
(347, '2023-12-13', 'on', NULL),
(348, '2023-12-14', 'off', NULL),
(349, '2023-12-15', 'off', NULL),
(350, '2023-12-16', 'off', NULL),
(351, '2023-12-17', 'on', NULL),
(352, '2023-12-18', 'on', NULL),
(353, '2023-12-19', 'on', NULL),
(354, '2023-12-20', 'on', NULL),
(355, '2023-12-21', 'on', NULL),
(356, '2023-12-22', 'off', NULL),
(357, '2023-12-23', 'off', NULL),
(358, '2023-12-24', 'off', NULL),
(359, '2023-12-25', 'off', NULL),
(360, '2023-12-26', 'off', NULL),
(361, '2023-12-27', 'off', NULL),
(362, '2023-12-28', 'off', NULL),
(363, '2023-12-29', 'off', NULL),
(364, '2023-12-30', 'off', NULL),
(365, '2023-12-31', 'off', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `examduty`
--

CREATE TABLE `examduty` (
  `ID` int(11) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `dept` enum('CSE','ECE','EEE') NOT NULL,
  `designation` varchar(255) NOT NULL,
  `role` enum('Chief Supervisor','Supervisor','Assistant') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `examduty`
--

INSERT INTO `examduty` (`ID`, `Name`, `dept`, `designation`, `role`) VALUES
(32, 'Dr. Nasrin Sultana', 'ECE', 'Associate Professor', 'Chief Supervisor'),
(8, 'Dr. Md. Arshad Ali', 'CSE', 'Professor', 'Supervisor'),
(2, 'Dr. Md. Abdulla Al Mamun', 'CSE', 'Professor', 'Supervisor'),
(1, 'Helper 1', '', 'helper', '');

-- --------------------------------------------------------

--
-- Table structure for table `helper`
--

CREATE TABLE `helper` (
  `helper_ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Dept` enum('CSE','ECE','EEE') NOT NULL,
  `Designation` enum('helper') NOT NULL,
  `dutyCount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `helper`
--

INSERT INTO `helper` (`helper_ID`, `Name`, `Dept`, `Designation`, `dutyCount`) VALUES
(1, 'Helper 1', 'CSE', 'helper', 38),
(2, 'Helper 2', 'ECE', 'helper', 38),
(3, 'Helper 3', 'EEE', 'helper', 38),
(4, 'Helper 4', 'CSE', 'helper', 38),
(5, 'Helper 5', 'ECE', 'helper', 38),
(6, 'Helper 6', 'EEE', 'helper', 38),
(7, 'Helper 7', 'CSE', 'helper', 38);

-- --------------------------------------------------------

--
-- Table structure for table `routine`
--

CREATE TABLE `routine` (
  `course_code` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `totStudents` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `routine`
--

INSERT INTO `routine` (`course_code`, `date`, `totStudents`) VALUES
('ACT 293 ', '2023-02-15', 45),
('ECE 251', '2023-02-22', 55),
('ECE 253', '2023-02-27', 65),
('ECE 255 ', '2023-03-02', 67),
('ECE 257', '2023-03-07', 70),
('CSE 261', '2023-03-13', 44),
('STT 211 ', '2023-03-16', 43);

-- --------------------------------------------------------

--
-- Table structure for table `syllabus_csefaculty`
--

CREATE TABLE `syllabus_csefaculty` (
  `id` int(50) NOT NULL,
  `faculty` varchar(255) DEFAULT NULL,
  `degree` varchar(50) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `semester` varchar(255) DEFAULT NULL,
  `course_code` varchar(255) DEFAULT NULL,
  `course_title` varchar(255) DEFAULT NULL,
  `credit_hours` varchar(255) DEFAULT NULL,
  `contact_hours` varchar(255) DEFAULT NULL,
  `course_type` varchar(255) DEFAULT NULL,
  `course_category` varchar(255) DEFAULT NULL,
  `conduct_department` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `syllabus_csefaculty`
--

INSERT INTO `syllabus_csefaculty` (`id`, `faculty`, `degree`, `level`, `semester`, `course_code`, `course_title`, `credit_hours`, `contact_hours`, `course_type`, `course_category`, `conduct_department`) VALUES
(6, 'CSE', 'ECE', '1', 'I', 'EEE 103', 'Basic Electrical Engineering', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(7, 'CSE', 'ECE', '1', 'I', 'EEE 104', 'Basic Electrical Engineering Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(8, 'CSE', 'ECE', '1', 'I', 'CSE 107  ', 'Computer Basics and Programming ', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(9, 'CSE', 'ECE', '1', 'I', 'CSE 108 ', 'Computer Basics and Programming  Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(10, 'CSE', 'ECE', '1', 'I', 'MAT 109 ', 'Differential and Integral Calculus ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(11, 'CSE', 'ECE', '1', 'I', 'CHE 139 ', 'Chemistry ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(12, 'CSE', 'ECE', '1', 'I', 'CHE 140', 'Chemistry Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(13, 'CSE', 'ECE', '1', 'I', 'SSL 107', 'Technical English ', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(14, 'CSE', 'ECE', '1', 'I', 'SOC 105', ' Sociology ', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(15, 'CSE', 'ECE', '1', 'II', 'ECE 151 ', 'Electronics-I ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(16, 'CSE', 'ECE', '1', 'II', 'ECE 152', 'Electronics-I Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(17, 'CSE', 'ECE', '1', 'II', 'EEE 157 ', 'Electrical Drives ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(18, 'CSE', 'ECE', '1', 'II', 'EEE 158', 'Electrical Drives Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(19, 'CSE', 'ECE', '1', 'II', 'AIE 110 ', 'Mechanical Engineering Drawing ', '0.75', '1.50', 'Theory', 'Compulsory', ''),
(20, 'CSE', 'ECE', '1', 'II', 'PHY 111 ', 'Engineering Physics ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(21, 'CSE', 'ECE', '1', 'II', 'PHY 112', 'Engineering Physics Sessional', '1.00', '2.00', 'Sessional', 'Compulsory', ''),
(22, 'CSE', 'ECE', '1', 'II', 'MAT 113', 'Ordinary & Partial Differential Equations  and Mat', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(23, 'CSE', 'ECE', '1', 'II', 'ECN 129', 'Economics ', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(24, 'CSE', 'ECE', '2', 'I', 'ECE 202', 'Electronic Circuit Design Sessional ', '1.00', '2.00', 'Sessional', 'Compulsory', ''),
(25, 'CSE', 'ECE', '2', 'I', 'ECE 203 ', 'Electronics-II ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(26, 'CSE', 'ECE', '2', 'I', 'ECE 204 ', 'Electronic-II Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(27, 'CSE', 'ECE', '2', 'I', 'ECE 205', 'Signals and Systems ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(28, 'CSE', 'ECE', '2', 'I', 'ECE 206', 'Signals and Systems Sessional ', '3.00', '3.00', 'Sessional', 'Compulsory', ''),
(29, 'CSE', 'ECE', '2', 'I', 'CSE 211', 'Data Structures and Algorithms ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(30, 'CSE', 'ECE', '2', 'I', 'CSE 212', 'Data Structures and Algorithms Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(31, 'CSE', 'ECE', '2', 'I', 'MAT 203 ', 'Vector Analysis and Operational Calculus', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(32, 'CSE', 'ECE', '2', 'II', 'ACT 293 ', 'Financial and Manegerial Accounting', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(33, 'CSE', 'ECE', '2', 'II', 'ECE 251', 'Digital Logic Design ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(34, 'CSE', 'ECE', '2', 'II', 'ECE 252 ', 'Digital Logic Design Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(35, 'CSE', 'ECE', '2', 'II', 'ECE 253', 'Electromagnetic Fields & Waves', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(36, 'CSE', 'ECE', '2', 'II', 'ECE 255 ', 'Analog Communications ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(37, 'CSE', 'ECE', '2', 'II', 'ECE 256', 'Analog Communications Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(38, 'CSE', 'ECE', '2', 'II', 'ECE 257', 'Industrial Electronics ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(39, 'CSE', 'ECE', '2', 'II', 'ECE 258', 'Industrial Electronics Sessional  ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(40, 'CSE', 'ECE', '2', 'II', 'CSE 261', 'Object Oriented and Internet Programming ', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(41, 'CSE', 'ECE', '2', 'II', 'CSE 262 ', 'Object Oriented Programming Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(42, 'CSE', 'ECE', '2', 'II', 'STT 211 ', 'Engineering Statistics and Complex  Variables', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(43, 'CSE', 'ECE', '3', 'I', 'ECE 301', 'Semiconductor physics and devices ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(44, 'CSE', 'ECE', '3', 'I', 'ECE 303', 'Control System Engineering', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(45, 'CSE', 'ECE', '3', 'I', 'ECE 304', 'Control System Engineering Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(46, 'CSE', 'ECE', '3', 'I', 'ECE 305', 'Digital Communication', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(47, 'CSE', 'ECE', '3', 'I', 'ECE 306 ', 'Digital Communication Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(48, 'CSE', 'ECE', '3', 'I', 'ECE 307 ', 'Microwave Engineering ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(49, 'CSE', 'ECE', '3', 'I', 'ECE 308', 'Microwave Engineering Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(50, 'CSE', 'ECE', '3', 'I', 'ECE 309', 'Numerical Methods in Engineering', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(51, 'CSE', 'ECE', '3', 'I', 'ECE 310 ', 'Numerical Methods in Engineering  Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(52, 'CSE', 'ECE', '3', 'I', 'CSE 316', 'Internet Programming Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(53, 'CSE', 'ECE', '3', 'II', 'ECE 352', 'Electronic Project Design and  Development ', '0.75', '1.50', 'Theory', 'Compulsory', ''),
(54, 'CSE', 'ECE', '3', 'II', 'ECE 353 ', 'Information Theory and coding ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(55, 'CSE', 'ECE', '3', 'II', 'ECE 353 ', 'Information Theory and coding ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(56, 'CSE', 'ECE', '3', 'II', 'ECE 355', 'Digital Signal Processing', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(57, 'CSE', 'ECE', '3', 'II', 'ECE 356', 'Digital Signal Processing Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(58, 'CSE', 'ECE', '3', 'II', 'ECE 357 ', 'Computer communications and  Networks', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(59, 'CSE', 'ECE', '3', 'II', 'ECE 358', 'Computer communications and  Networks Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(60, 'CSE', 'ECE', '3', 'II', 'ECE 359 ', 'Antennas and Propagation', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(61, 'CSE', 'ECE', '3', 'II', 'ECE 360 ', 'Antennas and Propagation Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(62, 'CSE', 'ECE', '3', 'II', 'ECE 361 ', 'Microprocessor and Microcomputer ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(63, 'CSE', 'ECE', '3', 'II', 'ECE 362 ', 'Microprocessor and Microcomputer  Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(64, 'CSE', 'ECE', '4', 'I', 'ECE 402 ', 'Project and Thesis', '1.50', '3.00', 'Theory', 'Compulsory', ''),
(65, 'CSE', 'ECE', '4', 'I', 'ECE 403', 'Telecommunication Networks and  Switching', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(66, 'CSE', 'ECE', '4', 'I', 'ECE 404', 'Telecommunication Networks and  Switching Sessiona', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(67, 'CSE', 'ECE', '4', 'I', 'ECE 405  ', 'VLSI Technology ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(68, 'CSE', 'ECE', '4', 'I', 'ECE 406  ', 'VLSI Technology Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(69, 'CSE', 'ECE', '4', 'I', 'ECE 407', 'Wireless and Mobile Communication', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(70, 'CSE', 'ECE', '4', 'I', 'ECE 408 ', 'Wireless and Mobile Communication  Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(71, 'CSE', 'ECE', '4', 'I', 'ECE 409', 'Multimedia Communication ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(72, 'CSE', 'ECE', '4', 'I', 'ECE 410 ', 'Multimedia Communication Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(73, 'CSE', 'ECE', '4', 'I', 'ECE ***', 'Elective I ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(74, 'CSE', 'ECE', '4', 'I', 'ECE +++', 'Sessional based on ECE *** ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(75, 'CSE', 'ECE', '4', 'I', 'ECE 431 ', 'Microwave Integrated Circuit and Filter ', '3.00', '3.00', 'Theory', 'Elective I', ''),
(76, 'CSE', 'ECE', '4', 'I', 'ECE 432', 'Microwave Integrated Circuit and Filter  Sessional', '0.75', '1.50', 'Sessional', 'Elective I', ''),
(77, 'CSE', 'ECE', '4', 'I', 'ECE 433', ' Numerical Techniques in Electromagnetics', '3.00', '3.00', 'Theory', 'Elective I', ''),
(78, 'CSE', 'ECE', '4', 'I', 'ECE 434', 'Numerical Techniques in Electromagnetics  Sessiona', '3.00', '1.50', 'Sessional', 'Elective I', ''),
(79, 'CSE', 'ECE', '4', 'I', 'ECE 435 ', 'Analog Integrated Circuit ', '3.00', '3.00', 'Theory', 'Elective I', ''),
(80, 'CSE', 'ECE', '4', 'I', 'ECE 436', 'Analog Integrated Circuit Sessional', '0.75', '1.50', 'Sessional', 'Elective I', ''),
(81, 'CSE', 'ECE', '4', 'I', 'ECE 437', 'Electronic Instrumentation', '3.00', '3.00', 'Theory', 'Elective I', ''),
(82, 'CSE', 'ECE', '4', 'I', 'ECE 438', 'Electronic Instrumentation Sessional', '0.75', '1.50', 'Sessional', 'Elective I', ''),
(83, 'CSE', 'ECE', '4', 'I', 'ECE 439', 'Biomedical Instrumentation', '3.00', '3.00', 'Theory', 'Elective I', ''),
(84, 'CSE', 'ECE', '4', 'I', 'ECE 440', 'Biomedical Instrumentation Sessional', '0.75', '1.50', 'Sessional', 'Elective I', ''),
(85, 'CSE', 'ECE', '4', 'I', 'ECE 441', 'Digital Speech Processing ', '3.00', '3.00', 'Theory', 'Elective I', ''),
(86, 'CSE', 'ECE', '4', 'I', 'ECE 442 ', 'Digital Speech Processing Sessional', '0.75', '1.50', 'Sessional', 'Elective I', ''),
(87, 'CSE', 'ECE', '4', 'II', 'ECE 452 ', 'Project and Thesis ', '3.00', '6.00', 'Theory', 'Compulsory', ''),
(88, 'CSE', 'ECE', '4', 'II', 'ECE 453 ', 'Radio and Television Engineering ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(89, 'CSE', 'ECE', '4', 'II', 'ECE 454', 'Radio and Television Engineering  Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(90, 'CSE', 'ECE', '4', 'II', 'ECE 455 ', 'Optical Fibre Communications ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(91, 'CSE', 'ECE', '4', 'II', 'ECE 456 ', 'Optical Fibre Communications Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(92, 'CSE', 'ECE', '4', 'II', 'ECE 457', 'Satellite Communications & RADAR ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(93, 'CSE', 'ECE', '4', 'II', 'ECE 458', 'Satellite Communications & RADAR  Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(94, 'CSE', 'ECE', '4', 'II', 'ECE 459', 'Digital Image Processing ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(95, 'CSE', 'ECE', '4', 'II', 'ECE ^^^', 'Elective –II ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(96, 'CSE', 'ECE', '4', 'II', 'ECE ***  ', 'Sessional Based on ECE ^^^', '0.75', '1.50', 'Theory', 'Compulsory', ''),
(97, 'CSE', 'ECE', '4', 'II', 'ECE 481', 'Advanced Communications and networking ', '3.00', '3.00', 'Theory', 'Elective II', ''),
(98, 'CSE', 'ECE', '4', 'II', 'ECE 482', 'Advanced Communications and networking  sessional ', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(99, 'CSE', 'ECE', '4', 'II', 'ECE 483', 'Digital Filter Design ', '3.00', '3.00', 'Theory', 'Elective II', ''),
(100, 'CSE', 'ECE', '4', 'II', 'ECE 484', 'Digital Filter Design Sessional ', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(101, 'CSE', 'ECE', '4', 'II', 'ECE 485', 'Neural and Fuzzy Systems in Communications', '3.00', '3.00', 'Theory', 'Elective II', ''),
(102, 'CSE', 'ECE', '4', 'II', 'ECE 486 ', 'Neural and Fuzzy Systems in Communications  Sessio', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(103, 'CSE', 'ECE', '4', 'II', 'ECE 487  ', 'Optoelectronics ', '3.00', '3.00', 'Theory', 'Elective II', ''),
(104, 'CSE', 'ECE', '4', 'II', 'ECE 488 ', 'Optoelectronics Sessional ', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(105, 'CSE', 'ECE', '4', 'II', 'ECE 489 ', 'Introduction to Nanotahnology ', '3.00', '3.00', 'Theory', 'Elective II', ''),
(106, 'CSE', 'ECE', '4', 'II', 'ECE 490 ', 'Introduction to Nanotahnology Sessional ', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(107, 'CSE', 'ECE', '4', 'II', 'ECE 491 ', 'Digital Integrated Circuit ', '3.00', '3.00', 'Theory', 'Elective II', ''),
(108, 'CSE', 'ECE', '4', 'II', 'ECE 492  ', 'Digital Integrated Circuit Sessional ', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(109, 'CSE', 'CSE', '1', 'I', 'CSE 101 ', 'Fundamentals of Computer and Computing', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(110, 'CSE', 'CSE', '1', 'I', 'CSE 102  ', 'Fundamentals of Computer and Computing  Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(111, 'CSE', 'CSE', '1', 'I', 'CSE 103', 'Discrete Mathematics ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(112, 'CSE', 'CSE', '1', 'I', 'MAT 101 ', 'Mathematics 1 (Calculus and Co-ordinate  Geometry)', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(113, 'CSE', 'CSE', '1', 'I', 'PHY 103', 'Physics (Electricity, Magnetism, Optics, Waves  an', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(114, 'CSE', 'CSE', '1', 'I', 'PHY 104', 'Physics (Electricity, Magnetism, Optics, Waves,  a', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(115, 'CSE', 'CSE', '1', 'I', 'MEE 101', 'Basic Mechanical Engineering', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(116, 'CSE', 'CSE', '1', 'I', 'ENG 101  ', 'Communicative English  ', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(117, 'CSE', 'CSE', '1', 'I', 'ENG 102', 'Communicative English Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(118, 'CSE', 'CSE', '1', 'II', 'CSE 151', 'Structured Programming Language ', '0.75', '1.50', 'Theory', 'Compulsory', ''),
(119, 'CSE', 'CSE', '1', 'II', 'CSE 151', 'Structured Programming Language ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(120, 'CSE', 'CSE', '1', 'II', 'CSE 152', 'Structured Programming Language Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(121, 'CSE', 'CSE', '1', 'II', 'CSE 153', 'Digital Logic Design  ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(122, 'CSE', 'CSE', '1', 'II', 'CSE 154', 'Digital Logic Design Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(123, 'CSE', 'CSE', '1', 'II', 'EEE 155', 'Introduction to Electrical Engineering ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(124, 'CSE', 'CSE', '1', 'II', 'EEE 156', 'Introduction to Electrical Engineering Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(125, 'CSE', 'CSE', '1', 'II', 'CIE 114', 'Engineering Drawing and Auto CAD Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(126, 'CSE', 'CSE', '1', 'II', 'MAT 105', 'Mathematics II (Matrix, Ordinary and Partial  Diff', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(127, 'CSE', 'CSE', '1', 'II', 'SOC 103', 'Society and Technology', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(128, 'CSE', 'CSE', '2', 'I', 'CSE 201', 'Object Oriented Programming  ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(129, 'CSE', 'CSE', '2', 'I', 'CSE 202', 'Object Oriented Programming (C++) Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(130, 'CSE', 'CSE', '2', 'I', 'CSE 203', 'Data Structures', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(131, 'CSE', 'CSE', '2', 'I', 'CSE 204', 'Data Structures Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(132, 'CSE', 'CSE', '2', 'I', 'CSE 205', 'Numerical Methods ', '2.00', '2.00', 'Sessional', 'Compulsory', ''),
(133, 'CSE', 'CSE', '2', 'I', 'CSE 206', 'Numerical Methods Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(134, 'CSE', 'CSE', '2', 'I', 'EEE 209', 'Electronic Devices and Circuits', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(135, 'CSE', 'CSE', '2', 'I', 'EEE 210', 'Electronic Devices and Circuits Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(136, 'CSE', 'CSE', '2', 'I', 'MAT 201', 'Mathematics III (Vector, Complex Variable,  Fourie', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(137, 'CSE', 'CSE', '2', 'I', 'STT 227', 'Statistics (Introduction to Statistics and  Probab', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(138, 'CSE', 'CSE', '2', 'II', 'CSE 254', 'Object Oriented Programming (Java) Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(139, 'CSE', 'CSE', '2', 'II', 'CSE 255', 'Algorithms Analysis and Design ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(140, 'CSE', 'CSE', '2', 'II', 'CSE 256', 'Algorithms Analysis and Design Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(141, 'CSE', 'CSE', '2', 'II', 'CSE 257', 'Theory of Computation and Concrete  Mathematics', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(142, 'CSE', 'CSE', '2', 'II', 'CSE 258', 'Theory of Computation and Concrete  Mathematics Se', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(143, 'CSE', 'CSE', '2', 'II', 'CSE 259', 'Computer Architecture and Organization', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(144, 'CSE', 'CSE', '2', 'II', 'ECE 259', 'Digital Electronics and Pulse Techniques', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(145, 'CSE', 'CSE', '2', 'II', 'ECE 260', 'Digital Electronics and Pulse Techniques  Sessiona', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(146, 'CSE', 'CSE', '2', 'II', 'ACT 205', 'Financial and Managerial Accounting ', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(147, 'CSE', 'CSE', '2', 'II', 'CSE 252', 'Application Development Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(148, 'CSE', 'CSE', '3', 'I', 'CSE 303  ', 'Database', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(149, 'CSE', 'CSE', '3', 'I', 'CSE 304', 'Database Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(150, 'CSE', 'CSE', '3', 'I', 'CSE 305', 'Software Engineering  ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(151, 'CSE', 'CSE', '3', 'I', 'CSE 307  ', 'Microprocessor and Interfacing  ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(152, 'CSE', 'CSE', '3', 'I', 'CSE 308', 'Microprocessor and Interfacing Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(153, 'CSE', 'CSE', '3', 'I', 'ECE 311', 'Data Communication ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(154, 'CSE', 'CSE', '3', 'I', 'ECN 305', 'Economics', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(155, 'CSE', 'CSE', '3', 'I', 'CSE 302', 'Software Development Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(156, 'CSE', 'CSE', '3', 'II', 'CSE 353  ', 'Operating System', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(157, 'CSE', 'CSE', '3', 'II', 'CSE 354 ', 'Operating System Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(158, 'CSE', 'CSE', '3', 'II', 'CSE 355', 'Web Engineering', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(159, 'CSE', 'CSE', '3', 'II', 'CSE 356  ', 'Web Engineering Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(160, 'CSE', 'CSE', '3', 'II', 'CSE 357', 'Computer Networks', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(161, 'CSE', 'CSE', '3', 'II', 'CSE 358', 'Computer Networks Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(162, 'CSE', 'CSE', '3', 'II', 'CSE 359  ', 'Compiler Design', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(163, 'CSE', 'CSE', '3', 'II', 'CSE 360', 'Compiler Design Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(164, 'CSE', 'CSE', '3', 'II', 'CSE 361', 'Mathematical Analysis for Computer Science', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(165, 'CSE', 'CSE', '3', 'II', 'CSE 352', 'Web and Mobile Application Development  Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(166, 'CSE', 'CSE', '4', 'I', 'CSE 403', 'Artificial Intelligence', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(167, 'CSE', 'CSE', '4', 'I', 'CSE 404', 'Artificial Intelligence Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(168, 'CSE', 'CSE', '4', 'I', 'CSE 405', 'Computer Graphics and Image Processing', '3.00', '3.00', 'Sessional', 'Compulsory', ''),
(169, 'CSE', 'CSE', '4', 'I', 'CSE 406', 'Computer Graphics and Image Processing Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(170, 'CSE', 'CSE', '4', 'I', 'CSE 4**', 'Option I', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(171, 'CSE', 'CSE', '4', 'I', 'CSE 4**', 'Option I Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(172, 'CSE', 'CSE', '4', 'I', 'CSE 4**', 'Option II', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(173, 'CSE', 'CSE', '4', 'I', 'CSE 4**', 'Option II Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(174, 'CSE', 'CSE', '4', 'I', 'CSE 408', 'Technical Writing and Presentation Skill  Developm', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(175, 'CSE', 'CSE', '4', 'I', 'CSE 402', 'Project and Thesis Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(176, 'CSE', 'CSE', '4', 'I', 'CSE 453', 'Multimedia System and Animation Techniques ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(177, 'CSE', 'CSE', '4', 'I', 'CSE 454 ', 'Multimedia System and Animation Techniques  Sessio', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(178, 'CSE', 'CSE', '4', 'I', 'CSE 455  ', 'Computer Ethics and Cyber Law', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(179, 'CSE', 'CSE', '4', 'I', 'MGT 405 ', 'Industrial Management', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(180, 'CSE', 'CSE', '4', 'I', 'CSE 4**', 'Option III', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(181, 'CSE', 'CSE', '4', 'I', 'CSE 4**', 'Option III Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(182, 'CSE', 'CSE', '4', 'I', 'CSE 4**', 'Option IV', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(183, 'CSE', 'CSE', '4', 'I', 'CSE 4**', 'Option IV Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(184, 'CSE', 'CSE', '4', 'I', 'CSE 452  ', 'Project and Thesis Sessional ', '3.00', '6.00', 'Sessional', 'Compulsory', ''),
(185, 'CSE', 'CSE', '4', 'I', 'CSE 409 ', 'Advanced Database Management System', '3.00', '3.00', 'Theory', 'Elective I', ''),
(186, 'CSE', 'CSE', '4', 'I', 'CSE 410 ', 'Advanced Database Management System  Sessional', '0.75', '1.50', 'Sessional', 'Elective I', ''),
(187, 'CSE', 'CSE', '4', 'I', 'CSE 411  ', 'Advanced Algorithm Design', '3.00', '3.00', 'Theory', 'Elective I', ''),
(188, 'CSE', 'CSE', '4', 'I', 'CSE 412', 'Advanced Algorithm Design Sessional ', '0.75', '1.50', 'Sessional', 'Elective I', ''),
(189, 'CSE', 'CSE', '4', 'I', 'CSE 413  ', 'Management Information System', '3.00', '3.00', 'Theory', 'Elective I', ''),
(190, 'CSE', 'CSE', '4', 'I', 'CSE 414 ', 'Management Information System Sessional ', '0.75', '1.50', 'Sessional', 'Elective I', ''),
(191, 'CSE', 'CSE', '4', 'I', 'CSE 415 ', 'Mobile and Wireless Communication', '3.00', '3.00', 'Theory', 'Elective I', ''),
(192, 'CSE', 'CSE', '4', 'I', 'CSE 416 ', 'Mobile and Wireless Communication Sessional ', '0.75', '1.50', 'Sessional', 'Elective I', ''),
(193, 'CSE', 'CSE', '4', 'I', 'CSE 417', 'Communication Engineering', '3.00', '3.00', 'Theory', 'Elective I', ''),
(194, 'CSE', 'CSE', '4', 'I', 'CSE 418', 'Communication Engineering Sessional', '0.75', '1.50', 'Sessional', 'Elective I', ''),
(195, 'CSE', 'CSE', '4', 'I', 'CSE 419  ', 'System Analysis and Design', '3.00', '3.00', 'Theory', 'Elective II', ''),
(196, 'CSE', 'CSE', '4', 'I', 'CSE 420 ', 'System Analysis and Design Sessional', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(197, 'CSE', 'CSE', '4', 'I', 'CSE 421', 'Software Testing and Quality Assurance', '3.00', '3.00', 'Theory', 'Elective II', ''),
(198, 'CSE', 'CSE', '4', 'I', 'CSE 422', 'Software Testing and Quality Assurance  Sessional', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(199, 'CSE', 'CSE', '4', 'I', 'CSE 423 ', 'Graph Theory', '3.00', '3.00', 'Theory', 'Elective II', ''),
(200, 'CSE', 'CSE', '4', 'I', 'CSE 424', 'Graph Theory Sessional', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(201, 'CSE', 'CSE', '4', 'I', 'CSE 425', 'Cryptography and Network Security', '3.00', '3.00', 'Theory', 'Elective II', ''),
(202, 'CSE', 'CSE', '4', 'I', 'CSE 426  ', 'Cryptography and Network Security Sessional ', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(203, 'CSE', 'CSE', '4', 'I', 'CSE 427 ', 'Simulation and Modelling', '3.00', '3.00', 'Theory', 'Elective II', ''),
(204, 'CSE', 'CSE', '4', 'I', 'CSE 428  ', 'Simulation and Modelling Sessional', '0.75', '1.50', 'Sessional', 'Elective II', ''),
(205, 'CSE', 'CSE', '4', 'I', 'CSE 459', 'Data Mining and Warehousing', '3.00', '3.00', 'Theory', 'Elective III', ''),
(206, 'CSE', 'CSE', '4', 'I', 'CSE 460', 'Data Mining and Warehousing Sessional', '0.75', '1.50', 'Sessional', 'Elective III', ''),
(207, 'CSE', 'CSE', '4', 'I', 'CSE 461', 'Cloud Computing', '3.00', '3.00', 'Theory', 'Elective III', ''),
(208, 'CSE', 'CSE', '4', 'I', 'CSE 462', 'Cloud Computing Sessional', '0.75', '1.50', 'Sessional', 'Elective III', ''),
(209, 'CSE', 'CSE', '4', 'I', 'CSE 463', 'VLSI Design', '3.00', '3.00', 'Theory', 'Elective III', ''),
(210, 'CSE', 'CSE', '4', 'I', 'CSE 464', 'VLSI Design Sessional', '0.75', '1.50', 'Sessional', 'Elective III', ''),
(211, 'CSE', 'CSE', '4', 'I', 'CSE 465', 'Digital System Design', '3.00', '3.00', 'Theory', 'Elective III', ''),
(212, 'CSE', 'CSE', '4', 'I', 'CSE 466', 'Digital System Design Sessional', '0.75', '1.50', 'Sessional', 'Elective III', ''),
(213, 'CSE', 'CSE', '4', 'I', 'CSE 467', 'Parallel and Distributed System', '3.00', '3.00', 'Theory', 'Elective III', ''),
(214, 'CSE', 'CSE', '4', 'I', 'CSE 468  ', 'Parallel and Distributed System Sessional ', '0.75', '1.50', 'Sessional', 'Elective III', ''),
(215, 'CSE', 'CSE', '4', 'I', 'CSE 469', 'Machine Learning and Pattern Recognition', '3.00', '3.00', 'Theory', 'Elective III', ''),
(216, 'CSE', 'CSE', '4', 'I', 'CSE 470', 'Machine Learning and Pattern Recognition  Sessiona', '0.75', '1.50', 'Sessional', 'Elective III', ''),
(217, 'CSE', 'CSE', '4', 'I', 'CSE 471', 'Natural Language Processing', '3.00', '3.00', 'Theory', 'Elective III', ''),
(218, 'CSE', 'CSE', '4', 'I', 'CSE 472', 'Natural Language Processing Sessional', '0.75', '1.50', 'Sessional', 'Elective III', ''),
(219, 'CSE', 'CSE', '4', 'I', 'CSE 473', 'Human and Computer Interaction', '3.00', '3.00', 'Theory', 'Elective III', ''),
(220, 'CSE', 'CSE', '4', 'I', 'CSE 474', 'Human and Computer Interaction Sessional', '0.75', '1.50', 'Sessional', 'Elective III', ''),
(221, 'CSE', 'CSE', '4', 'I', 'CSE 475', 'Robotics', '3.00', '3.00', 'Theory', 'Elective III', ''),
(222, 'CSE', 'CSE', '4', 'I', 'CSE 476', 'Robotics Sessional', '0.75', '1.50', 'Sessional', 'Elective III', ''),
(223, 'CSE', 'CSE', '4', 'I', 'CSE 477', 'Bioinformatics ', '3.00', '3.00', 'Theory', 'Elective III', ''),
(224, 'CSE', 'CSE', '4', 'I', 'CSE 478', 'Bioinformatics Sessional ', '0.75', '1.50', 'Sessional', 'Elective III', ''),
(225, 'CSE', 'EEE', '1', 'I', 'EEE 101', 'Electrical Circuits-I', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(226, 'CSE', 'EEE', '1', 'I', 'EEE 102 ', 'Electrical Circuits- I Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(227, 'CSE', 'EEE', '1', 'I', 'CHE 117', 'General Chemistry', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(228, 'CSE', 'EEE', '1', 'I', 'CHE 118', 'General Chemistry Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(229, 'CSE', 'EEE', '1', 'I', 'PHY 115', 'Mechanics, Waves and Oscillations, Optics and  The', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(230, 'CSE', 'EEE', '1', 'I', 'PHY 116', 'Mechanics ,Waves and Oscillations, Optics and  The', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(231, 'CSE', 'EEE', '1', 'I', 'MAT 129', 'Calculus- I', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(232, 'CSE', 'EEE', '1', 'I', 'MAT 131  ', 'Calculus- II ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(233, 'CSE', 'EEE', '1', 'I', 'CIE 116', 'Engineering Drawing ', '1.50', '3.00', 'Theory', 'Compulsory', ''),
(234, 'CSE', 'EEE', '1', 'II', 'EEE 151', 'Electrical Circuits- II', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(235, 'CSE', 'EEE', '1', 'II', 'EEE 152', 'Electrical Circuits- II Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(236, 'CSE', 'EEE', '1', 'II', 'EEE 154', 'Electrical Circuit Simulation Laboratory', '1.50', '3.00', 'Theory', 'Compulsory', ''),
(237, 'CSE', 'EEE', '1', 'II', 'PHY 133', 'Modern Physics, Electricity and Magnetism', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(238, 'CSE', 'EEE', '1', 'II', 'PHY 134 ', 'Modern Physics, Electricity and Magnetism  Session', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(239, 'CSE', 'EEE', '1', 'II', 'CSE 163', 'Computer Programming ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(240, 'CSE', 'EEE', '1', 'II', 'CSE 164', 'Computer Programming Sessional ', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(241, 'CSE', 'EEE', '1', 'II', 'MAT 135', 'Ordinary and Partial Differential Equations ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(242, 'CSE', 'EEE', '1', 'II', 'SOC 121', 'Sociology', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(243, 'CSE', 'EEE', '2', 'I', 'EEE 201', 'Electronics- I', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(244, 'CSE', 'EEE', '2', 'I', 'EEE 202 ', 'Electronics- I Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(245, 'CSE', 'EEE', '2', 'I', 'EEE 204', 'Electronics Circuit Simulation Laboratory', '0.75', '1.50', 'Theory', 'Compulsory', ''),
(246, 'CSE', 'EEE', '2', 'I', 'EEE 205', 'Electrical Machine-I', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(247, 'CSE', 'EEE', '2', 'I', 'EEE 206', 'Electrical Machine-I Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(248, 'CSE', 'EEE', '2', 'I', 'EEE 207 ', ' Electromagnetic Fields and Waves', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(249, 'CSE', 'EEE', '2', 'I', 'ECE 207', 'Signals and Systems', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(250, 'CSE', 'EEE', '2', 'I', 'MAT 213 ', 'Linear Algebra', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(251, 'CSE', 'EEE', '2', 'I', 'ENG 223', 'English', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(252, 'CSE', 'EEE', '2', 'II', 'EEE 251', 'Electrical Machine-II', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(253, 'CSE', 'EEE', '2', 'II', 'EEE 252', 'Electrical Machine-II Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(254, 'CSE', 'EEE', '2', 'II', 'EEE 253', 'Electronics -II', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(255, 'CSE', 'EEE', '2', 'II', 'EEE 254', 'Electronics- II Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(256, 'CSE', 'EEE', '2', 'II', 'EEE 255', 'Numerical Methods in Engineering', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(257, 'CSE', 'EEE', '2', 'II', 'MEE 203', 'Mechanical Engineering Fundamentals', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(258, 'CSE', 'EEE', '2', 'II', 'MEE 204  ', 'Mechanical Engineering Fundamentals Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(259, 'CSE', 'EEE', '2', 'II', 'STT 223 ', 'Basic statistics and probability ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(260, 'CSE', 'EEE', '2', 'II', 'ECN 277', 'Fundamentals of Economics', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(261, 'CSE', 'EEE', '3', 'I', 'EEE 301 ', 'Optoelectronics', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(262, 'CSE', 'EEE', '3', 'I', 'EEE 303', 'Digital Electronics', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(263, 'CSE', 'EEE', '3', 'I', 'EEE 304 ', 'Digital Electronics Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(264, 'CSE', 'EEE', '3', 'I', 'EEE 305', 'Transmission & Distribution of Electrical Power', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(265, 'CSE', 'EEE', '3', 'I', 'EEE 307', 'Electrical Properties of Material', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(266, 'CSE', 'EEE', '3', 'I', 'EEE 310', 'Electrical Services Design', '1.50', '3.00', 'Theory', 'Compulsory', ''),
(267, 'CSE', 'EEE', '3', 'I', 'ECE 313', 'Communication Theory', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(268, 'CSE', 'EEE', '3', 'I', 'ECE 314 ', 'Communication Theory Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(269, 'CSE', 'EEE', '3', 'I', 'ACT 305 ', 'Financial and Managerial Accounting', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(270, 'CSE', 'EEE', '3', 'II', 'EEE 351 ', 'Industrial and Power Electronics', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(271, 'CSE', 'EEE', '3', 'II', 'EEE 352', 'Industrial and Power Electronics Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(272, 'CSE', 'EEE', '3', 'II', 'EEE 353', 'Digital Signal Processing ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(273, 'CSE', 'EEE', '3', 'II', 'EEE 354  ', 'Digital Signal Processing Sessional ', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(274, 'CSE', 'EEE', '3', 'II', 'EEE 355', 'Power System-I', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(275, 'CSE', 'EEE', '3', 'II', 'EEE 356', 'Power System-I Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(276, 'CSE', 'EEE', '3', 'II', 'CSE 365', 'Microprocessor and Interfacing', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(277, 'CSE', 'EEE', '3', 'II', 'CSE 366', 'Microprocessor and Interfacing Sessional', '0.75', '1.50', 'Sessional', 'Compulsory', ''),
(278, 'CSE', 'EEE', '3', 'II', 'MGT 309  ', 'Industrial Management', '2.00', '2.00', 'Theory', 'Compulsory', ''),
(279, 'CSE', 'EEE', '4', 'I', 'EEE 444', 'Project/Thesis', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(280, 'CSE', 'EEE', '4', 'I', 'EEE 401  ', 'Solid State Devices & VLSI', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(281, 'CSE', 'EEE', '4', 'I', 'EEE 403', 'Control System', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(282, 'CSE', 'EEE', '4', 'I', 'EEE 404  ', 'Control System Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(283, 'CSE', 'EEE', '4', 'I', 'Elective I ', 'One course from Elective I', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(284, 'CSE', 'EEE', '4', 'I', 'Elective II ', 'One course from Elective II (Theory + Sessional)', '3.00', '3.00', 'Sessional', 'Compulsory', ''),
(285, 'CSE', 'EEE', '4', 'II', 'EEE 488', 'Project/Thesis ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(286, 'CSE', 'EEE', '4', 'II', 'EEE 451  ', 'Microcontroller Based System Design ', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(287, 'CSE', 'EEE', '4', 'II', 'EEE 452 ', 'Microcontroller Based System Design Sessional', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(288, 'CSE', 'EEE', '4', 'II', 'Elective III', 'One course from Elective III (Theory + Sessional)', '3.00', '3.00', 'Sessional', 'Compulsory', ''),
(289, 'CSE', 'EEE', '4', 'II', 'Elective III', 'One course from Elective III (Theory + Sessional)', '1.50', '3.00', 'Sessional', 'Compulsory', ''),
(290, 'CSE', 'EEE', '4', 'II', 'Elective IV', 'One course from Elective IV', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(291, 'CSE', 'EEE', '4', 'II', 'Elective V', 'One course from Elective V', '3.00', '3.00', 'Theory', 'Compulsory', ''),
(292, 'CSE', 'EEE', '4', 'II', 'EEE 480  ', 'Industrial Training', '1.00', 'Select Contact Hours', 'Theory', 'Compulsory', ''),
(293, 'CSE', 'EEE', '4', 'II', 'EEE 409  ', 'Optical Fiber Communication', '3.00', '3.00', 'Theory', 'Elective I', ''),
(294, 'CSE', 'EEE', '4', 'II', 'EEE 411', 'Electrical Machine III', '3.00', '3.00', 'Theory', 'Elective I', ''),
(295, 'CSE', 'EEE', '4', 'II', 'EEE 413', 'Analog Integrated circuit ', '3.00', '3.00', 'Theory', 'Elective I', ''),
(296, 'CSE', 'EEE', '4', 'II', 'EEE 415', 'Power System protection ', '3.00', '3.00', 'Theory', 'Elective II', ''),
(297, 'CSE', 'EEE', '4', 'II', 'EEE 416', 'Power System protection Sessional', '1.50', '3.00', 'Sessional', 'Elective II', ''),
(298, 'CSE', 'EEE', '4', 'II', 'EEE 417', 'Telecommunication Engineering', '3.00', '3.00', 'Theory', 'Elective II', ''),
(299, 'CSE', 'EEE', '4', 'II', 'EEE 418', 'Telecommunication Engineering Sessional', '1.50', '3.00', 'Sessional', 'Elective II', ''),
(300, 'CSE', 'EEE', '4', 'II', 'EEE 419 ', 'Biomedical Instrumentation', '3.00', '3.00', 'Theory', 'Elective II', ''),
(301, 'CSE', 'EEE', '4', 'II', 'EEE 420', 'Biomedical Instrumentation Sessional', '1.50', '3.00', 'Sessional', 'Elective II', ''),
(302, 'CSE', 'EEE', '4', 'II', 'EEE 453', 'Renewable Energy', '3.00', '3.00', 'Theory', 'Elective II', ''),
(303, 'CSE', 'EEE', '4', 'II', 'EEE 454', 'Renewable Energy Sessional', '1.50', '3.00', 'Sessional', 'Elective II', ''),
(304, 'CSE', 'EEE', '4', 'II', 'EEE 455', 'Digital Image Processing', '3.00', '3.00', 'Theory', 'Elective II', ''),
(305, 'CSE', 'EEE', '4', 'II', 'EEE 456', 'Digital Image Processing Sessional. ', '1.50', '3.00', 'Sessional', 'Elective II', ''),
(306, 'CSE', 'EEE', '4', 'II', 'EEE 457', 'High Voltage Engineering', '3.00', '3.00', 'Theory', 'Elective II', ''),
(307, 'CSE', 'EEE', '4', 'II', 'EEE 458', 'High Voltage Engineering Sessional ', '1.50', '3.00', 'Sessional', 'Elective III', ''),
(308, 'CSE', 'EEE', '4', 'II', 'EEE 459', 'Power Plant Engineering and Economy', '3.00', '3.00', 'Theory', 'Elective Iv', ''),
(309, 'CSE', 'EEE', '4', 'II', 'EEE 461 ', 'Nano Technology', '3.00', '3.00', 'Theory', 'Elective Iv', ''),
(310, 'CSE', 'EEE', '4', 'II', 'EEE 463 ', 'Computer Networks', '3.00', '3.00', 'Theory', 'Elective Iv', ''),
(311, 'CSE', 'EEE', '4', 'II', 'EEE 465', 'Mobile Cellular Communication', '3.00', '3.00', 'Theory', 'Elective V', ''),
(312, 'CSE', 'EEE', '4', 'II', 'EEE 467', 'Measurement and Instrumentation', '3.00', '3.00', 'Theory', 'Elective V', ''),
(313, 'CSE', 'EEE', '4', 'II', 'EEE 469', 'Microwave Engineering ', '3.00', '3.00', 'Theory', 'Elective V', '');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `teachers_ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Dept` enum('CSE','ECE','EEE') NOT NULL,
  `Designation` enum('Professor','Assistant Professor','Associate Professor','Lecturer') NOT NULL,
  `dutyCount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teachers_ID`, `Name`, `Dept`, `Designation`, `dutyCount`) VALUES
(1, 'Dr. Md. Mahabub Hossain', 'ECE', 'Professor', 29),
(2, 'Dr. Md. Abdulla Al Mamun', 'CSE', 'Professor', 29),
(3, 'Md. Mehedi Islam', 'ECE', 'Professor', 28),
(4, 'Dr. Md. Delowar Hossain', 'CSE', 'Professor', 28),
(5, 'Dr. Md. Zamil Sultan', 'EEE', 'Professor', 28),
(6, 'Adiba Mahjabin Nitu', 'CSE', 'Professor', 29),
(7, 'Dr. Ashis Kumar Mandal', 'CSE', 'Professor', 29),
(8, 'Dr. Md. Arshad Ali', 'CSE', 'Professor', 29),
(9, 'Md. Abubakar Siddik', 'ECE', 'Assistant Professor', 28),
(10, 'Md. Safiqul Islam', 'EEE', 'Assistant Professor', 29),
(11, 'Md. Ahsan Habib', 'CSE', 'Assistant Professor', 28),
(12, 'Rony Tota', 'EEE', 'Assistant Professor', 28),
(13, 'Jannatun Ferdous', 'ECE', 'Assistant Professor', 28),
(14, 'Md. Nahid Sultan', 'CSE', 'Assistant Professor', 28),
(15, 'Md. Mizanur Rahman', 'EEE', 'Assistant Professor', 28),
(16, 'Dr. Md. Palash Uddin', 'CSE', 'Assistant Professor', 28),
(17, 'Md. Kamal Hossain', 'ECE', 'Assistant Professor', 28),
(18, 'Md. Sohrawordi', 'CSE', 'Assistant Professor', 28),
(19, 'Md. Ferdous Wahid', 'EEE', 'Assistant Professor', 29),
(20, 'Md. Nadim', 'CSE', 'Assistant Professor', 29),
(21, 'Md. Shajalal', 'CSE', 'Assistant Professor', 29),
(22, 'Md. Ilius Hasan Pathan', 'EEE', 'Assistant Professor', 29),
(23, 'Emran Ali', 'CSE', 'Assistant Professor', 28),
(24, 'U.A. Md. Ehsan Ali', 'CSE', 'Assistant Professor', 28),
(25, 'Md. Abu Marjan', 'CSE', 'Assistant Professor', 29),
(26, 'Md. Faruk Kibria', 'EEE', 'Associate Professor', 29),
(27, 'Md. Fazle Rabbi', 'CSE', 'Associate Professor', 28),
(28, 'Dr. Md. Dulal Haque', 'ECE', 'Associate Professor', 29),
(29, 'Masud Ibn Afjal', 'CSE', 'Associate Professor', 29),
(30, 'Sumonto Sarker', 'ECE', 'Associate Professor', 28),
(31, 'Hasi Saha', 'CSE', 'Associate Professor', 29),
(32, 'Dr. Nasrin Sultana', 'ECE', 'Associate Professor', 29),
(33, 'Associate Professor 9', 'EEE', 'Associate Professor', 29),
(34, 'Md. Rashedul Islam', 'CSE', 'Associate Professor', 29),
(35, 'Dr. Tangina Sultana', 'ECE', 'Associate Professor', 29),
(36, 'Sumya Akter', 'CSE', 'Lecturer', 28),
(37, 'Md. Selim Hossain', 'ECE', 'Lecturer', 28),
(38, 'Md. Hassanul Karim Roni', 'EEE', 'Lecturer', 28),
(39, 'Pankaj Bhowmik', 'CSE', 'Lecturer', 29),
(40, 'Mahfujur Rahman', 'ECE', 'Lecturer', 29),
(41, 'Md. Sazedur Rahman', 'EEE', 'Lecturer', 28),
(42, 'Md. Motiur Rahman Tareq', 'EEE', 'Lecturer', 29);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `calender`
--
ALTER TABLE `calender`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `helper`
--
ALTER TABLE `helper`
  ADD PRIMARY KEY (`helper_ID`);

--
-- Indexes for table `syllabus_csefaculty`
--
ALTER TABLE `syllabus_csefaculty`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teachers_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `calender`
--
ALTER TABLE `calender`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=366;

--
-- AUTO_INCREMENT for table `syllabus_csefaculty`
--
ALTER TABLE `syllabus_csefaculty`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=314;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
