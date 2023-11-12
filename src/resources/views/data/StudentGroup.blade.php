<!DOCTYPE html>

<html>

    <head>
        <meta charset="utf-8" />
        <title>Данные: Студенческие Группы.</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />
    </head>

    <body>
        <div class="mw6 center pa3 sans-serif">
            <h1 class="mb4" style="text-align: center">
                Всего групп:
                {{ count($model) }}.
            </h1>
            @foreach ($model as $studentGroup)
                <hr />
                <div class="pa2 mb3 striped--near-white">
                    <header class="b mb2" style="text-align: center">Название: {{ $studentGroup->title }}</header>
                    <p class="mb3" style="text-align: center">
                        Факультет / Институт: <br />
                        {{ $studentGroup->getFaculty()->name }}
                    </p>

                    <div class="pl2">
                        <p class="mb2">ID: {{ $studentGroup->id }}</p>
                        <p class="mb2">UID: {{ $studentGroup->final_uid }}</p>
                        
                        <p class="mb2">Курс: {{ $studentGroup->course }}</p>
                        <p class="mb2">Программа (ID): {{ $studentGroup->program_id }}</p>
                        <p class="mb2">Расписание (ID): {{ $studentGroup->schedule_id }}</p>

                        <p class="mb2">Дата создания: {{ date_format($studentGroup->date_create, 'd.m.Y!') }}</p>
                        <p class="mb2">Последнее посещение: {{ $studentGroup->last_up ? date_format($studentGroup->last_up, 'H:i d.m.Y!') : '———' }}</p>
                    </div>
                </div>
                <hr />
            @endforeach
        </div>
    </body>

</html>
