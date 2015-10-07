#IP Studio AMBS documentation
Инструкция по использованию скрипта для прямого тестирования шлюзов оператора.


Прежде всего - нужно вручную запустить программу twinkle.

Запуск скрипта производится так - ./test.sh phones, где phones - подготовленный файл со списком телефонных номеров.Последняя строка в файле должна оканчиваться переводом строки, чтобы скрипт корректно обработал последний номер из списка.
В номерах не должно быть пробелов, должны быть только цифры, без всяческих тире и прочих знаков.


Далее, нужно выбрать компанию, от которой будут исходить звонки. После этого вводим ID сайта, на который нужно послать звонок и жмём Enter.
Сразу после этого скрипт инициирует звонок на первый номер из файла. Появляется список, в котором перечислены распространённые описания осуществленного звонка.

Нужно ввести номер варианта который соответствует ситуации со звонком (либо же, если подходящего варианта нет - введите своё описание) и нажмите Enter. В случае если звонок активный (идет разговор) - после нажания Enter он оборвется и произойдёт инициация вызова следующего номера.

Если нужно перепроверить номер - его можно вставить в Twinkle и проверить вручную, звонки не будут идти дальше пока не введено описание звонка.

После того как скрипт прозвонит все номера - он выведет полный лог своей работы, в конце которого будут результаты вашего теста. Эти результаты копируем и отправляем создателю тикета.


Если нужно проверить много операторов и сразу - в файл со звонками вносим номера с префиксами прямого тестирования.
На этапе выбора компании и сайта ничего не вводим, просто жмём Enter (операторы и сайта у нас уже указаны в файле)

