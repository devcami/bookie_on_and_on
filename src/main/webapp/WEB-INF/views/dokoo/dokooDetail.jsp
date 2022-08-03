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
<sec:authentication property="principal" var="loginMember"/>
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
					  <i class="fa fa-heart fa-regular fa-stack-1x front" id="like" data-dokoo-no="${dokoo.dokooNo}"></i>
					</span>
					<span class="fa-stack fa-lg" id='b-span'>
					  <i class="fa fa-bookmark fa-regular fa-stack-1x front" id="bookmark" data-dokoo-no="${dokoo.dokooNo}"></i>
					</span>
			
					<button type="button" data-no="${dokoo.dokooNo}"  onclick="openReportModal(this);" 
						class="btn" id="btn-report"><i class="fa-solid fa-ellipsis"></i></button>
					<c:if test="${dokoo.member.nickname eq loginMember.nickname}">
					<button type="button" class="float-right btn-sm btn-update mr-2" onclick="updateDokoo();">수정</button>	
					<button type="button" class="float-right btn-sm btn-delete mr-2" onclick="deleteDokoo();">삭제</button>	
					</c:if>
				</div>
			</div>
			<div class='likes-div'>						
				<span>좋아요</span>&nbsp;
				<span class='likes' id="likesCnt"></span>
				<span>개</span>					
			</div>
		</div>
		
		<!-- 댓글작성폼 -->
		<div class="input-group p-2 mb-2">
			<input type="text" class="form-control" name="content" id="comment-content" placeholder="댓글을 작성해주세요." aria-label="댓글을 작성해주세요." aria-describedby="button-comment">
			<div class="input-group-append">
				<button class="btn" type="button" id="btn-enroll-comment" onclick="enrollComment();">등록</button>
			</div>
    	</div>
		
		<!-- 댓글 확인 -->
		<c:forEach items="${dokoo.dokooComments}" var="comment" varStatus="vs">
			<!-- 일반 댓글 -->
			<c:if test="${comment.commentRef == 0}"> 
			<div class="card shadow comment-one mb-2" id="comment${vs.count}">
				<div class="card-body">
					<div class="d-flex flex-start">
						<c:if test="${loginMember.renamedFilename == null}">
						<div class="d-inline profile">
							<i class="fa-solid fa-user-large user-icon"></i>
						</div>
						</c:if>
						<c:if test="${loginMember.renamedFilename != null}">
						<img class="rounded-circle shadow-1-strong m-1"
							src="${pageContext.request.contextPath}/resources/upload/profile/${loginMember.renamedFilename}"
							alt="avatar" width="40" height="40" />
						</c:if>
						<div class="">
							<div
								class="m-1 comment-div d-flex justify-content-between  align-items-start" >
								<h6 class="ml-2 mb-0 comment-nickname d-inline">
									${comment.nickname} 
								</h6>
								<span class="text-dark" id="comment-content${vs.count}">${comment.content}</span>
								<fmt:parseDate value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
								<span class="mb-0 text-secondary">
									<fmt:formatDate value="${createdAt}" pattern="yyyy/MM/dd HH:mm"/>
								</span>
							</div>
							<div class="text-right mr-2">
								<p class="small mb-0 pr-2" style="color: #aaa;">
									<a href="#" class="link-grey" onclick="commentDel(this);" data-dokoocno="${comment.dokooCNo}">삭제</a> • 
									<c:if test="${comment.nickname == loginMember.nickname}">
									<a href="#!" class="link-grey" onclick="commentUpdate(this);" data-dokoocno="${comment.dokooCNo}" data-vs="${vs.count}">수정</a> • 
									</c:if>
									<a href="#!" class="link-grey" onclick="commentRef(this);" data-dokoocno="${comment.dokooCNo}">답글</a>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:if>
			<!-- 답글 -->
			<c:if test="${comment.commentRef != 0}">
			</c:if>
		</c:forEach>
		
	</div>
<form:form name="dokooDelFrm" method="post" action="${pageContext.request.contextPath}/dokoo/deleteDokoo.do">
	<input type="hidden" name="dokooNo" value="${param.dokooNo}" />
</form:form>
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


<%-- 독후감 수정 폼 요청 --%>
const updateDokoo = () => {
	location.href = "${pageContext.request.contextPath}/dokoo/updateDokoo.do?dokooNo=" + ${param.dokooNo};	
};

