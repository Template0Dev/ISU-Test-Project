<!DOCTYPE html>

<html>

    <head>
        <meta charset="utf-8" />
        <title>Обзор</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="{{ asset('resources/css/app.css') }}" />
        <link rel="stylesheet" href="{{ asset('resources/css/table.css') }}" />
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />

        <style>
            .table-container {
                padding: 5px;

                border: 2.5px solid black;
                border-collapse: collapse;
                border-radius: 8px;
            }

            .table-content tbody tr:last-child {
                background-color: gray;
            }
        </style>
    <body>
        <div class="center pa3 sans-serif parent">
            <h1 class="mb4" style="text-align: center">Полная отчётность.</h1>
            <h2 style="text-align: center">Всего доступно: {{ count($model) }}.</h2>

            <div class="table-container">
                <table class="table-content">
                    <thead>
                        <tr>
                            <th>Факультет / Институт</th>

                            <th>Очное (Всего)</th>
                            <th>Очное (Бюджет)</th>
                            <th>Очное (Договор)</th>

                            <th>Очно-Заочное (Всего)</th>
                            <th>Очно-Заочное (Бюджет)</th>
                            <th>Очно-Заочное (Договор)</th>

                            <th>Заочное (Всего)</th>
                            <th>Заочное (Бюджет)</th>
                            <th>Заочное (Договор)</th>

                            <th>Всего</th>
                            <th>Бюджет</th>
                            <th>Договор</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($model as $data)
                            <tr>
                                <td>{{ $data->{'Факультет / Институт'} }}</td>

                                <td>{{ $data->{'Очное (Всего)'} }}</td>
                                <td>{{ $data->{'Очное (Бюджет)'} }}</td>
                                <td>{{ $data->{'Очное (Договор)'} }}</td>

                                <td>{{ $data->{'Очно-Заочное (Всего)'} }}</td>
                                <td>{{ $data->{'Очно-Заочное (Бюджет)'} }}</td>
                                <td>{{ $data->{'Очно-Заочное (Договор)'} }}</td>

                                <td>{{ $data->{'Заочное (Всего)'} }}</td>
                                <td>{{ $data->{'Заочное (Бюджет)'} }}</td>
                                <td>{{ $data->{'Заочное (Договор)'} }}</td>

                                <td>{{ $data->{'Всего'} }}</td>
                                <td>{{ $data->{'Бюджет'} }}</td>
                                <td>{{ $data->{'Договор'} }}</td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </body>

</html>
