<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubBoardDetail.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽 게시판 글 작성" name="title"/>
</jsp:include>
<span>여긴아니지롱</span>
<%-- <sec:authentication property="principal" var="loginMember"/> --%>
<div id="clubBook-container">
	<section id="content">
		<div id="menuDiv">
			<ul>
				<li id="first-li" class="menu-li" style="background-color: #F76E11;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${club.clubNo}">메인페이지</a></li>
				<li id="second-li" class="menu-li" style="background-color: #FF9F45;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${club.clubNo}">북클럽 스토리</a></li>
				<li id="third-li" class="menu-li nowPage" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do/${clubNo}">게시판</a></li>
				<li id="fourth-li" class="menu-li" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${club.clubNo}/${loginMember.username}">미션</a></li>
				<li id="fifth-li" class="menu-li" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/club/clubChat.do/${club.clubNo}">채팅..?</a></li>		
			</ul>
		</div>
 		<div id="top-title" class="text-center">
			<h1>${clubBoard.title}</h1>
		</div>
		
		<div id="date-writer-div">
			<span>${clubBoard.enrollDate}</span>
			<span>by ${clubBoard.nickname}</span>
		</div>
		
		<div id="file-div">
			<c:forEach items="${clubBoard.chatAttachments}" var="attach">		
				<img src="${pageContext.request.contextPath}/resources/upload/club/${attach.renamedFilename}" />
			</c:forEach>
		</div>
		
		<div id="content-div">
			${clubBoard.content}	
		</div>
		
		<div id="btn-div">
			<button type="button" onclick="">수정</button>
			<button type="button" onclick="">삭제</button>
		</div>
	</section>

</div>


<script>

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>