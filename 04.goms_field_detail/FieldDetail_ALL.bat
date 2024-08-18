@echo off
setlocal

set "currentFolderPath=%CD%"

:: set PYTHON_SCRIPT=D:\08.SpringBoot\02.workspace\ams\script\read_yaml.py
set PYTHON_SCRIPT=%currentFolderPath%\read_yaml.py
set YAML_FILE=%currentFolderPath%\config.yml

echo YAML_FILE : %YAML_FILE%

for /f "tokens=*" %%i in ('python "%PYTHON_SCRIPT%" "%YAML_FILE%"') do %%i

set "workspace=%workspace_path%"
set "defaultPackage=%workspace_defaultPackage%"
set "targetPackage=%workspace_targetPackage%"
set "category=%workspace_category%"

set "table=%entity_table%"
set "query=%query%"
set "query_one=%query_one%"
set "query_del=%query_del%"
set "query_upd=%query_upd%"
set "query_ins=%query_ins%"

echo workspace : %workspace%
echo defaultPackage : %defaultPackage%
echo targetPackage : %targetPackage%
echo query_ins : %query_ins%

echo Hello, Goms World!

:: Taking the rest of the string as it is as we don't need to change that.
    set "restStr=%category:~1,20%"

:: Taking the first character of the string and doing it to upper case.
    set "str=%category:~0,1%"
    for /f "skip=2 delims=" %%I in ('tree "\%str%"') do if not defined upper set "upper=%%~I"
    set "upper=%upper:~3%"
:: Printing the result by concating both of them.
    set "uCategory=%upper%%restStr%"

echo %uCategory%

:: Create Controller
    set "strController=Controller"
    set "controller=%uCategory%%strController%

:: Create Repository
    set "strRepository=Repository"
    set "repository=%uCategory%%strRepository%

:: Create Service
    set "strService=Service"
    set "service=%uCategory%%strService%

echo %controller%
echo %repository%
echo %service%

:: Domain Create Folder
    set "strDomainFolder=domain"
    mkdir "%strDomainFolder%"

:: DTO Create Folder
    set "strDtoFolder=service\dto"
    mkdir "%strDtoFolder%"

:: Mapper Create Folder
    set "strMapperFolder=mapper"
    mkdir "%strMapperFolder%"

:: Controller Create Folder
    set "strControllerFolder=controller"
    mkdir "%strControllerFolder%"

:: Repository Create Folder
    set "strRepositoryFolder=repository"
    mkdir "%strRepositoryFolder%"

:: Service Create Folder
    set "strServiceFolder=service"
    mkdir "%strServiceFolder%"

:: ############################  Domain ############################
:: Domain Create File	>> MemberIn.java
    set "strIn=In"
    set "strIdxIn=IdxIn"
    set "strJava=.java"
    set "strDomainClassName=%uCategory%%strIn%"
    set "strDomainClassName_Idx=%uCategory%%strIdxIn%"
    set "strDomainPackageName=%defaultPackage%.%targetPackage%.domain";
    set "strDomainFilePath=%strDomainClassName%%strJava%"

    echo "%strDomainFilePath%"

:: Create the file and write content to it >>>> MemberIn.java
(
    echo package %strDomainPackageName%;
    echo.
    echo import java.util.Date;
    echo import org.springframework.format.annotation.DateTimeFormat;
    echo import com.fasterxml.jackson.annotation.JsonFormat;
    echo import lombok.Data;
    echo.
    echo @Data
    echo public class %strDomainClassName% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 10) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strDomainFilePath%"

:: Domain Create File > Move
move "%strDomainFilePath%" "%strDomainFolder%"

:: ############################  Domain IDX ############################
:: Domain Create File	>> MemberIdxIn.java
    set "strIdxIn=IdxIn"
    set "strDomainClassName_Idx=%uCategory%%strIdxIn%"
    set "strDomainFilePath_Idx=%strDomainClassName_Idx%%strJava%"

    echo "%strDomainFilePath_Idx%"

:: Create the file and write content to it >>>> MemberIdxIn.java
(
    echo package %strDomainPackageName%;
    echo.
    echo import lombok.Data;
    echo.
    echo @Data
    echo public class %strDomainClassName_Idx% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 0) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strDomainFilePath_Idx%"

