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
		
		let desc_kor = $("#desc_kor").val();
		
		if(desc_kor == ""){
			
			alert("검색어를 입력하시오.");
			f.desc_kor.value="";
			f.desc_kor.focus();
			return;
		}
		
		$.ajax({
			url		: "find.do",
			data	: {"desc_kor" : desc_kor},
			success : function(res_data){
				$("#disp").html(res_data);				
			},
			error	: function(err){
				alert(err.responseText);			
			}
			
		});
	}

</script>
</head>
<body>
	<div>
		<form>
			<table>
				<tr>
					<th>검색어</th>
					<td>
						<input name="desc_kor" id="desc_kor">
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
	</div>
</body>
</html>