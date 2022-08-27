--==============================================
-- TABLE 26媛�
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
    email varchar2(256),
    constraint pk_member_id primary key(member_id),
    constraint uq_member_nickname unique (nickname),
    constraint ck_member_gender check (gender in ('M', 'F'))
);
alter table member modify gender char(1) null;
commit;
select * from point_status;
select * from member;
select * from my_club;

update member set point = 12000 where member_id = 'sinsa';
commit;

delete from point_status where member_id = 'sinsa';

-- 2. authority
create table authority(
    member_id varchar2(200),
    auth varchar2(50),
    constraint pk_authority primary key(member_id, auth),
    constraint fk_authority_member_id foreign key(member_id) references member(member_id) on delete cascade
);
select * from authority;
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
select * from follower;
commit;
insert into follower values('honggd', 'tester');

-- 5. book
create table book(
    item_id varchar2(30),
    member_id varchar2(200),
    status varchar2(30) not null,
    score number,
    content varchar2(1500),
    my_pick number default 0 not null,
    enroll_date timestamp default sysdate,
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
    add_date timestamp default sysdate,
    constraint pk_book_ing_no primary key(ing_no),
    constraint fk_book_ing_member_id foreign key(member_id) references member(member_id) on delete cascade
);

create sequence seq_book_ing_no;


-- 7. dokoo - �룆�썑媛� �뀒�씠釉�
create table dokoo(
    dokoo_no number not null,
    member_id varchar2(200) not null,
    item_id varchar2(30) not null,
    title varchar2(1500) not null,
    content varchar2(4000) not null,
    is_opened char(1) not null,
    constraint pk_dokoo_no primary key(dokoo_no),
    constraint ck_dokoo_is_opened check(is_opened in ('O', 'F', 'C')),
    constraint fk_dokoo_member_id foreign key(member_id) references member(member_id) on delete cascade
);

create sequence seq_dokoo_no;


-- 8. dokoo_comment - �룆�썑媛� �뙎湲� �뀒�씠釉�
create table dokoo_comment(
    dokooc_no number not null,
    dokoo_no number not null,
    nickname varchar2(100) not null,
    comment_ref number,
    created_at date default sysdate,
    content varchar2(1000) not null,
    comment_level number default 1,
    constraint pk_dokooc_no primary key(dokooc_no),
    constraint fk_dokoo_comment_dokoo_no foreign key(dokoo_no) references dokoo(dokoo_no) on delete cascade,
    constraint fk_dokoo_comment_ref foreign key(comment_ref) references dokoo_comment(dokooc_no) on delete cascade,
    constraint fk_dokoo_comment_nickname foreign key(nickname) references member(nickname) on delete set null
);

create sequence seq_dokooc_no;

-- 9. pheed - �뵾�뱶 �뀒�씠釉�
create table pheed(
    pheed_no number not null,
    member_id varchar2(200) not null,
    item_id varchar2(30) not null,
    page number not null,
    content varchar2(3000) not null,
    is_opened char(1) not null,
    enroll_date date default sysdate,
    constraint pk_pheed_no primary key(pheed_no),
    constraint fk_pheed_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint ck_pheed_is_opened check(is_opened in ('O', 'F', 'C'))
);

create sequence seq_pheed_no;

-- 10. pheed_attachment - �뵾�뱶 泥⑤��뙆�씪 �뀒�씠釉�
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

-- 11. pheed_comment - �뵾�뱶 �뙎湲� �뀒�씠釉�
create table pheed_comment(
    pheedc_no number not null,
    pheed_no number not null,
    nickname varchar2(100) not null,
    content varchar2(1000) not null,
    comment_ref number,
    created_at date default sysdate not null,
    comment_level number default 1,
    constraint pk_pheedc_no primary key(pheedc_no),
    constraint fk_pheed_comment_pheed_no foreign key(pheed_no) references pheed(pheed_no) on delete cascade,
    constraint fk_pheed_comment_ref foreign key(comment_ref) references pheed_comment(pheedc_no) on delete cascade,
    constraint fk_pheed_comment_nickname foreign key(nickname) references member(nickname) on delete set null
);

create sequence seq_pheed_comment_no;

-- 12. club - 遺곹겢�읇 �뀒�씠釉� 
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
create sequence seq_club_no;

-- 13. club_book
create table club_book (
    club_no   number not null,
    item_id   varchar2(30) not null,
    constraint fk_club_book_club_no foreign key(club_no) references club(club_no) on delete cascade,
    constraint pk_item_id primary key(item_id, club_no)
);

