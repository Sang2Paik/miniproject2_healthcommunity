<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"  %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	
	#box{
		width:800px;
		margin: auto;
		margin-top: 20px;
	}
	
	.myphoto{
		width: 200px;
		margin-left: 20px;
	}
	
	
	
</style>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		let BMI = '${user.user_BMI}';
		
		if(BMI < 18.5){
			$("#my_status").text("저체중");
			$("#my_status_img").attr("src", "../img/Lenny.png");
		}else if (BMI > 18.5 && BMI <= 23){
			$("#my_status").text("정상");
			$("#my_status_img").attr("src", "../img/thumbs.png");
		}else if (BMI > 23 && BMI <= 25){
			$("#my_status").text("과체중");
			$("#my_status_img").attr("src", "../img/tongtong.jpeg");
		}else if (BMI > 25){
			$("#my_status").text("비만");
			$("#my_status_img").attr("src", "../img/pig.jpeg");
		}
		
	});

</script>
<script type="text/javascript">
	
	function show_health_info(){
		
		$("#my_health_info").show();
		
	}
	
	function show_basic_info(){
		
		$("#my_health_info").hide();
		
	}

	
	// 이미지 URL을 클릭한 경우, 해당 URL로 이동합니다.
	function mypage_image_view(b_idx) {
		
		location.href='mypage_board_view.do?b_idx=' + b_idx;
	}
	
	
