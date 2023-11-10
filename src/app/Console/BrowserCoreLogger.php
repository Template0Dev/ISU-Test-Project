<?php

namespace App\Console;

class BrowserCoreLogger 
{
    public static function writeToLog(string $message)
    {
        print("<script>console.log('$message');</script>");
    }
}