select * from club_book;

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
alter table member add sns_id varchar2(500);
commit;
select * from member;
alter table mission add foreign key(m_item_id, club_no) references club_book(item_id, club_no) on delete cascade;

create sequence seq_mission_no;

-- 15. mission_status
create table mission_status (
    mission_no   number not null,
    member_id   varchar2(200) not null,
    status      char(1) default 'F',
    answer varchar2(1000),
    renamed_filename varchar2(256),
    original_filename varchar2(256),
    constraint ck_mission_status check (status in ('P', 'F', 'I', 'A')),
    constraint pk_mission_status_no primary key(mission_no, member_id),
    constraint fk_mission_status_no foreign key(mission_no) references mission(mission_no) on delete cascade,
    constraint fk_mission_status_member_id foreign key(member_id) references member(member_id)
);
select * from mission_status where member_id = 'tmddbs';
select * from mission where club_no =45;
update mission set m_endDate = sysdate - 1 where mission_no = 39;
commit;

select
    *
from
    user_cons_columns
where table_name = 'MISSION_STATUS';
select * from mission_status;
-- 16. my_club
create table my_club (
    club_no      number not null,
    member_id   varchar2(200) not null,
    deposit      number not null,
    club_end date,
    mission_cnt number,
    club_status varchar2(2),
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
    enroll_date date default sysdate,
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

-- 19. 梨꾪똿肄붾찘�듃 �뀒�씠釉�
create table chat_comment(
    comment_no number not null,
    chat_no number not null,
    nickname varchar2(100) not null,
    comment_ref number,
    created_at date default sysdate not null,
    comment_content varchar2(1000) not null,
    comment_level number default 1,
    constraint pk_chat_comment_no primary key(comment_no)
);
select * from chat_comment;
create sequence seq_comment_no;

-- 20. �떊怨좏뀒�씠釉�
create table report (
    report_no number not null,
    member_id varchar2(200) not null,
    category varchar2(30) not null,
    beenzi_no number not null,
    status varchar2(200) not null, -- U(�븘吏곸쿂由ъ븞�맖) or E(泥섎━�셿猷�)
    content varchar2(1000),
    created_at date default sysdate,
    updated_at date,
    constraint pk_report_no primary key(report_no),
    constraint ck_report_category check(category in ('pheed','pheed_comment','dokoo','dokoo_comment'))
);

create sequence seq_report_no;
-- 21. 李쒗븯湲고뵾�뱶 �뀒�씠釉�
create table wishlist_pheed (
    pheed_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_pheed_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- 22. 李쒗븯湲곕룆�썑媛� �뀒�씠釉�
create table wishlist_dokoo (
    dokoo_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_dokoo_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- 23. 李쒗븯湲곕턿�겢�읇 �뀒�씠釉�
create table wishlist_club (
    club_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_club_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- 24. 醫뗭븘�슂�뵾�뱶 �뀒�씠釉�
create table likes_pheed (
    pheed_no number not null,
    member_id varchar2(200) not null,
    constraint fk_likes_pheed_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- 25. 醫뗭븘�슂�룆�썑媛� �뀒�씠釉�
create table likes_dokoo (
    dokoo_no number not null,
    member_id varchar2(200) not null,
    constraint fk_likes_dokoo_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- 26. 醫뗭븘�슂遺곹겢�읇 �뀒�씠釉�
create table likes_club (
    club_no number not null,
    member_id varchar2(200) not null,
    constraint fk_likes_club_member_id foreign key(member_id) references member(member_id) on delete set null
);

-- remeber-me table
create table persistent_logins (
    username varchar(64) not null, 
    series varchar(64) primary key, 
    token varchar(64) not null,  -- username, password, expire time�쓣 �떒諛⑺뼢 �븫�샇�솕�븳 媛�
    last_used timestamp not null);

-- �븣由쇳뀒�씠釉�
create table alarm(
    alarm_no number,
    member_id varchar2(50),
    alarm_content varchar2(1000),
    last_check number default 0,
    created_at date default sysdate,
    constraint pk_alarm primary key(alarm_no)
);
create sequence seq_alarm_no;

-- q&a table
create table qna(
    qna_no number,
    member_id varchar2(50),
    title varchar2(200),
    content varchar2(3000),
    enroll_date date,
    status char(1) default 'U', -- 泥섎━�쟾 U �셿猷� E
    constraint pk_qna_no primary key (qna_no)
);
alter table qna add status char(1) default 'U';
commit;
create sequence seq_qna_no;

-- q&a comment table
create table qna_comment(
    comment_no number not null,
    qna_no number not null,
    member_id varchar2(100) not null,
    comment_content varchar2(1000) not null,
    created_at date default sysdate not null,
    constraint pk_qna_comment_no primary key(comment_no)
);
create sequence seq_qna_comment_no;


create table point_status (
    point_no number,
    member_id varchar2(200) not null,
    content varchar2(1000),
    point number not null,
    total_point number,
    updated_at date default sysdate not null,
    imp_uid varchar2(50),
    status varchar2(1),
    constraint pk_point_status_no primary key(point_no),
    constraint fk_point_status_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint ck_point_status check (status in ('M', 'P'))
);
create sequence seq_point_no;

-- �듃由ш굅
SELECT a.osuser
               ,a.SID
               ,a.serial#
               ,a.status
               ,b.sql_text
  FROM v$session a
              ,v$sqlarea b
WHERE a.sql_address = b.address;
-- 트리거
select * from user_triggers;
drop trigger trigger_dokoo_comment;
drop trigger trigger_pheed_comment;
drop trigger trigger_chat_comment;
drop trigger trigger_club_chat;
drop trigger trigger_chat_log;
commit;

create trigger trigger_chat_comment 
    after 
    update on member 
    for each row 
begin 
    if updating then 
    update chat_comment set nickname = :new.nickname where nickname = :old.nickname;
    end if;
end;
/

create trigger trigger_dokoo_comment 
    after 
    update on member 
    for each row 
begin 
    if updating then 
    update dokoo_comment set nickname = :new.nickname where nickname = :old.nickname;
    end if;
end;
/

create trigger trigger_pheed_comment 
    after 
    update on member 
    for each row 
begin 
    if updating then 
    update pheed_comment set nickname = :new.nickname where nickname = :old.nickname;
    end if;
end;
/

create trigger trigger_club_chat
    after 
    update on member 
    for each row 
begin 
    if updating then 
    update club_chat set nickname = :new.nickname where nickname = :old.nickname;
    end if;
end;
/


create trigger trigger_chat_log 
    after 
    update on member 
    for each row 
begin 
    if updating then 
    update chat_log set nickname = :new.nickname where nickname = :old.nickname;
    end if;
end;
/

commit;
--==============================================
-- 議고쉶
--==============================================
-- �쟾泥� �뀒�씠釉� 紐⑸줉 議고쉶
select * from user_tables;
-- �쟾泥� 而щ읆 議고쉶
select * from user_tab_columns;

select * from user_sequences; -- �떆���뒪 議고쉶
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
select * from alarm;
select * from qna;
select * from qna_comment;

select * from persistent_logins;

SELECT 
    TABLE_NAME
    ,COLUMN_NAME    -- 而щ읆 紐�
    ,DATA_TYPE      -- �쑀�삎
    ,DATA_LENGTH    -- �뜲�씠�꽣 湲몄씠
    ,DATA_PRECISION -- NUMBER �쟾泥� �옄由우닔
    ,DATA_SCALE     -- NUMBER �냼�닔�젏�씠�븯 �몴�쁽 �옄由우닔
    ,NULLABLE       -- NULL �뿬遺�
    ,COLUMN_ID      -- 而щ읆 �닚�꽌
    ,DATA_DEFAULT   -- 湲곕낯 媛�   
FROM user_tab_columns; -- �빐�떦 怨꾩젙�뿉 �냽�븳 �뀒�씠釉� 
   --  dba_tab_columns �쟾泥� �뀒�씠釉붿쓽 寃쎌슦 
   


-------------------------
-- club <<���꽦>>
-------------------------

alter table mission modify content varchar2(4000);

select * from club;
select * from club_book;
select * from mission;
select * from my_club;
select * from member;
insert into authority values ('admin', 'ROLE_ADMIN');
select * from authority;
insert into my_club values ('25', 'honggd', 5000);
insert into my_club values ('25', 'sinsa', 5000);
insert into my_club values ('23', 'sinsa', 5000);
select * from book_ing;
select * from qna;
delete from qna where qna_no = 41;
alter table club_book add IMG_SRC varchar2(4000);
alter table mission add item_id varchar2(30);
ALTER TABLE mission RENAME COLUMN m_end_Date TO m_endDate;
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

select count(*) from likes_club where club_no = 26;
            
select
    c.*,
    b.*,
    (select count(*) from my_club where club_no = c.club_no) current_nop,
    (select count(*) from likes_club where club_no = c.club_no) likes_Cnt
from
    club c join club_book b on c.club_no = b.club_no
order by
    recruit_start desc;
    
select * from club order by recruit_start desc;

select * from club;
select * from mission where club_no = 58;

delete from club where club_no = 43;

insert into wishlist_club values ('51', 'tmddbs');
insert into wishlist_club values ('53', 'tmddbs');
insert into wishlist_club values ('55', 'tmddbs');
insert into wishlist_club values ('56', 'tmddbs');

select * from my_club;
select * from member;
select point from member where member_id = 'tmddbs';

select * from authority;
update member set point = 30000 where member_id = 'tmddbs';

select * from club_chat;
select * from chat_attachment;
select * from chat_comment;
delete from club_chat where chat_no = 7;

update club_chat set title = '�젣紐⑹젣紐⑹젣紐�', content = '�븯�씠�븯�씠' where chat_no = 1;

update club_chat set enroll_date = (sysdate - 4) where chat_no = 1;
update club_chat set enroll_date = (sysdate - 3) where chat_no = 4;
update club_chat set enroll_date = (sysdate - 2) where chat_no = 5;
update club_chat set enroll_date = (sysdate - 1) where chat_no = 6;

select * from club_chat order by enroll_date desc;

delete from club_chat where chat_no in (13, 12, 11, 10);

select * from club where recruit_end > sysdate order by recruit_end;select
    c.*,
    b.*,
    (select count(*) from my_club where club_no = c.club_no) current_nop,
    (select count(*) from likes_club where club_no = c.club_no) likes_Cnt
from
    club c join club_book b on c.club_no = b.club_no
order by
    recruit_start desc;
    
select * from club order by recruit_start desc;

select * from club;
select * from mission where club_no = 58;

delete from club where club_no = 43;

insert into wishlist_club values ('51', 'tmddbs');
insert into wishlist_club values ('53', 'tmddbs');
insert into wishlist_club values ('55', 'tmddbs');
insert into wishlist_club values ('56', 'tmddbs');

select * from my_club;
select * from book where status = '읽음';
select point from member where member_id = 'tmddbs';

select * from authority;
update member set point = 30000 where member_id = 'tmddbs';

select * from my_club;
select * from member;

select * from club_chat;
select * from chat_attachment;
select * from chat_comment;
delete from club_chat where chat_no = 7;

update club_chat set title = '�젣紐⑹젣紐⑹젣紐�', content = '�븯�씠�븯�씠' where chat_no = 1;

update club_chat set enroll_date = (sysdate - 4) where chat_no = 1;
update club_chat set enroll_date = (sysdate - 3) where chat_no = 4;
update club_chat set enroll_date = (sysdate - 2) where chat_no = 5;
update club_chat set enroll_date = (sysdate - 1) where chat_no = 6;

select * from club_chat order by enroll_date desc;

select * from member;

select * from club where recruit_end > sysdate order by recruit_end;       
select * from point_status order by updated_at desc;
select * from member;


select
    cc.*,
    ca.*,
    m.*,
    m.renamed_filename profilePic,
    ca.chat_no ca_chat_no
from
    club_chat cc 
        left join chat_attachment ca on cc.chat_no = ca.chat_no 
        left join member m on cc.nickname = m.nickname 
where
    cc.chat_no = 23;
    
    select * from club_chat;
---------------------------------
-- book <<��誘�>>
---------------------------------

select 
    b.*,
    i.started_at started_at,
    i.ended_at ended_at
from 
    book b right join (select * from book_ing order by add_date desc) i
        on b.member_id = i.member_id
where b.member_id = 'tmddbs' and b.item_id = '9788932474755' ;


select 
    m.*,
    i.interest
from 
    member m join interest i
        on m.member_id = i.member_id
where
    interest like '%�뼵�뼱%';

-- 1~3
select * 
from 
    (select row_number() over (order by enroll_date desc) rnum, p.* 
    from pheed p where is_opened = 'O')
where
    rnum between 1 and 3;
select
    *
from(
    select 
        row_number () over(order by no desc) rnum,
        b.*
    from
        board b)
where
    rnum between 11 and 15;

select 
    m.*,
    i.interest
from 
    member m join interest i
        on m.member_id = i.member_id
where
    m.member_id = 'honggd';
    
    
select 
    m.*,
    (select interest from interest where member_id = 'honggd') interest
from 
    member m
where
    m.member_id = 'honggd';
    
select 
    ph.*,
    (select count(*) from likes_pheed where pheed_no = ph.pheed_no) likes_cnt 
from 
    (select row_number() over (order by enroll_date desc) rnum, p.* from pheed p where is_opened = 'O' or is_opened = 'F') ph
where
    (rnum between 1 and 3)
    and
    member_id in (select following_member_id from follower where member_id = 'honggd');
    
select following_member_id from follower where member_id = 'tmddbs';
  
update member set point = 20010 where member_id = 'tmddbs';
select count(*) from club_chat where club_no = 45;

insert into point_status values(seq_point_no.nextval, 'tmddbs', '�룷�씤�듃 異⑹쟾', 1000, 16030, sysdate-20, null, 'P');
insert into point_status values(seq_point_no.nextval, 'tmddbs', '遺곹겢�읇 �뵒�뙆吏� 李④컧', 10000, 6030, sysdate-22, null, 'M');
insert into point_status values(seq_point_no.nextval, 'tmddbs', '遺곹겢�읇 �뵒�뙆吏� 李④컧', 5000, 1030, sysdate-40, null, 'M');
insert into point_status values(seq_point_no.nextval, 'tmddbs', '�룷�씤�듃 異⑹쟾', 30000, 31030, sysdate-49, null, 'P');

select last_day(sysdate) from dual;

SELECT
    *
FROM 
    point_status
WHERE  
    member_id = 'tmddbs' and
    SUBSTR(updated_at, 0, 8) BETWEEN (TO_CHAR(TRUNC(SYSDATE,'MM'),'YY/MM/DD') ) AND (LAST_DAY(SYSDATE))
order by 
    updated_at desc;
    
select 
    * 
from 
    point_status 
where 
    member_id = 'tmddbs'
    AND 
    to_char(updated_at, 'yymmdd') >= '22/08/01'
    AND 
    to_char(updated_at, 'yymmdd') <= '22/08/05'
order by 
    updated_at desc;
    
select 
    * 
from 
    point_status 
where 
   updated_at >= to_date('22/08/01', 'yy/mm/dd')
   and updated_at <= to_date('22/08/06', 'yy/mm/dd');

        
select 
    * 
from 
    (select 
        row_number() over(order by enroll_date desc) rnum , 
        cc.* 
    from 
        club_chat cc 
    where club_no = 45) 
where rnum between 1 and 10;

select * from interest;
select 
    m.*,
    i.interest
from 
    member m join interest i
        on m.member_id = i.member_id
where
    interest like '%�뼵�뼱%' and m.member_id != 'honggd';
    
    
select 
    m.*,
    (select interest from interest where interest like '%�뼵�뼱%' and member_id != 'honggd') interest
from 
    member m ;

insert into my_club values (45, 'honggd', 10000);
update member set point = 10000 where member_id = 'honggd';

select
    c.*,
    b.*,
    b.club_no bclub_no,
    (select count(*) from my_club where club_no = 45) current_nop,
    (select count(*) from likes_club where club_no = 45) likes_Cnt
from
    club c
         join club_book b on c.club_no = b.club_no
         join my_club m on c.club_no = m.club_no
where 
    c.club_no = 45;
    
select
    mc.*,
    m.*,
    mc.member_id mcMember_id
from 
    my_club mc 
        left join member m on mc.member_id = m.member_id
where 
    mc.club_no = 45;
    
    
select * from club_book;

select 
    *
from
    mission
where 
    club_no = 49;
    
    select
 c.*,
 b.*,
 b.club_no bclub_no,
  (select count(*) from my_club where club_no = 45) current_nop,
  (select count(*) from likes_club where club_no = 45) likes_Cnt
from
  club c
      join club_book b on c.club_no = b.club_no
where 
 c.club_no = 45;
 
select
    m.*,
    ms.*,
    (select img_src from club_book c where c.club_no = 45 and m.m_item_id = c.item_id) img_src
from 
    mission m 
        left join mission_status ms on m.mission_no = ms.mission_no
where 
    (member_id = 'tmddbs' or member_id is null) and m.club_no = 45
order by m_endDate;
select * from club_book where club_no = 45;

select
    m.*,
    ms.*,
    ms.mission_no mNo,
    (select img_src from club_book c where c.club_no = 45 and m.m_item_id = c.item_id) img_src
from 
    mission m 
        left join mission_status ms on m.mission_no = ms.mission_no
where 
    (member_id = 'tmddbs' or member_id is null) and m.club_no = 45
order by 
    m_endDate;

         
update club_book set book_title = '寃쎌젣��留덉솗 諛섎뱶�떆 遺��옄�릺�뒗 �닾�옄�쓽 �냼�떊' where club_no = 45 and item_id = '9788957822074';
update club_book set book_title = '遺��옄�쓽 �룆�꽌踰�' where club_no = 45 and item_id = '9791187444770';
update club_book set book_title = '�썡湲됱웳�씠 遺��옄濡� ���눜�븯�씪' where club_no = 45 and item_id = '9788925578156';

select * from mission_status;

select * from mission where club_no = 45;
update mission_status set status = 'A' where mission_no = 37 and member_id = 'tmddbs';
update mission_status set status = 'I' where mission_no = 38 and member_id = 'tmddbs';

delete mission_status where member_id = 'tmddbs';


select  
    m.*,
    (select img_src from club_book c where c.club_no = 45 and m.m_item_id = c.item_id) img_src
from 
    mission m 
where 
    m.club_no = 45;

select * from mission where club_no = 45;
select * from mission_status;
update mission_status set renamed_filename = '20220809_005528072_481.jpg' where mission_no = 37 and member_id = 'tmddbs';
update mission_status set status = 'A' where mission_no = 37 and member_id = 'tmddbs';
delete from mission_status where member_id = 'tmddbs';

select 
    *
from 
    pheed p left join pheed_attachment a 
        on p.pheed_no = a.pheed_no  
        left join member m
        on p.member_id = m.member_id
where 
    p.pheed_no = 37;

select
    *
from
    qna q left join qna_comment c
        on q.qna_no = c.qna_no
where
    q.qna_no = 1;

select 
    ms.*,
    m.*,
    (select img_src from club_book c where c.club_no = m.club_no and m.m_item_id = c.item_id) img_src,
    (select title from club cc where cc.club_no = m.club_no) club_title
from 
    mission_status ms
        left join mission m on ms.mission_no = m.mission_no
where 
    status = 'I';
    
    
update mission_status set status='I' where mission_no = 38 and member_id = 'honggd';


select * 
from 
    (select 
        row_number() over (order by enroll_date desc) rnum, 
        p.* 
    from pheed p where is_opened = 'O')
where
    rnum between 1 and 3;
    
select 
     *
from 
    (select
        row_number() over (order by updated_at) rnum, 
        ms.*,
        m.m_title,
        m.m_content,
        m.point,
        m.m_endDate,
        (select img_src from club_book c where c.club_no = m.club_no and m.m_item_id = c.item_id) img_src,
        (select title from club cc where cc.club_no = m.club_no) club_title
    from 
        mission_status ms
            left join mission m on ms.mission_no = m.mission_no
    where 
        ms.status = 'I')
where
    rnum between 1 and 2;
    
select * from mission_status order by updated_at;
update mission_status set status = 'I' where member_id in ('tmddbs', 'honggd'); 


select
    *
from (
    select
        row_number() over (order by recruit_end) rnum,
        c.*,
        (select count(*) from my_club where club_no = c.club_no) current_nop,
        (select count(*) from likes_club where club_no = c.club_no) likes_Cnt
    from
        club c
    where
        recruit_end > sysdate)
where rnum between 1 and 8;

select * from club;

commit;

select
    trunc(sysdate - club_start)+1,
    trunc(club_end - sysdate)+1
from 
    club 
where club_no = 45;

select * from club where club_no = 45;
select * from club_book where club_no = 45;
select * from club_chat where club_no = 45;
select * from mission where club_no = 45;
select * from my_club where club_no = 45;

select
    c.deposit,
    c.title,
    c.content,
    trunc(sysdate - c.club_start)+1 d_start,
    trunc(c.club_end - sysdate)+1 d_end,
    (select count(*) from mission where club_no = 45) total_mission,
    cb.img_src,
    cb.item_id,
    m.member_id,
    m.renamed_filename,
    m.nickname
from 
    club c 
        left join club_book cb on c.club_no = cb.club_no
        left join my_club mc on c.club_no = mc.club_no
        left join member m on mc.member_id = m.member_id
where c.club_no = 45;

select 
    *
from 
    club_chat
where 
    club_no = 45;

-- 1~3
select 
    * 
from 
    (select row_number() over (order by enroll_date desc) rnum,
    cc.chat_no,
    cc.nickname,
    cc.title,
    cc.enroll_date
    from club_chat cc where club_no = 45)
where
    rnum between 1 and 5;

select
	    c.deposit,
	    c.title,
	    c.content,
	    trunc(sysdate - c.club_start)+1 d_start,
	    trunc(c.club_end - sysdate)+1 d_end,
	    (select count(*) from mission where club_no = 45) total_mission,
	    cb.img_src,
	    cb.item_id,
	    cb.club_no bclub_no
	from 
	    club c 
	        left join club_book cb on c.club_no = cb.club_no
	where
		c.club_no = 45;
        
        
select * from chat_attachment;

select
	    c.deposit,
	    c.title,
	    c.content,
	    trunc(sysdate - c.club_start)+1 d_start,
	    trunc(c.club_end - sysdate)+1 d_end,
	    (select count(*) from mission where club_no = 45) total_mission
	from 
	    club c 
	where
		c.club_no =45;

select * from club;

update club set club_end = sysdate - 3 where club_no = 50;
update club set club_end = sysdate - 2 where club_no = 53;
update club set club_end = sysdate - 1 where club_no = 59;

select * from point_status;
select * from my_club;
select * from mission;
select * from mission_status;
select * from mission where club_no = 55;
update mission_status set club_no = 45 where mission_no in (37, 38, 39, 40);
commit;
select count(*) from mission_status where club_no = 55 and member_id = 'tmddbs' and status = 'P';

select * from point_status;

delete from point_status where point_no = 22;
update my_club set club_status = 'I' where club_no = 55 and member_id = 'tmddbs';
commit;

select * from chat_member;

create table chat_member (
    chatroom_id varchar2(50),
    member_id varchar2(50),
    last_check number default 0,
    created_at date default sysdate,
    deleted_at date,
    constraint pk_chat_member primary key(chatroom_id, member_id),
    constraint fk_chat_member_club_no foreign key(club_no) references club(club_no) on delete cascade,
    constraint fk_chat_member_id foreign key(member_id) references member(member_id) on delete cascade
);
alter table chat_member add club_no number;
alter table chat_member add constraint fk_chat_member_club_no foreign key(club_no) references club(club_no) on delete cascade;
alter table chat_member add constraint fk_chat_member_id foreign key(member_id) references member(member_id) on delete cascade;
commit;

create table chat_log (
    no number,
    chatroom_id varchar2(50),
    member_id varchar2(50),
    msg varchar2(4000),
    time number,
    nickname varchar2(100),
    renamed_filename varchar2(256),
    constraint pk_chat_log_no primary key(no),
    constraint fk_chat_log foreign key(chatroom_id, member_id) references chat_member(chatroom_id, member_id)
);
create sequence seq_chat_log_no;
alter table chat_member add constraint fk_chat_log_member_id foreign key(member_id) references member(member_id) on delete cascade;
alter table chat_member add constraint fk_chat_log_chatroom_id foreign key(chatroom_id, member_id) references chat_member(chatroom_id, member_id) on delete cascade;

select * from chat_member;
select * from chat_log;
delete from chat_log where member_id = 'tmddbs';
alter table chat_log add nickname varchar2(100);
alter table chat_log add renamed_filename varchar2(256);
commit;

select * from point_status;
update point_status set updated_at = sysdate - 80 where point_no = 3;

select 
    		ph.*,
    		(select count(*) from likes_pheed where pheed_no = ph.pheed_no) likes_cnt 
		from 
    		(select row_number() over (order by enroll_date desc) rnum, p.* from pheed p) ph
        where member_id = 'tmddbs';
        
        
select
        tb.*,
        m.*
    from
         (select 
                row_number() over(order by enroll_date desc) rnum, 
                d.* 
            from 
                dokoo d
            where member_id = 'tmddbs') tb 
                left join member m on tb.member_id = m.member_id
    where 
        rnum between 1 and 2
    order by
        tb.enroll_date desc;
        
        select * from club where club_no = 121;
        
    select * from likes_club;
    select * from wishlist_club;

select * from member;
select * from interest;
--delete from member where member_id = 'tester2';

commit;

select
        tb.*,
        m.*
    from
         (select 
            row_number() over(order by enroll_date desc) rnum,
            d.* 
                from dokoo d 
                    inner join wishlist_dokoo wd on d.dokoo_no = wd.dokoo_no where d.member_id = 'tmddbs') tb 
                        left join member m on tb.member_id = m.member_id
    where 
        rnum between 1 and 10
    order by
        tb.enroll_date desc;

select * from dokoo where member_id = 'tmddbs';
select row_number() over(order by enroll_date desc) rnum, d.* from dokoo d inner join wishlist_dokoo wd on d.member_id = wd.member_id where member_id = 'tmddbs';
select * from wishlist_dokoo where member_id = 'tmddbs';
select * from wishlist_pheed where member_id = 'tmddbs';
select * from wishlist_club where member_id = 'tmddbs';

select d.* from dokoo d inner join wishlist_dokoo wd on d.dokoo_no = wd.dokoo_no where d.member_id = 'tmddbs';
select row_number() over(order by enroll_date desc) rnum, d.* from dokoo d inner join wishlist_dokoo wd on d.dokoo_no = wd.dokoo_no where d.member_id = 'tmddbs';
    

update member set renamed_filename = 'dada', original_filename = 'asdwqad' where nickname = '스으응유은';

select 
    ph.*,
    (select count(*) from likes_pheed where pheed_no = ph.pheed_no) likes_cnt 
from 
    (select row_number() over (order by enroll_date desc) rnum, p.* from pheed p) ph
where
    (rnum between 1 and 10) and member_id = 'tmddbs';

select * from wishlist_dokoo where member_id = 'tmddbs';
select * from pheed;
select * from wishlist_pheed where member_id = 'tmddbs';
delete from wishlist_pheed where pheed_no = 32;
select * from wishlist_club where member_id = 'tmddbs';
commit;
 select
        ph.*,
        (select count(*) from likes_pheed where pheed_no = ph.pheed_no) likes_cnt 
 from
 (select  row_number() over (order by enroll_date desc) rnum, p.* from pheed p left join wishlist_pheed wp on p.member_id = wp.member_id) ph
 where 
        member_id = 'tmddbs';

select * from wishlist_club where member_id = 'tmddbs';

    select
        *
    from (
        select
            row_number() over (order by c.club_start desc) rnum,
            c.*,
            (select count(*) from wishlist_club where club_no = c.club_no) current_nop,
            (select count(*) from likes_club where club_no = c.club_no) likes_Cnt
        from
            club c 
                left join wishlist_club mc on c.club_no = mc.club_no         
        where
            member_id = 'tmddbs';)
         where rnum between 1 and 10;


 select
            row_number() over (order by c.club_start desc) rnum,
            c.*,
            (select count(*) from wishlist_club where club_no = c.club_no) current_nop,
            (select count(*) from likes_club where club_no = c.club_no) likes_Cnt
        from
            club c 
                left join wishlist_club mc on c.club_no = mc.club_no         
        where
            member_id = 'tmddbs';

select * from my_club where club_no = 121;
insert into my_club values(121, 'hosi', 5000, sysdate+12, 2, 'I');

commit;

select * from chat_member;
delete from chat_member where club_no = 121;

update member set renamed_filename = '20220821_135752473_746.jpg' where member_id = 'hosi';
update member set original_filename = 'hosi3.jpg' where member_id = 'hosi';
select * from member where member_id = 'hosi';

update member set email = 'jyjmjs2@naver.com' where member_id = 'hosi';
delete from point_status where member_id = 'hosi';
select * from member where member_id = 'hosi';
select * from club where club_no = 121;
commit;

select * from member;

select * from my_club;

insert into my_club values ('121', 'tester', 5000, sysdate+12, 2, 'I');
insert into my_club values ('121', 'honggd', 5000, sysdate+12, 2, 'I');

delete from my_club where member_id = 'bookie';

select * from point_status where member_id = 'hosi';
delete from point_status where imp_uid = 'imp_552130168255';
commit;
update member set point = 1000 where member_id = 'hosi';

commit;
delete from chat_member where club_no = 121;
delete from chat_log where chatroom_id = 'chatRoom121';

select * from chat_log;

delete from chat_log where no between 82 and 83;
commit;
select * from book_ing;
select * from mission where club_no = 121;
update mission set m_title = '감명깊은 구절 올리기' where mission_no = 122;
commit;

select * from mission_status;
delete from mission_status where mission_no = 122;


update club set club_end = sysdate - 1 where club_no = 121;
commit;

select * from my_club;
update my_club set club_end = sysdate - 1 where club_no = 121 and member_id = 'hosi';

update member set point = 6000 where member_id = 'hosi';

select * from alarm;
delete from alarm where member_id = 'hosi';
commit;

select * from book where member_id = 'test1';
select * from book_ing where member_id = 'test1';

select * from member;

select * from book where member_id = 'devcami';
select * from book_ing where member_id = 'devcami';


select * from my_club;
select * from mission_status;

select * from club;
update club set title='그냥 관리자 취향 책들입니다.', recruit_start = sysdate-7 where club_no = 101;
commit;

delete from club where club_no = 161;
select * from point_status where member_id = 'tmddbs';
delete from point_status where member_id = 'tmddbs';

select
    max(ing_no) ing_no
from
    book_ing
where
    member_id = 'devcami' and item_id = '9791163030195';