:: Domain Create File > Move
move "%strDomainFilePath_Idx%" "%strDomainFolder%"

:: ############################  Domain Del ############################
:: Domain Create File	>> MemberDelIn.java
    set "strDelIn=DelIn"
    set "strDomainClassName_Del=%uCategory%%strDelIn%"
    set "strDomainFilePath_Del=%strDomainClassName_Del%%strJava%"

    echo "%strDomainFilePath_Del%"

:: Create the file and write content to it >>>> MemberDelIn.java
(
    echo package %strDomainPackageName%;
    echo.
    echo import lombok.Data;
    echo.
    echo @Data
    echo public class %strDomainClassName_Del% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 0) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strDomainFilePath_Del%"

:: Domain Create File > Move
move "%strDomainFilePath_Del%" "%strDomainFolder%"

:: ############################  Domain Upd ############################
:: Domain Create File	>> MemberDelIn.java
    set "strUpdIn=UpdIn"
    set "strDomainClassName_Upd=%uCategory%%strUpdIn%"
    set "strDomainFilePath_Upd=%strDomainClassName_Upd%%strJava%"

    echo "%strDomainFilePath_Upd%"

:: Create the file and write content to it >>>> MemberUpdIn.java
(
    echo package %strDomainPackageName%;
    echo.
    echo import java.util.Date;
    echo import org.springframework.format.annotation.DateTimeFormat;
    echo import com.fasterxml.jackson.annotation.JsonFormat;
    echo import lombok.Data;
    echo.
    echo @Data
    echo public class %strDomainClassName_Upd% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 10) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strDomainFilePath_Upd%"

:: Domain Create File > Move
move "%strDomainFilePath_Upd%" "%strDomainFolder%"

:: ############################  Domain Ins ############################
:: Domain Create File	>> MemberDelIn.java
    set "strInsIn=InsIn"
    set "strDomainClassName_Ins=%uCategory%%strInsIn%"
    set "strDomainFilePath_Ins=%strDomainClassName_Ins%%strJava%"

    echo "%strDomainFilePath_Ins%"

:: Create the file and write content to it >>>> MemberInsIn.java
(
    echo package %strDomainPackageName%;
    echo.
    echo import java.util.Date;
    echo import org.springframework.format.annotation.DateTimeFormat;
    echo import com.fasterxml.jackson.annotation.JsonFormat;
    echo import lombok.Data;
    echo.
    echo @Data
    echo public class %strDomainClassName_Ins% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 10) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strDomainFilePath_Ins%"

:: Domain Create File > Move
move "%strDomainFilePath_Ins%" "%strDomainFolder%"

:: ############################  DTO ############################
:: DTO Create File
    set "strInDto=InDto"
    set "strJava=.java"
    set "strDtoClassName=%uCategory%%strInDto%"
    set "strDtoPackageName=%defaultPackage%.%targetPackage%.service.dto";
    set "strDtoFilePath=%strDtoClassName%%strJava%"

    echo "%strDtoFilePath%"

:: Create the file and write content to it >>>> MemberInDto.java
(
    echo package %strDtoPackageName%;
    echo.
    echo import java.util.Date;
    echo import org.springframework.format.annotation.DateTimeFormat;
    echo import io.swagger.v3.oas.annotations.media.Schema;
    echo import lombok.Data;
    echo.
    echo @Data
    echo @Schema^(description = "%uCategory% %strDtoClassName%"^)
    echo public class %strDtoClassName% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 10) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strDtoFilePath%"
:: DTO Create File > Move
move "%strDtoFilePath%" "%strDtoFolder%"

:: ############################  DTO IDX ############################
:: DTO Create File >>>> MemberIdxInDto.java
    set "strIdxInDto=IdxInDto"
    set "strJava=.java"
    set "strDtoClassName_Idx=%uCategory%%strIdxInDto%"
    set "strDtoFilePath_Idx=%strDtoClassName_Idx%%strJava%"

    echo "%strDtoFilePath_Idx%"

