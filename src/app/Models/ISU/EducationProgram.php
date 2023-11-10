<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class EducationProgram extends Model
{
    protected $casts = [
        'id' => 'integer',
        'profile_id' => 'integer',
        'education_form_id' => 'integer',
        'begin_date' => 'datetime'
    ];

    protected $fillable = [
        'profile_id',
        'education_form_id',
        'begin_date'
    ];

    public function profile()
    {
        return $this -> belongsTo(Profile::class, 'profile_id', 'id');
    }

    public function education_form()
    {
        return $this -> belongsTo(EducationForm::class, 'education_form_id', 'id');
    }
}
