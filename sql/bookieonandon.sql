--==============================================
-- TABLE 26개
--==============================================

-- 1. member 
create table member (
    member_id varchar2(200),
    password varchar2(300) not null,
    enroll_date date default sysdate not null,
    nickname varchar2(100) not null,
    phone char(11) not null,
    gender char(1) not null,
    birthday date,
    introduce varchar2(1000),
    renamed_filename varchar2(256),
    original_filename varchar2(256),
    sns varchar2(1000),
    point number default 0,
    constraint pk_member_id primary key(member_id),
    constraint uq_member_nickname unique (nickname),
    constraint ck_member_gender check (gender in ('M', 'F'))
);

-- 2. authority
create table authority(
    member_id varchar2(200),
    auth varchar2(50),
    constraint pk_authority primary key(member_id, auth),
    constraint fk_authority_member_id foreign key(member_id) references member(member_id) on delete cascade
);

-- 3. interest
create table interest(
    member_id varchar2(200),
    interest varchar2(150),
    constraint pk_interest_member_id primary key(member_id),
    constraint fk_interest_member_id foreign key(member_id) references member(member_id) on delete cascade
);

-- 4. follower
create table follower(
    member_id varchar2(200),
    following_member_id varchar2(200),
    constraint pk_follower_member_id primary key(member_id, following_member_id),
    constraint fk_follower_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint fk_following_member_id foreign key(following_member_id) references member(member_id) on delete cascade
);

select * from pheed where member_id like 'honggd' or member_id like 'sinsa';
insert into follower values('sinsa', 'honggd');
insert into follower values('honggd', 'admin');

-- 5. book
create table book(
    item_id varchar2(30),
    member_id varchar2(200),
    status varchar2(30) not null,
    score number,
    content varchar2(1500),
    my_pick number default 0 not null,
    constraint pk_book_item_id primary key(item_id, member_id),
    constraint fk_book_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint ck_book_score check (score between 1 and 10)
);

-- 6. book_ing
create table book_ing(
    ing_no number,
    item_id varchar2(30) not null,
    member_id varchar2(200) not null,
    started_at date default sysdate,
    ended_at date,
    constraint pk_book_ing_no primary key(ing_no),
    constraint fk_book_ing_member_id foreign key(member_id) references member(member_id) on delete cascade
);

create sequence seq_book_ing_no;


-- 7. dokoo - 독후감 테이블
create table dokoo(
    dokoo_no number not null,
    member_id varchar2(200) not null,
    item_id varchar2(30) not null,
    title varchar2(1500) not null,
    content varchar2(4000) not null,
    constraint pk_dokoo_no primary key(dokoo_no),
    constraint fk_dokoo_member_id foreign key(member_id) references member(member_id) on delete cascade
);

create sequence seq_dokoo_no;


-- 8. dokoo_comment - 독후감 댓글 테이블
create table dokoo_comment(
    dokooc_no number not null,
    dokoo_no number not null,
    nickname varchar2(100) not null,
    comment_ref number,
    created_at date default sysdate,
    constraint pk_dokooc_no primary key(dokooc_no),
    constraint fk_dokoo_comment_dokoo_no foreign key(dokoo_no) references dokoo(dokoo_no) on delete cascade,
    constraint fk_dokoo_comment_nickname foreign key(nickname) references member(nickname) on delete set null
);

create sequence seq_dokooc_no;


-- 9. pheed - 피드 테이블
create table pheed(
    pheed_no number not null,
    member_id varchar2(200) not null,
    item_id varchar2(30) not null,
    page number not null,
    content varchar2(3000) not null,
    is_opened char(1) not null,
    constraint pk_pheed_no primary key(pheed_no),
    constraint fk_pheed_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint ck_pheed_is_opened check(is_opened in ('O', 'F', 'C'))
);

create sequence seq_pheed_no;

-- 10. pheed_attachment - 피드 첨부파일 테이블
create table pheed_attachment(
    attach_no number not null,
    pheed_no number not null,
    original_filename varchar2(256) not null,
    renamed_filename varchar2(256) not null,
    created_at date default sysdate not null,
    constraint pk_pheed_attachment_attach_no primary key(attach_no),
    constraint fk_pheed_attachment_pheed_no foreign key(pheed_no) references pheed(pheed_no) on delete cascade
);

