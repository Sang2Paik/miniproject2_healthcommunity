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
	<form>
		<table>
			<tr>
				<th>검색어</th>
				<td>
					<input name="f_name" id="f_name">
					<input type="button" value="검색" onclick="find(this.form)">
				</td>
				<td>내가 담은 음식</td>
			</tr>
			<tr>
				<td colspan="2" class="result_area" style="vertical-align: top;">
				   검색 결과	
				   <div id="disp"></div>
							
				</td>
				<td class="result_area" style="vertical-align: top;">
					내가 담은 음식 결과
					<div id="disp_add"></div>
				</td>
			</tr>
		</table>		
	</form>


</body>
</html>