<%@page import="org.springframework.security.core.authority.SimpleGrantedAuthority"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.bookie.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자페이지" name="title"/>
</jsp:include>
<section id="content">

	<div class="container">
      <div class="row">
        <div class="col-12">
          <div class="row col-12 btn-group">
          	<a href="${pageContext.request.contextPath}/admin/memberList.do" class="btn yellow"    id="member" >회원목록</a>
			<a href="${pageContext.request.contextPath}/admin/reportList.do" class="btn red"    id="report" >신고</a>
			<a href="${pageContext.request.contextPath}/admin/qnaList.do" class="btn purple" id="question">Q & A</a>
			<a href="${pageContext.request.contextPath}/admin/sendAlarm.do" class="btn green"  id="alarm">알림전송</a>
			<a href="${pageContext.request.contextPath}/club/missionCheck.do" class="btn blue"  id="mission">미션확인</a>
	     </div>
        </div>
      </div>
    </div>

	<div class="container mt-4">
		<div class="card ">
			<div class="card-header">${report.memberId}님의 신고내역</div>
			<div class="card-body">
				<p class="card-text">${report.content}</p>
				<p class="card-text text-muted">
					<fmt:parseDate value="${report.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
					<fmt:formatDate value="${createdAt}" pattern="yyyy/MM/dd HH:mm"/>
				</p>
			</div>
			<div class="card-footer ">
				<form:form name="statusFrm" id="status" class="m-0"
						method="post" action="${pageContext.request.contextPath}/admin/reportUpdate.do?reportNo=${report.reportNo}">
					<label >처리상태</label>				
					<input type="radio" name="status" value="U" class="ml-5" ${report.status eq 'U' ? 'checked' : ''}/>
					<label for="O" class="ml-1">처리전</label>
					<input type="radio" name="status" value="E" class="ml-5" ${report.status eq 'E' ? 'checked' : ''}/>
					<label for="E" class="ml-1">처리완료</label>
					<button type="submit" class="btn btn-outline-success float-right">변경</button>
				</form:form>
			</div>
		</div>
		
	</div>
	
	<h1 class="text-center mt-5">신고글 내용 확인</h1>	
	
	<%-- 상세내역 --%>
	<%-- 독후감 일 때 --%>
	<div id="check-div" class="text-center">
	<c:if test="${report.category eq 'dokoo' || report.category eq 'dokoo_comment'}">
		<c:if test="${empty dokoo}">
			<h1>삭제 처리가 완료된 신고입니다.</h1>
		</c:if>
		<c:if test="${not empty dokoo}">
		<input type="button" class="m-4 btn btn-lg btn-outline-danger" onclick="deleteReport(this);" data-beenzi-no="${report.beenziNo}" data-category="${report.category}" value="신고 발생한 글 | 댓글 삭제"/>
		<section id="dokoo-content" class="rounded mt-5">
			<div id="dokoo-title">
				<p>"${dokoo.title}"</p>
			</div>
			<div id="dokoo-container">
				<div class="" id="dokoo-info">
					<div id="book-info" class=" p-4">
						<span id="book-title"></span> <span id="book-author"></span>
						<p id="book-category" class="text-secondary"></p>
					</div>
					<div class="p-3" id="writer">
						<!-- 프로필사진 -->
						<img class="rounded-circle shadow-1-strong m-1"
							src="${pageContext.request.contextPath}/resources/upload/profile/${dokoo.member.renamedFilename}"
							alt="avatar" width="40" height="40" /> <span class="p-2">${dokoo.member.nickname}</span>
						<p class="text-secondary">
							<fmt:parseDate value="${dokoo.enrollDate}"
								pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate" />
							<fmt:formatDate value="${enrollDate}" pattern="yyyy/MM/dd HH:mm" />
						</p>
					</div>
				</div>
				<div class="" id="dokoo-desc">
					<p class="text-dark">${dokoo.content}</p>
				</div>
			</div>
			<div id="comment-container" class="mt-4">
				<div id="comment-wrapper" class="p-2">
					<%-- 일반 댓글 --%>
					<c:forEach items="${dokoo.dokooComments}" var="comment"
						varStatus="vs">
	
						<%-- 댓글인 경우 --%>
						<c:if test="${comment.commentRef eq 0}">
							<div class="co-div flex-center comment-div" 
								id="comment${comment.dokooCNo}"
								${comment.dokooCNo == report.beenziNo ? 'style="background-color:#d156564a;"' : ''}					
								>
								<div class="co-left flex-center">
									<div class="co-writer flex-center">
										<img class="rounded-circle shadow-1-strong m-1"
											<%-- loginMember가 아니고 댓글단 사람 프로필 가져와야돼 --%>
										<c:if test="${not empty comment.renamedFilename}">
		                         			src="${pageContext.request.contextPath}/resources/upload/profile/${comment.renamedFilename}"
										</c:if>
										<c:if test="${empty comment.renamedFilename}">
		                         			src="${pageContext.request.contextPath}/resources/images/icon/none-profile-img.png"
										</c:if>
										alt="avatar" width="40" height="40"> <span>${comment.nickname}</span>
									</div>
									<div class="co-Content" id="contentDiv${comment.dokooCNo}">
										<span id="contentSpan${comment.dokooCNo}">${comment.content}</span>
									</div>
								</div>
								<div class="co-right">
									<span class="text-secondary"> <fmt:parseDate
											value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm"
											var="createdAt" /> <fmt:formatDate value="${createdAt}"
											pattern="yyyy/MM/dd HH:mm" />
									</span>
								</div>
							</div>
						</c:if>
						<%-- 댓글 끝 --%>
	
						<%-- 대댓글 --%>
						<c:if test="${comment.commentRef ne 0}">
							<div class="co-div flex-center coComment-div"
								id="coComment${comment.dokooCNo}"
								${comment.dokooCNo == report.beenziNo ? 'style="background-color:#d156564a;"' : ''}
								>
								<div class="co-left flex-center" style="margin-left: 40px;">
									↳
									<div class="co-writer flex-center">
										<img class="rounded-circle shadow-1-strong m-1"
											<%-- loginMember가 아니고 댓글단 사람 프로필 가져와야돼 --%>
										<c:if test="${not empty comment.renamedFilename}">
		                         			src="${pageContext.request.contextPath}/resources/upload/profile/${comment.renamedFilename}"
										</c:if>
										<c:if test="${empty comment.renamedFilename}">
		                         			src="${pageContext.request.contextPath}/resources/images/icon/none-profile-img.png"
										</c:if>
											alt="avatar" width="40" height="40"> <span>${comment.nickname}</span>
									</div>
									<div class="co-Content" id="contentDiv${comment.dokooCNo}">
										<span id="contentSpan${comment.dokooCNo}">${comment.content}</span>
									</div>
								</div>
								<div class="co-right">
									<span class="text-secondary"> <fmt:parseDate
											value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm"
											var="createdAt" /> <fmt:formatDate value="${createdAt}"
											pattern="yyyy/MM/dd HH:mm" />
									</span>
								</div>
							</div>
						</c:if>
						<%-- 대댓글 끝 --%>
	
					</c:forEach>
				</div>
	
			</div>
		</section>
		</c:if>
	</c:if>
		
	<%-- 피드일 때 --%>
	<c:if test="${report.category eq 'pheed' || report.category eq 'pheed_comment'}">
		<c:if test="${empty pheed}">
			<h1>삭제 처리가 완료된 신고입니다.</h1>
		</c:if>
		<c:if test="${not empty pheed}">
		<input type="button" class="m-4 btn btn-lg btn-outline-danger" onclick="deleteReport(this);" data-beenzi-no="${report.beenziNo}" data-category="${report.category}" value="신고 발생한 글 | 댓글 삭제"/>
		<fmt:parseDate value="${pheed.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate"/>
		<div class="pheed-container shadow bg-white">
			<div class="pheed-writer">
				<div class="profile">
					<c:if test="${pheed.member.renamedFilename != null}">
						<img src="${pageContext.request.contextPath}/resources/upload/profile/${pheed.member.renamedFilename}" alt="프로필사진" />
					</c:if>
					<c:if test="${pheed.member.renamedFilename == null}">
						<img src="${pageContext.request.contextPath}/resources/images/icon/none-profile-img.png" alt="프로필사진" />
					</c:if>
				</div>
				<h2>${pheed.member.nickname}</h2>
			</div>
			<c:if test="${pheed.attach != null}">
				<div class="pheed-img">
					<img src="${pageContext.request.contextPath}/resources/upload/pheed/${pheed.attach.renamedFilename}" alt="" />
				</div>
			</c:if>
			<div class="pheed">
				<div class="pheed-content">
					<div class="book-info">
						<span class="pheed-book-title" id="book-title-pheed"></span>
						<span class="pheed-book-page">[${pheed.page}p]</span>
						<p><fmt:formatDate value="${enrollDate}" pattern="yyyy.MM.dd HH:mm"/></p>
					</div>
					<p>${pheed.content}</p>
				</div>
			</div>
		</div>
		<%-- 피드 댓글 --%>
		<div id="comment-container" class="m-4">
			<div id="comment-wrapper" class="p-2">
				<%-- 일반 댓글 --%>
				<c:forEach items="${commentList}" var="comment" varStatus="vs">

					<%-- 댓글인 경우 --%>
					<c:if test="${comment.commentRef eq 0}">
						<div class="co-div flex-center comment-div"
							id="comment${comment.pheedCNo}"						
							${comment.pheedCNo == report.beenziNo ? 'style="background-color:#d156564a;"' : ''}
							>
							<div class="co-left flex-center">
								<div class="co-writer flex-center">
									<img class="rounded-circle shadow-1-strong m-1"
										<%-- loginMember가 아니고 댓글단 사람 프로필 가져와야돼 --%>
										<c:if test="${not empty comment.renamedFilename}">
		                         			src="${pageContext.request.contextPath}/resources/upload/profile/${comment.renamedFilename}"
										</c:if>
										<c:if test="${empty comment.renamedFilename}">
		                         			src="${pageContext.request.contextPath}/resources/images/icon/none-profile-img.png"
										</c:if>
										alt="avatar" width="40" height="40"> <span>${comment.nickname}</span>
								</div>
								<div class="co-Content" id="contentDiv${comment.pheedCNo}">
									<span id="contentSpan${comment.pheedCNo}">${comment.content}</span>
								</div>
							</div>
							<div class="co-right">
								<span class="text-secondary"> <fmt:parseDate
										value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm"
										var="createdAt" /> <fmt:formatDate value="${createdAt}"
										pattern="yyyy/MM/dd HH:mm" />
								</span>
							</div>
						</div>
					</c:if>
					<%-- 댓글 끝 --%>

					<%-- 대댓글 --%>
					<c:if test="${comment.commentRef ne 0}">
						<div class="co-div flex-center coComment-div"
							id="coComment${comment.pheedCNo}"
							${comment.pheedCNo == report.beenziNo ? 'style="background-color:#d156564a;"' : ''}
							>
							<div class="co-left flex-center" style="margin-left: 40px;">
								↳
								<div class="co-writer flex-center">
									<img class="rounded-circle shadow-1-strong m-1"
										<%-- loginMember가 아니고 댓글단 사람 프로필 가져와야돼 --%>
										<c:if test="${not empty comment.renamedFilename}">
		                         			src="${pageContext.request.contextPath}/resources/upload/profile/${comment.renamedFilename}"
										</c:if>
										<c:if test="${empty comment.renamedFilename}">
		                         			src="${pageContext.request.contextPath}/resources/images/icon/none-profile-img.png"
										</c:if>
										alt="avatar" width="40" height="40"> <span>${comment.nickname}</span>
								</div>
								<div class="co-Content" id="contentDiv${comment.pheedCNo}">
									<span id="contentSpan${comment.pheedCNo}">${comment.content}</span>
								</div>
							</div>
							<div class="co-right">
								<span class="text-secondary"> <fmt:parseDate
										value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm"
										var="createdAt" /> <fmt:formatDate value="${createdAt}"
										pattern="yyyy/MM/dd HH:mm" />
								</span>
							</div>
						</div>
					</c:if>
					<%-- 대댓글 끝 --%>
				</c:forEach>
			</div>
		</div>
		</c:if>
	</c:if>
	</div>
