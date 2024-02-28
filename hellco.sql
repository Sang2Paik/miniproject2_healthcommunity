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


create table user
(
	user_idx 			int primary key auto_increment,
	user_name 			varchar(100) not null,
	user_id				varchar(200) unique,
	user_pwd			varchar(200) not null,
	user_age			int not null,
	user_email			varchar(200) not null,
	user_gender			varchar(100) not null,
	user_height			double,
	user_kg				double,
	user_target			double,
	user_grade			varchar(100) not null,
	user_created_date 	datetime default now(),	
	user_modified_date	datetime default now(),
	user_ip				varchar(200) not null
)


insert into user values(null, '홍길동', 'hong123', 'hong123', 'hong123@gmail.com', '192.168.0.49', now(), now(),
					'user_user', 20, 'M', 100, 180, 85) 
					
create or replace view user_view 
as
select 
*, format(user_kg/((user_height/100)*(user_height/100)),2) as user_BMI				
from user

select * from user_view

create table category
(
	c_idx			int primary key auto_increment,
	c_name			varchar(200)
)

insert into category values (null, "workout");
insert into category values (null, "food");

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
	user_id			varchar(200),
	user_name		varchar(200)
)


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

insert into meal_type values(null, '아침');																																																																																														
insert into meal_type values(null, '점심');																																																																																														
insert into meal_type values(null, '저녁');																																																																																														
insert into meal_type values(null, '오전간식');																																																																																														
insert into meal_type values(null, '오후간식');																																																																																														
insert into meal_type values(null, '저녁간식');																																																																																														

select * from meal_type

create table food_kcal
(
	f_idx		int primary key auto_increment,
	f_no		int,
	f_name		varchar(200) not null,
	f_eattime	datetime default now(),
	m_idx		int,
	m_name		varchar(200),
	f_regdate	datetime default now(),
	f_unit_g	int,
	f_unit_kcal	double,
	f_csum_g	double,
	user_idx	int,
	f_maker		varchar(500)
)

desc food_kcal

drop table food_kcal

alter table food_kcal
		add constraint fk_food_kcal_m_idx foreign key(m_idx)
									references meal_type(m_idx);

alter table food_kcal
		add constraint fk_food_kcal_user_idx foreign key(user_idx)
											references user(user_idx);

insert into food_kcal values(null, '슈프림피자,냉동', now(), 2, 'lunch', now(), 100, 233.00, 170, 1)


create or replace view user_view 
as
select 
*, format(user_kg/((user_height/100)*(user_height/100)),2) as user_BMI				
from user

select * from user_view


create or replace view food_kcal_view
as
select 
*,
(f_unit_kcal/f_unit_g)*f_csum_g as f_csum_kcal 
from food_kcal

select * from food_kcal_view where f_name like concat('%','슈프림','%')

select ifnull(max(f_idx),0)+1 from food_kcal

select * from food_kcal where f_name='슈퍼슈프림피자,냉동' and f_unit_kcal=233.0 and f_maker=''

select * from food_kcal_view

select * from food_kcal

select ifnull(sum(f_csum_kcal),0) as f_total_kcal from food_kcal_view 
	where user_idx=1 and date_format(f_eattime, '%Y-%m-%d') as f_eat_data=curdate();

select ifnull(format(sum(f_csum_kcal),2),0) as f_total_kcal,
	   date_format(f_eattime, '%Y-%m-%d') as f_eat_date
	from food_kcal_view 
	where user_idx=1
	group by date_format(f_eattime, '%Y-%m-%d')
	

select ifnull(format(sum(f_csum_kcal),2),0) as f_total_kcal,
	   date_format(f_eattime, '%Y-%m-%d') as f_eat_date
from food_kcal_view 
group by
user_idx, 
date_format(f_eattime, '%Y-%m-%d')
order by 
date_format(f_eattime, '%Y-%m-%d')

select date_format(f_eattime, '%Y-%m-%d') as f_eat_date, 
m_name, sum(f_csum_kcal) as f_total_kcal, user_idx 
from food_kcal_view 
where user_idx=1
group by m_name, 
date_format(f_eattime, '%Y-%m-%d')
order by
date_format(f_eattime, '%Y-%m-%d') 

select * from food_kcal_view
*/
