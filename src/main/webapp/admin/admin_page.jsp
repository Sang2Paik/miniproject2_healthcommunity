<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"  %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
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

  function del(user_idx){
	  
	  //삭제확인
	  if(confirm("정말 삭제하시겠습니까?")==false) return;
	  
	  //삭제처리
	  location.href = "delete.do?user_idx=" + user_idx;
	  
	  
  }

</script>


</head>
<body>

<div id="box">
   <h1 id="title">::::관리자화면::::</h1>
   
   <!-- 로그인 / 로그아웃 -->
   <div style="text-align: right;">
        
        <!-- 로그인이 안된경우 : session영역에 user가 없냐? -->
        <c:if test="${ empty sessionScope.user }">
            <input class="btn btn-primary" type="button"  value="로그인"
                   onclick="location.href='${ pageContext.request.contextPath }/user/login_form.do'">
        </c:if>
        
        <!-- 로그인이 된 경우 : session영역에 user가 있냐? -->
        <c:if test="${ not empty sessionScope.user }">
             <b>${ sessionScope.user.user_name }</b>님 환영합니다
             <input class="btn btn-primary" type="button"  value="로그아웃"
                   onclick="location.href='logout.do'">
        </c:if>
   
   </div>
   
   <!-- 회원가입 -->
   <div style="margin-bottom: 5px;">
      <button  class="btn btn-primary" onclick="location.href='${ pageContext.request.contextPath }/user/insert_form.do'" >회원가입</button>
   <!-- 게시판가기 -->
      <button  class="btn btn-primary" onclick="location.href='../board/list.do'" >게시판가기</button>
   </div> 

   
   <table class="table">
      <!-- head -->
      <tr class="info">
         <th>회원번호</th>
         <th>회원명</th>
         <th>아이디</th>
         <!-- <th>비밀번호</th>
         <th>이메일</th>
         <th width="15%">(우편번호)주소</th> -->
         <th>이메일</th>
         <th>가입(갱신)일자</th>
         <th>회원등급</th>
         <th>편집</th>
      </tr>
      <!-- Data출력 -->
      <!-- for( Uservo user_vo : admin_user_list )   -->
      <c:forEach var="user_vo"  items="${ admin_user_list }">
         <tr>
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
             
	                <input class="btn btn-success" type="button"  value="수정"
	                       onclick="location.href='${ pageContext.request.contextPath }/admin/admin_user_modify_form.do?user_idx=${ user_vo.user_idx }'">
	                <input class="btn btn-danger"  type="button"  value="삭제"  onclick="del('${user_vo.user_idx}');">
	                
	                <input class="btn btn-info" type="button"  value="보기"
	                       onclick="location.href='${ pageContext.request.contextPath }/user/view.do?user_idx=${user_vo.user_idx}'">
	                       
                </c:if>
                       
            </td>
         </tr>
      </c:forEach>
      
   </table>
   
</div>

</body>
</html>


