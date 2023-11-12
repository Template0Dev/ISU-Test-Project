<?php

namespace App\Models\ISU\Views;
use Illuminate\Database\Eloquent\Model;

class Report extends Model 
{
    protected $table = 'report';

    protected $casts = [
        'Факультет / Институт' => 'string',

        'Очное (Всего)' => 'integer',
        'Очное (Бюджет)' => 'integer',
        'Очное (Договор)' => 'integer',

        'Очно-Заочное (Всего)' => 'integer',
        'Очно-Заочное (Бюджет)' => 'integer',
        'Очно-Заочное (Договор)' => 'integer',
        
        'Заочное (Всего)' => 'integer',
        'Заочное (Бюджет)' => 'integer',
        'Заочное (Договор)' => 'integer',

        'Всего' => 'integer',
        'Бюджет' => 'integer',
        'Договор' => 'integer'
    ];

    protected $fillable = [
        'Факультет / Институт',

        'Очное (Всего)',
        'Очное (Бюджет)',
        'Очное (Договор)',

        'Очно-Заочное (Всего)',
        'Очно-Заочное (Бюджет)',
        'Очно-Заочное (Договор)',
        
        'Заочное (Всего)',
        'Заочное (Бюджет)',
        'Заочное (Договор)',

        'Всего',
        'Бюджет',
        'Договор'
    ];
}
