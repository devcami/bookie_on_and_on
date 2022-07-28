<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css" />
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp" >
<jsp:param value="회원가입" name="title"/>
</jsp:include>
<div id="enroll-container" class="mx-auto text-center">
	<form:form name="memberEnrollFrm" action="" method="POST">
		<table class="mx-auto"> 
			<tr><td colspan="2">여기는 필수사항</td></tr>
			<tr>
				<th>아이디</th>
				<td>
					<div id="memberId-container">
						<input type="text" 
							   class="form-control" 
							   placeholder="4글자이상"
							   name="memberId" 
							   id="memberId"
							   value=""
							   required>
						<span class="guide ok">이 아이디는 사용 가능합니다.</span>
						<span class="guide error">이 아이디는 이미 사용중입니다.</span>
						<input type="hidden" id="idValid" value="0" /> <%-- 사용불가 0 사용가능 중복검사 통과 시 1 --%>
					</div>
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" class="form-control" name="password" id="password" value="" required>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" class="form-control" id="passwordCheck" value="" required>
				</td>
			</tr>  
			<tr>
				<th>닉네임</th>
				<td>
					<div id="nickname-container">
						<input type="text" 
							   class="form-control" 
							   placeholder="2글자이상"
							   name="nickname" 
							   id="nickname"
							   value=""
							   required>
						<span class="guide ok1" id="nickok">이 닉네임은 사용 가능합니다.</span>
						<span class="guide error1" id="nickerror">이 닉네임은 이미 사용중입니다.</span>
						<input type="hidden" id="nicknameValid" value="0" /> <%-- 사용불가 0 사용가능 중복검사 통과 시 1 --%>
					</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>	
					<input type="text" class="form-control" name="name" id="name" value="" required>
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>	
					<input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" value="" required>
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>
					<div class="form-check form-check-inline">
						<input type="radio" class="form-check-input" name="gender" id="gender0" value="M" >
						<label  class="form-check-label" for="gender0">남</label>&nbsp;
						<input type="radio" class="form-check-input" name="gender" id="gender1" value="F" >
						<label  class="form-check-label" for="gender1">여</label>
					</div>
				</td>
			</tr>
			<tr><td colspan="2">여기서부터는 선택사항</td></tr>
			<tr>
				<th>생년월일</th>
				<td>	
					<input type="date" class="form-control" name="birthday" id="birthday" value=""/>
				</td>
			</tr> 
			<tr>
				<th>자기소개 한마디</th>
				<td>	
					<input type="text" class="form-control" name="introduce" id="introduce" value=""/>
				</td>
			</tr> 
			<tr>
				<th>프로필사진</th>
				<td>	
					나중에할게요~
				</td>
			</tr> 
			<tr>
				<th>sns</th>
				<td>	
					<input type="text" class="form-control" name="sns" id="sns" value=""/>
				</td>
			</tr> 
			<tr>
				<th>관심 장르</th>
				<td>
					<div class="form-check form-check-inline">
						<input type="checkbox" class="form-check-input" name="interest" id="interest0" value="경제"><label class="form-check-label" for="interest0">경제</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest1" value="공학"><label class="form-check-label" for="interest1">공학</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest2" value="문학"><label class="form-check-label" for="interest2">문학</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest3" value="자기계발"><label class="form-check-label" for="interest3">자기계발</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest4" value="언어"><label class="form-check-label" for="interest4">언어</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest5" value="취미"><label class="form-check-label" for="interest5">취미</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest6" value="에세이"><label class="form-check-label" for="interest6">에세이</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest7" value="예술"><label class="form-check-label" for="interest7">예술</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest8" value="교육"><label class="form-check-label" for="interest8">교육</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest9" value="인문학"><label class="form-check-label" for="interest9">인문학</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest10" value="종교"><label class="form-check-label" for="interest10">종교</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="interest" id="interest11" value="기타"><label class="form-check-label" for="interest11">기타</label>&nbsp;
					 </div>
				</td>
			</tr>
		</table>
		<input type="submit" value="가입" >
		<input type="reset" value="취소">
	</form:form>
</div>
<script>
document.querySelector("#memberId").addEventListener('keyup', (e) => {
	const memberIdVal = e.target.value;
	const ok = document.querySelector(".guide.ok");
	const error = document.querySelector(".guide.error");
	const idValid = document.querySelector("#idValid");
	
	if(memberIdVal.length < 4){
		error.style.display = "none";	
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

document.querySelector("#nickname").addEventListener('keyup', (e) => {
	const nicknameVal = e.target.value;
	const ok = document.querySelector("#nickok");
	const error = document.querySelector("#nickerror");
	const nicknameValid = document.querySelector("#nicknameValid");
	
	// nickname 은 2글자이상 노중복
	if(nicknameVal.length < 2){
		error.style.display = "none";	
		ok.style.display = "none";	
		nicknameValid.value = "0";
		return;
	}
	
	$.ajax({
		url : '${pageContext.request.contextPath}/member/checkNicknameDuplicate.do',
		data : {
			nickname : nicknameVal
		},
		success(resp){
			//console.log(resp);
			const {nickname, available} = resp;
			
			if(available){
				error.style.display = "none";	
				ok.style.display = "inline";	
				nicknameValid.value = "1";
			}
			else{
				error.style.display = "inline";	
				ok.style.display = "none";	
				nicknameValid.value = "0";
			}
		},
		error(jqxhr, statusText, err){
			console.log(jqxhr, statusText, err);
			const {responseJSON : {error}} = jqxhr;
			alert(error);
		}
	});
});



<%-- 유효성 검사 --%>
document.memberEnrollFrm.addEventListener('submit', (e) => {
	const memberId = document.querySelector("#memberId");
	const idValid = document.querySelector("#idValid");
	
	if(!/^\w{4,}$/.test(memberId.value)){
		alert("아이디는 최소 4글자 이상의 영문자/숫자만 가능합니다.");
		e.preventDefault();
		return;
	}
	
	if(idValid.value !== "1"){
		alert("유효한 아이디를 입력해주세요.");
		e.preventDefault();
		return;
	}
});

const passwordValidator = () => {
	const password = document.querySelector("#password");
	const passwordCheck = document.querySelector("#passwordCheck");
	if(password.value !== passwordCheck.value){
		alert("두 비밀번호가 일치하지 않습니다.");
		passwordCheck.select();
	}
}
document.querySelector("#passwordCheck").addEventListener('blur', passwordValidator);
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />