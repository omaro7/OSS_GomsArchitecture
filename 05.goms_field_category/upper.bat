@echo off
setlocal

:: 입력 문자열 설정
set "category=field"

set "restStr=%category:~1,20%"

:: Taking the first character of the string and doing it to upper case.
    set "str=%category:~0,1%"
    for /f "skip=2 delims=" %%I in ('tree "\%str%"') do if not defined upper set "upper=%%~I"
    set "upper=%upper:~3%"
:: Printing the result by concating both of them.
    set "uCategory=%upper%%restStr%"

echo %uCategory%

:: 언더스코어 이후의 글자를 대문자로 변환
for /f "tokens=1,* delims=_" %%a in ("%uCategory%") do (
    set "prefix=%%a"
    set "suffix=%%b"
)

echo. %prefix%
echo. %suffix%

    set "str2=%suffix:~0,1%"
    set "restStr2=%suffix:~1,20%"
    for /f "skip=2 delims=" %%I in ('tree "\%str2%"') do if not defined upper2 set "upper2=%%~I"
    set "upper2=%upper2:~3%"

    set "uCategory2=%prefix%%upper2%%restStr2%"

echo %uCategory2%

endlocal
pause