<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>XSS-Demo</title>
</head>
<body>
    <h1>XSS-Demo</h1>
    <form action="xss_demo.php" method="post">
        Name: <input type="text" name="name">
        <input type="submit" value="Senden">
    </form>
    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $name = htmlspecialchars($_POST["name"], ENT_QUOTES, 'UTF-8');
        echo "<div id='greeting'>Hallo, " . $name . "!</div>";
    }
    ?>
</body>
</html>
