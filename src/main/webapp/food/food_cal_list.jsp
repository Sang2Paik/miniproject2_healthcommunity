<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일일 섭취 기록보기</title>
<%@ include file="../header.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

<style type="text/css">

.chartWrapper {
  position: relative;
    overflow-x: scroll;

  /* overflow-x: scroll; */
}

.chartWrapper > canvas {
  position: absolute;
  left: 0;
  top: 0;
  pointer-events: none;
  width: 100%;
}

.chartAreaWrapper {
  width: 1500px;
}



</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		getGraph();
		food_confirm_list();
	});
	
	function getGraph(){
		
		let timeList = [];
		let kcalList = [];
		
		$.ajax({
			
			url		: "food_cal_chart.do",
			type	: "get",
			dataType: "json",
			success : function(data){
				
				console.log(data);
				
				for(let i=0; i<data.food_chart_list.length; i++){
					
					timeList.push(data.food_chart_list[i].f_eat_date);
					kcalList.push(data.food_chart_list[i].f_total_kcal.toFixed(2));
				}
				
				/* myChart  넣는 곳 */
				new Chart("myChart", {
					  type: "bar",
					  data: {
					    labels: timeList,
					    datasets: [{
					      data: kcalList,
					      label : "섭취 칼로리",
					      backgroundColor: "blue",
					      barPercentage: 0.8, // 바의 너비 비율을 설정합니다.
                          categoryPercentage: 0.8 // 바의 간격 비율을 설정합니다.
					    }]
					  },
					  options: {
					    legend: {display: false},
					    title: {
					      display: true,
					      text: "일일 섭취 칼로리"
					    },
					    scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                        }
					  }
					}); /* mychart end */
				
			},
			error	: function(){
				alert("실패");
			}
			
		}); /* ajax end */
	
	}
	
	function food_confirm_list(){
				
		$.ajax({
				url: "food_list.do",
				success : function(res_data){
					$("#disp_food_list").html(res_data);				
				},
				error : function(){
					alert("리스트 실패");
				}
		});
	}
	
	
		
</script>
</head>
<body>

	<table class="table">
		<tr>
			<td align="left">
				<input type="button" class="nav_btn" value="마이 페이지" onclick="location.href='${pageContext.request.contextPath}/user/mypage_main.do'"> 
				<input type="button" class="nav_btn" value="메인 페이지" onclick="location.href='${pageContext.request.contextPath}/main.do'">
				<input type="button" class="nav_btn" value="모두의 갤러리" onclick="location.href='${pageContext.request.contextPath}/board/list.do'">
			</td>
			<td align="right">
				<input type="button" class="nav_btn" value="로그아웃" 
				onclick="location.href='${ pageContext.request.contextPath }/user/logout.do'">
			</td>
		</tr>
	</table>

	<div class="chartWrapper">
		<div class="chartAreaWrapper">
			<canvas id="myChart" width="960" height="300"></canvas>
		</div>
	</div>
	<div align="left" style="margin: 5px;">
		<button class="nav_btn" onclick="location.href='insert_basic.do?cf_page=true'">
			 + 음식 추가
		</button>
	</div>

	<!-- <input class="btn btn-gradient cyan block" type="button" value="추가 등록" onclick="location.href='insert_basic.do'">	 -->
	<div id="disp_food_list"></div>

</body>
</html>
