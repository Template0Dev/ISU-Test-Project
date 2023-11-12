<!DOCTYPE html>

<html>

    <head>
        <meta charset="utf-8" />
        <title>Данные: Факультеты</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />
    </head>

    <body>
        <div class="mw6 center pa3 sans-serif">
            <h1 class="mb4" style="text-align: center">
                Всего факультетов:
                {{ count($model) }}.
            </h1>
            @foreach ($model as $faculty)
                <hr />
                <div class="pa2 mb3 striped--near-white">
                    <header class="b mb2" style="text-align: center">Название: {{ $faculty->name }}</header>

                    <div class="pl2">
                        <p class="mb2">ID: {{ $faculty->id }}</p>
                        <p class="mb2">Код: {{ $faculty->code }}</p>
                    </div>
                </div>
                <hr />
            @endforeach
        </div>
    </body>

</html>
