<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

function del_f_no(f_no){
	
	if(confirm("정말 삭제하시겠습니까?") == false) return;
	
	$.ajax({
		url	: "confirm_food_delete.do",
		data : {"f_no" : f_no},
		success: function(){
			alert("삭제되었습니다.");	
			
			$.ajax({
                url: "food_list.do",
                success: function(data) {
                    // 데이터를 받아와서 해당 부분을 업데이트
                    $("#disp_food_list").html(data);
                },
                error: function() {
                    alert("데이터 불러오기 실패");
                }
            });
			
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
			
		},
		error	: function(){
			alert("실패");
		}
		
	});
	
}

</script>
</head>
<body>
	<table>
		<tr>
			<th>번호</th>
			<th>날짜</th>
			<th>식사종류</th>
			<th>칼로리</th>
			<th>버튼</th>
		</tr>
		<c:forEach var="food" items="${confirm_food_list}" varStatus="i">
			<input type="hidden" id="f_no" value="${food.f_no}">
			<tr>
				<td>${i.count}</td>
				<td>${food.f_eat_date}</td>
				<td>${food.m_name}</td>
				<td><fmt:formatNumber type="number" maxFractionDigits="2"
						value="${food.f_total_kcal}" /></td>
				<td><input type="button" value="수정"> <input
					type="button" value="삭제" onclick="del_f_no('${food.f_no}')"></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>