create sequence seq_pheed_attachment_no;

-- 11. pheed_comment - 피드 댓글 테이블
create table pheed_comment(
    pheedc_no number not null,
    pheed_no number not null,
    nickname varchar2(100) not null,
    content varchar2(1000) not null,
    comment_ref number,
    created_at date default sysdate not null,
    constraint pk_pheedc_no primary key(pheedc_no),
    constraint fk_pheed_comment_pheed_no foreign key(pheed_no) references pheed(pheed_no) on delete cascade,
    constraint fk_pheed_comment_nickname foreign key(nickname) references member(nickname) on delete set null
);
create sequence seq_pheed_comment_no;

-- 12. club - 북클럽 테이블 
create table club(
    club_no number not null,
    title varchar2(300) not null,
    content varchar2(4000) not null,
    recruit_start date not null,
    recruit_end date not null,
    club_start date not null,
    club_end date not null,
    book_count number not null,
    maximum_nop number not null,
    minimum_nop number not null,
    deposit number not null,
    constraint pk_club_no primary key(club_no)
);

create sequence seq_club_no;

-- 13. club_book
create table club_book (
    club_no   number not null,
    item_id   varchar2(30) not null,
    constraint fk_club_book_club_no foreign key(club_no) references club(club_no) on delete cascade,
    constraint pk_item_id primary key(item_id, club_no)
);

-- 14. mission
create table mission (
    club_no      number not null, 
    mission_no   number not null,
    title          varchar2(300) not null,
    content      varchar2(1000) not null,
    point      number,
    constraint fk_mission_club_no foreign key(club_no) references club(club_no) on delete cascade,
    constraint pk_mission_no primary key(mission_no)
);

create sequence seq_mission_mission_no;

-- 15. mission_status
create table mission_status (
    mission_no   number not null,
    member_id   varchar2(200) not null,
    status      char(1) default 'F',
    constraint ck_mission_status check (status in ('P', 'F')),
    constraint pk_mission_status_no primary key(mission_no),
    constraint fk_mission_status_no foreign key(mission_no) references mission(mission_no) on delete cascade,
    constraint fk_mission_status_member_id foreign key(member_id) references member(member_id)
);

-- 16. my_club
create table my_club (
    club_no      number not null,
    member_id   varchar2(200) not null,
    deposit      number not null,
    constraint pk_my_club_no primary key (club_no, member_id),
    constraint fk_my_club_member_id foreign key(member_id) references member(member_id) on delete cascade
);

-- 17. club_chat
create table club_chat(
    chat_no      number not null,
    nickname      varchar2(100) not null,
    club_no      number not null,
    title          varchar2(1500) not null,
    content      varchar2(4000) not null,
    constraint pk_club_chat_no primary key(chat_no),
    constraint fk_club_chat_club_no foreign key(club_no) references club(club_no) on delete cascade
);

create sequence seq_club_chat_no;

-- 18. chat_attachment
create table chat_attachment(
    attach_no      number not null,
    chat_no      number not null,
    original_filename   varchar2(256) not null,
    renamed_filename   varchar2(256) not null,
    created_at   date default sysdate,
    constraint pk_chat_attachment_no   primary key(attach_no),
    constraint fk_chat_attachment_chat_no foreign key(chat_no) references club_chat(chat_no) on delete cascade
);

create sequence seq_chat_attachment_no;

-- 19. 채팅코멘트 테이블
create table chat_comment(
    comment_no number not null,
    chat_no number not null,
    nickname varchar2(100) not null,
    comment_ref number,
    created_at date default sysdate not null,
    constraint pk_chat_comment_no primary key(comment_no) 
);

create sequence seq_comment_no;

-- 20. 신고테이블
create table report (
    report_no number not null,
    member_id varchar2(200) not null,
    category varchar2(30) not null,
    beenzi_no number not null,
    status varchar2(200) not null,
    constraint pk_report_no primary key(report_no),
    constraint ck_report_category check(category in ('pheed','pheed_comment','dokoo','dokoo_comment'))
);

create sequence seq_report_no;

-- 21. 찜하기피드 테이블
create table wishlist_pheed (
    pheed_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_pheed_member_id foreign key(member_id) references member(member_id)
);

-- 22. 찜하기독후감 테이블
create table wishlist_dokoo (
    dokoo_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_dokoo_member_id foreign key(member_id) references member(member_id)
);

