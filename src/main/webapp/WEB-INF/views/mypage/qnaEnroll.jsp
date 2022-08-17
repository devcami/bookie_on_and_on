<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubAnn.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/qnaList.css" />
<script src='${pageContext.request.contextPath}/resources/js/main.js'></script>
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="나의QNA목록" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<!-- 뒤로가기 -->
<div id="title-header">
	<div id="header-div">
		<div id="title-header-left">
			<i class="fa-solid fa-angle-left" onclick="location.href='${pageContext.request.contextPath}/mypage/qnaList.do?memberId=${loginMember.memberId}'"></i>		
		</div>
	</div>
</div>
<section id="content" style="min-height:800px;">
	<div id="top-title" class="text-center m-3">
		<h1>📝 문의글 작성 📝</h1>
	</div>
	<div class="p-4" id="qna-enroll-div">
		<form:form
			name="qnaEnrollFrm"
			method="POST"
			action = "${pageContext.request.contextPath}/mypage/enrollQna.do">
			<div id="memberId-div" class="mb-2">
				<label for="memberId">작성자</label>
				<br />
				<input type="text" name="memberId" id="memberId" value="${loginMember.memberId}" readonly />
			</div>
			<div id="title-div">
				<label for="title">제목</label>
				<br />
				<input type="text" id="title" name="title"/>
			</div>
			<div id="content-div">
				<label for="content">내용</label>
				<br />
				<textarea name="content" id="content"></textarea>
			</div>
			
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			<div id="btn-div">
				<button type="submit">제출</button>
			</div>
		
		</form:form>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>