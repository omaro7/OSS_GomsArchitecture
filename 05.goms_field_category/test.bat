@echo off
setlocal

:: �Է� ���ڿ� ����
set "category=field_catogory"

:: ������ھ� ���� ���� üũ
echo. %category% | find "_" > nul

if %errorlevel% equ 0 (
    set "restStr=%category:~1,5%"
    echo %category%
    echo. %restStr%

) else (
    echo. ������ھ ���ԵǾ� ���� �ʽ��ϴ�.


)

endlocal
pause