@echo off
color 3

mode con:cols=160 lines=50

::=========================НУЛЕВОЙ БЛОК=========================::

echo.
echo.
echo..dP"Y8 88  88    db    88 888888    db    88b 88      dP""b8  dP"Yb  88b 88 888888 88  dP""b8     Yb    dP oP"Yb.      dP"Yb  
echo.`Ybo." 88  88   dPYb   88   88     dPYb   88Yb88     dP   `" dP   Yb 88Yb88 88__   88 dP   `"      Yb  dP  "' dP'     dP   Yb 
echo.o.`Y8b 888888  dP__Yb  88   88    dP__Yb  88 Y88     Yb      Yb   dP 88 Y88 88""   88 Yb  "88       YbdP     dP'  .o. Yb   dP 
echo.8bodP' 88  88 dP""""Yb 88   88   dP""""Yb 88  Y8      YboodP  YbodP  88  Y8 88     88  YboodP        YP    .d8888 `"'  YbodP  
echo.
echo.

::=========================НУЛЕВОЙ БЛОК=========================::


::=========================ПЕРВЫЙ БЛОК=========================::

::Прокидываем на комп "шоколадку" для онлайн-установки софта с относительно последними версиями
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
::Тут вписываем софт, искать через https://chocolatey.org/packages , вписываем либо через пробел или через запятую
cinst 7zip vlc libreoffice notepadplusplus teamviewer googlechrome directx vcredist140 -y --ignore-checksums
echo.
echo.
echo.   db    88     88         .dP"Y8  dP"Yb  888888 888888 Yb        dP    db    88""Yb 888888           
echo.  dPYb   88     88         `Ybo." dP   Yb 88__     88    Yb  db  dP    dPYb   88__dP 88__             
echo. dP__Yb  88  .o 88  .o     o.`Y8b Yb   dP 88""     88     YbdPYbdP    dP__Yb  88"Yb  88""             
echo.dP""""Yb 88ood8 88ood8     8bodP'  YbodP  88       88      YP  YP    dP""""Yb 88  Yb 888888  
echo.         
echo.888888 88   88 88     88     Yb  dP     88 88b 88 .dP"Y8 888888    db    88     88     888888 8888b.  
echo.88__   88   88 88     88      YbdP      88 88Yb88 `Ybo."   88     dPYb   88     88     88__    8I  Yb 
echo.88""   Y8   8P 88  .o 88  .o   8P       88 88 Y88 o.`Y8b   88    dP__Yb  88  .o 88  .o 88""    8I  dY 
echo.88     `YbodP' 88ood8 88ood8  dP        88 88  Y8 8bodP'   88   dP""""Yb 88ood8 88ood8 888888 8888Y"  
echo.
timeout 5

::=========================ПЕРВЫЙ БЛОК=========================::


::=========================ВТОРОЙ БЛОК=========================::

::Прокидываем правила фаервола для тима и пинга
netsh advfirewall firewall set rule name="Teamviewer Remote Control Application" dir=in program="C:\Program Files (x86)\TeamViewer\TeamViewer.exe" new profile=any
netsh advfirewall firewall set rule name="Teamviewer Remote Control Service" dir=in program="C:\Program Files (x86)\TeamViewer\TeamViewer_Service.exe" new profile=any
netsh advfirewall firewall set rule name="Наблюдение за виртуальной машиной (эхо-запрос - ICMPv4 - входящий трафик)" protocol=icmpv4 localip=any remoteip=any dir=in program="System" new profile=any action=allow enable=yes
netsh advfirewall firewall set rule name="Общий доступ к файлам и принтерам (эхо-запрос - входящий трафик ICMPv4)" dir=in program="System" new profile=any protocol=icmpv4 localip=any remoteip=any  action=allow enable=yes
echo.
echo.
echo.888888 88 88""Yb 888888 Yb        dP    db    88     88         88""Yb 88   88 88     888888 .dP"Y8 
echo.88__   88 88__dP 88__    Yb  db  dP    dPYb   88     88         88__dP 88   88 88     88__   `Ybo." 
echo.88""   88 88"Yb  88""     YbdPYbdP    dP__Yb  88  .o 88  .o     88"Yb  Y8   8P 88  .o 88""   o.`Y8b 
echo.88     88 88  Yb 888888    YP  YP    dP""""Yb 88ood8 88ood8     88  Yb `YbodP' 88ood8 888888 8bodP' 
echo.
echo.88   88 88""Yb 8888b.     db    888888 888888 8888b.  
echo.88   88 88__dP  8I  Yb   dPYb     88   88__    8I  Yb                
echo.Y8   8P 88"""   8I  dY  dP__Yb    88   88""    8I  dY 
echo.`YbodP' 88     8888Y"  dP""""Yb   88   888888 8888Y"        
timeout 5

::=========================ВТОРОЙ БЛОК=========================::

::=========================ТРЕТИЙ БЛОК=========================::

::удаляем файл подкачки с диска C:\ и запихиваем его на диск D:\ с исходным размером в 16 гигов и максимальным 32 гига
@echo off
chcp 1251

