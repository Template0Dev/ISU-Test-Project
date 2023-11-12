<!DOCTYPE html>

<html>

    <head>
        <meta charset="utf-8" />
        <title>Данные: Группы на Дистанционном Обучении</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />
    </head>

    <body>
        <div class="mw6 center pa3 sans-serif">
            <h1 class="mb4" style="text-align: center">
                Всего групп:
                {{ count($model) }}.
            </h1>
            @foreach ($model as $tether)
                <hr />
                <div class="pa2 mb3 striped--near-white">
                    <header class="b mb2" style="text-align: center">ID: {{ $tether->id }}</header>

                    <div class="pl2">
                        <p class="mb2">
                            Группа: {{ $tether->group()->get()[0]->name }}
                        </p>
                        <p class="mb2">
                            Начало: {{ $tether->distant()->get()[0]->begin_date }}
                            <br />
                            Конец: {{ $tether->distant()->get()[0]->end_date }}
                        </p>
                    </div>
                </div>
                <hr />
            @endforeach
        </div>
    </body>

</html>
