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

set "strJava=.java"
set "strXML=.xml"

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

:: ############################  Domain In / Out ############################
:: Domain Create File	>> MemberIn.java, MemberOut.java
    set "strIn=In"
    set "strOut=Out"
    set "strDomainInClassName=%uCategory%%strIn%"
    set "strDomainOutClassName=%uCategory%%strOut%"

    set "strDomainPackageName=%defaultPackage%.%targetPackage%.domain";
    set "strDomainInFilePath=%strDomainInClassName%%strJava%"
    set "strDomainOutFilePath=%strDomainOutClassName%%strJava%"

    echo "%strDomainInFilePath%"
    echo "%strDomainOutFilePath%"

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
    echo public class %strDomainInClassName% {

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
) > "%strDomainInFilePath%"

:: Create the file and write content to it >>>> MemberOut.java
(
    echo package %strDomainPackageName%;
    echo.
    echo import java.util.Date;
    echo import org.springframework.format.annotation.DateTimeFormat;
    echo import com.fasterxml.jackson.annotation.JsonFormat;
    echo import lombok.Data;
    echo.
    echo @Data
    echo public class %strDomainOutClassName% {

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
) > "%strDomainOutFilePath%"

:: Domain Create File > Move
move "%strDomainInFilePath%" "%strDomainFolder%"
move "%strDomainOutFilePath%" "%strDomainFolder%"

:: ############################  Domain IDX ############################
:: Domain Create File	>> MemberIdxIn.java, MemberIdxOut.java
    set "strIdxIn=IdxIn"
    set "strIdxOut=IdxOut"
    set "strDomainInClassName_Idx=%uCategory%%strIdxIn%"
    set "strDomainInFilePath_Idx=%strDomainInClassName_Idx%%strJava%"
    set "strDomainOutClassName_Idx=%uCategory%%strIdxOut%"
    set "strDomainOutFilePath_Idx=%strDomainOutClassName_Idx%%strJava%"

    echo "%strDomainInFilePath_Idx%"
    echo "%strDomainOutFilePath_Idx%"

:: Create the file and write content to it >>>> MemberIdxIn.java
(
    echo package %strDomainPackageName%;
    echo.
    echo import lombok.Data;
    echo.
    echo @Data
    echo public class %strDomainInClassName_Idx% {

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
) > "%strDomainInFilePath_Idx%"

:: Create the file and write content to it >>>> MemberIdxOut.java
(
    echo package %strDomainPackageName%;
    echo.
    echo import java.util.Date;
    echo import org.springframework.format.annotation.DateTimeFormat;
    echo import com.fasterxml.jackson.annotation.JsonFormat;
    echo import lombok.Data;
    echo.
    echo @Data
    echo public class %strDomainOutClassName_Idx% {

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
) > "%strDomainOutFilePath_Idx%"

:: Domain Create File > Move
move "%strDomainInFilePath_Idx%" "%strDomainFolder%"
move "%strDomainOutFilePath_Idx%" "%strDomainFolder%"

:: ############################  Domain Del ############################
:: Domain Create File	>> MemberDelIn.java
    set "strDelIn=DelIn"
    set "strDomainInClassName_Del=%uCategory%%strDelIn%"
    set "strDomainInFilePath_Del=%strDomainInClassName_Del%%strJava%"

    echo "%strDomainInFilePath_Del%"

:: Create the file and write content to it >>>> MemberDelIn.java
(
    echo package %strDomainPackageName%;
    echo.
    echo import lombok.Data;
    echo.
    echo @Data
    echo public class %strDomainInClassName_Del% {

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
) > "%strDomainInFilePath_Del%"

:: Domain Create File > Move
move "%strDomainInFilePath_Del%" "%strDomainFolder%"

:: ############################  Domain Upd ############################
:: Domain Create File	>> MemberUpdIn.java
    set "strUpdIn=UpdIn"
    set "strDomainInClassName_Upd=%uCategory%%strUpdIn%"
    set "strDomainInFilePath_Upd=%strDomainInClassName_Upd%%strJava%"

    echo "%strDomainInFilePath_Upd%"

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
    echo public class %strDomainInClassName_Upd% {

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
) > "%strDomainInFilePath_Upd%"

:: Domain Create File > Move
move "%strDomainInFilePath_Upd%" "%strDomainFolder%"

:: ############################  Domain Ins ############################
:: Domain Create File	>> MemberInsIn.java
    set "strInsIn=InsIn"
    set "strDomainInClassName_Ins=%uCategory%%strInsIn%"
    set "strDomainInFilePath_Ins=%strDomainInClassName_Ins%%strJava%"

    echo "%strDomainInFilePath_Ins%"

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
    echo public class %strDomainInClassName_Ins% {

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
) > "%strDomainInFilePath_Ins%"

:: Domain Create File > Move
move "%strDomainInFilePath_Ins%" "%strDomainFolder%"

:: ############################  DTO ############################
:: DTO Create File		>> MemberInDto.java, MemberOutDto.java
    set "strInDto=InDto"
    set "strOutDto=OutDto"
    set "strInDtoClassName=%uCategory%%strInDto%"
    set "strOutDtoClassName=%uCategory%%strOutDto%"
    set "strDtoPackageName=%defaultPackage%.%targetPackage%.service.dto";
    set "strInDtoFilePath=%strInDtoClassName%%strJava%"
    set "strOutDtoFilePath=%strOutDtoClassName%%strJava%"

    echo "%strInDtoFilePath%"
    echo "%strOutDtoFilePath%"

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
    echo @Schema^(description = "%uCategory% %strInDtoClassName%"^)
    echo public class %strInDtoClassName% {

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
) > "%strInDtoFilePath%"

:: Create the file and write content to it >>>> MemberOutDto.java
(
    echo package %strDtoPackageName%;
    echo.
    echo import java.util.Date;
    echo import org.springframework.format.annotation.DateTimeFormat;
    echo import io.swagger.v3.oas.annotations.media.Schema;
    echo import lombok.Data;
    echo.
    echo @Data
    echo @Schema^(description = "%uCategory% %strOutDtoClassName%"^)
    echo public class %strOutDtoClassName% {

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
) > "%strOutDtoFilePath%"

:: DTO Create File > Move
move "%strInDtoFilePath%" "%strDtoFolder%"
move "%strOutDtoFilePath%" "%strDtoFolder%"

:: ############################  DTO IDX ############################
:: DTO Create File >>>> MemberIdxInDto.java
    set "strIdxInDto=IdxInDto"
    set "strIdxOutDto=IdxOutDto"

    set "strInDtoClassName_Idx=%uCategory%%strIdxInDto%"
    set "strOutDtoClassName_Idx=%uCategory%%strIdxOutDto%"
    set "strInDtoFilePath_Idx=%strInDtoClassName_Idx%%strJava%"
    set "strOutDtoFilePath_Idx=%strOutDtoClassName_Idx%%strJava%"

    echo "%strInDtoFilePath_Idx%"
    echo "%strOutDtoFilePath_Idx%"

:: Create the file and write content to it >>>> MemberIdxInDto.java
(
    echo package %strDtoPackageName%;
    echo.
    echo import lombok.Data;
    echo import io.swagger.v3.oas.annotations.media.Schema;
    echo.
    echo @Data
    echo @Schema^(description = "%uCategory% %strInDtoClassName_Idx%"^)
    echo public class %strInDtoClassName_Idx% {

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
) > "%strInDtoFilePath_Idx%"

:: Create the file and write content to it >>>> MemberIdxOutDto.java
(
    echo package %strDtoPackageName%;
    echo.
    echo import java.util.Date;
    echo import org.springframework.format.annotation.DateTimeFormat;
    echo import lombok.Data;
    echo import io.swagger.v3.oas.annotations.media.Schema;
    echo.
    echo @Data
    echo @Schema^(description = "%uCategory% %strOutDtoClassName_Idx%"^)
    echo public class %strOutDtoClassName_Idx% {

    setlocal enabledelayedexpansion
    for /l %%i in (0, 1, 20) do (
        set alias=!entity_colume_%%i_alias!
        set type=!entity_colume_%%i_type!
        if defined alias (
            echo     private !type! !alias!;
        )
    )
    endlocal

    echo }
) > "%strOutDtoFilePath_Idx%"

:: DTO Create File > Move
move "%strInDtoFilePath_Idx%" "%strDtoFolder%"
move "%strOutDtoFilePath_Idx%" "%strDtoFolder%"

:: ############################  DTO DEL ############################
:: DTO Create File >>>> MemberDelInDto.java
    set "strDelInDto=DelInDto"
    set "strInDtoClassName_Del=%uCategory%%strDelInDto%"
    set "strInDtoFilePath_Del=%strInDtoClassName_Del%%strJava%"

    echo "%strInDtoFilePath_Del%"

:: Create the file and write content to it >>>> MemberDelInDto.java
(
    echo package %strDtoPackageName%;
    echo.
    echo import lombok.Data;
    echo import io.swagger.v3.oas.annotations.media.Schema;
    echo.
    echo @Data
    echo @Schema^(description = "%uCategory% %strInDtoClassName_Del%"^)
    echo public class %strInDtoClassName_Del% {

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
) > "%strInDtoFilePath_Del%"

:: DTO Create File > Move
move "%strInDtoFilePath_Del%" "%strDtoFolder%"

:: ############################  DTO Upd ############################
:: DTO Create File >>>> MemberUpdInDto.java
    set "strUpdInDto=UpdInDto"
    set "strInDtoClassName_Upd=%uCategory%%strUpdInDto%"
    set "strInDtoFilePath_Upd=%strInDtoClassName_Upd%%strJava%"

    echo "%strInDtoFilePath_Upd%"

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
    echo @Schema^(description = "%uCategory% %strInDtoClassName_Upd%"^)
    echo public class %strInDtoClassName_Upd% {

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
) > "%strInDtoFilePath_Upd%"

:: DTO Create File > Move
move "%strInDtoFilePath_Upd%" "%strDtoFolder%"

:: ############################  DTO Ins ############################
:: DTO Create File >>>> MemberInsInDto.java
    set "strInsInDto=InsInDto"
    set "strInDtoClassName_Ins=%uCategory%%strInsInDto%"
    set "strInDtoFilePath_Ins=%strInDtoClassName_Ins%%strJava%"

    echo "%strInDtoFilePath_Ins%"

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
    echo @Schema^(description = "%uCategory% %strInDtoClassName_Ins%"^)
    echo public class %strInDtoClassName_Ins% {

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
) > "%strInDtoFilePath_Ins%"

:: DTO Create File > Move
move "%strInDtoFilePath_Ins%" "%strDtoFolder%"

:: ############################  Mapper ############################
:: Mapper Create File
    set "strDtoMapper=DtoMapper"
    set "strMapperClassName=%uCategory%%strDtoMapper%"
    set "strMapperPackageName= %defaultPackage%.%targetPackage%.mapper";

    set "strMapperJavaFilePath=%uCategory%%strDtoMapper%%strJava%"
    set "strMapperXMLFilePath=%uCategory%%strDtoMapper%%strXML%"

    echo "%strMapperJavaFilePath%"
    echo "%strMapperXMLFilePath%"

:: Create the file and write content to it >>>> MemberDtoMapper.java
(
    echo package %strMapperPackageName%;
    echo.
    echo import org.mapstruct.Mapper;
    echo import %strDomainPackageName%.%strDomainInClassName%;
    echo import %strDtoPackageName%.%strInDtoClassName%;
    echo.
    echo @Mapper^(componentModel="spring"^)
    echo public interface %strMapperClassName% extends EntityMapper^<%strInDtoClassName%, %strDomainInClassName%^>{}
) > "%strMapperJavaFilePath%"

:: Mapper Create File > Move
move "%strMapperJavaFilePath%" "%strMapperFolder%"

:: ############################  Mapper IDX ############################
:: Mapper Create File >>> idx mapper
    set "strIdxDtoMapper=IdxDtoMapper"

    set "strMapperClassName_Idx=%uCategory%%strIdxDtoMapper%"
    set "strMapperPackageName= %defaultPackage%.%targetPackage%.mapper";

    set "strMapperJavaFilePath_Idx=%uCategory%%strIdxDtoMapper%%strJava%"
    set "strMapperXMLFilePath_Idx=%uCategory%%strIdxDtoMapper%%strXML%"

    echo "%strMapperJavaFilePath_Idx%"
    echo "%strMapperXMLFilePath_Idx%"

:: Create the file and write content to it >>>> MemberIdxInDtoMapper.java
(
    echo package %strMapperPackageName%;
    echo.
    echo import org.mapstruct.Mapper;
    echo import %strDomainPackageName%.%strDomainInClassName_Idx%;
    echo import %strDtoPackageName%.%strInDtoClassName_Idx%;
    echo.
    echo @Mapper^(componentModel="spring"^)
    echo public interface %strMapperClassName_Idx% extends EntityMapper^<%strInDtoClassName_Idx%, %strDomainInClassName_Idx%^>{}
) > "%strMapperJavaFilePath_Idx%"

:: Mapper Create File > Move
move "%strMapperJavaFilePath_Idx%" "%strMapperFolder%"

:: ############################  Mapper Del ############################
:: Mapper Create File >>> idx mapper
    set "strDelDtoMapper=DelDtoMapper"

    set "strMapperClassName_Del=%uCategory%%strDelDtoMapper%"
    set "strMapperPackageName= %defaultPackage%.%targetPackage%.mapper";

    set "strMapperJavaFilePath_Del=%uCategory%%strDelDtoMapper%%strJava%"
    set "strMapperXMLFilePath_Del=%uCategory%%strDelDtoMapper%%strXML%"

    echo "%strMapperJavaFilePath_Del%"
    echo "%strMapperXMLFilePath_Del%"

:: Create the file and write content to it >>>> MemberDelInDtoMapper.java
(
    echo package %strMapperPackageName%;
    echo.
    echo import org.mapstruct.Mapper;
    echo import %strDomainPackageName%.%strDomainInClassName_Del%;
    echo import %strDtoPackageName%.%strInDtoClassName_Del%;
    echo.
    echo @Mapper^(componentModel="spring"^)
    echo public interface %strMapperClassName_Del% extends EntityMapper^<%strInDtoClassName_Del%, %strDomainInClassName_Del%^>{}
) > "%strMapperJavaFilePath_Del%"

:: Mapper Create File > Move
move "%strMapperJavaFilePath_Del%" "%strMapperFolder%"

:: ############################  Mapper Upd ############################
:: Mapper Create File >>> idx mapper
    set "strUpdDtoMapper=UpdDtoMapper"

    set "strMapperClassName_Upd=%uCategory%%strUpdDtoMapper%"
    set "strMapperPackageName= %defaultPackage%.%targetPackage%.mapper";

    set "strMapperJavaFilePath_Upd=%uCategory%%strUpdDtoMapper%%strJava%"
    set "strMapperXMLFilePath_Upd=%uCategory%%strUpdDtoMapper%%strXML%"

    echo "%strMapperJavaFilePath_Upd%"
    echo "%strMapperXMLFilePath_Upd%"

:: Create the file and write content to it >>>> MemberUpdInDtoMapper.java
(
    echo package %strMapperPackageName%;
    echo.
    echo import org.mapstruct.Mapper;
    echo import %strDomainPackageName%.%strDomainInClassName_Upd%;
    echo import %strDtoPackageName%.%strInDtoClassName_Upd%;
    echo.
    echo @Mapper^(componentModel="spring"^)
    echo public interface %strMapperClassName_Upd% extends EntityMapper^<%strInDtoClassName_Upd%, %strDomainInClassName_Upd%^>{}
) > "%strMapperJavaFilePath_Upd%"

:: Mapper Create File > Move
move "%strMapperJavaFilePath_Upd%" "%strMapperFolder%"

:: ############################  Mapper Ins ############################
:: Mapper Create File >>> idx mapper
    set "strInsDtoMapper=InsDtoMapper"

    set "strMapperClassName_Ins=%uCategory%%strInsDtoMapper%"
    set "strMapperPackageName= %defaultPackage%.%targetPackage%.mapper";

    set "strMapperJavaFilePath_Ins=%uCategory%%strInsDtoMapper%%strJava%"
    set "strMapperXMLFilePath_Ins=%uCategory%%strInsDtoMapper%%strXML%"

    echo "%strMapperJavaFilePath_Ins%"
    echo "%strMapperXMLFilePath_Ins%"

:: Create the file and write content to it >>>> MemberInsInDtoMapper.java
(
    echo package %strMapperPackageName%;
    echo.
    echo import org.mapstruct.Mapper;
    echo import %strDomainPackageName%.%strDomainInClassName_Ins%;
    echo import %strDtoPackageName%.%strInDtoClassName_Ins%;
    echo.
    echo @Mapper^(componentModel="spring"^)
    echo public interface %strMapperClassName_Ins% extends EntityMapper^<%strInDtoClassName_Ins%, %strDomainInClassName_Ins%^>{}
) > "%strMapperJavaFilePath_Ins%"

:: Mapper Create File > Move
move "%strMapperJavaFilePath_Ins%" "%strMapperFolder%"

:: ############################  Repository ############################
:: Repository Create File >>>> MemberRepository.java
    set "strRepository=Repository"

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
    echo import %strDtoPackageName%.%strInDtoClassName%;
    echo import %strDtoPackageName%.%strInDtoClassName_Idx%;
    echo import %strDtoPackageName%.%strInDtoClassName_Del%;
    echo import %strDtoPackageName%.%strInDtoClassName_Upd%;
    echo import %strDtoPackageName%.%strInDtoClassName_Ins%;
    echo import %strDtoPackageName%.%strOutDtoClassName%;
    echo import %strDtoPackageName%.%strOutDtoClassName_Idx%;
    echo.
    echo @Mapper 
    echo @Repository
    echo public interface  %strRepositoryClassName% {
    echo     public List^<%strOutDtoClassName%^> selectAll%uCategory%^(%strInDtoClassName% inDto^);
    echo     public %strOutDtoClassName_Idx%  get%uCategory%^(%strInDtoClassName_Idx% inDto^);
    echo     public boolean  del%uCategory%^(%strInDtoClassName_Del% inDto^);
    echo     public boolean  upd%uCategory%^(%strInDtoClassName_Upd% inDto^);
    echo     public boolean  ins%uCategory%^(%strInDtoClassName_Ins% inDto^);
    echo }
) > "%strRepositoryFilePath%"

:: Repository Create File > Move
move "%strRepositoryFilePath%" "%strRepositoryFolder%"

:: ############################  Service ############################
:: Service Create File	>> MemberService.java
    set "strService=Service"

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
    echo import %strDtoPackageName%.%strInDtoClassName%;
    echo import %strDtoPackageName%.%strInDtoClassName_Idx%;
    echo import %strDtoPackageName%.%strInDtoClassName_Del%;
    echo import %strDtoPackageName%.%strInDtoClassName_Upd%;
    echo import %strDtoPackageName%.%strInDtoClassName_Ins%;
    echo import %strDtoPackageName%.%strOutDtoClassName%;
    echo import %strDtoPackageName%.%strOutDtoClassName_Idx%;
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
    echo     public List^<%strOutDtoClassName%^> selectAll%uCategory%^(^){
    echo         %strInDtoClassName% inDto = new %strInDtoClassName%^(^);
    echo         List^<%strOutDtoClassName%^> list = null;
    echo         list = %strRepositoryMemberName%.selectAll%uCategory%^(inDto^);
    echo         return list;
    echo    }
    echo.
    echo     public %strOutDtoClassName_Idx% get%uCategory%^(%strInDtoClassName_Idx% inDto^){
    echo         %strOutDtoClassName_Idx% %category% = null;
    echo         %category% = %strRepositoryMemberName%.get%uCategory%^(inDto^);
    echo         return %category%;
    echo    }
    echo.
    echo     public boolean del%uCategory%^(%strInDtoClassName_Del% inDto^){
    echo         boolean isDel = %strRepositoryMemberName%.del%uCategory%^(inDto^);
    echo         return isDel;
    echo    }
    echo.
    echo     public boolean upd%uCategory%^(%strInDtoClassName_Upd% inDto^){
    echo         boolean isUpd = %strRepositoryMemberName%.upd%uCategory%^(inDto^);
    echo         return isUpd;
    echo    }
    echo.
    echo     public boolean ins%uCategory%^(%strInDtoClassName_Ins% inDto^){
    echo         boolean isIns = %strRepositoryMemberName%.ins%uCategory%^(inDto^);
    echo         return isIns;
    echo    }
    echo }
) > "%strServiceFilePath%"

:: Service Create File > Move
move "%strServiceFilePath%" "%strServiceFolder%"

:: ############################  Controller ############################
:: Controller Create File	>> MemberController.java
    set "strController=Controller"

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
    echo import kr.co.goms.web.ams.mam.core.api.ApiResponse;

    echo import %strDtoPackageName%.%strInDtoClassName_Idx%;
    echo import %strDtoPackageName%.%strInDtoClassName_Del%;
    echo import %strDtoPackageName%.%strInDtoClassName_Upd%;
    echo import %strDtoPackageName%.%strInDtoClassName_Ins%;
    echo import %strDtoPackageName%.%strOutDtoClassName%;
    echo import %strDtoPackageName%.%strOutDtoClassName_Idx%;
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
    echo    public ResponseEntity^<ApiResponse^<List^<%strOutDtoClassName%^>^>^> selectAll%uCategory%^(^) {
    echo         List^<%strOutDtoClassName%^> list = %strServiceMemberName%.selectAll%uCategory%^(^);
    echo         ApiResponse^<List^<%strOutDtoClassName%^>^> response = new ApiResponse^<^>^(true, list, "success"^);
    echo         return new ResponseEntity^<^>^(response, HttpStatus.OK^);
    echo    }
    echo.
    echo    @Tag^(name = "GOMS API > %uCategory%", description = "GOMS API %uCategory%입니다. 개별 조회입니다."^)
    echo    @PostMapping^("/%category%/get%uCategory%"^)
    echo    public ResponseEntity^<ApiResponse^<%strOutDtoClassName_Idx%^>^> get%uCategory%^(%strInDtoClassName_Idx% inDto^) {
    echo         %strOutDtoClassName_Idx%  %category% = %strServiceMemberName%.get%uCategory%^(inDto^);
    echo         ApiResponse^<%strOutDtoClassName_Idx%^> response = new ApiResponse^<^>^(true, %category%, "success"^);
    echo         return new ResponseEntity^<^>^(response, HttpStatus.OK^);
    echo    }
    echo.
    echo    @Tag^(name = "GOMS API > %uCategory%", description = "GOMS API %uCategory%입니다. 개별 삭제입니다."^)
    echo    @PostMapping^("/%category%/del%uCategory%"^)
    echo    public ResponseEntity^<ApiResponse^<Void^>^> del%uCategory%^(%strInDtoClassName_Del% inDto^) {
    echo         boolean isDel = %strServiceMemberName%.del%uCategory%^(inDto^);
    echo         ApiResponse^<Void^> response;
    echo         if ^(isDel^) {
    echo             response = new ApiResponse^<^>^(true, null, "success"^);
    echo         } else {
    echo             response = new ApiResponse^<^>^(false, null, "failure"^);
    echo         }
    echo         return new ResponseEntity^<^>^(response, HttpStatus.OK^);
    echo    }
    echo.
    echo    @Tag^(name = "GOMS API > %uCategory%", description = "GOMS API %uCategory%입니다. 개별 업데이트입니다."^)
    echo    @PostMapping^("/%category%/upd%uCategory%"^)
    echo    public ResponseEntity^<ApiResponse^<Void^>^> upd%uCategory%^(%strInDtoClassName_Upd% inDto^) {
    echo         boolean isUpd = %strServiceMemberName%.upd%uCategory%^(inDto^);
    echo         ApiResponse^<Void^> response;
    echo         if ^(isUpd^) {
    echo             response = new ApiResponse^<^>^(true, null, "success"^);
    echo         } else {
    echo             response = new ApiResponse^<^>^(false, null, "failure"^);
    echo         }
    echo         return new ResponseEntity^<^>^(response, HttpStatus.OK^);
    echo    }
    echo.
    echo    @Tag^(name = "GOMS API > %uCategory%", description = "GOMS API %uCategory%입니다. 저장입니다."^)
    echo    @PostMapping^("/%category%/ins%uCategory%"^)
    echo    public ResponseEntity^<ApiResponse^<Void^>^> ins%uCategory%^(%strInDtoClassName_Ins% inDto^) {
    echo         boolean isIns= %strServiceMemberName%.ins%uCategory%^(inDto^);
    echo         ApiResponse^<Void^> response;
    echo         if ^(isIns^) {
    echo             response = new ApiResponse^<^>^(true, null, "success"^);
    echo         } else {
    echo             response = new ApiResponse^<^>^(false, null, "failure"^);
    echo         }
    echo         return new ResponseEntity^<^>^(response, HttpStatus.OK^);
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
    echo     ^<select id="selectAll%uCategory%" parameterType="%strDtoPackageName%.%strInDtoClassName%" resultType="%strDtoPackageName%.%strOutDtoClassName%"^>
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
    echo     ^<select id="get%uCategory%" parameterType="%strDomainPackageName%.%strDomainInClassName_Idx%" resultType="%strDtoPackageName%.%strOutDtoClassName_Idx%"^>
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
    echo     ^<delete id="del%uCategory%" parameterType="%strDtoPackageName%.%strInDtoClassName_Del%" ^>
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
    echo     ^<update id="upd%uCategory%" parameterType="%strDtoPackageName%.%strInDtoClassName_Upd%"^>
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
    echo     ^<insert id="ins%uCategory%" parameterType="%strDtoPackageName%.%strInDtoClassName_Ins%"^>
    echo         %query_ins%
    echo    ^</insert^>
    echo ^</mapper^>
) > "%strMapperXMLFilePath_Ins%"

:: Mapper Create File > Move
move "%strMapperXMLFilePath_Ins%" "%strMapperFolder%"

endlocal
pause