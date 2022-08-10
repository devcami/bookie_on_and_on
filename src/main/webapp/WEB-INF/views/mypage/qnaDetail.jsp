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
<section id="content">
	<div id="top-title" class="text-center m-3">
		<h1>📝 답변 확인 📝</h1>
	</div>
	<div class="p-4" id="qna-enroll-div">
		<div id="memberId-div" class="mb-2">
			<label for="memberId">작성자</label>
			<br />
			<input type="text" name="memberId" id="memberId" value="${qna.memberId}" readonly />
		</div>
		<div id="title-div">
			<label for="title">제목</label>
			<br />
			<input type="text" id="title" name="title" value="${qna.title}" readonly/>
		</div>
		<div id="content-div" class="mb-5">
			<label for="content">내용</label>
			<br />
			<textarea name="content" id="content" readonly>${qna.content}</textarea>
		</div>
		<hr />
		<c:if test="${qna.status eq 'U'}">
		<div class="text-center mt-5 mb-5">
			<h2>[답변대기중]</h2>
			<p>잠시만 기다려주세요 !</p>
		</div>
		</c:if>
		<c:if test="${qna.status eq 'E'}">
		<div id="comment-div" class="mt-5 mb-5">
			<h2>답변내용</h2>
			<c:forEach items="${qna.qnaCommentList}" var="comment">
				<textarea name="commentContent" class="commentContent" readonly>${comment.commentContent}</textarea>
			</c:forEach>
		</div>
		</c:if>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<hr />
			<div id="comment-enroll-div" class="text-center">
				<form:form 
					method="post"
					action="${pageContext.request.contextPath}/admin/qnaCommentEnroll.do">
					<h1>답변 작성란</h1>
					<textarea name="commentContent" id="commentContent"></textarea>
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type="hidden" name="qnaNo" value="${param.qnaNo}" />
					<input type="hidden" name="memberId" value="${loginMember.memberId}" />
					<div id="btn-div">
						<button type="submit">답변</button>
					</div>
				</form:form>
			</div>
		</sec:authorize> 
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>