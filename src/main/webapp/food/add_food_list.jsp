<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>담기 리스트</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		let total_kcal = 0;
		
		$(".result_td").each(function(index, element){
			
			total_kcal += parseFloat($(element).find(".result_kcal").text());
			
		});
		
		total_kcal = total_kcal.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2});		
		$("#total_kcal").text(total_kcal);		
		
		
		
	})

</script>
<script type="text/javascript">

	function del(f_idx){
		
		$.ajax({
			url		: "delete.do",
			data	: {"f_idx" : f_idx},
			success : function (res_data){
				$("#disp_add").html(res_data);
			}, 
			error 	: function(err){
				alert(err.responseText);
			}
			
		});
	}
	
	function confirm(f){
		
		const total_count = $(".f_idx").length;		
		
		f.action = "food_cal_list.do";
		f.submit();
	
	}

</script>
</head>
<body>
	<form>	
		<div>
			<span id="total_kcal" style="font-size: 30px; font-weight: bold;"></span><span
				style="font-size: 25px; color: red">Kcal</span>
		</div>
	
	
		<c:forEach var="food" items="${add_food_list}" varStatus="i">
			<input type="hidden" class="f_idx" name="f_idx" value="${food.f_idx}">
			<table
				style="border: 1px solid black; width: 450px; margin-bottom: 10px;">
				<tr>
					<th colspan="2" style="width: 90%;">${food.f_name}<br>
					</th>
					<td rowspan="2"><input class="btn btn-danger" type="button" value="X"
						onclick="del('${food.f_idx}')"></td>
				</tr>
				<tr>
					<td class="result_td" style="width: 45%;"><span
						class="result_kcal">${food.f_csum_kcal}</span><span>kcal</span></td>
					<td style="width: 45%;">${food.f_csum_g}<span>g</span></td>
				</tr>
			</table>
		</c:forEach>
		<input class="btn btn-danger" type="button" value="완료" onclick="confirm(this.form);">
	</form>

</body>
</html>
