<?php
// Define access levels for each user
$users = array(
    'doctor1' => array('APPOINTMENTS', 'MEDICAL_RECORDS', 'PATIENT'),
    'admin1' => array('EMPLOYEE', 'ADMINISTRATOR', 'RECEPTIONIST', 'NURSE', 'DOCTOR', 'APPOINTMENTS', 'MEDICAL_RECORDS', 'FILL_IN', 'SET_UP', 'GO_TO'),
    'patient1' => array('MEDICAL_RECORDS', 'APPOINTMENTS'),
    'receptionist1' => array('APPOINTMENTS'),
    'nurse1' => array('MEDICAL_RECORDS', 'PATIENT')
);

// Initialize variables
$username = '';
$password = '';
$conn = null;
$tableData = array();
$allowedTables = array();

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve username and password from form
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Connect to the database using the entered username and password
    $conn = mysqli_connect('localhost', $username, $password, 'medicalcenter', '3307');

    // Check if connection is successful
    if (!$conn) {
        die('Connection error: ' . mysqli_connect_error());
    }

    // Check if username exists in defined users
    if (array_key_exists($username, $users)) {
        // Determine allowed tables based on user
        $allowedTables = $users[$username];

        // Execute SQL queries to fetch table data for allowed tables
        foreach ($allowedTables as $table) {
            // Skip fetching data for the patient table if the user is patient1
            if ($table === 'PATIENT' && $username === 'patient1') {
                continue;
            }
            
            $sql = "SELECT * FROM $table";
            $result = mysqli_query($conn, $sql);

            if ($result) {
                $tableData[$table] = mysqli_fetch_all($result, MYSQLI_ASSOC);
            } else {
                $tableData[$table] = array(); // Table is empty or does not exist
            }
        }
    } else {
        die('Invalid username');
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Center Tables</title>
    <!-- Add any additional styles or meta tags -->
</head>
<body>
    <h1>Login</h1>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" value="<?php echo $username; ?>" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" value="<?php echo $password; ?>" required><br><br>
        <input type="submit" value="Login">
    </form>

    <?php if ($_SERVER["REQUEST_METHOD"] == "POST" && $conn): ?>
        <h2>Medical Center Tables</h2>
        <?php foreach ($tableData as $tableName => $data): ?>
            <h3><?php echo $tableName; ?></h3>
            <?php if (!empty($data)): ?>
                <table border="1">
                    <tr>
                        <?php foreach ($data[0] as $columnName => $value): ?>
                            <th><?php echo $columnName; ?></th>
                        <?php endforeach; ?>
                    </tr>
                    <?php foreach ($data as $row): ?>
                        <tr>
                            <?php foreach ($row as $value): ?>
                                <td><?php echo $value; ?></td>
                            <?php endforeach; ?>
                        </tr>
                    <?php endforeach; ?>
                </table>
            <?php else: ?>
                <p>Table is empty or does not exist.</p>
            <?php endif; ?>
        <?php endforeach; ?>
    <?php endif; ?>
</body>
</html>

