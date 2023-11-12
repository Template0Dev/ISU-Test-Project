<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class Faculty extends Model 
{
    protected $table = 'faculty';

    protected $casts = [
        'id' => 'integer',
        'code' => 'integer',
        'name' => 'string'
    ];

    protected $fillable = [
        'code',
        'name'
    ];
}
