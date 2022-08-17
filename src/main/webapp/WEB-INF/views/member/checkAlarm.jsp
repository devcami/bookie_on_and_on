<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/checkAlarm.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽리스트" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<section id="content" style="min-height:800px;">
	<h1>알림</h1>	
	<c:forEach items="${list}" var="alarm">
		<div class="card p-3 mt-3 shadow" onclick="readAlarm(this)" data-alarm-no="${alarm.alarmNo}">
			<c:if test="${alarm.lastCheck == 0}">
				<div class="rounded-circle" id="unreadCheck"></div>
			</c:if>
			<div class="card-body">
				<p class="alarmContent">${alarm.alarmContent}</p>
				<fmt:parseDate value="${alarm.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
				<p class="text-secondary float-right"><fmt:formatDate value="${createdAt}" pattern="yyyy/MM/dd HH:mm"/></p>
			</div>
		</div>
	</c:forEach>
</section>

<script>
const readAlarm = (e) => {
	const alarmNo = e.dataset.alarmNo;
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	$.ajax({
		url: '${pageContext.request.contextPath}/member/readAlarm.do',
		method:'post',
		headers,
		data:{
			alarmNo
		},
		success(resp){
			document.querySelector("#unreadCheck").classList.add('d-none');	
			
			const {unreadCount} = resp;
			
			if(unreadCount == 0)
				unreadCountSpan.classList.add('d-none');
			else
				unreadCountSpan.innerText = unreadCount;
		},
		error: console.log
		
	});
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>