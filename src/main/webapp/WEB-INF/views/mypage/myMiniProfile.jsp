<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubList.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubAnn.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageSetting.css" />
<sec:authentication property="principal" var="loginMember" scope="page"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="미니프로필수정" name="title"/>
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
			<i class="fa-solid fa-angle-left" onclick="location.href='/bookie/mypage/mypage.do'"></i>		
		</div>
	</div>
</div>
<section id="content">
    <div class="quiz-wrapper" >
    	<form:form 
    		id="quiz-form"
    		action="${pageContext.request.contextPath}/mypage/myMiniProfileUpdate.do" 
			method="POST"
			enctype="multipart/form-data">
	     <h3 style="text-align: center;">Mini Profile</h3>
	     <a href="${pageContext.request.contextPath}/mypage/myProfileDelete.do" class="profile-delete"><h6 style="text-align: center;">프로필삭제</h6></a>
	    	<div class="gravatar" style="padding-top: 0px;">
		      <c:if test="${empty loginMember.originalFilename}">
		      <img id="img-satya" src="${pageContext.request.contextPath}/resources/images/icon/non-profile.png" alt="사진이없어요~"  width="200" height="200">
			  </c:if>
			  <c:if test="${not empty loginMember.originalFilename}">
			  <img src="${pageContext.request.contextPath}/resources/upload/profile/${loginMember.renamedFilename}" alt="멋지고이쁜내사진"  width="200" height="200" style="border-radius: 50%;">
			  </c:if>
	    	</div>
	    	<c:if test="${not empty loginMember.originalFilename}">
			  <input type="hidden" id="delFile" name="delFile" value="0"> 
			</c:if>
	    	<c:if test="${empty loginMember.originalFilename}">
			  <input type="hidden" id="delFile" name="delFile" value="1"> 
			</c:if>
			<div class="input-group mb-3" style="padding-top:10px;">
			  <div class="custom-file">
			  <c:if test="${empty loginMember.originalFilename}">
			    <input type="file" class="custom-file-input" name="upFile" id="upFile">
			    <label class="custom-file-label" for="upFile">프로필 사진을 추가하세요!</label>
			  </c:if>
			  <c:if test="${not empty loginMember.originalFilename}">
			    <input type="file" class="custom-file-input" name="upFile" id="upFile">
			    <label class="custom-file-label" for="upFile">${loginMember.originalFilename}</label>
			  </c:if>
			  </div>
			</div>
		  <div id="nickname-container">
	      <p class="form-label" style="margin-top: 10px; color: orange;">닉네임 : </p>
	        <input class="form-field" id="form-nickname" name="newNickname" type="text" onblur="nickChech();" value="${loginMember.nickname}" required>
			<span class="guide ok" id="nickok">이 닉네임은 사용 가능합니다.</span>
			<span class="guide error" id="nickerror1">이 닉네임은 이미 사용중입니다.</span>
			<span class="guide error" id="nickerror2">이 닉네임은 유효하지 않습니다.</span>
			<input type="hidden" id="nicknameValid" name="nicknameValid" value="0" /> <%-- 사용불가 0 사용가능 중복검사 통과 시 1 --%>
		  </div>
	      <p class="form-label" style="margin-top: 10px; color: orange;">소개 : </p>
	          <input class="form-field" id="form-introduce" name="introduce" type="text" value="${loginMember.introduce}">
	      <p class="form-label" style="margin-top: 10px; color: orange;">SNS : </p>
	          <input class="form-field" id="form-sns" name="sns" type="url" value="${loginMember.sns}">
	      <div id="submit-btn">
	          <input type="submit" value="정보수정">
	      </div>
    	</form:form>
	  </div>
</section>

<script>
var availableall = "";
/* 아이디 중복검사 */
function nickChech() {
	const nickVal = document.querySelector("#form-nickname").value;
	if(!nickVal){
		alert("닉네임을 입력하세요!");
		return false;
	}
	// 닉네임 중복체크 비동기화
	if(nickVal){
		const nickname = document.querySelector("#form-nickname").value;
		console.log(nickname);
		$.ajax({
			url : "${pageContext.request.contextPath}/mypage/nicknameCheck.do",
			method : "GET",
			data : {
				nickname
			},
			success(resp) {
				console.log(resp);
				const {available} = resp;
				console.log(available);
				availableall = available;
				if(available){
					// 유효성검사
				    if(!/^[a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{2,10}$/.test(nickVal)){
				        alert('닉네임을 2-10자 사이의 문자(숫자 포함 가능)로 만들어 주세요.');
						document.querySelector("#nickerror2").style.display = "inline";	
						document.querySelector("#nickok").style.display = "none";	
						document.querySelector("#nicknameValid").value = "0";
				        return false;
				    } else{
					document.querySelector("#nickerror1").style.display = "none";	
					document.querySelector("#nickok").style.display = "inline";	
					document.querySelector("#nicknameValid").value = "1";				    	
				    }
				}
				else {
					document.querySelector("#nickerror1").style.display = "inline";	
					document.querySelector("#nickok").style.display = "none";	
					document.querySelector("#nicknameValid").value = "0";
					return false;
				}
				console.log(document.querySelector("#nicknameValid").value);
			},
			error : console.log
		});
	}
	
	return true;
};

/* 프로필삭제 a링크 이동금지 */
document.querySelector(".profile-delete").addEventListener ("click", (e) =>{
	if(!`${loginMember.renamedFilename}`){
		alert("프로필사진이 없습니다.");
		return false; 
	}
});

document.querySelector("#quiz-form").addEventListener ('submit', (e) => {
	console.log(availableall);
	const delFile = document.querySelector("#delFile");
	if(!availableall){
		alert("사용불가 닉네임입니다. 다시 확인하세요.");
		return false;
	};
	if(document.querySelector("#nicknameValid").value == 0){
		alert("사용불가 닉네임입니다. 다시 확인하세요.");
		return false;
	};
});


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>