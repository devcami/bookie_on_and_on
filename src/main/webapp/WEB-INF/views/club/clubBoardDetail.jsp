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
	<jsp:param value="북클럽 게시판 글" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
${clubBoard.member}
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
		<div id="board-div">
			 <div id="content-top">
		 		<div id="top-title" class="text-center">
					<h1>${clubBoard.title}</h1>
				</div> 		
				<div id="date-writer-div">
					<div id="writerDiv">
						<img class="rounded-circle shadow-1-strong m-1"
							src="${pageContext.request.contextPath}/resources/upload/profile/${clubBoard.member.renamedFilename}"
							alt="avatar" width="40" height="40" />
						<span>${clubBoard.nickname}</span>					
					</div>
					
					<span id="enrollDate">
						<fmt:parseDate value="${clubBoard.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate"/>
						<fmt:formatDate value="${enrollDate}" pattern="yyyy/MM/dd HH:mm"/>
					</span>
				</div>
	 		</div>
	 		<div id="content-bottom">
				<div id="file-div">
					<c:forEach items="${clubBoard.chatAttachments}" var="attach">		
						<img src="${pageContext.request.contextPath}/resources/upload/club/${attach.renamedFilename}" class="imgs" />
					</c:forEach>
				</div>
				<div id="content-div">
					${clubBoard.content}	
				</div>
	 			<c:if test="${loginMember.nickname eq clubBoard.nickname}">
					<div id="btn-div">
						<button type="button" onclick="updateClubBoard();">수정</button>
						<button type="button" onclick="deleteClubBoard();">삭제</button>
					</div>								
				</c:if>
				
	 		</div>
		</div>
		
		<hr class="m-4">
		
		<div id="comment-container">
			<%-- 댓글 입력 창 --%>
			<div class="input-group p-2 mb-2">
				<input type="text" class="form-control" name="content" id="comment-content" placeholder="댓글을 작성해주세요." aria-label="댓글을 작성해주세요." aria-describedby="button-comment">
				<div class="input-group-append">
					<button class="btn" type="button" id="btn-enroll-comment" onclick="enrollComment();">등록</button>
				</div>
	    	</div>
	    	
	    	<%-- 일반 댓글 --%>
	    	<div class="card shadow comment-one mb-2" id="comment1">
				<div class="card-body">
					<div class="d-flex flex-start">
						
						
						<img class="rounded-circle shadow-1-strong m-1" src="" alt="avatar" width="40" height="40">
						
						<div class="">
							<div class="m-1 comment-div d-flex justify-content-between  align-items-start">
								<h6 class="ml-2 mb-0 comment-nickname d-inline">
									승윤 
								</h6>
								<span class="text-dark" id="comment-content1">엄청 길게 댓글을 작성한 다음에 수정하려고 하면 폼의 상태는 어떻게 될것인지 ? 정말 모르겟다 . 그래서 테스트를 해보려 한다.</span>
								
								<span class="mb-0 text-secondary">
									2022/08/01 22:09
								</span>
							</div>
							<div class="text-right mr-2">
								<p class="small mb-0 pr-2" style="color: #aaa;">
									<a href="#" class="link-grey" onclick="commentDel(this);" data-dokoocno="23">삭제</a> • 
									
									<a href="#!" class="link-grey" onclick="commentUpdate(this);" data-dokoocno="23" data-vs="1">수정</a> • 
									
									<a href="#!" class="link-grey" onclick="commentRef(this);" data-dokoocno="23">답글</a>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			
			<%-- 답글 --%>

 		</div>

	</section>

</div>

<form:form
	name="deleteClubBoardFrm"
	action="${pageContext.request.contextPath}/club/deleteClubBoard.do"
	method="POST">
	<input type="hidden" name="chatNo" value="${clubBoard.chatNo}" />
	<input type="hidden" name="clubNo" value="${clubBoard.clubNo}" />
</form:form>


<script>

const deleteClubBoard = () => {

	document.deleteClubBoardFrm.submit();
}

const updateClubBoard = () => {
	
	const chatNo = "${clubBoard.chatNo}";
	
	location.href = `${pageContext.request.contextPath}/club/updateClubBoard.do/\${chatNo}`;
}

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>