<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="workout">

	<!-- 내 운동 조회 -->
	<select id="my_workout_list" parameterType="vo.WorkoutVo" resultType="vo.WorkoutVo">

		select * from
		(
			select
				*, 
				substring(w_regdate,1,10) as regdate from workout_kcal
		) w
		where user_idx= #{user_idx} order by regdate desc, w_idx desc 
	</select>
	
	<!-- 날짜별 운동 조회 -->
	<select id="my_workout_list_date" parameterType="vo.WorkoutVo" resultType="vo.WorkoutVo">
	
		select * from
		(
			select
				*, substring(w_regdate,1,10) as regdate from workout_kcal 
		) w
		<trim prefix="where" prefixOverrides="or" >
			<if test = "w_regdate !=null">
				user_idx=#{ user_idx } and regdate = #{ w_regdate }
			</if>
		</trim>
		order by w_idx desc

	</select>
	
	<!-- 전체 운동 조회, 칼로리 계산 -->
	<select id="my_workout_list_cal" parameterType="int" resultType="vo.WorkoutVo">
	
		select regdate, sum(w_unit_kcal) as total_sum from
		(
			select
				*, 
				substring(w_regdate,1,10) as regdate from workout_kcal
		) w
		where user_idx=#{ user_idx } group by regdate  order by regdate desc

	</select>
	
		<!-- 날짜별 운동 조회, 칼로리 계산 -->
	<select id="my_workout_list_date_cal" parameterType="vo.WorkoutVo" resultType="vo.WorkoutVo">
	
		select regdate, sum(w_unit_kcal) as total_sum from
		(
			select
				*, 
				substring(w_regdate,1,10) as regdate from workout_kcal
		) w
		where user_idx=#{ user_idx} and regdate = #{ w_regdate } order by w_regdate desc
		
<!--  		<trim prefix="where" prefixOverrides="or" >
			<if test = "w_regdate !=null">
				user_idx = #{ user_idx} 
			</if>
		</trim>   -->
	</select>
	
	<!-- 오늘 운동 조회, 칼로리 계산 -->
	<select id="my_workout_list_cal_today" parameterType="int" resultType="double">
	
		select ifnull(total_sum,0) from
		(
			select regdate, sum(w_unit_kcal) as total_sum from
			(
				select
					*, 
					substring(w_regdate,1,10) as regdate from workout_kcal
			) w
			where user_idx=#{ user_idx} and regdate = Date_format(now(),'%Y-%m-%d') group by regdate
		) t
	</select>

	
	
	<!-- 내 운동 입력 -->
	<insert id="workout_insert" parameterType="vo.WorkoutVo">
		insert into workout_kcal values(null, #{w_name}, #{w_regdate}, #{w_time}, #{w_unit_kcal}, #{user_idx}, #{user_name})
	</insert>
	
	<!-- 내 운동 삭제 -->
	<delete id="my_workout_delete" parameterType="int">
		delete from workout_kcal where w_idx = #{ w_idx }
	</delete>

	<select id="my_workout_select_one" parameterType="int" resultType="vo.WorkoutVo">
		select * from workout_kcal where w_idx = #{ w_idx } 
	</select>
	
</mapper>
