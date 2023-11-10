<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class StudentGroup extends Model
{
    protected $casts = [
        'id' => 'integer',
        'final_uid' => 'integer',
        'title' => 'string',
        'course' => 'integer',
        'program_id' => 'integer',
        'schedule_id' => 'integer',
        'date_create' => 'datetime',
        'last_up' => 'datetime'
    ];

    protected $fillable = [
        'final_uid',
        'title',
        'course',
        'program_id',
        'schedule_id',
        'date_create',
        'last_up'
    ];

    public function program() 
    {
        return $this -> belongsTo(EducationProgram::class, 'program_id', 'id');
    }

    public function schedule()
    {
        return $this -> belongsTo(GroupSchedule::class, 'schedule_id', 'id');
    }
}
