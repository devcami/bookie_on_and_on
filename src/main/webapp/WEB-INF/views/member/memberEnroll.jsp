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
   <h1>회원가입</h1>
   <form:form 
      name="memberEnrollFrm" 
      method="POST"
      enctype="multipart/form-data"
      action = "${pageContext.request.contextPath}/member/memberEnroll.do">
      <h4 class="text-left">필수 입력 사항<span class="text-warning">❊</span></h4>
      <table class="mx-auto"> 
         <tr>
            <th><span class="text-warning">❊</span> 아이디</th>
            <td>
               <div id="memberId-container">
                  <input type="text" 
                        class="form-control" 
                        placeholder="영문자/숫자로 4글자 이상"
                        name="memberId" 
                        id="memberId"
                        value=""
                        required>
                  <span class="guide ok">이 아이디는 사용 가능합니다.</span>
                  <span class="guide error">이 아이디는 사용 불가능합니다..</span>
                  <input type="hidden" id="idValid" value="0" /> <%-- 사용불가 0 사용가능 중복검사 통과 시 1 --%>
               </div>
            </td>
         </tr>
         <tr>
            <th><span class="text-warning">❊</span> 패스워드</th>
            <td>
               <input type="password" class="form-control" name="password" id="password" value="" placeholder="영문자/숫자/특수문자!@#$%^&*()로 6글자 이상 - 지금은1234돼요 안막았음" required>
            </td>
         </tr>
         <tr>
            <th><span class="text-warning">❊</span>패스워드확인</th>
            <td>   
               <input type="password" class="form-control" id="passwordCheck" value="" required>
            </td>
         </tr>  
         <tr>
            <th><span class="text-warning">❊</span>닉네임</th>
            <td>
               <div id="nickname-container">
                  <input type="text" 
                        class="form-control" 
                        placeholder="한글/영문자/숫자 2글자 이상"
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
            <th><span class="text-warning">❊</span>이메일</th>
            <td>   
               <input type="email" class="form-control" name="email" id="email" value="" required>
            </td>
         </tr>
         <tr>
            <th></th>         
            <td >   
               <button type="button" class="btn btn-primary w-100" id="mail-Check-Btn">본인인증</button>
               <input class="form-control mail-check-input mt-2" placeholder="이메일 인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
               <p class="text-center" id="mail-check-warn" style="display:none;"></p>
            </td>
         </tr>
         <tr>
            <th><span class="text-warning">❊</span>이름</th>
            <td>   
               <input type="text" class="form-control" name="name" id="name" value="" required>
            </td>
         </tr>
         <tr>
            <th><span class="text-warning">❊</span>휴대폰</th>
            <td>   
               <input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" value="" required>
            </td>
         </tr>
         <tr>
            <th><span class="text-warning">❊</span>성별</th>
            <td>
               <div class="form-check form-check-inline">
                  <input type="radio" class="form-check-input" name="gender" id="gender0" value="M" >
                  <label  class="form-check-label" for="gender">남</label>&nbsp;
                  <input type="radio" class="form-check-input" name="gender" id="gender1" value="F" >
                  <label  class="form-check-label" for="gender">여</label>
               </div>
            </td>
         </tr>
         <tr class="p3"><td colspan="2" class="sub-text">선택사항</td></tr>
         <tr>
            <th>생년월일</th>
            <td>   
               <input type="date" class="form-control" name="birthday" id="birthday" value=""/>
            </td>
         </tr> 
         <tr>
            <th>자기소개 한마디</th>
            <td>   
               <input type="text" class="form-control none" name="introduce" placeholder="자신을 소개하는 한마디를 적어주세요 !" id="introduce" value=""/>
            </td>
         </tr> 
         <tr>
            <th>프로필사진</th>
            <td>   
               <div>
                  <img src="" class="rounded-circle m-2"  alt="미리보기" id="profileImg" style="display: none; width: 75px;"/>
               </div>
               <input type="file" name="upFile" id="upFile" onchange="loadImage(this);" />
            </td>
         </tr> 
         <tr>
            <th>sns</th>
            <td>   
               <input type="text" class="form-control none" name="sns" id="sns" value=""/>
            </td>
         </tr> 
         <tr>
            <th>관심 장르</th>
            <td>
               <div class="interest-div text-center">
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest0" value="경제">
                  <label class="interest-label" for="interest0">경제</label>
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest1" value="공학">
                  <label class="interest-label" for="interest1">공학</label>
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest2" value="문학">
                  <label class="interest-label" for="interest2">문학</label>
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest3" value="자기계발">
                  <label class="interest-label" for="interest3">자기계발</label>
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest4" value="언어">
                  <label class="interest-label" for="interest4">언어</label>
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest5" value="취미">
                  <label class="interest-label" for="interest5">취미</label>
                  <br />
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest6" value="에세이">
                  <label class="interest-label" for="interest6">에세이</label>
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest7" value="예술">
                  <label class="interest-label" for="interest7">예술</label>
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest8" value="교육">
                  <label class="interest-label" for="interest8">교육</label>
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest9" value="인문학">
                  <label class="interest-label" for="interest9">인문학</label>
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest10" value="종교">
                  <label class="interest-label" for="interest10">종교</label>
                  <input type="checkbox" class="interest-input" name="interestEnroll" id="interest11" value="기타">
                  <label class="interest-label" for="interest11">기타</label>
                </div>
            </td>
         </tr>
      </table>
      <div class="m-4">
         <button type="submit" class="btn btn-primary w-25 m-2" >가입</button>
         <button type="button" class="btn btn-secondary w-25 m-2" onclick="location.href='${pageContext.request.contextPath}'">취소</button>
      </div>
   </form:form>
