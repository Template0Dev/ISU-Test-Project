<?php

namespace App\Models\ISU;
use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    protected $table = 'student';
    
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

    public function getBioString(): string {
        $shortenName = mb_substr($this->name, 0, 1).'.';
        $shortenPatronymic = mb_substr($this->patronymic, 0, 1) ?? '';
        if ($shortenPatronymic != '') {
            $shortenPatronymic = $shortenPatronymic.'.';
        }

        return trim("$this->surname $shortenName $shortenPatronymic");
    }
}
