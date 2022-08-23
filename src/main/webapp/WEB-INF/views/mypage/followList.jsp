<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recommendUser.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/follower.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="유저 추천" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<section id="content" style="min-height:800px;">
	<div id="container-div">
		<c:if test="${not empty followerList}">
			<c:forEach items="${followerList}" var="follow" varStatus="vs">
				<div class="card m-2">
					<div class="card-body follow-box d-flex">
						<div class="d-flex" style="align-items: center;">
							<div class="card-profile">
								<c:if test="${not empty follow.member.renamedFilename}">
								<img src="${pageContext.request.contextPath}/resources/upload/profile/${follow.member.renamedFilename}" alt="프로필이미지"/>
								</c:if>
								<c:if test="${empty follow.member.renamedFilename}">
								<i class="fa-solid fa-user-large user-icon follow-icon"></i>
								</c:if>
							</div>
							<div class="user-nickname">
								<a href="${pageContext.request.contextPath}/mypage/mypage.do?memberId=${follow.memberId}" class="card-link ml-3">${follow.member.nickname}</a>
							</div>
						</div>
						<div>
							<label>
								<c:set var="done_loop" value="false"/>
								<c:set var="i" value="1"/>
								<c:forEach items="${myFollowerList}" var="myFollow">
									<c:if test="${done_loop ne true}">
										<c:set var="i" value="1"/>
										<c:if test="${myFollow.followingMemberId eq follow.memberId}">
											<c:set var="i" value="${i+1}"/>
										</c:if>
										<c:if test="${i eq 2}">
											<c:set var="done_loop" value="true"/>
										</c:if>
									</c:if>
								</c:forEach>
								<c:if test="${i eq 2}">
									<c:if test="${loginMember.memberId ne follow.memberId}">
										<input type="checkbox" name="follow-btn" id="follow-btn" class="follow-btn" onclick="followEvent(this);" data-follower-id="${follow.memberId}" checked/>
										<span class="followSpan">follow</span>
									</c:if>
								</c:if>
								<c:if test="${i eq 1}">
									<c:if test="${loginMember.memberId ne follow.memberId}">
										<input type="checkbox" name="follow-btn" id="follow-btn" class="follow-btn" onclick="followEvent(this);" data-follower-id="${follow.memberId}"/>
										<span class="followSpan">follow</span>
									</c:if>
								</c:if>
							</label>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${not empty followingList}">
			<c:forEach items="${followingList}" var="follow" varStatus="vs">
				<div class="card m-2">
					<div class="card-body follow-box d-flex">
						<div class="d-flex" style="align-items: center;">
							<div class="card-profile">
								<c:if test="${not empty follow.member.renamedFilename}">
								<img src="${pageContext.request.contextPath}/resources/upload/profile/${follow.member.renamedFilename}" alt="프로필이미지"/>
								</c:if>
								<c:if test="${empty follow.member.renamedFilename}">
								<i class="fa-solid fa-user-large user-icon follow-icon"></i>
								</c:if>
							</div>
							<div class="user-nickname">
								<a href="${pageContext.request.contextPath}/mypage/mypage.do?memberId=${follow.followingMemberId}" class="card-link ml-3">${follow.member.nickname}</a>
							</div>
						</div>
						<div>
							<label>
								<c:set var="done_loop" value="false"/>
								<c:set var="i" value="1"/>
								<c:forEach items="${myFollowerList}" var="myFollow">
									<c:if test="${done_loop ne true}">
										<c:set var="i" value="1"/>
										<c:if test="${myFollow.followingMemberId eq follow.followingMemberId}">
											<c:set var="i" value="${i+1}"/>
										</c:if>
										<c:if test="${i eq 2}">
											<c:set var="done_loop" value="true"/>
										</c:if>
									</c:if>
								</c:forEach>
								<c:if test="${i eq 2}">
									<c:if test="${loginMember.memberId ne follow.followingMemberId}">
									<input type="checkbox" name="follow-btn" id="follow-btn" class="follow-btn" onclick="followEvent(this);" data-follower-id="${follow.memberId}" checked/>
									<span class="followSpan">follow</span>
									</c:if>
								</c:if>
								<c:if test="${i eq 1}">
									<c:if test="${loginMember.memberId ne follow.followingMemberId}">
									<input type="checkbox" name="follow-btn" id="follow-btn" class="follow-btn" onclick="followEvent(this);" data-follower-id="${follow.memberId}"/>
									<span class="followSpan">follow</span>
									</c:if>
								</c:if>
							</label>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
</section>

<script>

const followEvent = (e) => {
	console.log(e);
	const followingMemberId = e.dataset.followerId;
	console.log(followingMemberId);
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송
	
	// 팔로우 되어있는 사람 취소
	if(!e.checked){
		$.ajax({
			url : '${pageContext.request.contextPath}/search/deleteFollower.do',
			method : 'post',
			headers,
			data : {
				memberId:'${loginMember.memberId}',
				followingMemberId
			},
			success(resp){
				console.log(resp);
				e.checked = false;
			},
			error: console.log
		});
	}
	// 팔로우 안되어있는 사람 등록
	else{
		$.ajax({
			url : '${pageContext.request.contextPath}/search/insertFollower.do',
			method : 'post',
			headers,
			data : {
				memberId:'${loginMember.memberId}',
				followingMemberId
			},
			success(resp){
				console.log(resp);
				e.checked = true;
			},
			error: console.log
		});
	}

}

	

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>