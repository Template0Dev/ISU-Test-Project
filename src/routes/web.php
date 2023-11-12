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

Route::get('/overview', function () {
    $faculties = request('faculties');
    $eduForms = request('eduForms') ?? array('О', 'ОЗ', 'З');
    if ($faculties != null) {
        $facultiesParameter = implode(', ', array_map(fn($value) => "'$value'", $faculties));
        $eduFormsParameter = implode(', ', array_map(fn($value) => "'$value'", $eduForms));

        BrowserCoreLogger::writeToLog("Specified faculty(-ies) have been found, redirection to specific page.");
        return view('/overview/Specific', [
            'eduForms' => $eduForms,
            'model' => DB::select("
                SELECT *
                FROM get_students_list__by_faculties_and_edu_forms(
                    ARRAY[$facultiesParameter],
                    ARRAY[$eduFormsParameter]
                ) 
                ORDER BY faculty_name;"
            ),
            'faculties' => $faculties
        ]);
    }

    BrowserCoreLogger::writeToLog('Faculty was not specified, redirection to overview page.');
    return view('/overview/Summary', ['model' => App\Models\ISU\Views\ReportFull::all()]);
});

Route::get('/data', function () {
    $dataType = request('dataType');
    if ($dataType == '') {
        BrowserCoreLogger::writeToLog('Target data type was empty or not specified, redirection to overview page.');
        return view('/overview/Summary');
    }
    
    $page = request('page') ?? 1;
    $dataType = strtolower(str_replace('_', '', $dataType));
    switch ($dataType) {
        case 'contract':
            return view('/data/Contract', ['model' => App\Models\ISU\Contract::all()]);
        case 'distanteducation':
            return view('/data/DistantEducation', ['model' => App\Models\ISU\DistantEducation::all()]);
        case 'educationform':
            return view('/data/EducationForm', ['model' => App\Models\ISU\EducationForm::all()]);
        case 'educationlevel':
            return view('/data/EducationLevel', ['model' => App\Models\ISU\EducationLevel::all()]);
        case 'educationprogram':
            return view('/data/EducationProgram', ['model' => App\Models\ISU\EducationProgram::all()]);
        case 'faculty':
            return view('/data/Faculty', ['model' => App\Models\ISU\Faculty::all()]);
        case 'schedule':
        case 'groupschedule':
            return view('/data/GroupSchedule', ['model' => App\Models\ISU\GroupSchedule::all()]);
        case 'groupsondistanteducation':
            return view('/data/GroupsOnDistantEducation', ['model' => App\Models\ISU\GroupsOnDistantEducation::all()]);
        case 'passport':
            return view('/data/Passport', ['model' => App\Models\ISU\Passport::all()]);
        case 'profile':
            return view('/data/Profile', ['model' => App\Models\ISU\Profile::all()]);
        case 'specialize':
            return view('/data/Specialize', ['model' => App\Models\ISU\Specialize::all()]);
        case 'studentgroup':
            return view('/data/StudentGroup', ['model' => App\Models\ISU\StudentGroup::all()]);

        // Default should be 'Student' data.
        default:
        {
            $entries = App\Models\ISU\Student::skip(10 * ($page - 1))->take(10)->get();
            $summaryCount = App\Models\ISU\Student::count();
            $isFinalPage = ceil($summaryCount / 10.0) <= $page;
    
            return view('/data/Student', [
                'model' => $entries, 
                'page' => $page, 
                'isFinalPage' => $isFinalPage,
                'summary' => $summaryCount
            ]);
        }
    }
});