:: Create the file and write content to it >>>> MemberIdxInDto.java
(
    echo package %strDtoPackageName%;
    echo.
    echo import lombok.Data;
    echo import io.swagger.v3.oas.annotations.media.Schema;
    echo.
    echo @Data
    echo @Schema^(description = "%uCategory% %strDtoClassName_Idx%"^)
    echo public class %strDtoClassName_Idx% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 0) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strDtoFilePath_Idx%"

:: DTO Create File > Move
move "%strDtoFilePath_Idx%" "%strDtoFolder%"

:: ############################  DTO DEL ############################
:: DTO Create File >>>> MemberDelInDto.java
    set "strDelInDto=DelInDto"
    set "strJava=.java"
    set "strDtoClassName_Del=%uCategory%%strDelInDto%"
    set "strDtoFilePath_Del=%strDtoClassName_Del%%strJava%"

    echo "%strDtoFilePath_Del%"

:: Create the file and write content to it >>>> MemberDelInDto.java
(
    echo package %strDtoPackageName%;
    echo.
    echo import lombok.Data;
    echo import io.swagger.v3.oas.annotations.media.Schema;
    echo.
    echo @Data
    echo @Schema^(description = "%uCategory% %strDtoClassName_Del%"^)
    echo public class %strDtoClassName_Del% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 0) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strDtoFilePath_Del%"

:: DTO Create File > Move
move "%strDtoFilePath_Del%" "%strDtoFolder%"

:: ############################  DTO Upd ############################
:: DTO Create File >>>> MemberUpdInDto.java
    set "strUpdInDto=UpdInDto"
    set "strJava=.java"
    set "strDtoClassName_Upd=%uCategory%%strUpdInDto%"
    set "strDtoFilePath_Upd=%strDtoClassName_Upd%%strJava%"

    echo "%strDtoFilePath_Upd%"

:: Create the file and write content to it >>>> MemberUpdInDto.java
(
    echo package %strDtoPackageName%;
    echo.
    echo import java.util.Date;
    echo import org.springframework.format.annotation.DateTimeFormat;
    echo import com.fasterxml.jackson.annotation.JsonFormat;
    echo import lombok.Data;
    echo import io.swagger.v3.oas.annotations.media.Schema;
    echo.
    echo @Data
    echo @Schema^(description = "%uCategory% %strDtoClassName_Upd%"^)
    echo public class %strDtoClassName_Upd% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 10) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strDtoFilePath_Upd%"

:: DTO Create File > Move
move "%strDtoFilePath_Upd%" "%strDtoFolder%"

:: ############################  DTO Ins ############################
:: DTO Create File >>>> MemberInsInDto.java
    set "strInsInDto=InsInDto"
    set "strJava=.java"
    set "strDtoClassName_Ins=%uCategory%%strInsInDto%"
    set "strDtoFilePath_Ins=%strDtoClassName_Ins%%strJava%"

    echo "%strDtoFilePath_Ins%"

:: Create the file and write content to it >>>> MemberInsInDto.java
(
    echo package %strDtoPackageName%;
    echo.
    echo import java.util.Date;
    echo import org.springframework.format.annotation.DateTimeFormat;
    echo import com.fasterxml.jackson.annotation.JsonFormat;
    echo import lombok.Data;
    echo import io.swagger.v3.oas.annotations.media.Schema;
    echo.
    echo @Data
    echo @Schema^(description = "%uCategory% %strDtoClassName_Ins%"^)
    echo public class %strDtoClassName_Ins% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 10) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strDtoFilePath_Ins%"

:: DTO Create File > Move
move "%strDtoFilePath_Ins%" "%strDtoFolder%"

:: ############################  Mapper ############################
:: Mapper Create File
    set "strInDtoMapper=InDtoMapper"
    set "strJava=.java"
    set "strXML=.xml"
    set "strMapperClassName=%uCategory%%strInDtoMapper%"
    set "strMapperPackageName= %defaultPackage%.%targetPackage%.mapper";

    set "strMapperJavaFilePath=%uCategory%%strInDtoMapper%%strJava%"
    set "strMapperXMLFilePath=%uCategory%%strInDtoMapper%%strXML%"

    echo "%strMapperJavaFilePath%"
    echo "%strMapperXMLFilePath%"