echo         1. Удалить своп с диска C:\ и пробросить на другой диск?
echo         2. Перейти к следующему заданию
set /p choice=        Введите цифру пункта: 
if '%choice%'=='1' goto 1
if '%choice%'=='2' goto 2
goto start
:1
chcp 866
cd /d C:\Windows\system32
::Получаем лист свопа
wmic pagefile get /format:list
::Выключаем автовыбор размера свопа системой
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
::Удаляем своп на C:\\
wmic pagefileset where name="C:\\pagefile.sys" delete
chcp 1251
set /p swapdisk="Впиши заглавную букву диска для свопа: "
chcp 866
::Создаем своп на диске который вводим ручками
wmic pagefileset create name="%swapdisk%:\\pagefile.sys"
::Создаем своп на диске который вводим ручками
wmic pagefileset create name="%swapdisk%:\\pagefile.sys"
::Пропинываемся в созданный своп для дальнейшего конфига
wmic pagefileset where name="%swapdisk%:\\pagefile.sys" 
::Задаем текущий размер и максимальный размер свопа (в МБ)
chcp 1251
set /p swapmin="Впиши размер свопа ОТ: (обычно от 16384)"
set /p swapmax="Впиши размер свопа ДО: (обычно до 32768)"
chcp 866
wmic pagefileset set InitialSize=%swapmin%,MaximumSize=%swapmax%
goto start
:2
goto exit

echo.
echo.
echo..dP"Y8 Yb        dP    db    88""Yb     888888 88 88     888888 
echo.`Ybo."  Yb  db  dP    dPYb   88__dP     88__   88 88     88__   
echo.o.`Y8b   YbdPYbdP    dP__Yb  88"""      88""   88 88  .o 88""   
echo.8bodP'    YP  YP    dP""""Yb 88         88     88 88ood8 888888 
echo.
echo.88   88 88""Yb 8888b.     db    888888 888888 8888b.            
echo.88   88 88__dP  8I  Yb   dPYb     88   88__    8I  Yb           
echo.Y8   8P 88"""   8I  dY  dP__Yb    88   88""    8I  dY           
echo.`YbodP' 88     8888Y"  dP""""Yb   88   888888 8888Y"            
echo.
echo.
timeout 5

::=========================ТРЕТИЙ БЛОК=========================::


::=========================ЧЕТВЕРТЫЙ БЛОК=========================::

::Устанавливаем схему питания "Высокая производительность"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
::Вырубаем таймаут на отключение монитора от сети
powercfg /change -monitor-timeout-ac 0
::Вырубаем таймаут на отключение монитора от батареи
powercfg /change -monitor-timeout-dc 0
::Вырубаем таймаут на отключение монитора от сети
powercfg /change -standby-timeout-ac 0
::Вырубаем таймаут на отключение монитора от батареи
powercfg /change -standby-timeout-dc 0

echo.
echo.
echo.88""Yb  dP"Yb  Yb        dP 888888 88""Yb     8b    d8  dP"Yb  8888b.  888888 
echo.88__dP dP   Yb  Yb  db  dP  88__   88__dP     88b  d88 dP   Yb  8I  Yb 88__   
echo.88"""  Yb   dP   YbdPYbdP   88""   88"Yb      88YbdP88 Yb   dP  8I  dY 88""   
echo.88      YbodP     YP  YP    888888 88  Yb     88 YY 88  YbodP  8888Y"  888888 
echo.
echo.88   88 88""Yb 8888b.     db    888888 888888 8888b.                          
echo.88   88 88__dP  8I  Yb   dPYb     88   88__    8I  Yb                         
echo.Y8   8P 88"""   8I  dY  dP__Yb    88   88""    8I  dY                         
echo.`YbodP' 88     8888Y"  dP""""Yb   88   888888 8888Y"                          
echo.
echo.
timeout 5

::=========================ЧЕТВЕРТЫЙ БЛОК=========================::


::=========================ПЯТЫЙ БЛОК=========================::
color 60
::Получаем имя ПК с которым работаем
hostname
::Немного магии для ввода имени в консоли
set /p name="Enter PC name: "
::Задаем имя ПК по значению введенном в консоли 
wmic computersystem where name="%computername%" call rename name="%name%" 
echo.
echo.
echo.88""Yb  dP""b8     88b 88    db    8b    d8 888888    
echo.88__dP dP   `"     88Yb88   dPYb   88b  d88 88__      
echo.88"""  Yb          88 Y88  dP__Yb  88YbdP88 88""      
echo.88      YboodP     88  Y8 dP""""Yb 88 YY 88 888888    
echo.
echo. dP""b8 88  88    db    88b 88  dP""b8 888888 8888b.  
echo.dP   `" 88  88   dPYb   88Yb88 dP   `" 88__    8I  Yb 
echo.Yb      888888  dP__Yb  88 Y88 Yb  "88 88""    8I  dY 
echo. YboodP 88  88 dP""""Yb 88  Y8  YboodP 888888 8888Y"  
echo.
echo.
timeout 5
color 40
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.88b 88 888888 888888 8888b.      88""Yb 888888 88""Yb  dP"Yb   dP"Yb  888888     d8b 
echo.88Yb88 88__   88__    8I  Yb     88__dP 88__   88__dP dP   Yb dP   Yb   88       Y8P 
echo.88 Y88 88""   88""    8I  dY     88"Yb  88""   88""Yb Yb   dP Yb   dP   88       `"' 
echo.88  Y8 888888 888888 8888Y"      88  Yb 888888 88oodP  YbodP   YbodP    88       (8) 
echo.
echo.
echo.
echo.
echo.
echo.
@echo off
:m1
Echo Please choice one:
Echo.
Echo 1 - REBOOT NOW! 1
Echo 2 - REBOOT LATER 2
 
echo.
Set /p choice="Your choice: "
if not defined choice goto m1
if "%choice%"=="1" (start shutdown.exe -r -t 00)
if "%choice%"=="2" (exit)
Echo.
Echo Не правильно сделан выбор задания
Echo.
Echo.
goto m1
pause >nul
::Перезагружаем ПК для применения настроек
::shutdown -r -t 00
::=========================ПЯТЫЙ БЛОК=========================::