<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/member/login.jsp">
	<jsp:param value="회원등록" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberEnroll.css" />

   <div id="enroll-container" class="mx-auto text-center">
        <form:form name="memberEnrollFrm" action="" method="POST">
            <table class="mx-auto">
                <tr>
                    <th>아이디</th>
                    <td>
                        <div id="memberId-container">
                            <input type="text" 
                                   class="form-control form-control-sm" 
                                   placeholder="4글자이상"
                                   name="memberId" 
                                   id="memberId"
                                   value="honggd"
                                   required>
                            <span class="guide ok">이 아이디는 사용가능합니다.</span>
                            <span class="guide error">이 아이디는 이미 사용중입니다.</span>
                            <input type="hidden" id="idValid" value="0" /> <!-- 0-사용불가 1-사용가능 -->
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>패스워드</th>
                    <td>
                        <input type="password" class="form-control form-control-sm" name="password" id="password" value="1234" required>
                    </td>
                </tr>
                <tr>
                    <th>패스워드확인</th>
                    <td>	
                        <input type="password" class="form-control form-control-sm" id="passwordCheck" value="1234" required>
                    </td>
                </tr>  
                <tr>
                    <th>닉네임</th>
                    <td>	
                        <input type="text" class="form-control form-control-sm" name="name" id="name" value="홍길동" required>
                    </td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td>	
                        <input type="text" class="form-control form-control-sm" name="name" id="name" value="홍길동" required>
                    </td>
                </tr>
                <tr>
                    <th>휴대폰</th>
                    <td>	
                        <input type="tel" class="form-control form-control-sm" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" value="01012341234" required>
                    </td>
                </tr>
                <tr>
                    <th>성별 </th>
                    <td>
                        <div class="form-check form-check-inline">
                            <input type="radio" class="form-check-input" name="gender" id="gender0" value="M">
                            <label  class="form-check-label" for="gender0">남</label>&nbsp;
                            <input type="radio" class="form-check-input" name="gender" id="gender1" value="F">
                            <label  class="form-check-label" for="gender1">여</label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>생년월일</th>
                    <td>	
                        <input type="date" class="form-control" name="birthday" value="1999-09-09" id="birthday"/>
                    </td>
                </tr> 
                <tr>
                    <th>이메일</th>
                    <td>	
                        <input type="email" class="form-control" placeholder="abc@xyz.com" name="email" id="email" value="honggd@naver.com">
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
	
	if(memberIdVal.length < 4) {
		error.style.display = "none";
		ok.style.display = "none";
		idValid.value = 0;
		return;
	}
	console.log(memberIdVal);
	
	$.ajax({
		url : '${pageContext.request.contextPath}/member/checkIdDuplicate.do',
		data : {
			memberId : memberIdVal
		},
		success(response){
			console.log(response);
			const {memberId, available} = response;
			
			if(available){
				error.style.display = "none";
				ok.style.display = "inline";
				idValid.value = 1;
			}
			else {
				error.style.display = "inline";
				ok.style.display = "none";
				idValid.value = 0;
			}
		},
		error(jqxhr, statusText, err){
			console.log(jqxhr, statusText, err);
			
			const {responseJSON : {error}} = jqxhr;
			alert(error);
		}
		
	});
	
});


document.memberEnrollFrm.addEventListener('submit', (e) => {
	const memberId = document.querySelector("#memberId");
	const idValid = document.querySelector("#idValid")
	
	if(!/^\w{4,}$/.test(memberId.value)){
		alert("아이디는 최소 4글자이상의 영문자/숫자만 가능합니다.");
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
		password.select();
	}
};
document.querySelector("#passwordCheck").addEventListener('blur', passwordValidator);


</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
