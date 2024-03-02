<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식 입력하기</title>
<%@ include file="../header.jsp" %>
<style>
	.result_area {
		width: 500px;
		height: 800px;
		border: 1px solid black;
	}

</style>
<script type="text/javascript">

	$(document).ready(function(){
		
		list();
		
		nc_add_list();
		
	})
	
	function nc_add_list (){
		
		let user_idx = '${user.user_idx}';
		
		$.ajax({
			url		: "add_food.do",
			data	: {
						"user_idx" : user_idx
						},
			success : function(res_data){
				$("#disp_add").html(res_data);				
			},
			error	: function(){
				alert("실패");			
			}
			
		});
		
	}
	
	function list(){
		
		let f_eattime = '${param.f_eattime}';
		let m_idx	= '${param.m_idx}';
		let m_name	= '${param.m_name}';
		let desc_kor = "김치찌개";
		
		$.ajax({
			url		: "find_list.do",
			data	: {
						"desc_kor" : desc_kor,
						"f_eattime" : f_eattime,
						"m_idx"	: m_idx,
						"m_name" : m_name
						},
			success : function(res_data){
				$("#disp").html(res_data);				
			},
			error	: function(err){
				alert("검색 결과가 없습니다. 다시 검색해주세요.");			
			}
			
		});
		
	}

	function find(f){
		
		$("#basic_list").hide();
		
		let desc_kor = $("#f_name").val();
		
		let f_eattime = '${param.f_eattime}';
		let m_idx	= '${param.m_idx}';
		let m_name	= '${param.m_name}';
			
		if(desc_kor == ""){
			
			alert("검색어를 입력하시오.");
			$("#f_name").val("");
			$("#f_name").focus();
			return;
		}
		
		$.ajax({
			url		: "find_list.do",
			data	: {
						"desc_kor" : desc_kor,
						"f_eattime" : f_eattime,
						"m_idx"	: m_idx,
						"m_name" : m_name
						},
			success : function(res_data){
				$("#disp").html(res_data);				
			},
			error	: function(err){
				alert("검색 결과가 없습니다. 다시 검색해주세요.");			
			}
			
		});
	}
	
	

</script>
</head>
<body>
	<form class="form-inline">
		<div class="form-outline form-white mb-4">
			<input class="form-control" name="f_name" id="f_name" placeholder="검색어를 입력하세요." style="width: 80%; display: inline-block;">
			<input class="btn btn-info" type="button" value="검색" onclick="find(this.form)" style="width: 15%; display: inline-block;">	
		</div>
		<table>
			<tr class="form-outline form-white mb-4">
				<th class="f18" style="color: white; background: #16bcd7;">검색 결과</th>
				<th class="f18" style="color: white; background: #16bcd7;">오늘 먹은 음식</th>
			</tr>
			<tr class="form-outline form-white mb-4" >
				<td class="result_area" style="vertical-align: top; overflow-y: auto;" >  	
				   <div id="disp" style="height: 300px;"></div>
							
				</td>
				<td class="result_area" style="vertical-align: top; overflow-y: auto;">
					<div id="disp_add" style="height: 300px;"></div>
				</td>
			</tr>
		</table>		
	</form>
</body>
</html>
