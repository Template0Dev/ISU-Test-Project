# ISU Test Project

![FullReport Title](https://github.com/Template0Dev/ISU-Test-Project/assets/148116566/3b7dc4d4-e54b-4bba-a17c-fd00582bc15f)

## RU

Русскоязычный раздел.

### Описание

Тестовый проект ИСУ.
В проекте содержатся все необходимые файлы для начала работы.

### Приготовления

Перед началом работы необходимо удостовериться, что соответствующий стенд соответствует необходимым требованиям:

* Требуется установленный Docker (Docker-Compose);
* Характеристики аппаратного обеспечения должны соответствовать требованиям.

### Запуск

Чтобы запустить проект локально необходимо выполнить следующие действия:

1. Перейти в терминал и открыть директорию 'laradock';
2. Ввести команду: 'docker-compose up -d postgres nginx pgadmin';
    1. Первый запуск потребует большого времени.
3. После завершения инициализации потребуется импортировать базу данных. Проще всего это сделать используя PGAdmin:
   1. Открыть браузер и в строке адреса указать адрес PGAdmin (по умолчанию это `https://localhost:5050/`);
   2. Указать учетные данные:
      1. User: `pgadmin4@pgadmin.org`;
      2. PWD: `admin`.
   3. В открывшейся вкладке выбрать локальный сервер и указать учётные данные БД:
      1. User: `default`;
      2. PWD: `secret`.
   4. Выбрать базу данных текущего пользователя, открыть контекстное меню и нажать на `restore`;
   5. Загрузить БД:
      1. В появившемся окне в графе `Filename` нажать на значок папки;
      2. В новом окне выбрать параметры (правый верхний угол) и нажать на `Upload`;
      3. Переместить файл БД (`Final BackUP.sql`) из директории `./db/` в область для файлов;
      4. Закрыть это диалоговое окно и в предыдущем выбрать соответствующий файл, затем нажать на `Select`.
   6. В качестве `Role name` указать текущего пользователя;
   7. На вкладке `Data Options` выбрать пункты `Pre-Data`, `Data`, `Post-Data`. В графе `Do not save` указать `Owner`;
   8. На вкладке `Query Options` включить переключатель `Include CREATE DATABASE statement`;
   9. Нажать на кнопку `Restore` и дождаться завершения процесса (должно появиться два успешных уведомления).
4. После этого следует открыть запущенный сайт. Он будет доступен на стандартных прослушиваемых портах (:80, :443)

### Работа с приложением

Для получения данных необходимо обратиться к контроллеру. Для этого нужно указать соответствующий адрес.
Все перечисленные ниже адреса даются относительно от базового адреса сайта (`https://localhost` или подобное).

#### Контроллеры

Все контроллеры делятся на 2 типа:

1. Контроллеры данных — Выводят соответствующие данные напрямую из БД. Обращение происходит по адресу `./data?dataType={0}`. В качестве параметра {0} может выступать:
   1. `Contract` — Данные о договорах;
   2. `Distant_Education` — Данные о дистанционном обучении;
   3. `Education_Form` — Данные о формах обучения;
   4. `Education_Level` — Данные об уровнях обучения;
   5. `Education_Program` — Данные о программах обучения;
   6. `Faculty` — Данные о факультетах (и институтах);
   7. `Schedule`, `Group_Schedule` — Данные о расписаниях;
   8. `Groups_On_Distant_Education` — Данные о группах, переведённых на дистанционное обучение;
   9. `Passport` — Данные о паспортах студентов;
   10. `Profile` — Данные о профилях обучения;
   11. `Specialize` — Данные о доступных специальностях;
   12. `Student_Group` — Данные о группах (студентов);
   13. `Student` (по умолчанию) — Данные о студентах. В отличие от остальных, принимает дополнительный параметр:
       1. `page` — Страница для вывода. На одной странице выводится 10 записей. Должен быть целым числом. Параметр должен быть дописан к запросу: `?dataType={0}&page={1}`.
2. Контроллеры отчётов — Выводят общие сведения по группам / институтам / студентам. Обращение происходит по адресу `./overview?faculties={0}&eduForms={1}`:
   1. Параметры:
      * Параметры должны отправляться в формате массива. Например: `./overview?faculties[]=ИТМ&faculties[]=ИИМРТ&eduForms[]=ОЗ`. Наличие знака массива `[]` обязательно после названия параметра. Параметры отправляются столько раз, сколько значений в них будет:
        1. Параметр `faculties` определяет факультеты / институты, которые будут выведены;
        2. Параметр `eduForms` определяет какие формы обучения (очная, очно-заочная, заочная) будут отобраны. Отправляется по инициалам (`О`, `ОЗ`, `З`). Если не определить этот параметр, будут выведены данные о всех формах обучения.
   2. Если параметр `faculties` не определён, будет выведен общий отчёт.

## EN

TODO.
