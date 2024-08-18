@echo off
setlocal

:: 입력 문자열 설정
set "category=field_story"

:: 첫 글자를 대문자로 변환
set "firstChar=%category:~0,1%"
for %%A in (%firstChar%) do set "firstChar=%%A"

:: 나머지 문자열을 추출하고 처리
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

:: 최종 결과 조합
set "result=%firstChar%%restStr%"

:: 결과 출력
echo %result%


endlocal
pause