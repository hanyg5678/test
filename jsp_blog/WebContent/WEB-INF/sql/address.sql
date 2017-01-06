DROP TABLE address;

CREATE TABLE address( 
  no	   NUMBER        NOT NULL,  -- 일련번호, -999999 ~ +999999 
  name     VARCHAR(20)   NOT NULL,  -- 이름 
  phone    VARCHAR(20)   NOT NULL,  -- 전화번호  
  zipcode  VARCHAR(6)    NOT NULL, -- 우편번호 
  address1 VARCHAR(200)  NOT NULL,  -- 주소 
  address2 VARCHAR(200)  NOT NULL,  -- 주소 
  wdate    DATE	 NOT NULL,
  PRIMARY KEY(no)              -- 고유한 값, 중복 안됨    
);

--일렬데이터 만들기
SELECT max(no) FROM address
SELECT nvl(max(no),0)+1 FROM address;
SELECT * FROM address






--create
INSERT INTO address
(no, name, phone, zipcode, address1, address2, wdate) 
VALUES 
((SELECT nvl(max(no),0)+1 FROM address),
'홍길동', '010-1111-1111', '12345', 
'서울시 종로구 관철동', '코아빌딩 5층,10층', sysdate);

--read
SELECT * FROM address 
WHERE no = 1;

--update
UPDATE address
SET
phone = '010-0000-0000',
zipcode = '00000',
address1 = '서울시 강남구 역삼동',
address2 = '테헤란로'
WHERE no = 1;



--delete
DELETE FROM address
WHERE NO = 1;


--list
SELECT no, name, phone, zipcode, wdate
FROM address
ORDER BY no DESC;

SELECT *
FROM address
ORDER BY no DESC;
