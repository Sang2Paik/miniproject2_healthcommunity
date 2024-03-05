<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식사 입력하기</title>
<%@ include file="../header.jsp" %>

<script type="text/javascript">

	/* 백상희 추가 20240228 */
	$(document).ready(function(){
		
		if(${not empty param.m_idx}){
			$("#meal_type").val('${param.m_idx}').prop('selected', true);
			$("#f_eattime").val('${param.f_eattime}');
		}
		
		if(${empty param.f_eattime}){
			
			let d = new Date();
			$("#f_eattime").val(new Date(d.getTime()-d.getTimezoneOffset()*60000).toISOString().slice(0, 16));
		}
		
	});

		
	function next(f){
		
		let m_idx = f.meal_type.value;
		let m_name = $("#meal_type option:checked").text();
		let f_eattime = f.f_eattime.value;
		
		if(f_eattime == ''){
			alert("식사 시간을 입력하세요.");
			f.f_eattime.focus();
			return;
		}
		
		/* console.log(m_idx);				
		console.log(f_eattime); */	
		
		location.href="insert_form.do?m_idx="+m_idx+"&m_name="+m_name+"&f_eattime="+f_eattime;
		
	}

	

</script>
</head>
<body>

<section class="vh-100 gradient-custom">
	<form>
		<div class="container py-5 h-100">
				<div class="row d-flex justify-content-center align-items-center h-100">
					<div class="col-12 col-md-8 col-lg-6 col-xl-5">
						<div class="card main_bg text-white" style="border-radius: 1rem;">
							<div class="card-body p-5 text-center">

								<div class="mb-md-5 mt-md-4 pb-5">
									<h2 class="fw-bold mb-2 text-uppercase">
										<img
											src="${ pageContext.request.contextPath }/img/login_title.png">
										<br>식사 입력하기
									</h2>

									<div class="form-outline form-white mb-4" style="width: 80%; margin: 0 auto;">
										<select class="form-control" name="meal_type"
											id="meal_type">
											<c:forEach var="meal" items="${meal_type_list}">
												<option value="${meal.m_idx}">${meal.m_name}</option>
											</c:forEach>
										</select>
									</div>

									<div class="form-outline form-white mb-4" style="width: 80%; margin: 0 auto;">
										<input class="form-control"
											type="datetime-local" name="f_eattime" id="f_eattime" />
									</div>
									<div class="form-outline form-white mb-4" >
										<input class="btn btn-gradient cyan block" type="button" value="다음" style="width: 80%; margin: 0 auto; display: inline-block;" onclick="next(this.form);">									
									</div>

									<div>
										<p class="mb-0">
											<c:if test="${not empty param.cf_page}">
												<a href="#!" class="text-white-50 fw-bold"
												onclick="location.href='${ pageContext.request.contextPath }/food/food_list_page.do'">이전</a>	
											</c:if>
											<c:if test="${empty param.cf_page}">
												<a href="#!" class="text-white-50 fw-bold"
												onclick="location.href='${ pageContext.request.contextPath }/user/mypage_main.do'">이전</a>
											</c:if>	
										</p>

									</div> 
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</section>

</body>
</html>
