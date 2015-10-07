#!/bin/bash

[ $# -lt 1 ] &&  { echo "Usage: ${0##*/} <numbers file>"; exit 1; }

clear								#Очистка консоли
count=1								#Установка счетчика номера звонка по порядку в 1
DATE=$(date)

#Перечислаем дескрипшены
desc[1]="КПВ + ответ абонента. Всё ОК."
desc[2]="Тарификация тишины"
desc[3]="КПВ без ответа"
desc[4]="Отбился"
desc[5]="Занято"
desc[6]="АИ"
desc[7]="АИ соединение установлено+КПВ+ответ"
desc[8]="АИ соединение установлено+КПВ без ответа"
desc[9]="Автоответчик, голосовая почта"
desc[10]="Ответ факса или модема"
desc[11]="Автосекретарь"
desc[12]="Тарификация КПВ+ответ абонента (возможно установлен АОН)"
desc[13]="Тарификация КПВ без ответа (возможно установлен АОН)"
desc[14]="Тарификация КПВ"
desc[15]="Большое ПДД (>10 сек) + отбой"
desc[16]="Большое ПДД (>10 сек) + ответ абонента"
desc[17]="Несколько гудков и отбой"
desc[18]="Плохая слышимость (прерывания, шумы)"
desc[19]="Абонент Б не слышит абонента А"
desc[20]="Отсутствие КПВ (ответ из тишины)"
desc[21]="АИ о пополнении баланса (любой)"
desc[22]="АИ номер заблокирован"
desc[23]="Подставленная аудиозапись (ложный ответ)"
desc[24]="Короткие гудки"
desc[25]="Нестандартные гудки"

#Узнаём сколько у нас всего дескрипшенов жи есть
desc_count=${#desc[*]}

echo "--------------------------------------" >> log.txt;
echo "Тестирование запущено $DATE" >> log.txt;				#Запись шапки лога

echo -e "\n\n"
echo -e "     ---------------------------------------------------"
echo -e "     |  Скрипт для тестирования роутов прямым набором  |"
echo -e "     |     With russian user-friendly CLI interface    |"
echo -e "     |                                                 |"
echo -e "     ---------------------------------------------------"
echo -e "\n\n"

echo "Через кого будем звонить?"
echo "1) Oper 1 (01000)"
echo "2) Oper 2 (11000)"
echo "3) Файл номеров заполнен вручную, с указанием префиксов"

read case;

case $case in
    1) prefix=01000;subj="Oper 1";;
    2) prefix=11000;subj="Oper 2";;
    3) prefix="";subj="Ручное заполнение";;
esac


if [ $prefix = '01000' -o $prefix = '11000' ]
then
echo "Введи сайт:"
read site_num
if [ -z "$site_num" ]
then
site=
else
site=${site_num}*
fi
fi

echo "Через ${prefix}${site}" >>log.txt;

exec 2<$1;
while read line <&2;
do
echo -e "Звоню по $count номеру"
echo -e "${prefix}${site}${line}"
twinkle --call ${prefix}${site}${line}?subject="Тестовый звонок №$count. $subj" --immediate show

#Тут рисовались плюсики, было подобие прогрессбара. Поскольку скрипт допилен - они больше не нужны.
#for dots in 1 2 3; do
#sleep 1
#echo -n "+"
#done
#echo -e "\t"
#echo -e "Надоело мне звонить на $count номер..."
#echo -e "\t"

echo -e "-----------------------------------------"
#Выводим дескрипшены
desc_echo_count=1
echo -e "Введите номер варианта и нажмите Enter\n"
while [ "$desc_echo_count" -le "$desc_count" ]
do
echo "$desc_echo_count) ${desc["$desc_echo_count"]}"
desc_echo_count=$(expr $desc_echo_count + 1)
done
echo -e "\n\nИли введите ваши комментарии и нажмите Enter"
echo -e "-----------------------------------------\n"

#При добавлении нового дескрипшена - надо добавлять его и в это условие. Как избивиться от этого - есчо не придумал.
read case;
case $case in
    1) echo "$line ${desc[$case]}" >> log.txt;;
    2) echo "$line ${desc[$case]}" >> log.txt;;
    3) echo "$line ${desc[$case]}" >> log.txt;;
    4) echo "$line ${desc[$case]}" >> log.txt;;
    5) echo "$line ${desc[$case]}" >> log.txt;;
    6) echo "$line ${desc[$case]}" >> log.txt;;
    7) echo "$line ${desc[$case]}" >> log.txt;;
    8) echo "$line ${desc[$case]}" >> log.txt;;
    9) echo "$line ${desc[$case]}" >> log.txt;;
    10) echo "$line ${desc[$case]}" >> log.txt;;
    11) echo "$line ${desc[$case]}" >> log.txt;;
    12) echo "$line ${desc[$case]}" >> log.txt;;
    13) echo "$line ${desc[$case]}" >> log.txt;;
    14) echo "$line ${desc[$case]}" >> log.txt;;
    15) echo "$line ${desc[$case]}" >> log.txt;;
    16) echo "$line ${desc[$case]}" >> log.txt;;
    17) echo "$line ${desc[$case]}" >> log.txt;;
    18) echo "$line ${desc[$case]}" >> log.txt;;
    19) echo "$line ${desc[$case]}" >> log.txt;;
    20) echo "$line ${desc[$case]}" >> log.txt;;
    21) echo "$line ${desc[$case]}" >> log.txt;;
    22) echo "$line ${desc[$case]}" >> log.txt;;
    23) echo "$line ${desc[$case]}" >> log.txt;;
    24) echo "$line ${desc[$case]}" >> log.txt;;
    25) echo "$line ${desc[$case]}" >> log.txt;;


     *) echo "$line $case" >> log.txt;;
esac

#В случае выставления оценки звонку - кладём трубку, не трогая твинкл мышкой.
twinkle --cmd bye

count=$(expr $count + 1)

done

echo "Тестирование окончено $DATE" >> log.txt;

cat log.txt