</script>
</head>
<body>

	<table>
		<tr>
			<td>
				<input type="button" value="나의 건강정보" onclick="show_health_info();">
				<input type="button" value="나의 기본정보" onclick="show_basic_info();">
				<input type="button" value="나의 갤러리" onclick="my_board_info();">
			</td>
		</tr>
	</table>
	
	<div id="my_health_info">
		<table>
			<tr>
				<th>나의 BMI 지수</th>
				<td>${user.user_BMI}</td>
				<td id="my_status" style="font-size: 20px;"></td>
				<td><img id="my_status_img" alt="비만" src=""></td>
			</tr>
			<tr>
				<th>키</th>
				<td>${user.user_height}&nbsp;cm</td>
			</tr>
			<tr>
				<th>몸무게</th>
				<td>${user.user_kg}&nbsp;kgs</td>
			</tr>
			<tr>
				<th>나의 목표</th>
				<td>${user.user_target}&nbsp;kgs</td>
			</tr>
			<tr>
				<th>일일 활동 칼로리</th>
				<td>
					<input type="button" value="입력" onclick="location.href='../workout/workout_insert_form.do'">
					<input type="button" value="보기" onclick="location.href='../workout/my_workout_list.do'">
				</td>
			</tr>
			<tr>
				<th>음식 칼로리</th>
				<td>
					<input type="button" value="입력" onclick="location.href='../food/insert_basic.do'">
					<input type="button" value="보기" onclick="location.href='../food/food_cal_list.do'">
				</td>
			</tr>
			<tr>
				<td>오늘 먹은 칼로리<span id="today_cal">${today_food_kcal}</span>&nbsp;kcals</td>
			</tr>
			<tr>
				<td>오늘 태운 칼로리<span id="today_cal">${today_workout_kal}</span>&nbsp;kcals</td>
			</tr>
		
		</table>
	</div>
	
	
	<div id="my_basic_info">
		<div id="box">
			<div class="panel panel-primary">
				<table class="table">
				
					<tr>
						<th><label>이름</label></th>
						<td>
							<input class="form-control" name="user_name" 
								value="${ user.user_name }" readonly="readonly">
						</td>
					</tr>		   
					<tr>
					   <th><label>아이디</label></th>
					   <td>
					   		<input class="form-control" name="user_id" 
					   			value="${ user.user_id }" readonly="readonly"></td>
					</tr>		
					<tr>
					   <th><label>비밀번호</label></th>
					   <td>
					   		<input class="form-control" type="password" name="user_pwd" 
					   			value="${ user.user_pwd }" readonly="readonly">
					   	</td>
					</tr>		   
					<tr>
					   <th><label>이메일</label></th>
					   <td>
					   		<input class="form-control" name="user_age"  
					   			value="${ user.user_age }" readonly="readonly">
					   	</td>
					</tr>		   
					<tr>
					   <th><label>나이</label></th>
					   <td>
					   		<input class="form-control" name="user_age"  
					   			value="${ user.user_age }" readonly="readonly">
					   </td>
					</tr>
					<tr>
						<th><label>이메일</label></th>
						<td>
							<input class="form-control"  name="user_email" 
								value="${ user.user_email }" readonly="readonly">
						</td>
					</tr>
					
					<tr>
						<th><label>성별</label></th>
						<td>
						 	<c:if test="${ user.user_gender eq 'man'}">
								<input type="radio" class="form-control"  name="user_gender" 
									value="man" checked="checked" onclick="return false;">남자&nbsp;&nbsp;&nbsp;
								<input type="radio" class="form-control"  name="user_gender" 
									value="woman" onclick="return false;">여자
							</c:if>
						
							<c:if test="${ user.user_gender eq 'woman'}">
								<input type="radio" class="form-control"  name="user_gender" 
									value="man" onclick="return false;">남자&nbsp;&nbsp;&nbsp;
								<input type="radio" class="form-control"  name="user_gender" 
									value="woman" checked="checked" onclick="return false;">여자
							</c:if>
						</td>
			         </tr>
			         
			         <tr>
						<th><label>가입일자</label></th>
						<td>
							<input class="form-control" name="user_created_date" 
								value="${ fn:substring(user.user_created_date,0,16) }" readonly="readonly">
						</td>
					</tr>		
					<tr>
						<th><label>마지막수정일자</label></th>
						<td>
							<input class="form-control" name="user_modifified_date" 
								value="${ fn:substring(user.user_modified_date,0,16)}" readonly="readonly">
						</td>
					</tr>		
					<tr>
						<th><label>키</label></th>
						<td>
							<input class="form-control" name="user_height" 
								value="${ user.user_height }" readonly="readonly">
						</td>
					</tr>
					<tr>
						<th><label>몸무게</label></th>
						<td>
							<input class="form-control" name="user_kg" 
								value="${ user.user_kg }" readonly="readonly">
						</td>
					</tr>
					<tr>
						<th><label>목표몸무게</label></th>
						<td>
							<input class="form-control" name="user_target" 
								value="${ user.user_target }" readonly="readonly">
						</td>
					</tr>
					<tr>
						<th><label>회원등급</label></th>
						<td>
							<input class="form-control" name="user_target" 
								value="${ fn:substring(user.user_grade, 5, fn:length(user.user_grade)) }" readonly="readonly">
						</td>
					</tr>
						
					<tr>
						<td colspan="2" align="center">
							<input class="btn btn-danger" type="button" value="탈퇴하기" 
								onclick="user_delete_form(${ user.user_idx });">
								
							<input class="btn btn-info" type="button" value="수정하기" 
								onclick="user_modify_form(${ user.user_idx });">
								
							<input class="btn btn-success" type="button"  value="게시판보기"
								onclick="location.href='${ pageContext.request.contextPath }/board/list.do'">  
						</td>
					</tr>
					         
					         
				</table>
			</div> <!-- end : panel panel-primary -->
		</div> <!-- end : box -->
	</div> <!-- end : my_basic_info -->

	<div id="my_board_info">
		<div id="box">
			<table class="table">
				
				
				<!-- 올린게시물이 있을경우 -->
				<c:if test="${ not empty mypage_board }">
					<!-- 카테고리 리스트만큼 수행 -->
					<c:forEach var="category" items="${ category_list }">
					
						<!-- 카테고리 별로 div태그로 묶기 -->
					    <div>
				        	<h2>${ category.c_name }</h2>
					        
					        <!-- board의 갯수만큼 수행 -->
					        <c:forEach var="board" items="${ mypage_board }">
					        	<!-- c_idx가 같은 항목을 출력 -->
					            <c:if test="${ board.c_idx eq category.c_idx }">
					                <!-- 해당 카테고리에 속하는 게시물 출력 -->
					                <img src="${ pageContext.request.contextPath }/upload/${ board_vo.b_photo }" onclick="mypage_image_view('${ board.b_idx }');"
					   						class="image-hover" id="board_image">
					                <div style="display: inline;">
					                    <div>${ board.b_subject }</div>
					                    <div>${ board.b_content }</div>
					                </div>
					            </c:if>
					        </c:forEach>
					        
					    </div>
					    
					</c:forEach>
				</c:if>
				
				
			</table> <!-- end : table -->
		</div> <!-- end : box -->
	</div> <!-- end : my_basic_info -->

	

</body>
</html>
