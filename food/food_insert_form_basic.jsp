<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
	.result_area {
		width: 500px;
		height: 800px;
		border: 1px solid black;
	}

</style>
<script type="text/javascript">

		
	function next(f){
		
		let m_idx = f.meal_type.value;
		let m_name = $("#meal_type option:checked").text();
		let f_eattime = f.f_eattime.value;
		
		console.log(m_idx);				
		console.log(f_eattime);	
		
		location.href="insert_form.do?m_idx="+m_idx+"&m_name="+m_name+"&f_eattime="+f_eattime;
		
	}

</script>
</head>
<body>

<div id="box">
		<form>
			<table>
				<tr>
					<th colspan='3'><label>내가 먹은 칼로리 등록하기</label></th>
				</tr>
				<tr>
					<th>식사종류</th>
					<td><select name="meal_type" id="meal_type">
							<c:forEach var="meal" items="${meal_type_list}">
								<option value="${meal.m_idx}">${meal.m_name}</option>
							</c:forEach>
					</select></td>
					<td></td>
				</tr>
				<tr>
					<th>식사시간</th>
					<td><input type="datetime-local" name="f_eattime"></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="button" value="다음" onclick="next(this.form);">
					</td>
				</tr>
			</table>
		</form>
</div>
		
</body>
</html>