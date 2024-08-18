@echo off
setlocal

:: 입력 문자열 설정
set "category=field_catogory"

:: 언더스코어 포함 여부 체크
echo. %category% | find "_" > nul

if %errorlevel% equ 0 (
    set "restStr=%category:~1,5%"
    echo %category%
    echo. %restStr%

) else (
    echo. 언더스코어가 포함되어 있지 않습니다.


)

endlocal
pause