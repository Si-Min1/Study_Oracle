-- 유저생성
CREATE USER busan IDENTIFIED BY dbdb;

alter session set "_ORACLE_SCRIPT"= true;

Drop User busan;

-- 생성한 사용자에게 권한 부여, 접속권한, 관리자 권한 모두 부여
GRANT CONNECT,RESOURCE,DBA TO busan;

-- 여기까지가 system 영역에서 처리 아래는 만들어진 계정으로 진행

CREATE TABLE TEST(
        AA VARCHAR2(40) NOT NULL,
        BB VARCHAR2(40) NOT NULL,
        CC VARCHAR2(40) NOT NULL
        );







