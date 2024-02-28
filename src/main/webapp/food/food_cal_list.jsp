<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.chartWrapper {
      width: 500px;
      overflow-x: scroll;
}
.chartAreaWrapper {
            width: 800px; 
            height: 400px; 
        }

canvas {
            width: 500px; 
            height: 400px; 
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
	<div>나의 칼로리 차트보기</div>
	<div class="chartWrapper">
		<div class="chartAreaWrapper">
			<canvas id="myChart"></canvas>
		</div>
	</div>
		
	<input type="button" value="나의 페이지" onclick="location.href='../user/mypage_main.do'">
	<div id="disp_food_list"></div>
</body>
</html>