:: Create the file and write content to it >>>> MemberInDtoMapper.java
(
    echo package %strMapperPackageName%;
    echo.
    echo import org.mapstruct.Mapper;
    echo import %strDomainPackageName%.%strDomainClassName%;
    echo import %strDtoPackageName%.%strDtoClassName%;
    echo.
    echo @Mapper^(componentModel="spring"^)
    echo public interface %strMapperClassName% extends EntityMapper^<%strDtoClassName%, %strDomainClassName%^>{}
) > "%strMapperJavaFilePath%"

:: Mapper Create File > Move
move "%strMapperJavaFilePath%" "%strMapperFolder%"

:: ############################  Mapper IDX ############################
:: Mapper Create File >>> idx mapper
    set "strIdxInDtoMapper=IdxInDtoMapper"
    set "strJava=.java"
    set "strXML=.xml"
    set "strMapperClassName_Idx=%uCategory%%strIdxInDtoMapper%"
    set "strMapperPackageName= %defaultPackage%.%targetPackage%.mapper";

    set "strMapperJavaFilePath_Idx=%uCategory%%strIdxInDtoMapper%%strJava%"
    set "strMapperXMLFilePath_Idx=%uCategory%%strIdxInDtoMapper%%strXML%"

    echo "%strMapperJavaFilePath_Idx%"
    echo "%strMapperXMLFilePath_Idx%"

:: Create the file and write content to it >>>> MemberIdxInDtoMapper.java
(
    echo package %strMapperPackageName%;
    echo.
    echo import org.mapstruct.Mapper;
    echo import %strDomainPackageName%.%strDomainClassName_Idx%;
    echo import %strDtoPackageName%.%strDtoClassName_Idx%;
    echo.
    echo @Mapper^(componentModel="spring"^)
    echo public interface %strMapperClassName_Idx% extends EntityMapper^<%strDtoClassName_Idx%, %strDomainClassName_Idx%^>{}
) > "%strMapperJavaFilePath_Idx%"

:: Mapper Create File > Move
move "%strMapperJavaFilePath_Idx%" "%strMapperFolder%"

:: ############################  Mapper Del ############################
:: Mapper Create File >>> idx mapper
    set "strDelInDtoMapper=DelInDtoMapper"
    set "strJava=.java"
    set "strXML=.xml"
    set "strMapperClassName_Del=%uCategory%%strDelInDtoMapper%"
    set "strMapperPackageName= %defaultPackage%.%targetPackage%.mapper";

    set "strMapperJavaFilePath_Del=%uCategory%%strDelInDtoMapper%%strJava%"
    set "strMapperXMLFilePath_Del=%uCategory%%strDelInDtoMapper%%strXML%"

    echo "%strMapperJavaFilePath_Del%"
    echo "%strMapperXMLFilePath_Del%"

:: Create the file and write content to it >>>> MemberDelInDtoMapper.java
(
    echo package %strMapperPackageName%;
    echo.
    echo import org.mapstruct.Mapper;
    echo import %strDomainPackageName%.%strDomainClassName_Del%;
    echo import %strDtoPackageName%.%strDtoClassName_Del%;
    echo.
    echo @Mapper^(componentModel="spring"^)
    echo public interface %strMapperClassName_Del% extends EntityMapper^<%strDtoClassName_Del%, %strDomainClassName_Del%^>{}
) > "%strMapperJavaFilePath_Del%"

:: Mapper Create File > Move
move "%strMapperJavaFilePath_Del%" "%strMapperFolder%"

:: ############################  Mapper Upd ############################
:: Mapper Create File >>> idx mapper
    set "strUpdInDtoMapper=UpdInDtoMapper"
    set "strJava=.java"
    set "strXML=.xml"
    set "strMapperClassName_Upd=%uCategory%%strUpdInDtoMapper%"
    set "strMapperPackageName= %defaultPackage%.%targetPackage%.mapper";

    set "strMapperJavaFilePath_Upd=%uCategory%%strUpdInDtoMapper%%strJava%"
    set "strMapperXMLFilePath_Upd=%uCategory%%strUpdInDtoMapper%%strXML%"

    echo "%strMapperJavaFilePath_Upd%"
    echo "%strMapperXMLFilePath_Upd%"

