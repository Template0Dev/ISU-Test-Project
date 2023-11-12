<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class Profile extends Model 
{
    protected $table = 'profile';
    
    protected $casts = [
        'id' => 'integer',
        'specialize_id' => 'integer',
        'name' => 'string'
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