<%-- 독후감 삭제 요청 --%>
const deleteDokoo = () => {
	if(confirm('삭제된 정보는 되돌이킬 수 없습니다. 정말 삭제하시겠습니까?')){
		document.dokooDelFrm.submit();
	}
};

<%-- 댓글 등록 비동기 --%>
const enrollComment = () => {
	const commentVal = document.querySelector('#comment-content').value;
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
	
	$.ajax({
		url : '${pageContext.request.contextPath}/dokoo/commentEnroll.do',
		method : 'post',
		headers,
		data : {
			nickname : '${loginMember.nickname}',
			dokooNo : '${param.dokooNo}',
			content : commentVal
		},
		success(resp){
			console.log(resp);
			location.reload();
		},
		error:console.log
	});
};

<%-- 댓글 삭제 --%>
const commentDel = (e) => {
	console.log(e.dataset.dokoocno);	
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
	
	if(confirm('댓글을 삭제하시겠습니까?')){
		$.ajax({
			url : '${pageContext.request.contextPath}/dokoo/commentDel.do',
			method : 'post',
			headers,
			data : {
				dokooCNo : e.dataset.dokoocno,
			},
			success(resp){
				location.reload();
			},
			error:console.log
		});
	}
};

<%-- 댓글 수정 --%>
let originalComment;
const commentUpdate = (e) => {
	const id = '#comment-content' + e.dataset.vs;
	//console.log(id);
	const dokooCNo = e.dataset.dokoocno;
	const dokooNo = '${param.dokooNo}';
	//console.log(dokoocno);
	const content = document.querySelector(id);
	
	if(e.innerText == '수정'){
		const contentInnerText = content.innerText;
		//console.log(contentInnerText);
		originalComment = contentInnerText;
		//console.log("e.innerText == 수정", e.innerText == '수정');
		const input = `<form:form name="commentUpdateFrm" action="${pageContext.request.contextPath}/dokoo/commentUpdate.do" method="post" class="m-0">
							<input type="text" name="content" id="commentText" value="\${content.innerText}"/>
							<input type="hidden" name="dokooCNo" value="\${dokooCNo}"/>
							<input type="hidden" name="dokooNo" value="\${dokooNo}"/>
							<button class="btn" type="submit" id="btn-update-comment">수정</button>
						</form:form>`;
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

<%-- 답글 --%>
const commentRef = (e) => {
	const dokooCNo = e.dataset.dokoocno;
	const div = ``;
};


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
      	<form:form name="dokooReportFrm" method="post" action="${pageContext.request.contextPath}/pheed/pheedReport.do">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">작성자</label>
            <input type="text" class="form-control" id="memberId" value="${loginMember.memberId}" readonly>
            <input type="hidden" class="form-control" id="category" value="dokoo"/>          
             <input type="hidden" class="form-control" id="dokooNo" value=""/>
          </div>
          <div class="form-group">
            <p class="col-form-label">신고 내용</p>
          	<div class="alert alert-danger alert-dismissible fade show" role="alert" id="alert-note" style="display:none">
			  내용을 10자 이상 작성해주세요 !
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
            <textarea class="form-control" id="report-content" placeholder="신고 내용을 작성해주세요."></textarea>
          </div>
        </form:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-danger" onclick="report();">신고하기</button>
      </div>
    </div>
  </div>
</div>
<script>
<%-- 신고창 열기 --%>
function openReportModal(e){
	console.log(e.dataset.no);
	$('#dokooNo').val(e.dataset.no);
	$('#reportModal').modal('show');
}

<%-- 신고창 폼 제출 --%>
const report = () => {
	const category = document.querySelector("#category").value;
	const memberId = document.querySelector('#memberId').value;
	const content = document.querySelector("#report-content").value;
	const dokooNo = document.querySelector('#dokooNo').value;
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
	
	
	console.log(content);
	if(!/.{10,}$/.test(content)){
		document.querySelector("#alert-note").style.display = "block";
		return;
	}
	if(confirm('신고를 제출하시겠습니까?')){
		$.ajax({
			url : "${pageContext.request.contextPath}/pheed/pheedReport.do",
			method : 'post',
			headers,
			data : {
				category,
				memberId,
				content,
				beenziNo : dokooNo
			},
			success(resp){
				const {msg} = resp;
				alert(msg);
				$('#content').val(''); //폼 초기화
				$('#reportModal').modal('hide');
			},
			error : console.log
			
		});
	}else{
		return;
	}
};

document.querySelector("#report-content").addEventListener('keyup', (e) => {
	const val = e.target.value;
	if(val.length > 10){
		document.querySelector("#alert-note").style.display = "none";
	}
});

<%-- heart / bookmark --%>
window.addEventListener('load', (e) => {
	
	// 로드할때 좋아요, 찜 내역 가져와
	$.ajax({
		url : "${pageContext.request.contextPath}/dokoo/getDokooSns.do",
		data : {
			dokooNo : ${param.dokooNo},
			memberId : '${loginMember.memberId}'
		},
		success(resp){
			console.log(resp);
			const dokooSns = resp[0];
			const span = document.querySelector('#likesCnt');
			if(dokooSns == null){
				span.innerText = "0";
			}
			else{
				resp.forEach((sns) => {
					const {memberId, snsType} = sns;
					if(snsType == 'LIKE'){
						if(memberId == '${loginMember.memberId}'){
							const iHeart = `<i class="fa fa-heart fa-solid fa-stack-1x h-behind"></i>`;
							const hspan = document.querySelector("#h-span");
							hspan.insertAdjacentHTML('beforeend', iHeart);						
						}
						span.innerText = Number(span.innerText) + 1;
					}
					if(snsType == 'BOOKMARK'){
						if(memberId == '${loginMember.memberId}'){
							const iBookMark = `<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind"></i>`;
							const bspan = document.querySelector("#b-span");
							bspan.insertAdjacentHTML('beforeend', iBookMark);						
						}
					}
				});
			}
		},
		error : console.log
	});
	
	// 로드할때 하트 클릭 이벤트 줘
	document.querySelector("#like").addEventListener('click', (e) => {
		
			// 부모한테 이벤트 전파하지마셈
			e.stopPropagation(); 
			
			// 클릭할때마다 상태왔다갔다
			changeIcon(e.target, 'heart');
	});	
	
	// 로드할때 북마크 클릭 이벤트 줘
	document.querySelector("#bookmark").addEventListener('click', (e) => {
			
			// 부모한테 이벤트 전파하지마셈
			e.stopPropagation(); 
			
			// 클릭할때마다 상태왔다갔다
			changeIcon(e.target, 'bookmark');
	});	
	
});


const changeIcon = (icon, shape) => {
	let cnt = icon.parentElement.childElementCount;
	//console.log(cnt);
	let dokooNo = icon.dataset.dokooNo;
	//console.log(dokooNo);
	const iHeart = `<i class="fa fa-heart fa-solid fa-stack-1x h-behind"></i>`;
	const iBookMark = `<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind"></i>`;
	let memberId = "";
	
	if("${loginMember}"){
         memberId = "${loginMember.username}";			
	}
	
	// 비동기 처리할 때 security 땜시 token 보내야 함. 
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	const span = document.querySelector('#likesCnt');
	
	if(cnt==1) {
		// 비었는데 눌렀는 경우 -> insert
		$.ajax({
				url : "${pageContext.request.contextPath}/dokoo/insertLikesWish.do",
				data : {
					shape : shape,
					memberId : memberId,
					dokooNo : dokooNo
				},
				headers,
				method : "POST",
				success(data) {
					
					if(shape=='heart'){
						icon.parentElement.insertAdjacentHTML('beforeend', iHeart);
						
						// 좋아요 수 1 올려
						span.innerText = Number(span.innerText) + 1;
					}
					else{
						icon.parentElement.insertAdjacentHTML('beforeend', iBookMark);						
					}
					
				},
				error: console.log
			});
	}
	else {
		// 채워졌었는데 해제한 경우 -> delete
		$.ajax({
			url : "${pageContext.request.contextPath}/dokoo/deleteLikesWish.do",
			data : {
				shape : shape,
				memberId : memberId,
				dokooNo : dokooNo
			},
			headers,
			method : "POST",
			success(data) {
				
				icon.parentElement.removeChild(icon.parentElement.lastElementChild);
				
				if(shape=="heart"){
					// 좋아요 수 1 내려
					span.innerText = Number(span.innerText) - 1;
				}
				
			},
			error: console.log
		});
	}

}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>