:: Create the file and write content to it >>>> MemberUpdInDtoMapper.java
(
    echo package %strMapperPackageName%;
    echo.
    echo import org.mapstruct.Mapper;
    echo import %strDomainPackageName%.%strDomainClassName_Upd%;
    echo import %strDtoPackageName%.%strDtoClassName_Upd%;
    echo.
    echo @Mapper^(componentModel="spring"^)
    echo public interface %strMapperClassName_Upd% extends EntityMapper^<%strDtoClassName_Upd%, %strDomainClassName_Upd%^>{}
) > "%strMapperJavaFilePath_Upd%"

:: Mapper Create File > Move
move "%strMapperJavaFilePath_Upd%" "%strMapperFolder%"

:: ############################  Mapper Ins ############################
:: Mapper Create File >>> idx mapper
    set "strInsInDtoMapper=InsInDtoMapper"
    set "strJava=.java"
    set "strXML=.xml"
    set "strMapperClassName_Ins=%uCategory%%strInsInDtoMapper%"
    set "strMapperPackageName= %defaultPackage%.%targetPackage%.mapper";

    set "strMapperJavaFilePath_Ins=%uCategory%%strInsInDtoMapper%%strJava%"
    set "strMapperXMLFilePath_Ins=%uCategory%%strInsInDtoMapper%%strXML%"

    echo "%strMapperJavaFilePath_Ins%"
    echo "%strMapperXMLFilePath_Ins%"

:: Create the file and write content to it >>>> MemberInsInDtoMapper.java
(
    echo package %strMapperPackageName%;
    echo.
    echo import org.mapstruct.Mapper;
    echo import %strDomainPackageName%.%strDomainClassName_Ins%;
    echo import %strDtoPackageName%.%strDtoClassName_Ins%;
    echo.
    echo @Mapper^(componentModel="spring"^)
    echo public interface %strMapperClassName_Ins% extends EntityMapper^<%strDtoClassName_Ins%, %strDomainClassName_Ins%^>{}
) > "%strMapperJavaFilePath_Ins%"

:: Mapper Create File > Move
move "%strMapperJavaFilePath_Ins%" "%strMapperFolder%"

:: ############################  Repository ############################
:: Repository Create File >>>> MemberRepository.java
    set "strRepository=Repository"
    set "strJava=.java"
    set "strRepositoryClassName=%uCategory%%strRepository%"
    set "strRepositoryMemberName=%category%%strRepository%"
    set "strRepositoryPackageName=%defaultPackage%.%targetPackage%.repository";

    set "strRepositoryFilePath=%uCategory%%strRepository%%strJava%"

    echo "%strRepositoryFilePath%"

:: Create the file and write content to it >>>> MemberRepository.java
(
    echo package %strRepositoryPackageName%;
    echo.
    echo import java.util.List;
    echo import org.apache.ibatis.annotations.Mapper;
    echo import org.springframework.stereotype.Repository;
    echo import %strDtoPackageName%.%strDtoClassName%;
    echo import %strDtoPackageName%.%strDtoClassName_Idx%;
    echo import %strDtoPackageName%.%strDtoClassName_Del%;
    echo import %strDtoPackageName%.%strDtoClassName_Upd%;
    echo import %strDtoPackageName%.%strDtoClassName_Ins%;
    echo.
    echo @Mapper 
    echo @Repository
    echo public interface  %strRepositoryClassName% {
    echo     public List^<%strDtoClassName%^> selectAll%uCategory%^(%strDtoClassName% inDto^);
    echo     public %strDtoClassName_Idx%  get%uCategory%^(%strDtoClassName_Idx% inDto^);
    echo     public %strDtoClassName_Del%  del%uCategory%^(%strDtoClassName_Del% inDto^);
    echo     public %strDtoClassName_Upd%  upd%uCategory%^(%strDtoClassName_Upd% inDto^);
    echo     public %strDtoClassName_Ins%  ins%uCategory%^(%strDtoClassName_Ins% inDto^);
    echo }
) > "%strRepositoryFilePath%"

