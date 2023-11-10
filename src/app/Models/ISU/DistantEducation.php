<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class DistantEducation extends Model
{
    protected $casts = [
        'id' => 'integer',
        'begin_date' => 'datetime',
        'end_date' => 'datetime',
        'note' => 'string'
    ];

    protected $fillable = [
        'begin_date',
        'end_date',
        'note'
    ];
}
