<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pheed.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dokoo.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이스크랩" name="title"/>
</jsp:include>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>
<div id="pheed-container" >
	<div id="pheed-header">
		<div class="btns m-0">
			<button type="button" class="btn btn-lg btn-link btn-pheed" onclick="location.href='${pageContext.request.contextPath}/mypage/myScrap.do'">독후감</button>
			<button type="button" class="btn btn-lg btn-link btn-pheed" onclick="location.href='${pageContext.request.contextPath}/mypage/myScrapPheedCList.do'">피드</button>
			<button type="button" class="btn btn-lg btn-link btn-pheed" onclick="location.href='${pageContext.request.contextPath}/mypage/myScrapClubList.do'">북클럽</button>
		</div>
	</div>
</div>
<div id="dokoo-container" class="p-3 m-3" style="background-image:url('${pageContext.request.contextPath}/resources/images/background_dokoo.PNG');">
	<section id="content" class="">
		<div id="title" class="text-center">
			<h1>📙 찜한 독후감 📙</h1>
			<button type="button" class="btn btn-lg btn-link" id="btn-dokoo-enroll" onclick="location.href='${pageContext.request.contextPath}/dokoo/dokooEnroll.do';">
				<i class="fa-solid fa-plus"></i>
			</button>
		</div>
		<div class="dokoo-list">
			<table class="table table-hover">
				<thead>
					<tr class="tr">
						<th scope="col">No</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="dokoo" varStatus="vs">
					<fmt:parseDate value="${dokoo.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate"/>
						<tr data-no="${dokoo.dokooNo}">
							<td class="dokoo-no">
								${totalMyDokoo - ((cPage - 1) * 10 + vs.index)}
							</td>
							<td class="dokoo-title">${dokoo.title}</td>
							<td class="dokoo-nickname">${dokoo.member.nickname}</td>
							<td class="dokoo-date">
								<fmt:formatDate value="${enrollDate}" pattern="yyyy/MM/dd HH:mm"/>
							</td>
						</tr>						
					</c:forEach>
				</tbody>
			</table>
		</div>
	</section>
	<div class="pagebar">
		<nav class="pagination-outer">${pagebar}</nav>
	</div>
</div>
<script>
window.addEventListener('load', (e) => {
	document.querySelectorAll("tr[data-no]").forEach((tr) => {
		tr.addEventListener('click', (e)=>{
			const tr = e.target.parentElement;
			//console.log(tr);
			
			if(tr.matches('tr[data-no]')){
				const dokooNo = tr.dataset.no; 
				console.log(dokooNo);
				location.href = '${pageContext.request.contextPath}/dokoo/dokooDetail.do?dokooNo=' + dokooNo;
			}
		});
	});
});
document.querySelector("#btn-dokoo-enroll").addEventListener('mouseenter', (e) => {
	e.target.innerHTML = "<span>글쓰기</span>";
});
document.querySelector("#btn-dokoo-enroll").addEventListener('mouseleave', (e) => {
	e.target.innerHTML = "<i class='fa-solid fa-plus'></i>";
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>