-- 23. 찜하기북클럽 테이블
create table wishlist_club (
    club_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_club_member_id foreign key(member_id) references member(member_id)
);

-- 24. 좋아요피드 테이블
create table likes_pheed (
    pheed_no number not null,
    member_id varchar2(200) not null,
    constraint fk_likes_pheed_member_id foreign key(member_id) references member(member_id)
);

-- 25. 좋아요독후감 테이블
create table likes_dokoo (
    dokoo_no number not null,
    member_id varchar2(200) not null,
    constraint fk_likes_dokoo_member_id foreign key(member_id) references member(member_id)
);

-- 26. 좋아요북클럽 테이블
create table likes_club (
    club_no number not null,
    member_id varchar2(200) not null,
    constraint fk_likes_club_member_id foreign key(member_id) references member(member_id)
);

--==============================================
-- 조회
--==============================================
select * from user_sequences; -- 시퀀스 조회

select * from member;
select * from authority;
select * from interest;
select * from follower;
select * from book;
select * from book_ing;
select * from dokoo;
select * from dokoo_comment;
select * from pheed;
select * from pheed_attachment;
select * from pheed_comment;
select * from club;
select * from club_book;
select * from mission;
select * from mission_status;
select * from my_club;
select * from club_chat;
select * from chat_attachment;
select * from chat_comment;
select * from report;
select * from wishlist_pheed;
select * from wishlist_dokoo;
select * from wishlist_club;
select * from likes_pheed;
select * from likes_dokoo;
select * from likes_club;


-- remeber-me table
create table persistent_logins (
    username varchar(64) not null, 
    series varchar(64) primary key, 
    token varchar(64) not null,  -- username, password, expire time을 단방향 암호화한 값
    last_used timestamp not null);

select * from persistent_logins;

select 
    * 
from 
    pheed p left join pheed_attachment a
        on p.pheed_no = a.pheed_no
order by 1 desc ;
select * from pheed_attachment;

-- sample data
insert into member
values(
    'honggd1',
    '1234',
    sysdate,
    '길동1',
    '01012341234',
    'M',
    to_date('90-12-25','rr-mm-dd'),
    '안녕하세요 홍길동입니다.',
    null,
    null,
    'https://www.instagram.com/honggd',
    default
);
insert into member
values(
    'sinsa',
    '1234',
    sysdate,
    '신사',
    '01012345678',
    'F',
    to_date('90-10-25','rr-mm-dd'),
    '안녕하세요 신사임당입니다.',
    null,
    null,
    'https://www.instagram.com/sinsa',
    default
);
insert into member
values(
    'admin',
    '1234',
    sysdate,
    '빈지노',
    '01011111234',
    'M',
    to_date('87-09-12','rr-mm-dd'),
    '안녕하세요 관리자입니다.',
    null,
    null,
    'https://www.instagram.com/realisshoman',
    default
);
insert into authority values ('honggd', 'ROLE_USER');
insert into authority values ('admin', 'ROLE_USER');
insert into authority values ('admin', 'ROLE_ADMIN');
insert into interest values ('honggd', '취미, 공학');

insert into pheed values(seq_pheed_no.nextval, 'honggd1', '9791197912412', '23', '피드피드테스트팔로워테스트','O');
insert into pheed values(seq_pheed_no.nextval, 'honggd', '9791166890871', '55', '피드피드테스트2','F');

insert into pheed_attachment values(seq_pheed_attachment_no.nextval, '1', 'attach1.jpg', 'attach1.jpg', sysdate);
insert into pheed_attachment values(seq_pheed_attachment_no.nextval, '2', 'attach2.jpg', 'attach2.jpg', sysdate);


insert into pheed_comment values(seq_pheed_comment_no.nextval, 1, '길동', 'ㅎㅇ', null, sysdate);
insert into pheed_comment values(seq_pheed_comment_no.nextval, 1, '길동', 'ㅎㅇㅎㅇ', null, sysdate);
insert into pheed_comment values(seq_pheed_comment_no.nextval, 2, '길동', 'ㅎㅇ', null, sysdate);
insert into pheed_comment values(seq_pheed_comment_no.nextval, 2, '길동', 'ㅎㅇㅎㅇ', 1, sysdate);
