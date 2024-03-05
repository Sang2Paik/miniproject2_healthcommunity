<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"  %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<!-- 20240303 최시환 추가 -->
<%@ include file="../header.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<style type="text/css">
  #box{
     width:1000px;
     margin: auto;
     margin-top: 10px;
  }

  #title{
     text-align: center;
     font-size: 28px;
     font-weight: bold;
     color: #3366ff;
     text-shadow: 1px 1px 2px black;
  }
  
  
  /* ellipsis */
  
  #user_id {
      display: inline-block;
      width: 100px;
      overflow: hidden;
	  white-space: nowrap;
	  text-overflow: ellipsis;
	  word-break: break-all;
  }
  th,td{
  	text-align: center;
  }
  
  td{
     vertical-align: middle  !important ;
  }
</style>

<script type="text/javascript">

  function user_del(user_idx){
	  
	  //삭제확인
	  if(confirm("회원번호 "+user_idx+"번을 정말 삭제하시겠습니까?")==false) return;
	  
	  //삭제처리
	  location.href = "admin_user_delete.do?user_idx=" + user_idx;
	  
	  
  }
  
 function category_del(c_idx){
	  
	  //삭제확인
	  if(confirm("카테고리 "+ c_idx +"를 삭제하시겠습니까?")==false) return;
	  
	  //삭제처리
	  location.href = "category_delete.do?c_idx=" + c_idx;
	  
	  
  }
 
  // 모달창 생성 후 카테고리 생성 시
  function createCategory(f) {
	  
	  let c_name = f.c_name.value.trim();
	  
	  //비어있으면
	  if(c_name==''){
			alert('제목을 입력해주세요');
			f.c_name.value='';
			f.c_name.focus();
			return;
		}
	  
	  if(confirm(c_name+' 카테고리를 생성하시겠습니까?') == false) return;
		
		f.action="category_insert.do";
		f.submit();
	  
  }
  
</script>


</head>
<body>

	<div id="box">
	   <!-- 로그인 / 로그아웃 -->
	   <div style="text-align: right;">
	        <!-- 로그인이 안된경우 : session영역에 user가 없냐? -->
	        <c:if test="${ empty sessionScope.user }">
	            <input class="nav_btn" type="button"  value="로그인"
	                   onclick="location.href='${ pageContext.request.contextPath }/user/login_form.do'">
	        </c:if>
	        
	        <!-- 로그인이 된 경우 : session영역에 user가 있냐? -->
	        <c:if test="${ not empty sessionScope.user }">
	             <b>${ sessionScope.user.user_name }님 </b>
	             <input class="nav_btn" type="button"  value="로그아웃"
	                   onclick="location.href='${ pageContext.request.contextPath }/logout.do'">
	        </c:if>
	   
	   </div>
	   
	   
	   <!-- 게시판가기 -->
	   <div style="margin-bottom: 5px; text-align: left;">
	      <button  class="btn btn-gradient blue" onclick="location.href='${ pageContext.request.contextPath }/board/list.do'" >게시판가기</button>
	   </div> 
	
	   
	   <table class="table">
	      <!-- head -->
	      <tr class="info">
	      	 <th  class="f16 text-center">순번</th>
	         <th  class="f16 text-center">회원번호</th>
	         <th  class="f16 text-center">회원명</th>
	         <th  class="f16 text-center">아이디</th>
	         <th  class="f16 text-center">이메일</th>
	         <th  class="f16 text-center">가입(갱신)일자</th>
	         <th  class="f16 text-center">회원등급</th>
	         <th  class="f16 text-center">편집</th>
	      </tr>
	      <!-- Data출력 -->
	      <!-- for( Uservo user_vo : admin_user_list )   -->
	      <c:forEach var="user_vo"  items="${ admin_user_list }" varStatus="i">
	         <tr>
	         	<td>${ admin_user_list.size() - i.index }</td>
	            <td>${ user_vo.user_idx }</td>
	            <td>${ user_vo['user_name'] }</td>
	            <td><span id="user_id">${ user_vo.user_id }</span></td>
	            <td>${ user_vo.user_email }</td>
	            <td>${ fn:substring(user_vo.user_created_date,0,10) }<br>
	            	(${ fn:substring(user_vo.user_modified_date,0,10) })</td>
	            <td>${ fn:substring(user_vo.user_grade, 5, fn:length(user_vo.user_grade)) }</td>
	            <td>
	            
	                <!-- 3개의 버튼이 활성화되는 조건: (로그인유저가 관리자) 또는 (로그인 본인) --> 
	                <c:if test="${ (user.user_grade eq 'user_admin')  or (user.user_idx == user_vo.user_idx) }">
	             
		                <input class="btn btn-gradient green" type="button"  value="수정"
		                       onclick="location.href='${ pageContext.request.contextPath }/admin/admin_user_modify_form.do?user_idx=${ user_vo.user_idx }'">
		                <input class="btn btn-gradient red" type="button"  value="삭제"  onclick="user_del(${ user_vo.user_idx });">
		                
		                <input class="btn btn-gradient blue" type="button"  value="보기"
		                       onclick="location.href='${ pageContext.request.contextPath }/user/view.do?user_idx=${ user_vo.user_idx }'">
		                       
	                </c:if>
	                       
	            </td>
	         </tr>
	      </c:forEach>
	      
	   </table>
	   
	   <br>
	   
	    <!-- 카테고리 생성 -->
	   <div style="margin-bottom: 5px; text-align: left;">
	       <button class="btn btn-gradient blue" data-toggle="modal" data-target="#categoryModal">카테고리 생성</button>
	   </div> 
	   
	   <table class="table">
	      <!-- head -->
	      <tr class="info">
	      	 <th  class="f16 text-center">순번</th>
	         <th  class="f16 text-center">고유번호</th>
	         <th  class="f16 text-center">카테고리 명</th>
	         <th  class="f16 text-center">편집</th>
	      </tr>
	      <!-- Data출력 -->
	      <!-- for( CategoryVo Category_vo : admin_category_list )   -->
	      <c:forEach var="category"  items="${ admin_category_list }" varStatus="i">
	         <tr>
	         	<td>${ admin_category_list.size() - i.index}</td>
	            <td>${ category.c_idx }</td>
	            <td>${ category.c_name }</td>
				
	            <td>
	            	 <!-- 버튼이 활성화되는 조건: (관리자) --> 
	                <c:if test="${ (user.user_grade eq 'user_admin') }">
	                	<input class="btn btn-gradient red" type="button"  value="삭제"  onclick="category_del(${ category.c_idx });">
	                </c:if>
	            </td>
	         </tr>
	      </c:forEach>
	      
	   </table>
	   
	</div>
	
	<!-- 모달 -->
	<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="exampleModalLabel">카테고리 생성</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <form>
		            <div class="modal-body">
		                
		                    <div class="form-group">
		                        <label for="categoryName">카테고리 제목</label>
		                        <input type="text" class="form-control" id="c_name" name="c_name" placeholder="카테고리 제목 입력">
		                    </div>
		            </div>
		            <div class="modal-footer">
		                <input type="button" class="btn btn-gradient green" onclick="createCategory(this.form)" value="생성">
		            </div>
	            </form>
	        </div>
	    </div>
	</div>

</body>
</html>


