<!DOCTYPE html>

<html>

    <head>
        <meta charset="utf-8" />
        <title>Данные: Паспорта</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />
    </head>

    <body>
        <div class="mw6 center pa3 sans-serif">
            <h1 class="mb4" style="text-align: center">
                Всего паспортов:
                {{ count($model) }}.
            </h1>
            @foreach ($model as $passport)
                <hr />
                <div class="pa2 mb3 striped--near-white">
                    <header class="b mb2" style="text-align: center">
                        ID: {{ $passport->id }}
                    </header>

                    <div class="pl2" style="text-align: center">
                        <p class="mb2">
                            Владелец: <br />
                            {{ $passport->student()->get()[0]->getBioString() }}
                        </p>
                    </div>
                    <div class="pl2">
                        <p class="mb2">Актуальность: {{ $passport->is_actual == 1 ? 'Да' : 'Нет' }}</p>
                        <p class="mb2">ID владельца: {{ $passport->student_id }}</p>
                        <p class="mb2">Серия: {{ $passport->series }}</p>
                        <p class="mb2">Номер: {{ $passport->number }}</p>
                        <p class="mb2">Дата выдачи: {{ $passport->date_of_give }}</p>
                        <p class="mb2">Место выдачи: {{ $passport->place_of_give }}</p>
                    </div>
                </div>
                <hr />
            @endforeach
        </div>
    </body>

</html>