:: Repository Create File > Move
move "%strRepositoryFilePath%" "%strRepositoryFolder%"

:: ############################  Service ############################
:: Service Create File	>> MemberService.java
    set "strService=Service"
    set "strJava=.java"
    set "strServiceClassName=%uCategory%%strService%"
    set "strServiceMemberName=%category%%strService%"
    set "strServicePackageName=%defaultPackage%.%targetPackage%.service";
    set "strServiceFilePath=%strServiceClassName%%strJava%"

    echo "%strServiceFilePath%"

:: Create the file and write content to it >>>> MemberService.java
(
    echo package %strServicePackageName%;
    echo.
    echo import java.util.List;
    echo import org.slf4j.Logger;
    echo import org.slf4j.LoggerFactory;
    echo import org.springframework.beans.factory.annotation.Autowired;
    echo import jakarta.transaction.Transactional;
    echo import org.springframework.stereotype.Service;
    echo import %strDtoPackageName%.%strDtoClassName%;
    echo import %strDtoPackageName%.%strDtoClassName_Idx%;
    echo import %strDtoPackageName%.%strDtoClassName_Del%;
    echo import %strDtoPackageName%.%strDtoClassName_Upd%;
    echo import %strDtoPackageName%.%strDtoClassName_Ins%;
    echo import %strRepositoryPackageName%.%strRepositoryClassName%;
    echo.
    echo @Service
    echo @Transactional
    echo public class  %strServiceClassName% {
    echo.
    echo    private final Logger log = LoggerFactory.getLogger^(%strServiceClassName%.class^);
    echo.
    echo    @Autowired %strRepositoryClassName% %strRepositoryMemberName%;
    echo.
    echo     public List^<%strDtoClassName%^> selectAll%uCategory%^(^){
    echo         %strDtoClassName% inDto = new %strDtoClassName%^(^);
    echo         List^<%strDtoClassName%^> list = null;
    echo         list = %strRepositoryMemberName%.selectAll%uCategory%^(inDto^);
    echo         return list;
    echo    }
    echo.
    echo     public %strDtoClassName_Idx% get%uCategory%^(%strDtoClassName_Idx% inDto^){
    echo         %strDtoClassName_Idx% %category% = null;
    echo         %category% = %strRepositoryMemberName%.get%uCategory%^(inDto^);
    echo         return %category%;
    echo    }
    echo.
    echo     public %strDtoClassName_Del% del%uCategory%^(%strDtoClassName_Del% inDto^){
    echo         %strDtoClassName_Del% %category% = null;
    echo         %category% = %strRepositoryMemberName%.del%uCategory%^(inDto^);
    echo         return %category%;
    echo    }
    echo.
    echo     public %strDtoClassName_Upd% upd%uCategory%^(%strDtoClassName_Upd% inDto^){
    echo         %strDtoClassName_Upd% %category% = null;
    echo         %category% = %strRepositoryMemberName%.upd%uCategory%^(inDto^);
    echo         return %category%;
    echo    }
    echo.
    echo     public %strDtoClassName_Ins% ins%uCategory%^(%strDtoClassName_Ins% inDto^){
    echo         %strDtoClassName_Ins% %category% = null;
    echo         %category% = %strRepositoryMemberName%.ins%uCategory%^(inDto^);
    echo         return %category%;
    echo    }
    echo }
) > "%strServiceFilePath%"

:: Service Create File > Move
move "%strServiceFilePath%" "%strServiceFolder%"

:: ############################  Controller ############################
:: Controller Create File	>> MemberController.java
    set "strController=Controller"
    set "strJava=.java"
    set "strControllerClassName=%uCategory%%strController%"
    set "strControllerMemberName=%category%%strController%"
    set "strControllerPackageName=%defaultPackage%.%targetPackage%.controller";
    set "strControllerFilePath=%strControllerClassName%%strJava%"

    echo "%strControllerFilePath%"

