<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식사 수정하기</title>
<%@ include file="../header.jsp" %>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#meal_type").val('${param.m_idx}').prop('selected', true);
		$("#f_eattime").val('${param.f_eattime}');
		
		
	});
			
	function next(f){
		
		let m_idx = f.meal_type.value;
		let m_name = $("#meal_type option:checked").text();
		let f_eattime = f.f_eattime.value;
		let f_no = ${param.f_no};
		
			
		location.href = "food_modify_form.do?m_idx="+m_idx+"&m_name="+m_name+"&f_eattime="+f_eattime+"&f_no="+f_no;
		
	}

</script>
</head>
<body>

	<section class="vh-100 gradient-custom">
		<form>
			<div class="container py-5 h-100">
				<div
					class="row d-flex justify-content-center align-items-center h-100">
					<div class="col-12 col-md-8 col-lg-6 col-xl-5">
						<div class="card main_bg text-white" style="border-radius: 1rem;">
							<div class="card-body p-5 text-center">

								<div class="mb-md-5 mt-md-4 pb-5">
									<h2 class="fw-bold mb-2 text-uppercase">
										<img
											src="${ pageContext.request.contextPath }/img/login_title.png">
										<br>식사 수정하기
									</h2>

									<div class="form-outline form-white mb-4"
										style="width: 80%; margin: 0 auto;">
										<select class="form-control" name="meal_type" id="meal_type">
											<c:forEach var="meal" items="${meal_type_list}">
												<option value="${meal.m_idx}">${meal.m_name}</option>
											</c:forEach>
										</select>
									</div>

									<div class="form-outline form-white mb-4"
										style="width: 80%; margin: 0 auto;">
										<input class="form-control" type="datetime-local"
											name="f_eattime" id="f_eattime" />
									</div>

									<div class="form-outline form-white mb-4">
										<input class="btn btn-gradient cyan block" type="button"
											value="다음" style="width: 80%; margin: 0 auto;"
											onclick="next(this.form);"> 
									</div>

									<div>
										<p class="mb-0">
											<a href="#!" class="text-white-50 fw-bold"
												onclick="location.href='${ pageContext.request.contextPath }/food/food_cal_list.do'">이전</a>
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