<%@page import="com.kh.bookie.member.model.dto.Interest"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.bookie.member.model.dto.Member"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
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
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메인프로필수정" name="title"/>
</jsp:include>
<%
	Interest interest = (Interest) request.getAttribute("interest");
	String[] interests = interest.getInterests();	
	List<String> interestList = interests != null?
									Arrays.asList(interests) : null;
	pageContext.setAttribute("interestList", interestList);

%>
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
<sec:authentication property="principal" var="loginMember" scope="page"/>
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
    		action="${pageContext.request.contextPath}/mypage/myMainProfileUpdate.do" 
			method="POST"
			enctype="multipart/form-data">
		   <h3 style="text-align: center;">'${member.nickname}' profile</h3>	
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
			    <p class="form-label">아이디 [수정불가]</p>
			      <input class="form-field" id="memberId" name="memberId" type="text" value="${member.memberId}" required readonly>
			    <div id="nickname-container">
			    	<p class="form-label" style="margin-top: 10px; color: orange;">닉네임 : </p>
			        <input class="form-field" id="form-nickname" name="nickname" type="text" onblur="nickChech();" value="${member.nickname}" required>
					<span class="guide ok" id="nickok">이 닉네임은 사용 가능합니다.</span>
					<span class="guide error" id="nickerror1">이 닉네임은 이미 사용중입니다.</span>
					<span class="guide error" id="nickerror2">이 닉네임은 유효하지 않습니다.</span>
					<input type="hidden" id="nicknameValid" name="nicknameValid" value="0" /> <%-- 사용불가 0 사용가능 중복검사 통과 시 1 --%>
				</div>		    
			  	<p class="form-label">이메일</p>
			  	<input class="form-field" id="email" name="email" type="email" value="${member.email}" required style="margin-bottom: 0.5rem">
		  		<button type="button" class="btn btn-primary w-100" id="mail-Check-Btn">본인인증</button>
                <input class="form-control mail-check-input mt-2" placeholder="이메일 인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
               	<p class="text-center" id="mail-check-warn" style="display:none;"></p>
			  	<p class="form-label">gender</p>
			    <label>
			        <input type="radio" name="gender" value="M" ${member.gender eq 'M' ? 'checked' : ''} required>남
			    </label>
			    <label>
		          	<input type="radio" name="gender" value="F" ${member.gender eq 'F' ? 'checked' : ''} required>여
		        </label>
		        <p class="form-label">생년월일</p>
		       		<input class="form-field" type="date" name="birthday" value="${member.birthday}">
		        <p class="form-label">Phone Number:</p>
		           <input class="form-field" type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" value="${member.phone}" required>
		        <p class="form-label">관심 장르</p>
		        <div class="interest-div text-center">
							<input type="checkbox" class="interest-input" name="interest" id="interest0" value="경제" ${interestList.contains('경제') ? 'checked' : ''}>
							<label class="interest-label" for="interest0">경제</label>
							<input type="checkbox" class="interest-input" name="interest" id="interest1" value="공학" ${interestList.contains('공학') ? 'checked' : ''}>
							<label class="interest-label" for="interest1">공학</label>
							<input type="checkbox" class="interest-input" name="interest" id="interest2" value="문학" ${interestList.contains('문학') ? 'checked' : ''}>
							<label class="interest-label" for="interest2">문학</label>
							<input type="checkbox" class="interest-input" name="interest" id="interest3" value="자기계발" ${interestList.contains('자기계발') ? 'checked' : ''}>
							<label class="interest-label" for="interest3">자기계발</label>
							<input type="checkbox" class="interest-input" name="interest" id="interest4" value="언어" ${interestList.contains('언어') ? 'checked' : ''}>
							<label class="interest-label" for="interest4">언어</label>
							<input type="checkbox" class="interest-input" name="interest" id="interest5" value="취미" ${interestList.contains('취미') ? 'checked' : ''}>
							<label class="interest-label" for="interest5">취미</label>
							<br />
							<input type="checkbox" class="interest-input" name="interest" id="interest6" value="에세이" ${interestList.contains('에세이') ? 'checked' : ''}>
							<label class="interest-label" for="interest6">에세이</label>
							<input type="checkbox" class="interest-input" name="interest" id="interest7" value="예술" ${interestList.contains('예술') ? 'checked' : ''}>
							<label class="interest-label" for="interest7">예술</label>
							<input type="checkbox" class="interest-input" name="interest" id="interest8" value="교육" ${interestList.contains('교육') ? 'checked' : ''}>
							<label class="interest-label" for="interest8">교육</label>
							<input type="checkbox" class="interest-input" name="interest" id="interest9" value="인문학" ${interestList.contains('인문학') ? 'checked' : ''}>
							<label class="interest-label" for="interest9">인문학</label>
							<input type="checkbox" class="interest-input" name="interest" id="interest10" value="종교" ${interestList.contains('종교') ? 'checked' : ''}>
							<label class="interest-label" for="interest10">종교</label>
							<input type="checkbox" class="interest-input" name="interest" id="interest11" value="기타" ${interestList.contains('기타') ? 'checked' : ''}>
							<label class="interest-label" for="interest11">기타</label>
						 </div>
				<p class="form-label" style="margin-top: 10px; color: orange;">소개</p>
	            	<input class="form-field" id="form-introduce" name="introduce" type="text" value="${member.introduce}" placeholder="나에 대해 짧게 설명해주세요!">
	            <p class="form-label" style="margin-top: 10px; color: orange;">SNS</p>
	            	<input class="form-field" id="form-sns" name="sns" type="url" value="${member.sns}" placeholder="sns주소를 추가해주세요!">
		        <div id="submit-btn">
		          <input type="submit" value="정보수정">
		          <input type="reset"  value="취소" onclick="location.href='${pageContext.request.contextPath}/mypage/mypageSetting.do'">
		        </div>
		      <!--   <input type="hidden" name="interest[]" id="interestArray" value=''> -->
	      </form:form>
	  </div>
