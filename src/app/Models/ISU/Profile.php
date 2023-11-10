<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class Profile extends Model 
{
    protected $casts = [
        'id' => 'integer',
        'specialize_id' => 'integer',
        'name' => 'string',
        'education_duration' => 'interval'
    ];

    protected $fillable = [
        'specialize_id',
        'name',
        'education_duration'
    ];

    public function specialize() 
    {
        return $this -> belongsTo(Specialize::class, 'specialize_id', 'id');
    }
}
