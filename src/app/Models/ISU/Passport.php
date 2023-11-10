<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class Passport extends Model
{
    protected $casts = [
        'id' => 'integer',
        'student_id' => 'integer',
        'is_actual' => 'boolean',
        'series' => 'integer',
        'number' => 'integer',
        'date_of_give' => 'datetime',
        'place_of_give' => 'string'
    ];

    protected $fillable = [
        'student_id',
        'is_actual',
        'series',
        'number',
        'date_of_give',
        'place_of_give'
    ];

    public function student()
    {
        return $this -> belongsTo(Student::class, 'student_id', 'id');
    }
}
