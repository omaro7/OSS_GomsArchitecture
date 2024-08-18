@echo off
setlocal enabledelayedexpansion

:: 입력 문자열 설정
set "category=field"

set "restStr=%category:~1,20%"

:: Taking the first character of the string and doing it to upper case.
    set "str=%category:~0,1%"
    for /f "skip=2 delims=" %%I in ('tree "\%str%"') do if not defined upper set "upper=%%~I"
    set "upper=%upper:~3%"
:: Printing the result by concating both of them.
    set "uCategory=%upper%%restStr%"

:: 언더스코어 이후의 글자를 대문자로 변환
for /f "tokens=1,* delims=_" %%a in ("%uCategory%") do (
    set "prefix=%%a"
    set "suffix=%%b"
)

echo.%prefix%
echo.%suffix%

:: prefix 변수를 전역 변수로 설정
set "globalPrefix=%prefix%"
set "globalSuffix=%suffix%"

echo.Prefix: %globalPrefix%
echo.Suffix: %globalSuffix%

:: suffix가 null이 아닐 경우 > str2를 미리 세팅한다.
set "str2=%globalSuffix:~0,1%"
set "restStr2=%globalSuffix:~1,20%"

set "upper2=%globalSuffix:~0,1%"
set "uCategory2=%globalPrefix:~0,20%"

:: suffix가 null이 아닐 경우에만 진행
if defined globalSuffix (
    echo.여기여기
    echo.%globalPrefix%
    echo.%globalSuffix%
    :: suffix의 첫 글자를 추출
    set "str2=%globalSuffix:~0,1%"
    set "restStr2=%suffix:~1,20%"

    echo.STR2: !str2!
    echo.RESTSTR2: !restStr2!

    :: 첫 글자를 대문자로 변환
    set "upper2="
    for %%I in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
        if /I "!str2!"=="%%I" set "upper2=%%I"
    )
    echo.UPPER2: !upper2!

    :: 결과를 결합
    set "uCategory=%globalPrefix%!upper2!!restStr2!"
    echo.Final Category: !uCategory!

) else (
    :: suffix가 null이면 pass
    echo.Final Category: !uCategory!
)

echo.Final Category: !uCategory!

set "category=

endlocal
pause