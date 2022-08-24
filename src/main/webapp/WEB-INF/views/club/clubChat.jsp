<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubChat.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽 채팅" name="clubChat"/>
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
				<li id="third-li" class="menu-li" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do?clubNo=${clubNo}">게시판</a></li>
				<li id="fourth-li" class="menu-li" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${clubNo}/${loginMember.username}">미션</a></li>
				<li id="fifth-li" class="menu-li nowPage" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/chat/clubChat.do/${clubNo}">채팅</a></li>		
			</ul>
		</div>
		
		<h1 class="mb-4" style="text-align: center;">🌼북클럽 채팅🌼</h1>
		
		<div id="chatList">
			<c:forEach items="${chatLogList}" var="chat" varStatus="vs">
				<%-- 내가 보낸 채팅일 경우 --%>
				<c:if test="${loginMember.username eq chat.memberId}">
					<div class="chatDiv myChatDiv">
						<div class="imgDiv">
							<img 
								class="rounded-circle shadow-1-strong"
								src="${pageContext.request.contextPath}/resources/upload/profile/${chat.renamedFilename}"
								style = "width: 40px; height: 40px;" />				
						</div>
						<div class="myChat">
							<span class="nickname">${chat.nickname}</span>
							<span class="chatMsgSpan">${chat.msg}</span>		
							<span class="msgTime" style="text-align: left; margin-right: 5px;"><fmt:formatDate value="${chat.dateTime}" pattern="yyyy/MM/dd HH:mm"/></span>		
						</div>
					</div>
				</c:if>
				
				<%-- 남이 보낸 채팅인 경우 --%>
				<c:if test="${loginMember.username ne chat.memberId}">
					<div class="chatDiv">
						<img 
							class="rounded-circle shadow-1-strong"
							src="${pageContext.request.contextPath}/resources/upload/profile/${chat.renamedFilename}" 
							style = "width: 40px; height: 40px;"/>
						<div class="otherChat">
							<span class="nickname">${chat.nickname}</span>
							<span class="chatMsgSpan">${chat.msg}</span>				
							<span class="msgTime" style="text-align: right; margin-right: 10px"><fmt:formatDate value="${chat.dateTime}" pattern="yyyy/MM/dd HH:mm"/></span>
						</div>
					</div>
				</c:if>
				
			</c:forEach>
			
			<div id="alertDiv" style="display: none;" onclick="goToBottom();">
				<span id="alertNickname">썬구리고양이 : </span>
				<span id="alertMsg">깔깔깔깔깔 무슨소리하는거야</span>
			</div>
			
		</div>
		
		<div id="chatHead" class="mt-2" >
			<input type="text" id="msgInput" placeholder="메세지를 입력하세요." />
			<button type="button" id="sendBtn" class="ml-1">전송</button>
		</div>
	</section>

</div>

<script>
	const chatroomId = '${chatroomId}';
	const url = "${pageContext.request.contextPath}";
	let profile = "";
	let nickname = "";
	
	window.addEventListener('load', () => {
		
		document.querySelector("#chatList").scrollTop = document.querySelector("#chatList").scrollHeight;

		$.ajax({
			url : `${pageContext.request.contextPath}/chat/getProfileAndNickname.do/\${memberId}`,
			method: "GET",
			success(resp) {
				console.log(resp);
				profile = resp.renamedFilename;
				nickname = resp.nickname;

			},
			error: console.log
		});
	});
	
	$('#chatList').scroll(function () {

		const alertDiv = document.querySelector("#alertDiv");
		const container = document.querySelector("#chatList");
		
		let height = Math.round($('#chatList').scrollTop()) + 550;
		alertDiv.style.top = height;
		

		const scrollTop = Math.ceil(container.scrollTop);
		const scrollHeight = container.scrollHeight;
		const innerHeight = $(container).innerHeight();
		
		if(scrollTop + innerHeight + 10 >= scrollHeight) {
			alertDiv.style.display = 'none';
		}

	}); 
	
	const goToBottom = () => {
		document.querySelector("#chatList").scrollTop = document.querySelector("#chatList").scrollHeight;
	}
</script>
<script src="${pageContext.request.contextPath}/resources/js/clubChat.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>