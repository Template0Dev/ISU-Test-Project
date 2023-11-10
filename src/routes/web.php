<?php

use App\Console\BrowserCoreLogger;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/
Route::get('/', function () {
    return view('Home');
});

Route::get('/summary', function () {
    $faculty = request('faculty');
    if ($faculty == '') {
        BrowserCoreLogger::writeToLog('Faculty was not specified, redirection to overview page.');
        return view('/overview/Summary');
    } else {
        BrowserCoreLogger::writeToLog("Specified ($faculty) have been found, redirection to specific page.");
        return view('/overview/Specific', ['faculty' => $faculty]);
    }
});

Route::get('/data', function () {
    $dataType = request('dataType');
    if ($dataType == '') {
        BrowserCoreLogger::writeToLog('Target data type was empty or not specified, redirection to overview page.');
        return view('/overview/Summary');
    } else {
        return view('/data/{$dataType}');
    }
});
