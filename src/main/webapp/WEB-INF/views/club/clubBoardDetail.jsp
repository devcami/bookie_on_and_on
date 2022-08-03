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
${clubBoard.chatComments}
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
			<div class="input-group p-2 mb-2" id="comment-input">
				<input type="text" class="form-control" name="content" id="comment-content" placeholder="댓글을 작성해주세요." aria-label="댓글을 작성해주세요." aria-describedby="button-comment">
				<div class="input-group-append">
					<button class="btn" type="button" id="btn-enroll-comment" onclick="enrollComment();">등록</button>
				</div>
	    	</div>
	    	
	    	<%-- 일반 댓글 --%>
	    	<c:forEach items="${clubBoard.chatComments}" var="comment" varStatus="vs">
		    	<div class="card shadow comment-one mb-2" id="comment${comment.commentNo}">
					<div class="card-body">
						<div class="d-flex flex-start">
							
							<%-- <c:if test="${loginMember.renamedFilename != null}"> --%>
							<img 
								class="rounded-circle shadow-1-strong m-1" 
								src="${pageContext.request.contextPath}/resources/upload/profile/${loginMember.renamedFilename}" 
								alt="avatar" width="40" height="40">
							<%-- </c:if> --%>
							<div class="">
								<div class="m-1 comment-div d-flex justify-content-between  align-items-start">
									<h6 class="ml-2 mb-0 comment-nickname d-inline">
										${comment.nickname} 
									</h6>
									<span class="text-dark" id="comment-content${comment.commentNo}">${comment.commentContent}</span>
									<fmt:parseDate value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
									<span class="mb-0 text-secondary">
										<fmt:formatDate value="${createdAt}" pattern="yyyy/MM/dd HH:mm"/>
									</span>
								</div>
								<div class="text-right mr-2">
									<p class="small mb-0 pr-2" style="color: #aaa;">
									<c:if test="${comment.nickname == loginMember.nickname}">
										<a href="#!" class="link-grey" onclick="commentDel(this);" data-comment-no="${comment.commentNo}">삭제</a> • 
										
										<a href="#!" id="updateBtn${comment.commentNo}" class="link-grey" onclick="showCommentUpdate(this);" data-comment-no="${comment.commentNo}">수정</a> • 
									</c:if>
										<a href="#!" class="link-grey" onclick="commentRef(this);" data-comment-no="${comment.commentNo}">답글</a>
									</p>
								</div>
							</div>
						</div>
						<div class="coCommentDiv">
							
						</div>
					</div>
				</div>
	    	
	    	
	    	
	    	</c:forEach>
	    	
			
			
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

<%-- 게시글 삭제 요청 --%>
const deleteClubBoard = () => {
	if(confirm("정말 삭제하시겠습니까?")){
		document.deleteClubBoardFrm.submit();	
	}
}

<%-- 게시글 수정 요청 --%>
const updateClubBoard = () => {
	
	const chatNo = "${clubBoard.chatNo}";
	
	location.href = `${pageContext.request.contextPath}/club/updateClubBoard.do/\${chatNo}`;
}

<%-- 댓글 등록 비동기 --%>
const enrollComment = () => {
	const commentVal = document.querySelector('#comment-content').value;
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
	
	$.ajax({
		url : '${pageContext.request.contextPath}/club/commentEnroll.do',
		method : 'post',
		headers,
		data : {
			nickname : '${loginMember.nickname}',
			chatNo : '${clubBoard.chatNo}',
			commentContent : commentVal
		},
		success(resp){
			console.log(resp);
			const {chatNo, commentContent, commentNo} = resp;
			const container = document.querySelector("#comment-input")
			
			var today = new Date();

			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);
			var hours = ('0' + today.getHours()).slice(-2); 
			var minutes = ('0' + today.getMinutes()).slice(-2)
			
			const createdAt = year + "/" + month + "/" + day + " " + hours + ":" + minutes;
			
			const div = `
				<div class="card shadow comment-one mb-2" id="comment\${commentNo}">
					<div class="card-body">
						<div class="d-flex flex-start">
							<img class="rounded-circle shadow-1-strong m-1" src="" alt="avatar" width="40" height="40">
							
							<div class="">
								<div class="m-1 comment-div d-flex justify-content-between  align-items-start">
									<h6 class="ml-2 mb-0 comment-nickname d-inline">
										${loginMember.nickname}
									</h6>
									<span class="text-dark" id="comment-content\${commentNo}">\${commentContent}</span>
									
									<span class="mb-0 text-secondary">
										\${createdAt}
									</span>
								</div>
								<div class="text-right mr-2">
									<p class="small mb-0 pr-2" style="color: #aaa;">
										<a href="#!" class="link-grey" onclick="commentDel(this);" data-comment-no="\${commentNo}">삭제</a> • 
										
										<a href="#!" class="link-grey" id="updateBtn\${commentNo}" onclick="showCommentUpdate(this);" data-comment-no="\${commentNo}">수정</a> • 

										<a href="#!" class="link-grey" onclick="commentRef(this);" data-comment-no="\${commentNo}">답글</a>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>`;
				
				container.insertAdjacentHTML('afterend', div);
				container.value = '';
					
			/* location.reload(); */
		},
		error:console.log
	});
	
}

