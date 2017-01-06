CREATE TABLE imgbbs ( 
  no      NUMBER(7)     NOT NULL,  -- 글 일련 번호, -9999999 ~ +9999999 
  name    VARCHAR(20)   NOT NULL,  -- 글쓴이 
  title   VARCHAR(100)  NOT NULL,  -- 제목(*) 
  content VARCHAR(4000) NOT NULL,  -- 글 내용 
  passwd  VARCHAR(15)   NOT NULL,  -- 비밀 번호 
  viewcnt NUMBER(5)     DEFAULT 0, -- 조회수, 기본값 사용 
  wdate   DATE          NOT NULL,  -- 등록 날짜, sysdate 
  grpno   NUMBER(7)     DEFAULT 0, -- 부모글 번호 
  indent  NUMBER(2)     DEFAULT 0, -- 답변여부,답변의 깊이
  ansnum  NUMBER(5)     DEFAULT 0, -- 답변 순서 
  filename VARCHAR(30)   DEFAULT 'default.jpg', --이미지
  PRIMARY KEY (no)  
); 

INSERT INTO imgbbs(no, name, title, content, passwd, wdate,
				    filename, grpno )
VALUES((SELECT NVL(MAX(no), 0) + 1 as no FROM imgbbs), 
	    '부모글1', '제목', '내용', '123', sysdate, 'member.jpg', 
	    (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM imgbbs));
	    
INSERT INTO imgbbs(no, name, title, content, passwd, wdate,
				    filename, grpno)
VALUES((SELECT NVL(MAX(no), 0) + 1 as no FROM imgbbs), 
	    '부모글2', '제목', '내용', '123', sysdate, 'member.jpg', 
	    (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM imgbbs));	    
SELECT * FROM imgbbs 
WHERE no = 1;

DELETE FROM imgbbs 
WHERE no =1;

 ALTER TABLE imgbbs
 ADD (refno number default 0);
	    
--read에서 여러파일읽어오는 문장
SELECT * FROM 
  ( 
     select   
         lag(no,2)     over (order by no) pre_no2,  
         lag(no,1)     over (order by no ) pre_no1, 
         no,
         lead(no,1)    over (order by no) nex_no1,  
         lead(no,2)    over (order by no) nex_no2,  
         lag(filename,2)  over (order by no) pre_file2,   
         lag(filename,1)  over (order by no ) pre_file1,
         filename, 
         lead(filename,1) over (order by no) nex_file1,
         lead(filename,2) over (order by no) nex_file2 
         from ( 
              SELECT no, filename  
              FROM imgbbs
              ORDER BY no DESC 
         ) 
  ) 
  WHERE no = 3;
	    