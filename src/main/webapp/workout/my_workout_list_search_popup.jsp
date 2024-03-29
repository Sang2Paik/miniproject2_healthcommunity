<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<style type="text/css">

	#box{

		/* border: solid green 1px; */
		margin: auto;
		margin-top: 30px;
		padding: 10px;
		color: black;
	}
	
	th, td {
		text-align: center;
	}
	
 	#my_workout_list {
		border: solid #16b4ce 1px;
		width:500px;
		max-height: 450px;
		overflow-y: scroll;
	}
	
	#my_workout_stat {
		
		width: 500px;

		font-size: 20px; 
		font-weight: bold;
		
	}
	
	#kcal_sum_list{
		font-size: 20px; 
		color: black
	
	}
	
	#btn_select{
		width: 40px;
		height: 20px;
		margin: 0px;
		padding: 0px;
		text-align: center;
	}


</style>
	
	
<script type="text/javascript">
	
	
	function del(w_idx, regdate){

	
	if(confirm('정말 삭제하시겠습니까?')==false){
		return;
	}
	location.href="my_workout_delete.do?w_idx=" + w_idx + "&regdate=" + regdate;
	
	 //setTimeout(function(){
            // 2초 후에 삭제되었습니다 메시지를 표시
            //alert("운동 항목이 삭제되었습니다.");
            // 삭제를 진행하는 요청
            //location.href="my_workout_delete.do?w_idx=" + w_idx + "&regdate=" + regdate;
       // }, 2000);
	
}

</script>


</head>
<body>
<form>
<div id="box_modal">
<!-- Button to Open the Modal -->
<button  style="display:none;" id="btn_modal" type="button"  data-toggle="modal" data-target="#myModal">
  Open modal
</button>


<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="search_list">${ user.user_name }님의 운동 내역 상세</h4>
      </div>
	  <div class="modal-body">

		<div id="my_workout_info_title">

			<!-- <b>일일 소모 칼로리 상세정보</b> -->
		</div>
		<div id="my_workout_list">
			
			<table class="table form-class list_table2">

				<div id="disp1"></div>

			</table>
		</div>
	 </div>
	 <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
	 
	</div>
</div>
</div>

</div>

</form>
</body>
</html>
