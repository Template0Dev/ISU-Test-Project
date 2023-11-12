<!DOCTYPE html>

<html>

    <head>
        <meta charset="utf-8" />
        <title>Данные: Студенты</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />

        <style>
            #page-control {
                display: flex;
                justify-content: space-evenly;
            }

            #page-control > a {
                text-decoration-line: none;
            }
        </style>
    </head>

    <body>
        <div class="mw6 center pa3 sans-serif">
            <h1 style="text-align: center">Всего записей: {{ $summary }}.</h1>
            <h2 class="mb4" style="text-align: center">
                Страница {{ $page }}. <br />
                Записи
                <?php
                    $startEntry = 10 * ($page - 1);
                    $endEntry = count($model) + $startEntry;

                    $startEntry = $startEntry == 0 ? $startEntry + 1 : $startEntry;
                    print "$startEntry — $endEntry.";
                ?>
            </h2>
            @foreach ($model as $student)
                <hr />
                <div class="pa2 mb3 striped--near-white">
                    <header class="b mb2" style="text-align: center">{{ $student->getBioString() }}</header>
                    <p style="text-align: center">Группа: {{ $student->group()->get()[0]->title }}</p>

                    <div class="pl2">
                        <p class="mb2">ISU ID: {{ $student->isu_id }}</p>
                        <p class="mb2">AO: {{ $student->ao }}</p>
                        <p class="mb2">Студенческий билет: {{ $student->study_book }}</p>
                        <p class="mb2">Создано: {{ $student->entry_creation_date }}</p>
                    </div>
                </div>
                <hr />
            @endforeach

            <div id="page-control">
                <?php
                    $baseUrl = parse_url($_SERVER["REQUEST_URI"], PHP_URL_PATH);
                    if ($page > 1) {
                        $newPage = $page - 1;
                        print "<a title='Назад' href=\"$baseUrl?dataType=Student&page=$newPage\">◀️◀️◀️</a>";
                    }
                    if (!$isFinalPage) {
                        $newPage = $page + 1;
                        print "<a title='Вперёд' href=\"$baseUrl?dataType=Student&page=$newPage\">▶️▶️▶️</a>";
                    }
                ?>
            </div>
        </div>
    </body>

</html>
