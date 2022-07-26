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
		<div class="" id="dokoo-info">
			<div id="book-info" class=" p-4">
				<span id="book-title"></span>
				<span id="book-author"></span>
				<p id="book-category" class="text-secondary"></p>
			</div>
			<div class="p-3" id="writer">
				<!-- 프로필사진 -->				
				<img class="rounded-circle shadow-1-strong m-1"
							src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(26).webp"
							alt="avatar" width="40" height="40" />
							
				<span class="p-2">${dokoo.member.nickname}</span>
				<p class="text-secondary">
					<fmt:parseDate value="${dokoo.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate"/>
					<fmt:formatDate value="${enrollDate}" pattern="yyyy/MM/dd HH:mm"/>
				</p>
			</div>
		</div>
		<div class="" id="dokoo-desc">
			<p class="text-dark">${dokoo.content}</p>
		</div>
	</div>
	<div id="comment-container">
		<hr class="m-4"/>
		<!-- 좋아요 버튼 -->
		<div class="dokoo-sns">
			<div class="dokoo-sns-icons">
				<div class="btn-group" role="group" aria-label="Basic example">
					<span class="fa-stack fa-lg" id='h-span'>
					  <i class="fa fa-heart fa-regular fa-stack-1x front" ></i>
					</span>
					<span class="fa-stack fa-lg" id='b-span'>
					  <i class="fa fa-bookmark fa-regular fa-stack-1x front"></i>
					</span>
				  <button type="button" data-toggle="modal" data-target="#reportModal" 
				  			class="btn" id="btn-report"><i class="fa-solid fa-ellipsis"></i></button>
				</div>
			</div>
			<div class="dokoo-sns-cal" id="sns-cal">
			</div>
		</div>
		
		<!-- 댓글작성폼 -->
		<form name="dokooCommentFrm">
			<div class="input-group p-2 mb-2">
				<input type="hidden" class="form-control" name="memberId" value="loginMemberId">
				<input type="text" class="form-control" name="content" placeholder="댓글을 작성해주세요." aria-label="댓글을 작성해주세요." aria-describedby="button-comment">
				<div class="input-group-append">
					<button class="btn" type="button" id="btn-enroll-comment" onclick="enrollComment();">등록</button>
				</div>
	    	</div>
		</form>
		
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
window.addEventListener('load', () => {
	const bookTitle = document.querySelector("#book-title");
	const bookAuthor = document.querySelector("#book-author");
	const bookCategory = document.querySelector("#book-category");
	
	$.ajax({
		url : '${pageContext.request.contextPath}/search/selectBook.do',
		data : {
			ttbkey : 'ttbiaj96820130001',
			itemIdType : 'ISBN13', 
			ItemId : ${dokoo.itemId},
			output : 'js',
			Cover : 'Big',
			Version : '20131101'
		},
		success(resp){
			const {item} = resp;
			//console.log(item);
			let {title, subInfo, author, pubDate, description, isbn13, cover, customerReviewRank, categoryId, categoryName, publisher} = item[0];			
			const {subTitle, itemPage} = subInfo;
			bookTitle.innerText = title;
			bookAuthor.innerText = author;
			bookCategory.innerText = categoryName;
		},
		error : console.log
	});
});

</script>
<%-- 신고창 모달 --%>
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="reportModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="reportModalLabel">신고</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form name="dokooReportFrm" method="post" action="${pageContext.request.contextPath}/pheed/pheedReport.do">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">작성자</label>
            <input type="text" class="form-control" id="memberId" value="로긴멤버아이디" readonly>
            <input type="hidden" class="form-control" id="category" value="dokoo"/>          
          </div>
          <div class="form-group">
            <p class="col-form-label">신고 내용</p>
          	<div class="alert alert-danger alert-dismissible fade show" role="alert" id="alert" style="display:none">
			  내용을 10자 이상 작성해주세요 !
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
            <textarea class="form-control" id="report-content" placeholder="신고 내용을 작성해주세요."></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-danger" onclick="report();">신고하기</button>
      </div>
    </div>
  </div>
</div>
<%-- 신고창 폼 제출 --%>
<script>
const report = () => {
	const content = document.querySelector("#report-content").value;
	//console.log(content);
	const alert = document.querySelector("#alert");
	if(!/.{10,}$/.test(content)){
		alert.style.display = "block";
		return;
	}
	if(confirm('신고를 제출하시겠습니까?')){
		document.dokooReportFrm.submit();	
		document.dokooReportFrm.reset();
	}else{
		return;
	}
};

document.querySelector("#report-content").addEventListener('keyup', (e) => {
	const val = e.target.value;
	if(val.length > 10){
		document.querySelector("#alert").style.display = "none";
	}
});

<%-- heart / bookmark --%>
window.addEventListener('load', (e) => {
	document.querySelector("#h-span").addEventListener('click', (e) => {
			// 부모한테 이벤트 전파하지마셈
			e.stopPropagation(); 
			
			// 클릭할때마다 상태왔다갔다
			changeIcon(e.target, 'heart');
	});	
});

window.addEventListener('load', (e) => {
	document.querySelector("#b-span").addEventListener('click', (e) => {
			// 부모한테 이벤트 전파하지마셈
			e.stopPropagation(); 
			
			// 클릭할때마다 상태왔다갔다
			changeIcon(e.target, 'bookmark');
	});	
});


const changeIcon = (icon, shape) => {
	let cnt = icon.parentElement.childElementCount;
	
	const iHeart = `<i class="fa fa-heart fa-solid fa-stack-1x h-behind"></i>`;
	const iBookMark = `<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind"></i>`;
	
	
	if(cnt==1) {
		if(shape == 'heart'){
			icon.parentElement.insertAdjacentHTML('beforeend', iHeart);
		}
		else {
			icon.parentElement.insertAdjacentHTML('beforeend', iBookMark);
		}
	}
	else {
		icon.parentElement.removeChild(icon.parentElement.lastElementChild);
	}
	
	

}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>