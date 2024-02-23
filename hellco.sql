/*
 
drop table seller
drop table menu
drop table coupon
drop table user
drop table cart
drop table product
drop table category
drop table comment
drop table board


drop table user

create table user 
(
	 user_idx  			 int primary key not null auto_increment,
	 user_name  	 	 varchar(100) not null,
	 user_id    		 varchar(100) unique not null,
	 user_pwd   	 	 varchar(100) not null,
	 user_age		 	 int		  not null,
	 user_email	         varchar(100) not null,
	 user_gender		 varchar(100) not null,
	 user_height		 double,
	 user_kg			 double,
	 user_target		 double,
	 user_grade          varchar(100) not null,
	 user_created_date   datetime default now(),
	 user_modified_date  datetime default now(),
	 user_ip			 varchar(100) default null
)

insert into user values(null, 'c_test', 'a', 'a', 23, 'a@a.com', 'man', 25.5, 155.7, 68.8,'user_admin', now(), now()+10000, '1.1.1.1' )

drop table category

drop table product

drop table cart

create table category
(
	c_idx			int primary key auto_increment,
	c_name			varchar(200)
)


insert into category values (null, "workout");
insert into category values (null, "food");

select c_idx from category where c_name='food'

select * from category order by c_idx desc

create table board
(
	b_idx 			int primary key auto_increment,
	b_subject		varchar(200) not null,
	c_idx			int,
	c_name			varchar(200),
	b_content		text,
	b_photo			varchar(200),
	b_ip			varchar(200),
	b_regdate		datetime default now(),
	b_modify_date	datetime default now(),
	b_readhit		int,
	b_like			int,
	b_open			varchar(50) default "Y",
	user_idx		int,
	user_id			varchar(200),
	user_name		varchar(100)
)

drop table board

drop table comment

select * from board

INSERT INTO board (b_subject, c_idx, c_name, b_content, b_photo, b_ip, b_readhit, b_like, user_idx, user_id, user_name)
VALUES ('제목 예시', 1, '카테고리명', '내용 예시', '이미지파일명.jpg', '127.0.0.1', 0, 0, 1, '사용자ID', '사용자이름');


alter table board
		add constraint fk_category_idx foreign key(c_idx)
										references category(c_idx);
alter table board
		add constraint fk_user_idx	foreign key(user_idx)
										references user(user_idx);									
alter table board
		add constraint fk_user_id	foreign key(user_id)
										references user(user_id);										

create table comment
(
	cmt_idx 		int primary key auto_increment,
	cmt_content 	text not null,
	cmt_ip			varchar(200),
	cmt_regdate		datetime default now(),
	b_idx			int,
	user_idx		int,
	user_id			varchar(200)
)

select * from comment

drop table comment

alter table comment 
		add constraint fk_board_idx foreign key(b_idx)
									references board(b_idx);
									
alter table comment 
		add constraint fk_board_user_idx foreign key(user_idx)
										references user(user_idx);	

alter table comment 
		add constraint fk_board_user_id foreign key(user_id)
										references user(user_id);											


create table workout_kcal
(
	w_idx 		int primary key auto_increment,
	w_name		varchar(100) not null,
	w_regdate	datetime	default now(),
	w_time		int,
	w_unit_kcal	double,
	user_idx	int
)																								
																																																																								
alter table workout_kcal
		add constraint fk_workout_kcal_user_idx foreign key(user_idx)
										references user(user_idx);																																																

create table meal_type
(
	m_idx 		int primary key auto_increment,
	m_name 		varchar(200)
)

insert into meal_type values(null, 'breakfast');																																																																																														
insert into meal_type values(null, 'lunch');																																																																																														
insert into meal_type values(null, 'dinner');																																																																																														
insert into meal_type values(null, 'morning_snack');																																																																																														
insert into meal_type values(null, 'afternoon_snack');																																																																																														
insert into meal_type values(null, 'night_snack');																																																																																														

create table food_kcal
(
	f_idx		int primary key auto_increment,
	f_name		varchar(200) not null,
	f_type		varchar(200),
	m_idx		int,
	m_name		varchar(200),
	f_regdate	datetime default now(),
	f_unit_g	int,
	f_unit_kcal	double,
	f_csum_g	double not null,
	user_idx	int
)

alter table food_kcal
		add constraint fk_food_kcal_m_idx foreign key(m_idx)
									references meal_type(m_idx);

alter table food_kcal
		add constraint fk_food_kcal_user_idx foreign key(user_idx)
											references user(user_idx);

*/