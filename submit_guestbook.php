<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = htmlspecialchars($_POST["name"], ENT_QUOTES, 'UTF-8');
    $message = htmlspecialchars($_POST["message"], ENT_QUOTES, 'UTF-8');
    
    $entry = "<p><strong>$name:</strong> $message</p>\n";
    
    file_put_contents("entries.txt", $entry, FILE_APPEND);
    
    header("Location: guestbook.html");
    exit();
}
?>