<%-- 댓글 삭제 --%>
const commentDel = (e) => {
	console.log(e.dataset.commentNo);
	const commentNo = e.dataset.commentNo;
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
	
	if(confirm('댓글을 삭제하시겠습니까?')){
		$.ajax({
			url : '${pageContext.request.contextPath}/club/commentDel.do',
			method : 'post',
			headers,
			data : {
				commentNo : commentNo,
			},
			success(resp){
				const deleteCommentId = "#comment" + commentNo;
				$(deleteCommentId).remove();
				
			},
			error:console.log
		});
	}
};


<%-- 댓글 수정 화면 바꿔 --%>
let originalComment;
const showCommentUpdate = (e) => {
	const commentNo = e.dataset.commentNo;
	const id = '#comment-content' + commentNo
	// console.log(id);
	const chatNo = '${param.chatNo}';
	// console.log(chatNo);
	const content = document.querySelector(id);
	// console.log(content);
	
 	if(e.innerText == '수정'){
		const contentInnerText = content.innerText;
		//console.log(contentInnerText);
		originalComment = contentInnerText;
		//console.log("e.innerText == 수정", e.innerText == '수정');
		const input = `<input type="text" name="content" id="commentText\${commentNo}" value="\${content.innerText}" class="updateCommentInput"/>
					   <button class="btn" type="button" id="btn-update-comment\${commentNo}" onclick="updateComment(this)" data-comment-no="\${commentNo}">수정</button>`;
		content.innerHTML = "";
		content.insertAdjacentHTML('beforeend', input);
		
		e.innerText="취소";	
	}
	else{
		//console.log(content);
		content.innerHTML = originalComment;
		e.innerText = "수정";	
	}
	const p = document.querySelector(".text-right.mr-2");
	p.style.position = 'relative';
	p.style.bottom = '7px';
};

<%-- 댓글 수정 비동기 --%>
const updateComment = (e) => {
	const commentNo = e.dataset.commentNo
	
	const originalDivId = '#comment-content' + commentNo
	
	// 원래 댓글 담기는 곳
	const container = document.querySelector(originalDivId);
	// console.log(container);
	
	const inputId = "#commentText" + commentNo; 
	const btnId = "#btn-update-comment" + commentNo;

	// 수정한 내용 들고와
	const commentContent = document.querySelector(inputId).value;
	// console.log("수정한 내용 = ", commentContent);

	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
	
	$.ajax({
		url: "${pageContext.request.contextPath}/club/commentUpdate.do",
		method : "POST",
		headers,
		data : {
			commentNo : commentNo,
			commentContent : commentContent
		},
		success(resp){
			console.log(resp);
			// Input 지워
			$(inputId).remove();
			// 버튼 지워
			$(btnId).remove();
			// 원래 내용 추가해
			container.innerHTML = commentContent;
			
			// 취소로 바꿔
			document.getElementById(`updateBtn\${commentNo}`).innerHTML = '수정';
		},
		error: console.log
	});
	
	
}

<%-- 답글 --%>
const commentRef = (e) => {
	const commentNo = e.dataset.commentNo;
	const div = ``;
};

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>