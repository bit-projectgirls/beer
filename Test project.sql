-- 테이블 생성

CREATE TABLE users (
    uuid        VARCHAR2(200) PRIMARY KEY,
    email       VARCHAR2(200)   NOT NULL,
    nickname    VARCHAR2(100)   NOT NULL,
    kakaoId     VARCHAR2(100),
    userPic     VARCHAR2(200)   NOT NULL,
    joinDate    DATE            NOT NULL
);

CREATE TABLE company (
    companyNo   NUMBER PRIMARY KEY,
    country     VARCHAR2(100) NOT NULL,
    companyName VARCHAR2(200) NOT NULL
);

CREATE TABLE beers (
    beerNo      NUMBER PRIMARY KEY,
    beerName    VARCHAR2(100) NOT NULL,
    beerPic     VARCHAR2(100),
    companyNo   NUMBER, -- foreign key
    type        VARCHAR2(100),
    abv         NUMBER,
    rating      NUMBER NOT NULL,
    ratingBA    NUMBER,
    note        VARCHAR2(1000)
);

CREATE TABLE beer_like (
    bLikeNo NUMBER PRIMARY KEY,
    uuid    NUMBER NOT NULL, -- foriegn key
    beerNo NUMBER NOT NULL, -- foriegn key
    regDate DATE NOT NULL
);

CREATE TABLE hashtag (
    tagNo NUMBER PRIMARY KEY,
    tagName VARCHAR2(100) NOT NULL,
    beerNo NUMBER NOT NULL, -- foriegn key
    reviewNo NUMBER NOT NULL
);

CREATE TABLE review (
    reviewNo    NUMBER PRIMARY KEY,
    uuid        NUMBER, -- foreign key
    beerNo      NUMBER, -- foreign key
    reviewContent   VARCHAR2(4000),
    reviewPic   VARCHAR2(100),
    rating      NUMBER NOT NULL,
    regDate     DATE NOT NULL,
    likeCnt     NUMBER NOT NULL,
    cmtCnt      NUMBER NOT NULL
);

CREATE TABLE comment (
    cmtNo NUMBER PRIMARY KEY,
    reviewNo NUMBER NOT NULL, -- foriegn key
    uuid NUMBER NOT NULL, -- foriegn key
    cmtContent VARCHAR2(500) NOT NULL,
    regDate DATE NOT NULL    
);

CREATE TABLE review_like (
    rLikeNo NUMBER PRIMARY KEY,
    reviewNo NUMBER NOT NULL, -- foriegn key
    uuid NUMBER NOT NULL -- foriegn key
);

-- 시퀀스 생성
CREATE SEQUENCE seq_tag_no
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
CREATE SEQUENCE seq_review_no
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
-- 테이블 삭제
DROP TABLE users;
DROP TABLE hashtag;

-- 시퀀스 삭제
DROP SEQUENCE seq_tag_no;

-- 테이블 확인
SELECT * FROM users;
SELECT * FROM hashtag;