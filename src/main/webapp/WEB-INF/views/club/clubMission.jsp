<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMission.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽 미션" name="title"/>
</jsp:include>
${clubNo}
${memberId}
${missions}
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>
<section id="content">
	<div id="menuDiv">
		<ul>
			<li id="first-li" class="menu-li" style="background-color: #F76E11;"><a href="${pageContext.request.contextPath}/club/clubDetail.do/${clubNo}">메인페이지</a></li>
			<li id="second-li" class="menu-li" style="background-color: #FF9F45;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${clubNo}">북클럽 스토리</a></li>
			<li id="third-li" class="menu-li" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do/${clubNo}">게시판</a></li>
			<li id="fourth-li" class="menu-li nowPage" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${clubNo}/${loginMember.username}">미션</a></li>
			<li id="fifth-li" class="menu-li" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/club/clubChat.do/${clubNo}">채팅..?</a></li>		
		</ul>
	</div>

	<div id="menu">
		<h1>나의 미션</h1>	
	</div>
	<div id="mission-wrapper">
		<div class="mission-container">
			<div class="mission-left">
				<span>시작!</span>
			</div>
			<div id="bar-first" class="mission-bar">
				<i class="fa-solid fa-circle fa-circle-border"></i>
				<i class="fa-solid fa-circle fa-circle-inside" style="color: #3AB4F2"></i>
			</div>
		</div>
		
		<c:forEach items="${missions}" var="mission" varStatus="vs">
			<div class="mission-container">
				<div class="mission-left">
					<span>통과되었습니다!</span>
				</div>
				<div class="mission-bar">
					<i class="fa-solid fa-circle fa-circle-border"></i>
					<i class="fa-solid fa-circle fa-circle-inside" style="color: #3AB4F2"></i>
				</div>
				<div class="mission-card">
					<img src="${fn:replace(mission.imgSrc, 'covermini', 'cover')}" onclick="">
					<span>mission.title</span>
					<span>mission.point</span>
				</div>
			</div>		
		</c:forEach>
	</div>
	
</section>

<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>