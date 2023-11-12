<!DOCTYPE html>

<html>

    <head>
        <meta charset="utf-8" />
        <title>Данные: Договора</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />
    </head>

    <body>
        <div class="mw6 center pa3 sans-serif">
            <h1 class="mb4" style="text-align: center">
                Всего договоров:
                {{ count($model) }}.
            </h1>
            @foreach ($model as $contract)
                <hr />
                <div class="pa2 mb3 striped--near-white">
                    <header class="b mb2" style="text-align: center">Номер: {{ $contract->number }}</header>

                    <div class="pl2">
                        <p class="mb2">ID: {{ $contract->id }}</p>

                        <p class="mb2">ID студента: {{ $contract->student_id }}</p>

                        <p class="mb2">Дата подписания: {{ $contract->ratification_date }}</p>

                        <div class="mb2" style="text-align: center">
                            <p>Заметки</p>
                            <p>{{ $contract->info ?? '—————' }}</p>
                        </div>
                    </div>
                </div>
                <hr />
            @endforeach
        </div>
    </body>

</html>
