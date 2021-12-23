--webdb 계정에 book 테이블 만들기--

CREATE TABLE book(
     book_id NUMBER(5),
     title VARCHAR2(50),
     author VARCHAR2(10),
     pub_date date
);

--book 테이블에 pubs 컬럼 추가하기
ALTER TABLE book add(pubs VARCHAR2(50));

--book 테이블에 컴럼속성 변경하기
ALTER TABLE book MODIFY (title VARCHAR2(100));
ALTER TABLE book RENAME COLUMN title TO subject; /*컬럼 이름 변경*/

--컬럼삭제
ALTER TABLE book DROP (author);

--테이블 명 변경하기
RENAME book TO article;

--테이블 삭제
DROP TABLE author;

--author(작가) 테이블 만들기
CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY(author_id)
);


--책 테이블 만들기

create table book(
    book_id NUMBER(10),
    title VARCHAR2(100) NOT NULL,
    pubs VARCHAR2(100),
    author_id NUMBER(10),
    PRIMARY KEY(book_id),
    CONSTRAINT book_fk FOREIGN KEY (author_id) /*book의 author_id와 author의 author_id과 연관을 지어준다*/
    REFERENCES author(author_id)  /*book의 author_id와 author의 author_id과 연관을 지어준다*/
);


--작가 (author) 테이블 데이터 추가
--묵시적 방법 컬럼 이름, 순서 지정하지 않음 테이블 생성시 정의한 순서에 따라 값 지정 null이 있으면 안됨--
INSERT INTO author
VALUES (1, '박경리', '토지 작가' );

INSERT INTO author
VALUES (3, '기안84', '토지 작가' );
--명시적 방법 컬럼 이름명시적 사용 지정되지 않은 컬럼 NULL 자동입력--
INSERT INTO author( author_id, author_name )
VALUES (2, '이문열' );

--조건을 만족하는 레코드를 변경 컬럼 이름, 순서 지정하지 않음. 테이블 생성시 정의한 순서에 따라 값 지정
--원래 있던 데이터 삭제하고 다시 집어넣음
UPDATE author
SET author_name = '기안84' , 
author_desc = '웹툰작가'
WHERE author_id = 1 ;
--주의점 WHERE 절이 생략되면 모든 레코드에 적용(주의)
UPDATE author
SET author_name = '강풀',
author_desc = '인기작가' ;

--조건을 만족하는 레코드를 삭제
DELETE FROM author
WHERE author_id = 1 ;

--조건이 없으면 모든 데이터 삭제(주의)
DELETE FROM author;

--SEQUENCE(시퀀스)  • 연속적인 일렬번호 생성PK에 주로 사용됨 데이터 삭제 후 다시 만들어도 초기화 안됨
--ex) 예 데이터 번호 1 2 3, 삭제 후 다시 입력 4 5 6으로 나옴

--시퀀스 생성
CREATE SEQUENCE seq_author_id
INCREMENT BY 1 
start with 1;

--시퀀스 사용
INSERT INTO author
VALUES (seq_author_id.nextval, '박경리', '토지 작가 ' );

INSERT INTO author
VALUES (seq_author_id.nextval, '이문열', '삼국지 작가 ' );

INSERT INTO author
VALUES (seq_author_id.nextval, '강풀', '웹툰작가');

--시퀀스 조회
SELECT * FROM USER_SEQUENCES;

--현재 시퀀스 조회
SELECT seq_author_id.currval FROM dual;

--다음 시퀀스 조회
SELECT seq_author_id.nextval FROM dual;

--시퀀스 삭제
DROP SEQUENCE seq_author_id;

--SYSDATE : 현재시간이 입력이 됨
INSERT INTO board
VALUES (1, '게시판제목', '본문내용', SYSDATE );

-----------------------------------------------
SELECT * FROM book;
SELECT * FROM author;

/* commit; 마지막에 써줘야됨 안그러면 사라짐*/