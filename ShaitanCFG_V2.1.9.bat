@echo off
color 3

mode con:cols=160 lines=50

::=========================������� ����=========================::

echo.
echo.
echo..dP"Y8 88  88    db    88 888888    db    88b 88      dP""b8  dP"Yb  88b 88 888888 88  dP""b8     Yb    dP oP"Yb.      dP"Yb  
echo.`Ybo." 88  88   dPYb   88   88     dPYb   88Yb88     dP   `" dP   Yb 88Yb88 88__   88 dP   `"      Yb  dP  "' dP'     dP   Yb 
echo.o.`Y8b 888888  dP__Yb  88   88    dP__Yb  88 Y88     Yb      Yb   dP 88 Y88 88""   88 Yb  "88       YbdP     dP'  .o. Yb   dP 
echo.8bodP' 88  88 dP""""Yb 88   88   dP""""Yb 88  Y8      YboodP  YbodP  88  Y8 88     88  YboodP        YP    .d8888 `"'  YbodP  
echo.
echo.
::��������� �������� �������������� ������ ����� ���� ������ � �����������
schtasks /Change /TN \Microsoft\Windows\Defrag\ScheduledDefrag /DISABLE
::���������� posh ������ ��� ���������� ���������� �� ������ �� ������ ������
powershell.exe -executionpolicy remotesigned -File "%~dp0indexingOFF.ps1"
::=========================������� ����=========================::


::=========================������ ����=========================::

::����������� �� ���� "���������" ��� ������-��������� ����� � ������������ ���������� ��������
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
::��� ��������� ����, ������ ����� https://chocolatey.org/packages , ��������� ���� ����� ������ ��� ����� �������
cinst 7zip vlc libreoffice notepadplusplus teamviewer anydesk.install googlechrome microsoft-edge directx vcredist140 -y --ignore-checksums
timeout 3
cinst 7zip vlc libreoffice notepadplusplus teamviewer anydesk.install googlechrome microsoft-edge directx vcredist140 -y --ignore-checksums
echo. SOFT INSTALLERD COMPLEATLY

pause


::=========================������ ����=========================::


::=========================������ ����=========================::

::����������� ������� �������� ��� ���� � �����
netsh advfirewall firewall set rule name="Teamviewer Remote Control Application" dir=in program="C:\Program Files (x86)\TeamViewer\TeamViewer.exe" new profile=any
netsh advfirewall firewall set rule name="Teamviewer Remote Control Service" dir=in program="C:\Program Files (x86)\TeamViewer\TeamViewer_Service.exe" new profile=any
netsh advfirewall firewall set rule name="���������� �� ����������� ������� (���-������ - ICMPv4 - �������� ������)" protocol=icmpv4 localip=any remoteip=any dir=in program="System" new profile=any action=allow enable=yes
netsh advfirewall firewall set rule name="����� ������ � ������ � ��������� (���-������ - �������� ������ ICMPv4)" dir=in program="System" new profile=any protocol=icmpv4 localip=any remoteip=any  action=allow enable=yes
echo.FIREWALL RULES UPDATED
timeout 5

::=========================������ ����=========================::

::=========================������ ����=========================::

::������� ���� �������� � ����� C:\ � ���������� ��� �� ���� D:\ � �������� �������� � 16 ����� � ������������ 32 ����
@echo off
chcp 1251

echo         1. ������� ���� � ����� C:\ � ���������� �� ������ ����?
echo         2. ������� � ���������� �������
set /p choice=        ������� ����� ������: 
if '%choice%'=='1' goto 1
if '%choice%'=='2' goto 2
goto start
:1
chcp 866
cd /d C:\Windows\system32
::�������� ���� �����
wmic pagefile get /format:list
::��������� ��������� ������� ����� ��������
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
::������� ���� �� C:\\
wmic pagefileset where name="C:\\pagefile.sys" delete
chcp 1251
set /p swapdisk="����� ��������� ����� ����� ��� �����: "
chcp 866
::������� ���� �� ����� ������� ������ �������
wmic pagefileset create name="%swapdisk%:\\pagefile.sys"
::������� ���� �� ����� ������� ������ �������
wmic pagefileset create name="%swapdisk%:\\pagefile.sys"
::������������� � ��������� ���� ��� ����������� �������
wmic pagefileset where name="%swapdisk%:\\pagefile.sys" 
::������ ������� ������ � ������������ ������ ����� (� ��)
chcp 1251
set /p swapmin="����� ������ ����� ��: (������ �� 16384)"
set /p swapmax="����� ������ ����� ��: (������ �� 32768)"
chcp 866
wmic pagefileset set InitialSize=%swapmin%,MaximumSize=%swapmax%
goto 2

echo.SWAP FILE UPDATED
timeout 5

::=========================������ ����=========================::


::=========================��������� ����=========================::
goto start
:2
::������������� ����� ������� "������� ������������������"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
::�������� ������� �� ���������� �������� �� ����
powercfg /change -monitor-timeout-ac 0
::�������� ������� �� ���������� �������� �� �������
powercfg /change -monitor-timeout-dc 0
::�������� ������� �� ���������� �������� �� ����
powercfg /change -standby-timeout-ac 0
::�������� ������� �� ���������� �������� �� �������
powercfg /change -standby-timeout-dc 0

echo. POWER CONFIG UPDATED

timeout 5

::=========================��������� ����=========================::


::=========================����� ����=========================::
color 60
::�������� ��� �� � ������� ��������
hostname
::������� ����� ��� ����� ����� � �������
set /p name="Enter PC name: "
::������ ��� �� �� �������� ��������� � ������� 
wmic computersystem where name="%computername%" call rename name="%name%" 
echo.PC NAME CHANGED

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
Echo �� ��������� ������ ����� �������
Echo.
Echo.
goto m1
pause >nul
::������������� �� ��� ���������� ��������
::shutdown -r -t 00
::=========================����� ����=========================::