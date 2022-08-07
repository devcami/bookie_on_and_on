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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainProfile.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubList.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubAnn.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageSetting.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메인프로필수정" name="title"/>
</jsp:include>
<%
	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	Member loginMember = (Member) authentication.getPrincipal();
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
			<i class="fa-solid fa-angle-left" onclick="location.href='/bookie/mypage/mypage.do'"></i>		
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
		   <h3 style="text-align: center;">Main Profile</h3>	    
		   	<div class="gravatar">
			    <img id="img-satya" src="${pageContext.request.contextPath}/resources/images/book-club-8.png" alt="내사진">
		    </div>
		    <p class="form-label">아이디 :</p>
		      <input class="form-field" id="memberId" name="memberId" type="text" value="${loginMember.memberId}" required readonly>
		    <div id="nickname-container">
		    	<p class="form-label" style="margin-top: 10px; color: orange;">닉네임 : </p>
		        <input class="form-field" id="form-nickname" name="newNickname" type="text" onblur="nickChech();" value="${loginMember.nickname}" required>
				<span class="guide ok" id="nickok">이 닉네임은 사용 가능합니다.</span>
				<span class="guide error" id="nickerror1">이 닉네임은 이미 사용중입니다.</span>
				<span class="guide error" id="nickerror2">이 닉네임은 유효하지 않습니다.</span>
				<input type="hidden" id="nicknameValid" name="nicknameValid" value="0" /> <%-- 사용불가 0 사용가능 중복검사 통과 시 1 --%>
			</div>		    
		  	<p class="form-label">Gender</p>
		    <label>
		        <input type="radio" name="gender" value="M" ${loginMember.gender eq 'M' ? 'checked' : ''} required>남
		    </label>
		    <label>
	          	<input type="radio" name="gender" value="F" ${loginMember.gender eq 'F' ? 'checked' : ''} required>여
	        </label>
	        <p class="form-label">Phone Number:</p>
	           <input class="form-field" type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" value="${loginMember.phone}" required>
		    <p class="form-label">Date of Birth:</p>
		       <input class="form-field" type="date" min="2001/01/01" value="" required>
	        <p class="form-label">관심 장르 :</p>
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
	        <div id="submit-btn">
	          <input type="submit" value="정보수정">
	          <input type="reset"  value="취소">
	        </div>
	      </form:form>
	  </div>
</section>

<script>

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

/* 이메일본인인증 */
$('#mail-Check-Btn').click(function() {
	const eamil = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
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

// 인증번호 비교 
// blur -> focus가 벗어나는 경우 발생
$('.mail-check-input').blur(function () {
	const inputCode = $(this).val();
	const $resultMsg = $('#mail-check-warn');
	
	if(inputCode === code){
		$resultMsg.html('인증번호가 일치합니다.');
		$resultMsg.css('color','green');
		$('#mail-Check-Btn').attr('disabled',true);
		$('#userEamil1').attr('readonly',true);
		$('#userEamil2').attr('readonly',true);
		$('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
         $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
	}else{
		$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
		$resultMsg.css('color','red');
	}
});

document.querySelector("#memberId").addEventListener('keyup', (e) => {
	const memberIdVal = e.target.value;
	const ok = document.querySelector(".guide.ok");
	const error = document.querySelector(".guide.error");
	const idValid = document.querySelector("#idValid");
	
	if(memberIdVal.length < 4){
		error.style.display = "inline";	
		ok.style.display = "none";	
		idValid.value = "0";
		return;
	}
	//console.log(memberIdVal);
	
	$.ajax({
		url : '${pageContext.request.contextPath}/member/checkIdDuplicate.do',
		data : {
			memberId : memberIdVal
		},
		success(resp){
			//console.log(resp);
			const {memberId, available} = resp;
			
			if(available){
				error.style.display = "none";	
				ok.style.display = "inline";	
				idValid.value = "1";
			}
			else{
				error.style.display = "inline";	
				ok.style.display = "none";	
				idValid.value = "0";
			}
		},
		error(jqxhr, statusText, err){
			console.log(jqxhr, statusText, err);
			const {responseJSON : {error}} = jqxhr;
			alert(error);
		}
	});
});

/* 폼 제출시 유효성 검사 */
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