<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class Contract extends Model 
{
    protected $table = 'contract';

    protected $primaryKey = 'id';

    public $incrementing = true;

    protected $casts = [
        'id' => 'integer',
        'student_id' => 'integer',
        'number' => 'integer',
        'ratification_date' => 'datetime',
        'info' => 'string'
    ];

    protected $fillable = [
        'student_id',
        'number',
        'ratification_date',
        'info'
    ];

    public function student() 
    {
        return $this -> belongsTo(Student::class, 'student_id', 'id');
    }
}
