<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript">

	//전역변수
	let latitude;
	let longitude;
	
	$(document).ready(function(){
		
//--------------------현재 위치 구하기---------------------
		
		//geolocation
		navigator.geolocation.getCurrentPosition((position) => {
			//console.log(position)
			latitude  = position.coords.latitude;
			longitude = position.coords.longitude;
			//console.log("----- [geolocation] -----");
			//console.log(latitude,longitude);
			
		},(error) => {
			//geolocation 미지원 시, https://api.ip.pe.kr/ 통해서 구하기 (정확도 떨어짐)
			
			$.ajax({
				url      : "https://api.ip.pe.kr/json/",
				dataType : "JSON",
				success  : function(res_data){

					alert(res_data.ip)
					
					$.ajax({
						url      : "http://ip-api.com/json/" + res_data.ip,
						dataType : "JSON",
						success  : function(data){
							latitude = data.lat;
							longitude= data.lon;
						},
						error    : function(err){
							alert(err.responseText);
						}
					});
				},
				error    : function(err){
					alert(err.responseText);
				}
			});
		});
		
		
		//--------------------현재 날짜/시간 구하기---------------------

/* 		let today = new Date();
		let year  = today.getFullYear();
		let month = today.getMonth();
		let date  = today.getDate();
		
		let base_date = year + ((month+1)<9 ? "0"+ (month+1) : (month+1)) + (date<9 ? "0"+date : date);
		console.log(base_date);
		
		let hour = today.getHours();
		
		let base_time = 0;
		if(hour%3==0){
			base_time = (hour<9 ? "0"+hour : hour)-1 + "00";
		} else {
			base_time = (Math.floor(hour/3,0))*3-1 + "00";
		}
		console.log(base_time);
		console.log(hour/3); */
		
		/* let fcstDate  = base_date;
		console.log(fcstDate); */
		
		/* let fcstTime  = ((hour+1)<9 ? "0"+(hour+1) : hour+1) + "00";
		console.log(fcstTime); */
		//-------------------------------------------------------------		
					
		
		weather_show();

		
		/* ajax weather-forecast */
		function weather_show(){			
			//Ajax
			$.ajax({
				url		:	"list.do",        //WeatherController
				data	:	{"lat":latitude,"lon":longitude},
				success	:	function(res_data){					
					$("#weather_forecast").html(res_data);
				},
				error	:	function(err){
					alert(err.responseText);
				}				
			});			
		}
	});
		
</script>

</head>


<body>

	<div id="weather-box">
		<div id="weather_forecast"></div>
	</div>

</body>


</html>