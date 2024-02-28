<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
	#box, th, td {
		text-align: center;
	}
	/* 모달 바디 스타일 */
    .modal-body table {
        width: 100%;
        border-collapse: collapse;
    }
    .modal-body table td, .modal-body table th {
        padding: 8px; /* 셀 내부의 패딩 추가 */
        text-align: center; /* 가운데 정렬 */
    }
    .modal-body input {
        width: 50%;
        padding: 8px; /* 입력란의 패딩 추가 */
        box-sizing: border-box; /* 입력란의 크기를 패딩과 테두리까지로 설정 */
    }
    .modal-body p {
        margin: 0; /* 문단의 위아래 여백 제거 */
    }

</style>
<script type="text/javascript">
	$(document).ready(function(){
					
		$("#f_csum_g").keyup(function(){
			
			let entered_g = parseFloat($("#f_csum_g").val()) || 0.1; 
			let unit_g = parseFloat($("#f_unit_g").text());
			let unit_kcal = parseFloat($("#f_unit_kcal").text());
			
			/* console.log(entered_g);
			console.log(unit_g);
			console.log(unit_kcal); */
			
			let csum_kcal = entered_g*(unit_kcal/unit_g);
			$("#f_csum_g").val(entered_g);
			$("#result_kcal").text(csum_kcal);
			
		});
		
		
		
	})

</script>

<script type="text/javascript">
	
	function modal_add(f_name, f_unit_g, f_unit_kcal, f_maker){
		
		/* console.log(f_name); */

		$("#f_name_value").text(f_name);
		$("#f_unit_g").text(f_unit_g); 
		$("#f_csum_g").val(f_unit_g); // 섭취량(g) 입력란에 값 설정
		$("#result_kcal").text(f_unit_kcal);
		$("#f_unit_kcal").text(f_unit_kcal); 
		$("#f_maker").text(f_maker);
		
		let user_idx = '${user.user_idx}';
		
		$.ajax({
			url		: "add_check.do",
			data	: {	
						"f_name"      : f_name,
						"f_unit_kcal" : f_unit_kcal,
						"f_maker"	  : f_maker,
						"user_idx"	  : user_idx
					   },
			dataType : "json",
			success : function(res_data){
					if(res_data.result == true){
						$("#myModal").modal("hide");
						alert("이미 담긴 항목입니다.");	
						return;
					}else{
						$("#myModal").modal("show");
					}						

			},
			error	: function(err){
				alert(err.responseText);
			}
		});
	}
	
	function add(){
		
		let f_name = $("#f_name_value").text();
		let f_unit_g = $("#f_unit_g").text();
		let f_csum_g = $("#f_csum_g").val();
		let f_unit_kcal = $("#result_kcal").text();
		let f_maker = $("#f_maker").text();
		
		let f_eattime = '${f_eattime}';
		let m_idx	= '${m_idx}';
		let m_name	= '${m_name}';
		let user_idx = '${user.user_idx}';

		
		$.ajax({
			url		: "add_food.do",
			data	: {	
						"f_name"      : f_name,
						"f_unit_g"    : f_unit_g,
						"f_unit_kcal" : f_unit_kcal,
						"f_csum_g"	  : f_csum_g,
						"f_maker"	  : f_maker,
						"f_eattime"   : f_eattime,
						"m_idx"		  : m_idx,
						"m_name" 	  : m_name,
						"user_idx"	  : user_idx
					   },
			success : function(res_data){
					$("#disp_add").html(res_data);
					$("#myModal").modal("hide");
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
			<td rowspan="2"><input type="button" class="btn btn-info btn-lg" data-target="#myModal" data-dismiss="modal" value="담기" onclick="modal_add('${food.f_name}','${food.f_unit_g}', '${food.f_unit_kcal}', '${food.f_maker}');"></td>
		</tr>
		<tr>
			<td style="width: 90%;">
				<b>칼로리 : ${food.f_unit_kcal}&nbsp;kcal</b> 
				탄수화물 : ${food.carbo}g &nbsp; 단백질 : ${food.protein}g &nbsp; 지방 : ${food.fat}g &nbsp;
				<c:if test="${not empty food.sweet}">
				당 : ${food.sweet}g
				</c:if>&nbsp;
				<c:if test="${not empty food.natrium}">
				나트륨 : ${food.natrium}mg
				</c:if>&nbsp;
				<c:if test="${not empty food.chole}">
				콜레스테롤 : ${food.chole}mg
				</c:if>&nbsp;
				<c:if test="${not empty food.sat_fat}">
				포화지방산 : ${food.sat_fat}g
				</c:if>&nbsp;			
				<c:if test="${not empty food.trans_fat}">
				트랜스지방산 : ${food.trans_fat}g
				</c:if>&nbsp;
				<c:if test="${not empty food.f_maker}">
				제조사 : ${food.f_maker}
				</c:if>
			</td>
		</tr>
	</table>
</c:forEach>

<!-- Modal -->	
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- 모달 내용 -->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title"><b>섭취량 설정</b></h4>
      </div>
      <div class="modal-body">  		
			<table>
				<tr>
					<th colspan="2" id="f_name_value"></th>
				</tr>
				<tr>
					<td><span id="result_kcal"></span><span>kcal</span></td>				
					<td>
						<input id="f_csum_g"><br>
						<p style="font-size: 11px;">섭취량(g)을 설정하세요.
						<span>(&nbsp; 1회 제공량 : </span><span id="f_unit_g"></span><span>g &nbsp; </span>
						<span id="f_unit_kcal"></span><span>kcal</span> &nbsp;
						<span id="f_maker"></span><span>)</span>
						</p>
					</td>
				</tr>
			</table>
      </div>
      <div class="modal-footer">
      	<input type="button" class="btn btn-primary" value="등록" onclick="add();">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


</body>
</html>