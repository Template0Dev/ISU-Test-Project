<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class EducationLevel extends Model 
{
    protected $casts = [
        'id' => 'integer',
        'name' => 'string'
    ];

    protected $fillable = [
        'name'
    ];
}
