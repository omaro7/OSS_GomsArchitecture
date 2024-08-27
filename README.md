2024 OSS Goms Architecture

2024 OSS Goms Spring Boot Architechture 사용법

1.구성
 1)Folder >>>> Member, Company, Group, Field, FieldDetail, FieldCategory
 2)Config File >>>> config.yml
 3)Read Yaml py >>>> read_yaml.py

Python 실행환경 필요!!!

2.실행
 1)python yaml 설치
   > pip intall pyyaml
 2)각 폴더의 {폴더}_ALL2.bat 실행

특정 컴퓨터에 bat 실행 시, 한글 포함되어 있어서 에러가 발생할 수 있습니다. 
bat 내용에 한글주석 혹은 내용을 빼시면 됩니다.
 
3.생성
 1)controller
 2)domain
 3)mapper
   *.java, *.xml
 4)repository
 5)service
   ㄴ dto

4.STS(Spring tool suit) > Workspace에 해당 폴더 옮겨서 적용
