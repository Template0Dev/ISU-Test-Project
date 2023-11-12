<!DOCTYPE html>

<html>

    <head>
        <meta charset="utf-8" />
        <title>Данные: Специальности</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />
    </head>

    <body>
        <div class="mw6 center pa3 sans-serif">
            <h1 class="mb4" style="text-align: center">
                Всего специальностей:
                {{ count($model) }}.
            </h1>
            @foreach ($model as $specialize)
                <hr />
                <div class="pa2 mb3 striped--near-white">
                    <header class="b mb2" style="text-align: center">Название: {{ $specialize->name }}</header>
                    <p class="mb3" style="text-align: center">
                        Факультет:
                        {{ $specialize->faculty()->get()[0]->name }}
                    </p>

                    <div class="pl2">
                        <p class="mb2">ID: {{ $specialize->id }}</p>
                        <p class="mb2">Номер: {{ $specialize->number }}</p>
                        <p class="mb2">Код: {{ $specialize->code }}</p>
                        <p class="mb2">
                            Уровень образования: 
                            {{ $specialize->education_level()->get()[0]->name }}
                        </p>
                    </div>
                </div>
                <hr />
            @endforeach
        </div>
    </body>

</html>
