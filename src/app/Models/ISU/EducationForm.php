<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class EducationForm extends Model 
{
    protected $casts = [
        'id' => 'integer',
        'name' => 'string',
        'full_name' => 'string'
    ];

    protected $fillable = [
        'name',
        'full_name'
    ];
}
