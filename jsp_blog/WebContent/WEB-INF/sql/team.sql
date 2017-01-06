DROP TABLE team;

CREATE TABLE team( 
  no	   NUMBER(6)     NOT NULL,  -- 일련번호, -999999 ~ +999999 
  name     VARCHAR(20)   NOT NULL,  -- 이름 
  gender   VARCHAR(5) 	 NOT NULL,  -- 성별   
  phone    VARCHAR(20)   NOT NULL,  -- 전화번호  
  zipcode  VARCHAR(6)    NOT NULL, -- 우편번호 
  address1 VARCHAR(200)  NOT NULL,  -- 주소 
  address2 VARCHAR(200)  NOT NULL,  -- 주소 
  skill    VARCHAR(100)  NOT NULL,
  hobby    VARCHAR(100)  NOT NULL,
  filename VARCHAR(50)	 DEFAULT 'member.jpg',
  PRIMARY KEY(no)              -- 고유한 값, 중복 안됨    
);

--일렬데이터 만들기
SELECT max(no) FROM team
SELECT nvl(max(no),0)+1 FROM team;
SELECT * FROM team


-- SEQUENCE 객체 생성 
CREATE SEQUENCE team_seq 
START WITH 1 
INCREMENT BY 1 
MINVALUE 0 
CACHE 100; 



--create
INSERT INTO team
(no, name, gender, phone, zipcode, address1, address2, skill, hobby, filename)
VALUES 
((SELECT nvl(max(no),0)+1 FROM team),
'홍길동', '남', '010-1111-1111', '12345', '서울시 종로구 관철동', '코아빌딩 5층,10층',
'Java, Jsp, MVC','기술서적읽기','member.jpg'
);

--read
SELECT * FROM team
WHERE no = 1;

--update
UPDATE team 
SET
hobby = '게임하기'
WHERE no = 1;

UPDATE team 
SET
filename='01.jpg'
WHERE no = 1;


--delete
DELETE FROM team
WHERE NO = 1;


--list
SELECT no, name, phone, skill
FROM team
ORDER BY no DESC;