</section>

<script>
var availableall = "";

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
			async:false,
			data : {
				nickname
			},
			success(resp) {
				console.log(resp);
				const {available} = resp;
				console.log("여기확인");
				console.log(available);
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

/* 이메일본인인증 */
$('#mail-Check-Btn').click(function() {
	const eamil = document.querySelector('#email').value; // 이메일 주소값 얻어오기!
	console.log('완성된 이메일 : ' + eamil); // 이메일 오는지 확인
	const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
	
	$.ajax({
		method : 'get',
		url : "${pageContext.request.contextPath}/member/mailCheck?email="+eamil, // GET방식이라 Url 뒤에 email을 붙힐수있다.
		success: function(data) {
			console.log("data : " +  data);
			checkInput.attr('disabled',false);
			code = data;
			alert('인증번호가 전송되었습니다.');
		},
		error : console.log
	});
});

//인증번호 비교 
//blur -> focus가 벗어나는 경우 발생
$('.mail-check-input').blur(function () {
	const inputCode = $(this).val();
	const $resultMsg = $('#mail-check-warn');
	const checkInput = $('.mail-check-input');
	
	if(inputCode === code){
	   $resultMsg.html('인증번호가 일치합니다.');
	   $resultMsg.css('display','inline');
	   $resultMsg.css('color','green');
	   checkInput.attr('readonly', false);
	   $('#mail-Check-Btn').attr('disabled',true);
	   $('#email').attr('readonly',true);
	   $('#email').attr('onFocus', 'this.initialSelect = this.selectedIndex');
	   $('#email').attr('onChange', 'this.selectedIndex = this.initialSelect');
	}else{
	   $resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!');
	   checkInput.focus();
	   $resultMsg.css('color','red');
	}
});

/* 제출 시 닉네임 유효성검사 */
document.querySelector("#quiz-form").addEventListener ('submit', (e) => {
	// 아무것도 안했을 때
/* 	if(availableall == ''){
		e.preventDefault();
		alert('변경사항이 없습니다.');
		return false;
	} */
	
	console.log("나와?여기?");
	console.log(availableall);
	
	// 변경할려고 시도했는데 못쓰는 닉네임일때
	if(document.querySelector("#nicknameValid").value == "0"){
		console.log("나와?여기?2");
	    e.preventDefault();
	    alert('사용불가 닉네임입니다. 다시 확인하세요.');     
		return false;
	};
	
	// email인증을 아예 안했을 경우
	if(document.querySelector('#mail-check-warn').style.display == 'none'){
	    e.preventDefault();
	    alert('이메일 인증 후 가입 가능합니다.');      
	    return false;
	}
	   
	// 했는데 불일치할 경우
    const $resultMsg = $('#mail-check-warn');
    const checkInput = $('.mail-check-input');
    if(document.querySelector('#mail-check-warn').innerText == '인증번호가 불일치 합니다. 다시 확인해주세요!'){
       e.preventDefault();      
       checkInput.attr('readonly', false);
       checkInput.focus();
       alert('이메일 인증번호를 올바르게 입력해주세요.');
       return false;
    }
	   
    // phone
    if(!/^010\d{8}$/.test(phone.value)){
       e.preventDefault();
       alert("유효한 전화번호를 입력하세요.");
       return false;
    }
    
    // gender
    let cnt;
    document.querySelectorAll('[name=gender]').forEach((radio) => {
       if(!radio.checked){
          cnt++;         
       }
    });
    if(cnt == 2){
       e.preventDefault();      
       alert('성별을 입력해주세요.');
       return false;
    }
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>