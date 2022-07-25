<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dokoo.css" />
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="독후감" name="title"/>
</jsp:include>
<div id="title-header" class="" style="display:none">
	<p id="title-p">
		<i class="fa-solid fa-angle-left" onclick="location.href='${pageContext.request.contextPath}/dokoo/dokooList.do'"></i>
		${dokoo.title}
	</p>
</div>
<section id="dokoo-content">
	<div id="dokoo-title">
		<p>"${dokoo.title}"</p>
	</div>
	<div id="dokoo-container">
		<div class="p-3" id="dokoo-info">
			${dokoo.enrollDate}
		</div>
		<div class="p-3" id="dokoo-content">
			<p class="text-dark">${dokoo.content}</p>
		</div>
	</div>
	<div id="comment-container">
		<hr class="m-4"/>
		<!-- 좋아요 버튼 -->
		<div class="dokoo-sns">
			<div class="dokoo-sns-icons">
				<div class="btn-group" role="group" aria-label="Basic example">
				  <button type="button" class="btn"><i class="fa-regular fa-heart"></i></button>
				  <button type="button" class="btn"><i class="fa-regular fa-bookmark"></i></button>
				  <button type="button" data-toggle="modal" data-target="#reportModal" 
				  			class="btn" id="btn-report"><i class="fa-solid fa-ellipsis"></i></button>
				</div>
			</div>
			<div class="dokoo-sns-cal" id="sns-cal">
			</div>
		</div>
		
		<!-- 댓글작성폼 -->
		<div class="input-group p-2 mb-2">
			<input type="text" class="form-control" name="content" placeholder="댓글을 작성해주세요." aria-label="댓글을 작성해주세요." aria-describedby="button-comment">
			<div class="input-group-append">
				<button class="btn" type="button" id="btn-enroll-comment" onclick="enrollComment();">등록</button>
			</div>
    	</div>
		
		<!-- 댓글 확인 -->
		<c:forEach items="${dokoo.dokooComments}" var="comment" varStatus="vs">
			<div class="card m-2 shadow" id="comment-one">
				<div class="card-body p-3">
					<div class="d-flex flex-start">
						<img class="rounded-circle shadow-1-strong m-1"
							src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(26).webp"
							alt="avatar" width="40" height="40" />
						<div class="w-100">
							<div
								class="d-flex justify-content-between align-items-center m-1">
								<h6 class="ml-2 mb-0" id="comment-nickname">
									${comment.nickname} <span class="text-dark">${comment.content}</span>
								</h6>
								<fmt:parseDate value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
								<p class="mb-0 text-secondary">
									<fmt:formatDate value="${createdAt}" pattern="yyyy/MM/dd HH:mm"/>
								</p>
							</div>
							<div class="text-right m-1">
								<p class="small mb-0" style="color: #aaa;">
									<a href="#!" class="link-grey">삭제</a> • 
									<a href="#!" class="link-grey">답글</a>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>


		</c:forEach>
		
	</div>
	
</section>
<script>
	let header = document.querySelector("#header-container")
	let headerHeight = header.clientHeight;
	const titlebar = document.querySelector("#title-header");
	window.onscroll = function() {
		let windowTop = window.scrollY;
		if (windowTop >= headerHeight) {
			titlebar.classList.add("drop");
			titlebar.style.display = "inline";
		} else {
			titlebar.classList.remove("drop");
			titlebar.style.display = "none";
		}
	};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>