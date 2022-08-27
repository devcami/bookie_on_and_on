<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubBoard.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽 게시판" name="title"/>
</jsp:include>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>
<div id="clubBook-container">
	<section id="content">
		<div id="menuDiv">
			<ul>
				<li id="first-li" class="menu-li" style="background-color: #F76E11;"><a href="${pageContext.request.contextPath}/club/clubDetail.do/${clubNo}">메인페이지</a></li>
				<li id="second-li" class="menu-li" style="background-color: #FF9F45;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${clubNo}">북클럽 스토리</a></li>
				<li id="third-li" class="menu-li nowPage" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do?clubNo=${clubNo}">게시판</a></li>
				<li id="fourth-li" class="menu-li" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${clubNo}/${loginMember.username}">미션</a></li>
				<li id="fifth-li" class="menu-li" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/chat/clubChat.do/${clubNo}">채팅</a></li>		
			</ul>
		</div>
		<div id="title" class="text-center">
			<h1>📣북클럽 게시판📣</h1>
			
			<%-- 글이 있는 경우! --%>
			<c:if test="${chat.size() ne 0}">
				<div id="sortTypeDiv">
					<a 
						href="${pageContext.request.contextPath}/club/clubBoard.do?clubNo=${clubNo}"
						class="${sortType eq null ? 'textColor' : ''}"
						>최신순</a>
					<a 
						href="${pageContext.request.contextPath}/club/clubBoard.do?clubNo=${clubNo}&sortType=oldList"
						class="${sortType eq 'oldList' ? 'textColor' : ''}"
						>오래된순</a>
				</div>
				<button 
					type="button" 
					class="btn btn-lg btn-link" 
					id="clubBoard-enroll"
					onclick="boardEnroll();">
					<i class="fa-solid fa-plus"></i>
				</button>	
		  	</c:if>
		</div>
		
		<c:if test="${chat.size ne 0}">
			<div id="table-div">
				<table>
				  <thead>
				    <tr class="tr">
				      <th scope="col">No</th>
				      <th scope="col">제목</th>
				      <th scope="col">작성자</th>
				      <th scope="col">작성일</th>
				    </tr>
				  </thead>
				  <tbody>
			  		
				  	<c:forEach items="${list}" var="chat" varStatus="vs">
				  		<tr onclick="showDetailClubBoard(this)">
					      <th scope="row">${chat.chatNo}</th>
					      <td>${chat.title}</td>
					      <td>${chat.nickname}</td>
					      <td>
					      	<fmt:parseDate value="${chat.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate"/>
					      	<fmt:formatDate value="${enrollDate}" pattern="yyyy/MM/dd HH:mm"/>
					     </td>
					    </tr>
				  	</c:forEach>
				  </tbody>
				</table>
			</div>
			
			<nav>${pagebar}</nav>
		</c:if>
		<%-- 글이 있는 경우! 끝 --%>
		
		
		<%-- 글이 없는 경우! --%>
		<c:if test="${chat.size eq 0}">
		<div id="noChatDiv">
			<p id="noChatPfirst">게시글이 아직 없습니다!</p>
			<p id="noChatPsecond">첫 번째 게시글의 작성자가 되어보세요!</p>
			
			<button 
				id="noChatWriteBtn"
				onclick="boardEnroll();"
				class="btn">작성하기</button>
		</div>
		</c:if>		
		<%-- 글이 있는 경우! 끝 --%>
		
		
	</section>

</div>

<form:form 
	action="${pageContext.request.contextPath}/club/clubBoardForm.do"
	method="GET"
	name="clubBoardEnrollFrm">
	<input type="hidden" name="memberId" value="${loginMember.username}" />
	<input type="hidden" name="clubNo" value="${clubNo}" />
</form:form>


<script>
	const boardEnroll = () => {
		
		const frm = document.clubBoardEnrollFrm;
		frm.submit();
		
	}
	
	const showDetailClubBoard = (e) => {
		const chatNo = e.firstElementChild.innerHTML;
		location.href = `${pageContext.request.contextPath}/club/clubBoardDetail.do?chatNo=` + chatNo;  
	}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>