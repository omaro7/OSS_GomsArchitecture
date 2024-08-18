@echo off
setlocal enabledelayedexpansion

:: �Է� ���ڿ� ����
set "category=field"

set "restStr=%category:~1,20%"

:: Taking the first character of the string and doing it to upper case.
    set "str=%category:~0,1%"
    for /f "skip=2 delims=" %%I in ('tree "\%str%"') do if not defined upper set "upper=%%~I"
    set "upper=%upper:~3%"
:: Printing the result by concating both of them.
    set "uCategory=%upper%%restStr%"

:: ������ھ� ������ ���ڸ� �빮�ڷ� ��ȯ
for /f "tokens=1,* delims=_" %%a in ("%uCategory%") do (
    set "prefix=%%a"
    set "suffix=%%b"
)

echo.%prefix%
echo.%suffix%

:: prefix ������ ���� ������ ����
set "globalPrefix=%prefix%"
set "globalSuffix=%suffix%"

echo.Prefix: %globalPrefix%
echo.Suffix: %globalSuffix%

:: suffix�� null�� �ƴ� ��� > str2�� �̸� �����Ѵ�.
set "str2=%globalSuffix:~0,1%"
set "restStr2=%globalSuffix:~1,20%"

set "upper2=%globalSuffix:~0,1%"
set "uCategory2=%globalPrefix:~0,20%"

:: suffix�� null�� �ƴ� ��쿡�� ����
if defined globalSuffix (
    echo.���⿩��
    echo.%globalPrefix%
    echo.%globalSuffix%
    :: suffix�� ù ���ڸ� ����
    set "str2=%globalSuffix:~0,1%"
    set "restStr2=%suffix:~1,20%"

    echo.STR2: !str2!
    echo.RESTSTR2: !restStr2!

    :: ù ���ڸ� �빮�ڷ� ��ȯ
    set "upper2="
    for %%I in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
        if /I "!str2!"=="%%I" set "upper2=%%I"
    )
    echo.UPPER2: !upper2!

    :: ����� ����
    set "uCategory=%globalPrefix%!upper2!!restStr2!"
    echo.Final Category: !uCategory!

) else (
    :: suffix�� null�̸� pass
    echo.Final Category: !uCategory!
)

echo.Final Category: !uCategory!

set "category=

endlocal
pause