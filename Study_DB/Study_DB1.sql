-- 생성
CREATE TABLE lprod(
    lprod_id number(7) NOT NULL,
    lprod_gu char(4) NOT NULL,
    lprod_nm varchar2(40) NOT NULL,
    CONSTRAINT pk_lprod primary key (lprod_gu)
);

-- 조회하기
SELECT * FROM lprod;


-- 데이터 삽입
INSERT INTO lprod(
    lprod_id, lprod_gu, lprod_nm
) Values (
    9, 'P403', '문구류'
);

-- 조회
-- 상품분류정보에서 상품분류 코드의 값이 P@@@ 인 데이터를 조회하십시오
SELECT * FROM lprod
    WHERE lprod_gu = 'P202';

-- 내용 수정
-- 상품분류코드가 P102에 대하여 상품분류 값을 향수로 변경하십시오.
UPDATE lprod SET lprod_nm = '향수'
    WHERE lprod_gu = 'P102';

-- 내용 삭제
-- 상품분류정보에서 분류코드가  P202에 대한 데이터를 삭제하시오.
DELETE FROM lprod
    WHERE lprod_gu = 'P202';

-- 생성
-- 거래처 정보 테이블 생성
CREATE TABLE buyer(
    buyer_id char(6) NOT NULL,                      -- 거래처 코드
    buyer_name VARCHAR2(40) NOT NULL,       -- 거래처명
    buyer_lgu char(4) NOT NULL,                    -- 취급 상품 대분류
    buyer_bank VARCHAR2(60),                        -- 은행
    buyer_bankno VARCHAR2(60),                     -- 계좌번호
    buyer_bankname VARCHAR2(15),                -- 은행주
    buyer_zip CHAR(7),                                  -- 우편번호
    buyer_add1 VARCHAR2(100),                       -- 주소1
    buyer_add2 VARCHAR2(70),                        -- 주소2
    buyer_comtel VARCHAR2(14) NOT NULL,       -- 전화번호
    buyer_fax VARCHAR2(20) NOT NULL             -- FAX번호
);


-- 테이블 형태 수정
-- 컬럼 추가
ALTER TABLE buyer ADD (
    buyer_mail VARCHAR2(60) NOT NULL,
    buyer_charger VARCHAR2(20),
    buyer_telext VARCHAR2(2)
    );

-- 컬럼 수정
ALTER TABLE buyer MODIFY (
    buyer_name VARCHAR2(60)
    );

ALTER TABLE buyer ADD (
    CONSTRAINT pk_buyer PRIMARY KEY (buyer_id),
    CONSTRAINT fr_buyer_lprod FOREIGN KEY (buyer_lgu)
        REFERENCES lprod(lprod_gu)
);
    
    
-- 데이터의 정렬 ASC쓰면 NULL이 먼저 올라온다.

    