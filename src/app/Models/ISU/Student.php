<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    protected $casts = [
        'id' => 'integer',
        'isu_id' => 'integer',
        'group_id' => 'integer',
        'surname' => 'string',
        'name' => 'string',
        'patronymic' => 'string',
        'ao' => 'integer',
        'study_book' => 'integer',
        'entry_creation_date' => 'datetime'
    ];

    protected $fillable = [
        'isu_id',
        'group_id',
        'surname',
        'name',
        'patronymic',
        'ao',
        'study_book',
        'entry_creation_date'
    ];

    public function group()
    {
        return $this -> belongsTo(StudentGroup::class, 'group_id', 'id');
    }
}
