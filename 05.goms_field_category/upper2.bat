@echo off
setlocal

:: �Է� ���ڿ� ����
set "category=field_story"

:: ù ���ڸ� �빮�ڷ� ��ȯ
set "firstChar=%category:~0,1%"
for %%A in (%firstChar%) do set "firstChar=%%A"

:: ������ ���ڿ��� �����ϰ� ó��
set "restStr=%category:~1%"
:loop
    setlocal enabledelayedexpansion
    set "underscorePos=!restStr:_=!"
    if "%underscorePos%" neq "%restStr%" (
        for /f "tokens=1,* delims=_" %%a in ("!restStr!") do (
            set "nextChar=%%b"
            set "nextChar=!nextChar:~0,1!"
            set "nextChar=!nextChar:S=S!"
            set "restStr=%%a!nextChar!!nextChar:~1!"
        )
    )
    endlocal
    if "%underscorePos%" neq "%restStr%" goto loop

:: ���� ��� ����
set "result=%firstChar%%restStr%"

:: ��� ���
echo %result%


endlocal
pause