<!DOCTYPE html>

<html>

    <head>
        <meta charset="utf-8" />
        <title>Обзор</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="{{ asset('resources/css/app.css') }}" />
        <link rel="stylesheet" href="{{ asset('resources/css/table.css') }}" />
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />

    <body>
        <div class="center pa3 sans-serif parent">
            <h1 class="mb4" style="text-align: center">
                Факультет{{ count($faculties) > 1 ? 'ы' : '' }}: <br />
                {{ implode(', ', $faculties) }}.
            </h1>
            <div class="table-container">
                <h2 style="text-align: center">Всего записей: {{ count($model) }}.</h2>
                <table class="table-content">
                    <thead>
                        <tr>
                            <th>Факультет / Институт</th>

                            <th>Форма обучения</th>
                            <th>Группа</th>
                            <th>Бюджет?</th>

                            <th>ISU ID</th>
                            <th>Фамилия</th>
                            <th>Имя</th>
                            <th>Отчество</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($model as $data)
                            <tr>
                                <td>{{ $data->faculty_name }}</td>

                                <td>{{ $data->education_form }}</td>
                                <td>{{ $data->student_group }}</td>
                                <td>{{ $data->on_contract ? 'Нет' : 'Да' }}</td>

                                <td>{{ $data->student_isu_id }}</td>
                                <td>{{ $data->student_surname }}</td>
                                <td>{{ $data->student_name }}</td>
                                <td>{{ $data->student_patronymic ?? '———' }}</td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </body>

</html>
