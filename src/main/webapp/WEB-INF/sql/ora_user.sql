create table s_board (
   bno number(10,0) generated as identity,
   title varchar2(200) not null,
   content varchar2(2000) not null,
   writer varchar2(50) not null,
   regdate date default sysdate,
   updatedate date default sysdate
);

create table tbl_reply (
  rno number(10,0) GENERATED AS IDENTITY,
  bno number(10,0) not null, 
  reply varchar2(1000) not null,
  replyer varchar2(50) not null,
  replyDate date default sysdate, 
  updateDate date default sysdate
);

create table tbl_board (
bno number(10,0) generated as identity,
title varchar2(200) not null,
content varchar2(2000) not null,
writer varchar2(50) not null,
regdate date default sysdate,
updatedate date default sysdate
);
alter table s_board add constraint pk_board primary key(bno);

create table tbl_attach (
   uuid varchar2(100) not null,
   uploadPath varchar2(200) not null,
   fileName varchar2(100) not null,
   fileType char(1) default 'I',
   bno number(10,0)
);

alter table tbl_attach add constraint pk_attach primary key (uuid);
alter table tbl_attach add constraint s_board_attach foreign key (bno) references tbl_board (bno);

create table users (
    username varchar2(50) not null primary key,
    password varchar2(50) not null,
    enabled char(1) default '1'
);

create table authorities (
    username varchar2(50) not null,
    authority varchar2(50) not null,
    constraint fk_authorities_users foreign key(username) references users(username)
);

create unique index ix_auth_username on authorities (username, authority);

create table tbl_member (
   userid varchar2(50) not null primary key,
   userpw varchar2(100) not null,
   username varchar2(100) not null,
   regdate date default sysdate,
   updatedate date default sysdate,
   enabled char(1) default '1'
);

create table tbl_member_auth (
   userid varchar2(50) not null,
   auth varchar2(50) not null,
   constraint fk_member_auth foreign key(userid) references tbl_member(userid)
);

create table persistent_logins (
   username varchar2(64) not null,   -- userid
   series varchar2(64) primary key,
   token varchar2(64) not null,      -- cookie 값
   last_used timestamp not null   -- 최종 로그인 시간
);

create table board_like(
    likeno number not null primary key,
    bno number,
    userid varchar2(50) not null, 
    likecheck number default 0 not null,
    foreign key(userid) references tbl_member(userid) on delete cascade,
    foreign key(bno) references s_board(bno) on delete cascade
);

alter table s_board add(likehit number default 0);

commit;
