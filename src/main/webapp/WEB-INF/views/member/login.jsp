<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css" />
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp" >
<jsp:param value="로그인" name="title"/>
</jsp:include>
<section style="min-height:800px;">

<div class="global-container">
	<div class="card login-form ">
		<div class="card-body">
			<h1 class="card-title text-center">로그인</h1>
			<div class="card-text">
				<form:form method="post" name="loginFrm">
					<c:if test="${param.error != null}">
						<div class="alert alert-danger alert-dismissible fade show" role="alert">
							<span class="text-plain">아이디 또는 비밀번호가 일치하지 않습니다.</span>
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
					</c:if>
					<label for="exampeleInputEmail1">회원 아이디👨‍👩‍👦‍👦</label> 
					<input type="text" class="form-control form-control-sm" name="memberId"
						placeholder="User ID..." required>
					<br />
					<label for="exampeleInputPassword">비밀번호🔒</label> 
					<input type="password" class="form-control form-control-sm"
						id="password" name="password" placeholder="User Password..."
						required>
					<div class="text-center">
						<input type="checkbox" class="form-check-input" name="remember-me" id="remember-me" />
						<label for="remember-me" class="form-check-label">Remember me</label>
					</div>
					<div class="text-center m-3">
						<a href="#" class="text-secondary">아이디찾기</a> | 
						<a href="#" class="text-secondary">비밀번호 찾기</a>
					</div>
					<button type="submit" class="btn btn-primary btn-block">로그인</button>
					<button type="button" class="btn btn-primary btn-block" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do'">회원가입</button>
					<a href="${pageContext.request.contextPath}/kakao_login.do" id="kakaolink">
						<img id="kakao" src="${pageContext.request.contextPath}/resources/images/icon/kakao_login_medium_wide.png">
					</a>
				</form:form>
			</div>
		</div>
	</div>
</div>
</section>
<script>
//카카오로그인
Kakao.init('057ff0aa472813117d2205a428300779');
//초기화 여부 판단
console.log('초기화여부판단:',Kakao.isInitialized());

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />