<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- Daum 주소검색 API  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">
  #box{
     width:600px;
     margin: auto;
     margin-top: 20px;
  }
  
</style>




</head>
<body>
	<div id="box">
		<div class="panel panel-primary">
			<div class="panel-heading"><h4>::::회원정보::::</h4></div>
			<div class="panel-body">
			   <table class="table">
	              <tr>
	                 <th><label>이름</label></th>
	                <td><input name="user_name" value="${ vo.user_name }"></td>
	              </tr>		   
	              <tr>
	                 <th><label>아이디</label></th>
	                 <td><input class="form-control" name="user_id" value="${ vo.user_id }" readonly="readonly"></td>
	              </tr>		
	              <tr>
	                 <th><label>비밀번호</label></th>
	                 <td><input class="form-control" type="password" name="user_pwd" value="${ vo.user_pwd }" readonly="readonly"></td>
	              </tr>		   
	              <tr>
	                 <th><label>이메일</label></th>
	                 <td><input class="form-control" name="user_age"  value="${ vo.user_age }" readonly="readonly"></td>
	              </tr>		   
	              <tr>
	                 <th><label>나이</label></th>
	                 <td><input class="form-control" name="user_age"  value="${ vo.user_age }" readonly="readonly"></td>
	              </tr>
	              <tr>
	                 <th><label>이메일</label></th>
	                 <td><input class="form-control"  name="user_email" value="${ vo.user_email }" readonly="readonly"></td>
	              </tr>
	              <tr>
	                 <th><label>성별</label></th>
						<td>
						 	<c:if test="${ vo.user_gender eq 'man'}">
							  	<input type="radio" class="form-control"  name="user_gender" 
							  				value="man" checked="checked" onclick="return false;">남자&nbsp;&nbsp;&nbsp;
							  	<input type="radio" class="form-control"  name="user_gender" 
							  				value="woman" onclick="return false;">여자
							</c:if>
							
							<c:if test="${ vo.user_gender eq 'woman'}">
							  	<input type="radio" class="form-control"  name="user_gender" 
							  				value="man" onclick="return false;">남자&nbsp;&nbsp;&nbsp;
							  	<input type="radio" class="form-control"  name="user_gender" 
							  				value="woman" checked="checked" onclick="return false;">여자
						 	</c:if>
						</td>
	              </tr>
	              <tr>
	                 <th><label>가입일자</label></th>
	                 <td><input class="form-control" name="user_created_date" value="${ fn:substring(vo.user_created_date,0,16) }" readonly="readonly"></td>
	              </tr>		
	              <tr>
	                 <th><label>마지막수정일자</label></th>
	                 <td><input class="form-control" name="user_modifified_date" value="${ fn:substring(vo.user_modified_date,0,16)}" readonly="readonly"></td>
	              </tr>		
	              <tr>
	                 <th><label>키</label></th>
	                 <td><input class="form-control" name="user_height" value="${ vo.user_height }" readonly="readonly"></td>
	              </tr>
	              <tr>
	                 <th><label>몸무게</label></th>
	                 <td><input class="form-control" name="user_kg" value="${ vo.user_kg }" readonly="readonly"></td>
	              </tr>
	              <tr>
	                 <th><label>목표몸무게</label></th>
	                 <td><input class="form-control" name="user_target" value="${ vo.user_target }" readonly="readonly"></td>
	              </tr>
	              <tr>
	                 <th><label>회원등급</label></th>
	                 <td><input class="form-control" name="user_target" value="${fn:substring(vo.user_grade, 5, fn:length(vo.user_grade))}" readonly="readonly"></td>
	              </tr>
	              
	              <tr>
	                  <td colspan="2" align="center">
	                           <input  class="btn btn-success" type="button"  value="목록보기"
	                                onclick="location.href='${ pageContext.request.contextPath }/board/admin_page.do'">  
	                  </td>
	              </tr>
	              
	              
			   </table>
			</div>
		</div>
	</div>

</body>
</html>