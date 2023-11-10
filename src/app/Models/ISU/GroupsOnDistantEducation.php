<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class GroupsOnDistantEducation extends Model
{
    protected $casts = [
        'id' => 'integer',
        'group_id' => 'integer',
        'distant_id' => 'integer'
    ];

    protected $fillable = [
        'group_id',
        'distant_id'
    ];

    public function group()
    {
        return $this -> belongsTo(StudentGroup::class, 'group_id', 'id');
    }

    public function distant() 
    {
        return $this -> belongsTo(DistantEducation::class, 'distant_id', 'id');
    }
}