</section>
<script>
window.addEventListener('load', () => {
	const bookTitlePheed = document.querySelector("#book-title-pheed");
	const bookTitle = document.querySelector("#book-title");
	const bookAuthor = document.querySelector("#book-author");
	const bookCategory = document.querySelector("#book-category");
	
	const itemId = ${not empty dokoo.itemId ? dokoo.itemId : pheed.itemId}; 
	
	$.ajax({
		url : '${pageContext.request.contextPath}/search/selectBook.do',
		data : {
			ttbkey : 'ttbiaj96820130001',
			itemIdType : 'ISBN13', 
			ItemId : itemId,
			output : 'js',
			Cover : 'Big',
			Version : '20131101'
		},
		success(resp){
			const {item} = resp;
			//console.log(item);
			let {title, subInfo, author, pubDate, description, isbn13, cover, customerReviewRank, categoryId, categoryName, publisher} = item[0];			
			const {subTitle, itemPage} = subInfo;
			if(bookAuthor != null && bookCategory != null && bookTitle != null){
				bookTitle.innerText = title;
				bookAuthor.innerText = author;
				bookCategory.innerText = categoryName;
			}
			if(bookTitlePheed != null){
				bookTitlePheed.innerText = title;
			}
		},
		error : console.log
	});
});


const deleteReport = (e) => {
	console.log(e.dataset.beenziNo);	
	console.log(e.dataset.category);	
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	if(confirm('신고당한 글 | 댓글을 삭제하시겠습니까?')){
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/reportDelete.do", 
			method : 'post',
			headers,
			data : {
				beenziNo : e.dataset.beenziNo,
				category : e.dataset.category
			},
			success(resp){
				const checkDiv = document.querySelector("#check-div");
				const div = `<h1>삭제 처리가 완료된 신고입니다.</h1>`;
				checkDiv.innerHTML = "";
				checkDiv.insertAdjacentHTML('beforeend', div);
			},
			error : console.log
		});
		
	}
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>