</div>
<script>

<%-- 이메일 인증하기 --%>
$('#mail-Check-Btn').click(function() {
   const email = document.querySelector('#email').value; // 이메일 주소값 얻어오기!
   console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
   const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
   
   $.ajax({
      method : 'get',
      url : "${pageContext.request.contextPath}/member/mailCheck?email=" + email, // GET방식이라 Url 뒤에 email을 붙힐수있다.
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


<%-- img 미리보기 --%>
const loadImage = (input) => {
    console.log(input.files);
    if(input.files[0]){
       const fr = new FileReader();
       fr.readAsDataURL(input.files[0]);
       fr.onload = (e) => {
          console.log(e.target.result);
          const profileImg = document.querySelector("#profileImg"); 
          profileImg.src = e.target.result
          profileImg.style.display = "inline";
      }
   }
}   
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
   
   // id 
   if(!/^[a-zA-Z0-9]{4,}$/.test(memberId.value)){
      e.preventDefault();
      alert("아이디는 최소 4글자 이상의 영문자/숫자만 가능합니다.");
      return false;
   }
   
   if(idValid.value !== "1"){
      e.preventDefault();
      alert("유효한 아이디를 입력해주세요.");
      return false;
   }
   
   // nickname
   const nickname = document.querySelector("#nickname");
   if(!/^[0-9가-힣a-zA-Z]{2,}$/.test(nickname.value)){
      e.preventDefault();
      alert("닉네임은 최소 2글자 이상의 한글/영문자/숫자만 가능합니다.");
      return false;
   }
   const nicknameValid = document.querySelector("#nicknameValid");
   if(nicknameValid.value !== "1"){
      e.preventDefault();
      alert("유효한 닉네임을 입력해주세요.");
      return false;
   }
   
   const password = document.querySelector("#password");
   // password 영문자/숫자/특수문자!@#$%^&*()
   //if(!/^[A-Za-z0-9!@#$%^&*()]{6,}$/.test(password.value)){
   //우리가 쓸 땐 1234로 되게 해놀게여
   if(!/^[a-zA-Z0-9]{4,}$/.test(password.value)){
      e.preventDefault();
      alert("비밀번호는 영문자/숫자/특수문자!@#$%^&*()로 6글자 이상이어야 합니다.");
      return false;
   }
   
   // 패스워드 일치여부 검사
   if(passwordValidator()){
      e.preventDefault();
      return false;
   }
   
   // name
   
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

const passwordValidator = () => {
   const password = document.querySelector("#password");
   const passwordCheck = document.querySelector("#passwordCheck");
   if(password.value !== passwordCheck.value){
      alert("두 비밀번호가 일치하지 않습니다.");
      passwordCheck.select();
      return false;
   }
}
//document.querySelector("#passwordCheck").addEventListener('blur', passwordValidator);
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />