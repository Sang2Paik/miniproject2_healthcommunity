<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

	$(document).ready(function(){
		
		let total_kcal = 0;
		
		$(".result_td").each(function(index, element){
			
			total_kcal += parseFloat($(element).find(".result_kcal").text());
			
		});
				
		$("#total_kcal").text(total_kcal);		
		$(".f_csum_g").keyup(function(){
			
			let entered_g = parseFloat($(this).val()) || 0.1; 
			let unit_g = parseFloat($(this).attr('data-unit-g'));
	        let unit_kcal = parseFloat($(this).attr('data-unit-kcal'));
	        
	        let csum_kcal = entered_g*(unit_kcal/unit_g);
	      	        
	        $(this).val(entered_g);	        	                      
	        $(this).closest('tr').find('.result_kcal').text(csum_kcal);
	        
	        let total_kcal = 0;
			
	        $(".result_td").each(function(index, element){
				
				total_kcal += parseFloat($(element).find(".result_kcal").text());
				
			});
	        	       		
	        $("#total_kcal").text(total_kcal);
		});
		
		
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
		
		let f_idx = f.f_idx.value;
		let f_csum_g = f.f_csum_g.value;
		
		console.log(f_idx);
		console.log(f_csum_g);
		
		/* console.log(f_idx); */
	}

</script>

</head>
<body>
	<div>
		<span id="total_kcal" style="font-size: 30px; font-weight: bold;"></span><span style="font-size: 25px; color: red">Kcal</span>
	</div>
	<form>
		<c:forEach var="food" items="${add_food_list}">
			<input type="hidden" name="f_idx" value="${food.f_idx}">
			<table
				style="border: 1px solid black; width: 500px; margin-bottom: 10px;">
				<tr>
					<th colspan="2" style="width: 90%;">${food.f_name}<br>
					</th>
					<td rowspan="2"><input type="button" value="X"
						onclick="del('${food.f_idx}')"></td>
				</tr>
				<tr>
					<td class="result_td" style="width: 45%;"><span
						class="result_kcal">${food.f_unit_kcal}</span><span>kcal</span></td>
					<td style="width: 45%;"><input name="f_csum_g"
						class="f_csum_g" value="${food.f_unit_g}"
						data-unit-g="${food.f_unit_g}"
						data-unit-kcal="${food.f_unit_kcal}">g <br>
					<p style="font-size: 11px;">섭취량(g)을 설정하세요.</p></td>
					<td></td>
				</tr>
			</table>
		</c:forEach>
		<input type="button" value="완료" onclick="confirm(this.form);">
	</form>
</body>
</html>