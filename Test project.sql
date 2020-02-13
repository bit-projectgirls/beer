-- 테이블 생성

CREATE TABLE users (
    uuid        VARCHAR2(200) PRIMARY KEY,
    email       VARCHAR2(200)   NOT NULL,
    nickname    VARCHAR2(100)   NOT NULL,
    kakaoId     VARCHAR2(100),
    userPic     VARCHAR2(200)   NOT NULL,
    joinDate    DATE            NOT NULL
);

CREATE TABLE country (
    country     VARCHAR2(100) NOT NULL,
    countryKo   VARCHAR2(200) NOT NULL
);

CREATE TABLE beer (
    beerNo      NUMBER PRIMARY KEY,
    beerName    VARCHAR2(100) NOT NULL,
    beerPic     VARCHAR2(100),
    companyNo   NUMBER, -- foreign key
    country     VARCHAR2(100) NOT NULL,
    beerType        VARCHAR2(100),
    abv         NUMBER,
    rating      NUMBER NOT NULL,
    ratingBA    NUMBER,
    note        VARCHAR2(1000)
);

CREATE TABLE beer_like (
    bLikeNo NUMBER PRIMARY KEY,
    uuid    VARCHAR2(200) NOT NULL, -- foriegn key
    beerNo NUMBER NOT NULL, -- foriegn key
    regDate DATE NOT NULL
);

CREATE TABLE hashtag (
    tagNo NUMBER PRIMARY KEY,
    tagName VARCHAR2(100) NOT NULL,
    beerNo NUMBER NOT NULL, -- foriegn key
    reviewNo VARCHAR2(200) NOT NULL
);

CREATE TABLE review (
    reviewNo    VARCHAR2(200) PRIMARY KEY,
    uuid        VARCHAR2(200), -- foreign key
    beerNo      NUMBER, -- foreign key
    reviewContent   VARCHAR2(4000),
    reviewPic   VARCHAR2(100),
    rating      NUMBER NOT NULL,
    regDate     DATE NOT NULL,
    likeCnt     NUMBER NOT NULL
);

CREATE TABLE review_like (
    rLikeNo NUMBER PRIMARY KEY,
    reviewNo NUMBER NOT NULL, -- foriegn key
    uuid VARCHAR2(200) NOT NULL -- foriegn key
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
DROP TABLE review;
DROP TABLE beer_like;

-- 시퀀스 삭제
DROP SEQUENCE seq_tag_no;

-- 테이블 확인
SELECT * FROM users;
SELECT * FROM hashtag;
SELECT * FROM review;
SELECT * FROM beer;
SELECT * FROM beer WHERE beerno = 465777;
SELECT reviewNo, users.uuid, beerNo, reviewContent, reviewPic, rating, regDate, likeCnt, nickname
FROM review, users
WHERE review.uuid = users.uuid; 
SELECT * FROM beer WHERE rownum <= 10;
SELECT country FROM(
    SELECT ROWNUM AS idx, a.* FROM(
        SELECT DISTINCT country
        FROM beer
        WHERE country Like ('%'|| '' ||'%')
        ORDER BY country) a
    WHERE ROWNUM <= 40)
WHERE idx > 0;
UPDATE beer  SET rating = 0  WHERE beerNo = 5;
commit;