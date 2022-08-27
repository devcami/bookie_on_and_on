<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubList.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubAnn.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPasswordUpdate.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myBook.css" />
<sec:authentication property="principal" var="loginMember" scope="page"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="비밀번호수정" name="title"/>
</jsp:include>

<style>
/* 중복아이디체크관련 */
div# { position:relative; padding:0px; }
span.guide { display:none; font-size:12px; top:12px; right:10px; }
span.ok { color:green; }
span.error { color:red; }
a:hover {
    color:#697C37;
}
.profile-delete {
	color:#CCDA46;
	text-decoration: none;
}
</style>
<div id="title-header" class="">
	<div id="header-div">
		<div id="title-header-left">
			<i class="fa-solid fa-angle-left" onclick="location.href='/bookie/mypage/mypageSetting.do'"></i>		
		</div>
	</div>
</div>
<section id="content">
    <div class="quiz-wrapper" >
    	<form:form 
    		id="quiz-form"
    		action="${pageContext.request.contextPath}/mypage/myPasswordUpdate.do" 
			method="POST">
		  <div id="password-container">
	      <p class="form-label" style="margin-top: 10px; color: orange;">현재 비밀번호 : </p>
	        <input class="form-field" id="nowPassword" name="nowPassword" type="password" placeholder="현재 비밀번호를 입력하세요!" required>
			<span class="guide ok" id="passwordCheckOk">기존 비밀번호와 일치합니다.</span>
			<span class="guide error" id="passwordCheckError">비밀번호를 다시 확인해주세요.</span>
			<input type="hidden" id="passwordValid1" name="passwordValid1" value="0" /> <%-- 사용불가 0 사용가능 중복검사 통과 시 1 --%>
		  </div>
		  <div id='submit-btn'>
			<button id="btn-more" class="btn gap-2 col-12" type="button" onclick="checkPassword()">비밀번호 확인</button>
		  </div>
		  <div id="password-container">
	      <p class="form-label" style="margin-top: 10px; color: orange;">새로운 비밀번호 : </p>
	        <input class="form-field" id="newPassword" name="newPassword" type="password" value="" required>
		  </div>
		  <div id="password-container">
	      <p class="form-label" style="margin-top: 10px; color: orange;">비밀번호 확인 : </p>
	        <input class="form-field" id="newPasswordCheck" name="newPasswordCheck" type="password" value="" onblur="passwordSameCheck()" required>
			<span class="guide error" id="passwordError">비밀번호가 일치하지 않습니다.</span>
			<span class="guide ok" id="passwordOk">비밀번호가 일치합니다.</span>
			<input type="hidden" id="passwordValid3" name="passwordValid3" value="0" /> <%-- 사용불가 0 사용가능 중복검사 통과 시 1 --%>
		  </div>
		  <div id='btn-more-container'>
			<button id="btn-more" class="btn gap-2 col-12" type="submit" style="margin-top: 10px;">비밀번호 수정</button>
		  </div>
    	</form:form>
	  </div>
</section>

<script>
/* 기존 비밀번호 확인 */
function checkPassword(){
	const nowPassword = document.querySelector("#nowPassword").value;
	
	const csrfHeader = '${_csrf.headerName}'; // 직접가져오기
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
    $.ajax({
	      url : '${pageContext.request.contextPath}/mypage/passwordCheck.do',
	      method : "post",
	      data : {
	    	  nowPassword : nowPassword
	      },
	      headers,
	      success(resp){
	         /* console.log(resp); */
	         const {msg, valid} = resp;
	         alert(msg);
	         console.log(valid);
	         if(valid == "1"){ // 사용가능
	         	document.querySelector("#passwordValid1").value = "1";
	         	document.querySelector("#passwordCheckOk").style.display = "inline";
	         	document.querySelector("#passwordCheckError").style.display = "none";
	         }
	         else{	        
	         	document.querySelector("#passwordValid1").value = "0";
	         	document.querySelector("#passwordCheckOk").style.display = "none";
	         	document.querySelector("#passwordCheckError").style.display = "inline";
	         }
	      },
	      error : console.log
	 });
};

/* 비밀번호 확인 */
function passwordSameCheck() {
	const newPassword = document.querySelector("#newPassword").value;
	const passwordCheck = document.querySelector("#newPasswordCheck").value;
	if(newPassword !== passwordCheck){
		alert("두 비밀번호가 일치하지 않습니다.");
		document.querySelector("#passwordOk").style.display = "none";
		document.querySelector("#passwordError").style.display = "inline";
		document.querySelector("#passwordValid3").value = "0";
		document.querySelector("#newPassword").focus();
	}
	else{
		document.querySelector("#passwordOk").style.display = "inline";
		document.querySelector("#passwordError").style.display = "none";
		document.querySelector("#passwordValid3").value = "1";
	}
};

document.querySelector("#quiz-form").addEventListener ("submit", (e) =>{
	const passwordValid1 = document.querySelector("#passwordValid1").value;
	const passwordValid3 = document.querySelector("#passwordValid3").value;
	const newPasswordCheck = document.querySelector("#newPasswordCheck").value;
  	if(!/^[a-zA-Z0-9]{4,}$/.test(newPasswordCheck)){
        e.preventDefault();
        alert("비밀번호는 영문자/숫자/특수문자!@#$%^&*()로 6글자 이상이어야 합니다.");
        return false;
   	}
	if(passwordValid1 == "0"){
		alert("기존비밀번호가 일치하지 않습니다. 다시 확인해주세요.") 
		e.preventDefault();
		return false;
	}
	if(passwordValid1 == "0"){
		alert("기존비밀번호가 일치하지 않습니다. 다시 확인해주세요.") 
		e.preventDefault();
		return false;
	}
	if(passwordValid3 == "0"){
		alert("새로운 비밀번호가 일치하지 않습니다. 다시 확인해주세요") 
		e.preventDefault();
		return false;
	}
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>