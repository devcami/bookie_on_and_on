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
			<i class="fa-solid fa-angle-left" onclick="location.href='/bookie/mypage/mypage.do?memberId=${member.memberId}'"></i>		
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
	     <h3 style="text-align: center;">공개프로필 수정</h3>
	     <h6 class="profile-delete" style="text-align: center; cursor:pointer;" onclick="deleteProfileImg();">프로필삭제</h6>
	    	<div class="gravatar" style="padding-top: 0px;">
		      <c:if test="${empty member.originalFilename}">
		      <img id="img-satya" src="${pageContext.request.contextPath}/resources/images/icon/none-profile-img.png" alt="사진이없어요~"  width="200" height="200">
			  </c:if>
			  <c:if test="${not empty member.originalFilename}">
			  <img id="img-satya" src="${pageContext.request.contextPath}/resources/upload/profile/${member.renamedFilename}" alt="멋지고이쁜내사진"  width="200" height="200" style="border-radius: 50%;">
			  </c:if>
	    	</div>
	    	<c:if test="${not empty member.originalFilename}">
			  <input type="hidden" id="delFile" name="delFile" value="0"> 
			</c:if>
	    	<c:if test="${empty member.originalFilename}">
			  <input type="hidden" id="delFile" name="delFile" value="1"> 
			</c:if>
			<div class="input-group mb-3" style="padding-top:10px;">
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="upFile" id="upFile" onchange="loadImage(this);">
			  <c:if test="${empty member.originalFilename}">
			    <label class="custom-file-label" for="upFile" id="profile-label">프로필 사진을 추가하세요!</label>
			  </c:if>
			  <c:if test="${not empty member.originalFilename}">
			    <label class="custom-file-label" for="upFile" id="profile-label">
			        <c:if test="${fn:length(member.originalFilename) ge 30}">
                    	${fn:substring(member.originalFilename, 0, 25)}
                    </c:if>
                    <c:if test="${fn:length(member.originalFilename) lt 30}">
		   			 	${member.originalFilename}
                    </c:if>
			    </label>
			  </c:if>
			  </div>
			</div>
		  <div id="nickname-container">
	      <p class="form-label" style="margin-top: 10px; color: orange;">닉네임 : </p>
	        <input class="form-field" id="form-nickname" name="newNickname" type="text" onblur="nickChech();" value="${loginMember.nickname}" required>
			<span class="guide ok" id="nickok">이 닉네임은 사용 가능합니다.</span>
			<span class="guide error" id="nickerror1">이 닉네임은 이미 사용중입니다.</span>
			<span class="guide error" id="nickerror2">이 닉네임은 유효하지 않습니다. 2-10자 사이의 문자(숫자 포함 가능)로 만들어 주세요.</span>
			<input type="hidden" id="nicknameValid" name="nicknameValid" value="0" /> <%-- 사용불가 0 사용가능 중복검사 통과 시 1 --%>
		  </div>
	      <p class="form-label" style="margin-top: 10px; color: orange;">소개 : </p>
	          <input class="form-field" id="form-introduce" name="introduce" type="text" value="${member.introduce}" placeholder="나에 대해 짧게 설명해주세요!">
	      <p class="form-label" style="margin-top: 10px; color: orange;">SNS : </p>
	          <input class="form-field" id="form-sns" name="sns" type="url" value="${member.sns}" placeholder="sns주소를 추가해주세요!">
	      <div id="submit-btn" class="text-center">
	          <input type="submit" value="정보수정">
	      </div>
    	</form:form>
	  </div>
</section>

<script>
var availableall = "";
/* 닉네임 중복검사 */
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
					// 중복이긴 해 근데 내 지금 닉네임이랑 똑같애 그럼 사용가능
					if(nickVal == '${member.nickname}'){
						document.querySelector("#nickerror1").style.display = "none";	
						document.querySelector("#nickok").style.display = "inline";	
						document.querySelector("#nicknameValid").value = "1";	
						return;
					}
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

/* 프로필삭제 클릭 시 비동기로 삭제처리 */
const deleteProfileImg = () => {
	const memberId = "${member.memberId}";
	/* 등록된 프로필이 없으면 프로필삭제 제출 막기 */
	if('${member.renamedFilename}' == ''){
		return; 
	}
	else{
		const csrfHeader = '${_csrf.headerName}';
		const csrfToken = '${_csrf.token}';
		const headers = {};
		headers[csrfHeader] = csrfToken;
		$.ajax({
			url : "${pageContext.request.contextPath}/mypage/myProfileDelete.do",
			method : 'post',
			data : {memberId : memberId},
			headers,
			success(resp){
				//console.log(resp);
				console.log('프로필사진 삭제 성공');
				document.querySelector("#img-satya").src = '${pageContext.request.contextPath}/resources/images/icon/none-profile-img.png';
				document.querySelector("#profile-label").innerText = "프로필 사진을 추가하세요!";
			},
			error: console.log
		});
	}
}

<%-- img 미리보기 --%>
const loadImage = (input) => {
    console.log(input.files);
    if(input.files[0]){
       const fr = new FileReader();
       fr.readAsDataURL(input.files[0]);
       fr.onload = (e) => {
          console.log(e.target.result);
          document.querySelector("#img-satya").src = e.target.result;
		}
	} 
    if(input.files.length == 0){
        document.querySelector("#img-satya").src = '${pageContext.request.contextPath}/resources/images/icon/none-profile-img.png';
    }
};   


/* 제출 시 닉네임 유효성검사 */
document.querySelector("#quiz-form").addEventListener ('submit', (e) => {

	// 아무것도 안했을 때
	if(availableall == ""){
		document.querySelector("#quiz-form").submit();
		return;
	}
	
	// 변경할려고 시도했는데 못쓰는 닉네임일때
	if(document.querySelector("#nicknameValid").value == 0){
		e.preventDefault();
		alert("사용불가 닉네임입니다. 다시 확인하세요.");
		return false;
	};
});


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>