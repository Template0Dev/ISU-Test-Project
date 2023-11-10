<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class Specialize extends Model 
{
    protected $casts = [
        'id' => 'integer',
        'faculty_id' => 'integer',
        'number' => 'string',
        'code' => 'string',
        'name' => 'string',
        'education_level_id' => 'integer'
    ];

    protected $fillable = [
        'faculty_id',
        'number',
        'code',
        'name',
        'education_level_id'
    ];

    public function faculty() 
    {
        return $this -> belongsTo(Faculty::class, 'faculty_id', 'id');
    }

    public function education_level() 
    {
        return $this -> belongsTo(EducationLevel::class, 'education_level_id', 'id');
    }
}
