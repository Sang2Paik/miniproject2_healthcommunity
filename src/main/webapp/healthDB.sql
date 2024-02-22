/*


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
		 user_height		 double 	  not null,
		 user_kg			 double 	  not null,
		 user_target		 double		  not null,
		 user_grade          varchar(100) not null,
		 user_created_date   datetime default now(),
		 user_modified_date  datetime default now(),
		 user_ip			 varchar(100) default null
	)
	
select * from user
	
insert into user values(null, 'c_test', 'a', 'a', 23, 'a@a.com', 'man', 25.5, 155.7, 68.8,'user_admin', now(), now()+10000, '1.1.1.1' )

-- 외래키 [table]의 yy는 xx  yy table의 yy를 참조한다 ( []는 제거 ()는 안에 작성)
alter table [table명] add constraint [설정할제목] foreign key(yy) references [yytable](yy);
	








*/