:: Create the file and write content to it >>>> MemberController.java
(
    echo package %strControllerPackageName%;
    echo.

    echo import java.util.List;
    echo import org.slf4j.Logger;
    echo import org.slf4j.LoggerFactory;
    echo import org.springframework.beans.factory.annotation.Autowired;

    echo import org.springframework.http.HttpStatus;
    echo import org.springframework.http.ResponseEntity;
    echo import org.springframework.web.bind.annotation.GetMapping;
    echo import org.springframework.web.bind.annotation.PostMapping;
    echo import org.springframework.web.bind.annotation.RequestMapping;
    echo import org.springframework.web.bind.annotation.RestController;

    echo import io.swagger.v3.oas.annotations.tags.Tag;
    echo import lombok.extern.slf4j.Slf4j;

    echo import %strDtoPackageName%.%strDtoClassName%;
    echo import %strDtoPackageName%.%strDtoClassName_Idx%;
    echo import %strDtoPackageName%.%strDtoClassName_Del%;
    echo import %strDtoPackageName%.%strDtoClassName_Upd%;
    echo import %strDtoPackageName%.%strDtoClassName_Ins%;
    echo import %strServicePackageName%.%strServiceClassName%;
    echo.
    echo @Slf4j
    echo @RestController
    echo @RequestMapping^("/api"^)
    echo public class %strControllerClassName% {
    echo.
    echo    private static final Logger log = LoggerFactory.getLogger^(%strControllerClassName%.class^);
    echo.
    echo    @Autowired
    echo    private %strServiceClassName% %strServiceMemberName%;
    echo.
    echo    @Tag^(name = "GOMS API > %uCategory%", description = "GOMS API %uCategory%입니다. 전체 조회입니다."^)
    echo    @GetMapping^("/%category%/selectAll%uCategory%"^)
    echo    public ResponseEntity^<List^<%strDtoClassName%^>^> selectAll%uCategory%^(^) {
    echo         List^<%strDtoClassName%^> list = %strServiceMemberName%.selectAll%uCategory%^(^);
    echo         return new ResponseEntity^<^>^(list, HttpStatus.OK^);
    echo    }
    echo.
    echo    @Tag^(name = "GOMS API > %uCategory%", description = "GOMS API %uCategory%입니다. 개별 조회입니다."^)
    echo    @PostMapping^("/%category%/get%uCategory%"^)
    echo    public ResponseEntity^<%strDtoClassName_Idx%^> get%uCategory%^(%strDtoClassName_Idx% inDto^) {
    echo         %strDtoClassName_Idx%  %category% = %strServiceMemberName%.get%uCategory%^(inDto^);
    echo         return new ResponseEntity^<^>^(%category%, HttpStatus.OK^);
    echo    }
    echo.
    echo    @Tag^(name = "GOMS API > %uCategory%", description = "GOMS API %uCategory%입니다. 개별 삭제입니다."^)
    echo    @PostMapping^("/%category%/del%uCategory%"^)
    echo    public ResponseEntity^<%strDtoClassName_Del%^> del%uCategory%^(%strDtoClassName_Del% inDto^) {
    echo         %strDtoClassName_Del%  %category% = %strServiceMemberName%.del%uCategory%^(inDto^);
    echo         return new ResponseEntity^<^>^(%category%, HttpStatus.OK^);
    echo    }
    echo.
    echo    @Tag^(name = "GOMS API > %uCategory%", description = "GOMS API %uCategory%입니다. 개별 업데이트입니다."^)
    echo    @PostMapping^("/%category%/upd%uCategory%"^)
    echo    public ResponseEntity^<%strDtoClassName_Upd%^> upd%uCategory%^(%strDtoClassName_Upd% inDto^) {
    echo         %strDtoClassName_Upd%  %category% = %strServiceMemberName%.upd%uCategory%^(inDto^);
    echo         return new ResponseEntity^<^>^(%category%, HttpStatus.OK^);
    echo    }
    echo.
    echo    @Tag^(name = "GOMS API > %uCategory%", description = "GOMS API %uCategory%입니다. 저장입니다."^)
    echo    @PostMapping^("/%category%/ins%uCategory%"^)
    echo    public ResponseEntity^<%strDtoClassName_Ins%^> ins%uCategory%^(%strDtoClassName_Ins% inDto^) {
    echo         %strDtoClassName_Ins%  %category% = %strServiceMemberName%.ins%uCategory%^(inDto^);
    echo         return new ResponseEntity^<^>^(%category%, HttpStatus.OK^);
    echo    }
    echo }
) > "%strControllerFilePath%"

