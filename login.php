<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Verbindung zur Datenbank herstellen (Sie müssen dies mit Ihren eigenen Daten anpassen)
$servername = "127.0.0.1";
$dbusername = "sam";
$dbpassword = "infosec";
$dbname = "infosec";

// Verbindung erstellen
$conn = new mysqli($servername, $dbusername, $dbpassword, $dbname);

// Überprüfen, ob die Verbindung erfolgreich war
if ($conn->connect_error) {
    die("Verbindung fehlgeschlagen: " . $conn->connect_error);
}

// Benutzereingaben erhalten
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $dbusername = $_POST['username'];
    $dbpassword = $_POST['password'];

    // SQL-Abfrage vorbereiten und ausführen
    $sql = "SELECT * FROM login WHERE benutzername='$dbusername' AND passwort='$dbpassword'";
    $result = $conn->query($sql);

    // Überprüfen, ob ein Datensatz gefunden wurde
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $username = $row['benutzername'];
        echo "Login erfolgreich!";
    } else {
        echo "Login fehlgeschlagen. Benutzername oder Passwort ist falsch.";
    }
}

// Verbindung zur Datenbank schließen
$conn->close();
?>
