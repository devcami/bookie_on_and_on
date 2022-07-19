--==============================================
-- TABLE (26개)
--==============================================

-- 1. member
create table member (
    member_id varchar2(200),
    password varchar2(300) not null,
    enroll_date date default sysdate not null,
    nickname varchar2(100) not null,
    phone char(11) not null,
    gender char(1) not null,
    enabled number default 1 not null,
    birthday date,
    job varchar2(100),
    introduce varchar2(1000),
    renamed_filename varchar2(256),
    original_filename varchar2(256),
    sns varchar2(1000),
    point number default 0,
    constraint pk_member_id primary key(member_id),
    constraint uq_member_nickname unique,
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
    constraint pk_interest primary key(member_id),
    constraint fk_interest_member_id foreign key(member_id) references member(member_id) on delete cascade
);

-- 4. follower
create table follower(
    member_id varchar2(200),
    following_member_id varchar2(200),
    constraint pk_follower primary key(member_id, following_member_id),
    constraint fk_interest_follower_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint fk_interest_member_id foreign key(member_id) references member(member_id) on delete cascade
);

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
    content varchar2(5000) not null,
    constraint pk_dokoo_no primary key(dokoo_no),
    constraint fk_dokoo_member_id foreign key(member_id) references book(member_id) on delete cascade
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
    description varchar2(500) not null,
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







-- 19. 채팅코멘트 테이블
create table chat_comment(
    comment_no number not null,
    chat_no number not null,
    nickname varchar2(100) not null,
    comment_ref number,
    created_at date default sysdate not null,
    constraint pk_chat_comment_comment_no primary key(comment_no) 
);

create sequence seq_comment_no;

-- 20. 신고테이블
create table report (
    report_no number not null,
    member_id varchar2(200) not null,
    category varchar2(30) not null,
    no number not null,
    status varchar2(200) not null,
    constraint pk_report_report_no primary key(report_no),
    constraint ck_report_category check(enabled in ('pheed','pheed_comment','dokoo','dokoo_comment'))
);

create sequence seq_report_no;

-- 21. 찜하기피드 테이블
create wishlist_pheed (
    pheed_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_pheed_member_id foreign key(member_id) references member(member_id)
);

-- 22. 찜하기독후감 테이블
create wishlist_dokoo (
    dokoo_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_dokoo_member_id foreign key(member_id) references member(member_id)
);

-- 23. 찜하기북클럽 테이블
create wishlist_club (
    club_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_club_member_id foreign key(member_id) references member(member_id)
);

-- 24. 좋아요피드 테이블
create likes_pheed (
    pheed_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_pheed_member_id foreign key(member_id) references member(member_id)
);

-- 25. 좋아요독후감 테이블
create likes_dokoo (
    dokoo_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_dokoo_member_id foreign key(member_id) references member(member_id)
);

-- 26.좋아요북클럽 테이블
create likes_club (
    club_no number not null,
    member_id varchar2(200) not null,
    constraint fk_wishlist_club_member_id foreign key(member_id) references member(member_id)
);

--==============================================




