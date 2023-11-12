<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class GroupSchedule extends Model
{
    protected $table = 'group_schedule';
    
    protected $casts = [
        'id' => 'integer'
    ];
}
