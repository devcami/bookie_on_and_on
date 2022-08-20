<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recommendUser.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="유저 추천" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<section id="content">
	<div id="container-div">
		<c:forEach items="${list}" var="follow" varStatus="vs">
			<p>${follow}</p>
		
		</c:forEach>
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