:: Controller Create File > Move
move "%strControllerFilePath%" "%strControllerFolder%"

:: ############################  Mapper XML ############################
:: Create the file and write content to it >>>> MemberInDtoMapper.xml
(
    echo ^<?xml version="1.0" encoding="UTF-8"?^>
    echo ^<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd"^>
    echo ^<mapper namespace="%strRepositoryPackageName%.%strRepositoryClassName%"^>
    echo     ^<select id="selectAll%uCategory%" parameterType="%strDtoPackageName%.%strDtoClassName%" resultType="%strDomainPackageName%.%strDomainClassName%"^>
    echo         %query%
    echo    ^</select^>
    echo ^</mapper^>
) > "%strMapperXMLFilePath%"

:: Mapper Create File > Move
move "%strMapperXMLFilePath%" "%strMapperFolder%"

:: ############################  Mapper IDX XML ############################
:: Create the file and write content to it >>>> MemberIdxInDtoMapper.xml
(
    echo ^<?xml version="1.0" encoding="UTF-8"?^>
    echo ^<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd"^>
    echo ^<mapper namespace="%strRepositoryPackageName%.%strRepositoryClassName%"^>
    echo     ^<select id="get%uCategory%" parameterType="%strDtoPackageName%.%strDtoClassName_Idx%" resultType="%strDomainPackageName%.%strDomainClassName_Idx%"^>
    echo         %query_one%
    echo    ^</select^>
    echo ^</mapper^>
) > "%strMapperXMLFilePath_Idx%"

:: Mapper Create File > Move
move "%strMapperXMLFilePath_Idx%" "%strMapperFolder%"

:: ############################  Mapper Del XML ############################
:: Create the file and write content to it >>>> MemberDelInDtoMapper.xml >>> delete는 resultType있으면 에러발생함.
(
    echo ^<?xml version="1.0" encoding="UTF-8"?^>
    echo ^<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd"^>
    echo ^<mapper namespace="%strRepositoryPackageName%.%strRepositoryClassName%"^>
    echo     ^<delete id="del%uCategory%" parameterType="%strDtoPackageName%.%strDtoClassName_Del%" ^>
    echo         %query_del%
    echo    ^</delete^>
    echo ^</mapper^>
) > "%strMapperXMLFilePath_Del%"

:: Mapper Create File > Move
move "%strMapperXMLFilePath_Del%" "%strMapperFolder%"

:: ############################  Mapper Upd XML ############################
:: Create the file and write content to it >>>> MemberUpdInDtoMapper.xml
(
    echo ^<?xml version="1.0" encoding="UTF-8"?^>
    echo ^<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd"^>
    echo ^<mapper namespace="%strRepositoryPackageName%.%strRepositoryClassName%"^>
    echo     ^<update id="upd%uCategory%" parameterType="%strDtoPackageName%.%strDtoClassName_Upd%"^>
    echo         %query_upd%
    echo    ^</update^>
    echo ^</mapper^>
) > "%strMapperXMLFilePath_Upd%"

:: Mapper Create File > Move
move "%strMapperXMLFilePath_Upd%" "%strMapperFolder%"

:: ############################  Mapper Ins XML ############################
:: Create the file and write content to it >>>> MemberInsInDtoMapper.xml
(
    echo ^<?xml version="1.0" encoding="UTF-8"?^>
    echo ^<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd"^>
    echo ^<mapper namespace="%strRepositoryPackageName%.%strRepositoryClassName%"^>
    echo     ^<insert id="ins%uCategory%" parameterType="%strDtoPackageName%.%strDtoClassName_Ins%"^>
    echo         %query_ins%
    echo    ^</insert^>
    echo ^</mapper^>
) > "%strMapperXMLFilePath_Ins%"

:: Mapper Create File > Move
move "%strMapperXMLFilePath_Ins%" "%strMapperFolder%"

endlocal
pause