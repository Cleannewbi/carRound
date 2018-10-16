SELECT * FROM RC_RENT

SELECT * FROM RC_MEMBER;

INSERT INTO RC_MEMBER
VALUES (SEQ_RC_MEMBER.NEXTVAL,'cat','123',NULL, '고양이','01011111111','고양시','cat@cat.com','1234123412341234',1);
INSERT INTO RC_MEMBER
VALUES (SEQ_RC_MEMBER.NEXTVAL,'dog','123',NULL, '강아지','01058585858','갱쥐시','dog@dog.com','1234123412341234',1);
INSERT INTO RC_MEMBER
VALUES (SEQ_RC_MEMBER.NEXTVAL,'testcom', '123', NULL, 'TEST COMPANY','01099999999','회사시','com@com.com','1234123412341234',2);
INSERT INTO RC_MEMBER
VALUES (SEQ_RC_MEMBER.NEXTVAL,'admin','admin',NULL, '관리자','010-5555-5555','서울시','admin@admin.com','1234123412341234',3);

DELETE FROM RC_MEMBER WHERE ID='cat';

UPDATE RC_MEMBER SET ADDRESS='서울특별시 강남구 논현로 545'
WHERE SEQ=44;

SELECT * FROM RC_INFO 

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'ds','123','1234123412341234','01012341234','다슬','경기도 김포시 풍무동','ds@ds.com','1234123412341234',1);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'cow','123','1234123412341234','01012341234','소씨','경기도 김포시 장기동','cow@cow.com','1234123412341234',1);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'gs','123','1234123412341234','01012341234','경상','서울시 강남구 역삼동','gs@gs.com','1234123412341234',1);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'yj','123','1234123412341234','01012341234','유진','서울시 강남구 역삼동','yj@yj.com','1234123412341234',1);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'yt','123','1234123412341234','01012341234','영태','서울시 강남구 역삼동','yt@yt.com','1234123412341234',1);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'dh','123','1234123412341234','01012341234','대헌','서울시 강남구 역삼동','dh@dh.com','1234123412341234',1);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'seoulService','123','seulService.jpg','025542085','서울자동차서비스','서울특별시 강남구 선릉로93길 46','seoulser@naver.com','1234123412341234',2);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'gumnam','123','gumnam.jpg','025642500','금남자동차공업사','서울특별시 강남구 테헤란로14길 17','gumnam@naver.com','1234123412341234',2);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'tireworld','123','tireWorld.jpg','0222221000','한국타이어월드와이드','서울특별시 강남구 테헤란로 133 한국타이어빌딩','tireworld@naver.com','1234123412341234',2);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'tirepia','123','tirepia.jpg','025620067','타이어피아 역삼점','서울특별시 강남구 도곡로 179','tirepia@naver.com','1234123412341234',2);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'renosamsung','123','renosamsung.jpg','025013552','르노삼성자동차 강남정비사업소','서울특별시 강남구 테헤란로6길 8','renosamsung@naver.com','1234123412341234',2);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'contiseoul','123','contiSeoul.jpg','025547071','콘티넨탈남서울','서울특별시 강남구 도곡로 243','contiseoul@naver.com','1234123412341234',2);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'tirepro','123','tirepro.jpg','025015527','타이어프로 역삼점','서울특별시 강남구 논현로 545','tirepro@naver.com','1234123412341234',2);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'giaotoq','123','giaotoq.jpg','025618285','기아오토큐','서울특별시 강남구 언주로104길 15','giaotoq@naver.com','1234123412341234',2);

INSERT INTO RC_MEMBER
VALUES(SEQ_RC_MEMBER.NEXTVAL,'bluehands','123','bluehands.jpg','025386197','블루핸즈 역삼점','서울특별시 강남구 논현로81길 4','bluehands@naver.com','1234123412341234',2);

INSERT INTO RC_INFO
VALUES (SEQ_RC_INFO, '기아오토큐', 'KiaSportage.jpg', '
Kia Sportage', '승용차', 'LPG', '중형', '40,000')




