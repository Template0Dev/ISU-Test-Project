<!DOCTYPE html>

<html>

    <head>
        <meta charset="utf-8" />
        <title>Данные: Программы Обучения</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />
    </head>

    <body>
        <div class="mw6 center pa3 sans-serif">
            <h1 class="mb4" style="text-align: center">
                Всего программ:
                {{ count($model) }}.
            </h1>
            @foreach ($model as $program)
                <hr />
                <div class="pa2 mb3 striped--near-white">
                    <header class="b mb2" style="text-align: center">ID: {{ $program->id }}</header>

                    <div class="pl2">
                        <p class="mb2">
                            Профиль: {{ $program->profile()->get()[0]->name }}
                        </p>
                        <p class="mb2">
                            Форма обучения: {{ $program->education_form()->get()[0]->full_name }}
                        </p>

                        <p class="mb2">
                            Начало учёбы: {{ date_format($program->begin_date, 'd.m.Y!') }}
                        </p>
                        <p class="mb2">
                            Продолжительность обучения:
                            <?php
                                $rawInterval = $program->profile()->get()[0]->education_duration;
                                $result = App\Providers\PostgresIntervalProvider::getIntervalFromPostgresRawIntervalResult($rawInterval)->format('%y года, %m месяцев');
                                
                                print $result;
                            ?>
                        </p>
                    </div>
                </div>
                <hr />
            @endforeach
        </div>
    </body>

</html>
