<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">

 
</style>
<script type="text/javascript">
	
	function add(f_name, f_unit_g, f_unit_kcal, animal_plant){
		
		$.ajax({
			url		: "add.do",
			data	: {	
						"f_name"      : f_name,
						"f_unit_g"    : f_unit_g,
						"f_unit_kcal" : f_unit_kcal,
						"animal_plant": animal_plant
					   },
			success : function(res_data){
					$("#disp_add").html(res_data);
			},
			error	: function(err){
				alert(err.responseText);
			}
		});
		
	}

</script>
</head>
<body>
	<c:forEach var="food" items="${food_search_list}">
		<table style="border: 1px solid black; width: 500px; height: 80px; margin-bottom: 10px;">
			<tr>
				<th style="font-size: '15px'; color:purple; width: 90%;">${food.f_name} (1회제공량,${food.f_unit_g}g)</th>
				<td rowspan="2"><input type="button" value="담기" onclick="add('${food.f_name}','${food.f_unit_g}', '${food.f_unit_kcal}', '${food.animal_plant}' );"></td>
			</tr>
			<tr>
				<td style="width: 90%;">
					<b>칼로리 : ${food.f_unit_kcal}&nbsp;kcal</b> |
					탄수화물 : xxx 
					<c:if test="${not empty food.animal_plant}">
					제조사 : ${food.animal_plant}
					</c:if>
				</td>
			</tr>
		</table>
	</c:forEach>
</body>
</html>