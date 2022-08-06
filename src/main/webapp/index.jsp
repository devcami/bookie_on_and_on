<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css" />
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북이온앤온" name="title"/>
</jsp:include>
	<section id="content">
		<div class="article main-banner" onclick="location.href='${pageContext.request.contextPath}/search/intro.do';">
			<img src="${pageContext.request.contextPath}/resources/images/main-banner.png" alt="메인배너" />
		</div>
		<div class="article book-club-ann">
			<img src="${pageContext.request.contextPath}/resources/images/book-club-8.png" alt="북클럽공고" onclick="location.href='${pageContext.request.contextPath}/club/clubListMonth.do'"/>
			<div class="button d-grid col-md-10 mx-auto">
				<button type="button" class="btn btn-lg" onclick="location.href='${pageContext.request.contextPath}/club/clubList.do'">북클럽 더보기 + </button>
			</div>
		</div>
		<div class="article goto">
			<div class="button d-grid col-md-12" onclick="location.href='${pageContext.request.contextPath}/search/recommendUser.do'">
				<p class="col-md-12 m-0 small">${loginMember.nickname}님을 위한</p>
				<p><i class="fa-solid fa-hand-point-right"></i></p>
				<p class="col-12 m-0">추천 유저</p>
			</div>
		</div>
		<div class="article goto">
			<div class="button d-grid col-12" onclick="location.href='${pageContext.request.contextPath}/search/categoryList.do'" >
				<p class="col-12 m-0 small">신간 | 베스트</p>
				<p><i class="fa-solid fa-hand-point-right"></i></p>
				<p class="col-12 m-0">분야별 도서 보기</p>
			</div>
		</div>
		<div class="article goto">
			<div class="button d-grid col-12" onclick="location.href='${pageContext.request.contextPath}/pheed/pheedCList.do'">
				<p class="col-12 m-0 small">이 부분 어때요?</p>
				<p><i class="fa-solid fa-hand-point-right"></i></p>
				<p class="col-12 m-0">피드 둘러보기</p>
			</div>
		</div>
		
	</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
