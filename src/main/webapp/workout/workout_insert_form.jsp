<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>



<script type="text/javascript">

	$(document).ready(function(){
		
		let page = 1;
		let perPage = 360;
		
		$.ajax({
			
			url       : "workout_cal_list.do",        //WorkoutController
			data      : {"page" : page, "perPage" : perPage},
			success   : function(res_data){
				$("#workout_info").html(res_data);
			},
			error     : function(err){
				alert(err.responseText);
			}
			
		});
		
	}); 
	
	
</script>

</head>
<body>
	<div id="workout_info"></div>
</body>
</html>