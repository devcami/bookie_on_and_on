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
    interest varchar2(50) not null,
    mission_Cnt varchar2(30) null,
    constraint pk_club_no primary key(club_no)
);
select * from club;
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
    m_title          varchar2(300) not null,
    m_content      varchar2(1000) not null,
    point      number,
    m_item_id varchar2(13),
    m_endDate date,
    constraint fk_mission_club_no foreign key(club_no) references club(club_no) on delete cascade,
    constraint pk_mission_no primary key(mission_no)
);
select * from mission;
create sequence seq_mission_no;

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
    constraint fk_wishlist_pheed_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- 22. 찜하기독후감 테이블
create table wishlist_dokoo (
    dokoo_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_dokoo_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- 23. 찜하기북클럽 테이블
create table wishlist_club (
    club_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_club_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- 24. 좋아요피드 테이블
create table likes_pheed (
    pheed_no number not null,
    member_id varchar2(200) not null,
    constraint fk_likes_pheed_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- 25. 좋아요독후감 테이블
create table likes_dokoo (
    dokoo_no number not null,
    member_id varchar2(200) not null,
    constraint fk_likes_dokoo_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- 26. 좋아요북클럽 테이블
create table likes_club (
    club_no number not null,
    member_id varchar2(200) not null,
    constraint fk_likes_club_member_id foreign key(member_id) references member(member_id) on delete set null
);

--==============================================
-- 조회
--==============================================
select * from user_sequences; -- 시퀀스 조회
delete from member where member_id = 'admin';

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
    member m 
        join authority a on m.member_id = a.member_id
        left join interest i on m.member_id = i.member_id 
where
    m.member_id = 'tmddbs';

select 
    * 
from 
    pheed p left join pheed_attachment a
        on p.pheed_no = a.pheed_no
order by 1 desc ;
select * from pheed_attachment;
select * from pheed;

-- sample data

insert into pheed values(seq_pheed_no.nextval, 'honggd1', '9791197912412', '23', '피드피드테스트팔로워테스트','O');
insert into pheed values(seq_pheed_no.nextval, 'honggd', '9791166890871', '55', '피드피드테스트2','F');

insert into pheed_attachment values(seq_pheed_attachment_no.nextval, '1', 'attach1.jpg', 'attach1.jpg', sysdate);
insert into pheed_attachment values(seq_pheed_attachment_no.nextval, '2', 'attach2.jpg', 'attach2.jpg', sysdate);


insert into dokoo values(seq_dokoo_no.nextval, 'honggd1', '9791164064410', '독후감테스트', '내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'honggd', '9791191824001', '지구어쩌구온실', '테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'honggd', '9791191824001', '테스트 페이지바 ! 1', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'honggd', '9791191824001', '똑같은 책 페이지바 2', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'honggd', '9791191824001', '홍길동동주렁주렁', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'honggd', '9791191824001', '홍홍길길동동주주렁렁주주렁렁', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'sinsa', '9791191824001', '다음페이지에있는놈을 봐주세요', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'admin', '9791191824001', 'dj샘플데이터를언제까지 추가해야되냐?', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'sinsa', '9791191824001', '왜요오', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'C');
insert into dokoo values(seq_dokoo_no.nextval, 'honggd1', '9791191824001', '내글을 읽어봐 넌 행복해지고', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'admin', '9791191824001', '다른책 ㄱ추가하기 너무 귀찮아', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'honggd', '9791191824001', '책을읽읍시다.', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'sinsa', '9791191824001', '콜라먹고싶은데 일어나기 귀찮아', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'admin', '9791191824001', '빈지노빈진호', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'sinsa', '9791191824001', '지금은 5시 25분', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');
insert into dokoo values(seq_dokoo_no.nextval, 'honggd', '9791191824001', '똑같은 ', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'F');
insert into dokoo values(seq_dokoo_no.nextval, 'honggd1', '9791191824001', '독후감독후감', ' 독후감을 써보자 테스트입니다. 내용은 몇글자가 들어가야될까요 안녕하세요  뭐요 뭘봐 견뎌 홍길동동주렁주렁', sysdate,'O');

insert into dokoo_comment values(seq_dokooc_no.nextval, 1, '길동1', null, sysdate, 'ㅎㅇ');
insert into dokoo_comment values(seq_dokooc_no.nextval, 1, '길동', null, sysdate, 'ㅎㅇㅎㅇ');
insert into dokoo_comment values(seq_dokooc_no.nextval, 2, '빈지노', null, sysdate, 'test!');
insert into dokoo_comment values(seq_dokooc_no.nextval, 2, '신사', null, sysdate, 'commentTest!!');
insert into dokoo_comment values(seq_dokooc_no.nextval, 2, '길동', null, sysdate, 'commentTest!!');
insert into dokoo_comment values(seq_dokooc_no.nextval, 3, '빈지노', null, sysdate, 'commentTest!!');
insert into dokoo_comment values(seq_dokooc_no.nextval, 3, '길동1', null, sysdate, 'commentTest!!');


alter table mission modify content varchar2(4000);
commit;


select * from club;
select * from club_book;
select * from mission;
select * from my_club;
select * from member;

insert into authority values ('admin', 'ROLE_ADMIN');
select * from authority;
delete from authority where member_id = 'tmddbs' and auth = 'ROLE_ADMIN';
commit;


insert into my_club values ('25', 'honggd', 5000);
insert into my_club values ('25', 'sinsa', 5000);
insert into my_club values ('23', 'sinsa', 5000);

commit;

alter table club_book add IMG_SRC varchar2(4000);
alter table mission add item_id varchar2(30);
ALTER TABLE mission RENAME COLUMN m_end_Date TO m_endDate;
commit;

select
    c.*,
    b.*,
    b.club_no bclub_no,
    (select count(*) from my_club where club_no = c.club_no) current_nop,
    (select count(*) from likes_club where club_no = c.club_no)  likes_cnt
from
    club c join club_book b on c.club_no = b.club_no
order by
    recruit_start desc;

insert into pheed_comment values(seq_pheed_comment_no.nextval, 5, '길동', 'test!', null, sysdate);
insert into pheed_comment values(seq_pheed_comment_no.nextval, 5, '길동', 'commentTest!!', 1, sysdate);
commit;

alter table dokoo add is_opened char(1) not null ;
alter table dokoo_comment add content varchar2(1000) not null ;
alter table dokoo add constraint ck_dokoo_is_opened check(is_opened in ('O', 'F', 'C'));
select * from dokoo_comment;
select * from dokoo;
SELECT 
    TABLE_NAME
    ,COLUMN_NAME    -- 컬럼 명
    ,DATA_TYPE      -- 유형
    ,DATA_LENGTH    -- 데이터 길이
    ,DATA_PRECISION -- NUMBER 전체 자릿수
    ,DATA_SCALE     -- NUMBER 소수점이하 표현 자릿수
    ,NULLABLE       -- NULL 여부
    ,COLUMN_ID      -- 컬럼 순서
    ,DATA_DEFAULT   -- 기본 값   
FROM user_tab_columns; -- 해당 계정에 속한 테이블 
   --  dba_tab_columns 전체 테이블의 경우 
alter table pheed add enroll_date date default sysdate;

insert into likes_club values (22, 'honggd');
insert into likes_club values (22, 'sinsa');
insert into likes_club values (26, 'honggd1');


select
		    c.*,
		    b.*,
		    b.club_no bclub_no,
		    m.*,
		    m.club_no mclub_no,
		    (select count(*) from my_club where club_no = c.club_no and c.club_no = 26) current_nop,
		    (select count(*) from likes_club where club_no = c.club_no and c.club_no = 26) likesCnt
		from
		    club c 
		    	join club_book b on c.club_no = b.club_no
		    	join mission m on c.club_no = m.club_no
		where 
			c.club_no = 26;
    
            
            
select* from mission where club_no = 43 and m_item_id = 9788963710358;

		select 
			*
		from 
			club_book b 
				left join mission m on b.item_id = m.m_item_id
		where 
            b.club_no = 43 and m.m_item_id = 9788963710358;
            
            select * from club;
            
            select * from likes_club;
            
            select count(*) from likes_club where club_no = 26;
            select * from my_club;