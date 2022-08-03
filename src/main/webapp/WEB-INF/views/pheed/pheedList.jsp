<%@page import="com.kh.bookie.pheed.model.dto.PheedComment"%>
<%@page import="com.kh.bookie.pheed.model.dto.Pheed"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pheed.css" />
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="피드" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div id="pheed-container" >
	<div id="pheed-header">
		<div class="btns">
			<button type="button" class="btn btn-lg btn-link btn-pheed" onclick="location.href='${pageContext.request.contextPath}/pheed/pheedFList.do'">팔로워</button>
			<button type="button" class="btn btn-lg btn-link btn-pheed" onclick="location.href='${pageContext.request.contextPath}/pheed/pheedCList.do'" id="btn-pheed-c">발견</button>
			<button type="button" class="btn btn-lg btn-link " id="btn-pheed-enroll" onclick="location.href='${pageContext.request.contextPath}/pheed/pheedEnroll.do'"><i class="fa-solid fa-plus"></i></button>
		</div>
	</div>
</div>
<section id="content">
	<c:forEach items="${list}" var="pheed" varStatus="vs">
	<fmt:parseDate value="${pheed.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate"/>
		<div class="pheed-container shadow bg-white">
			<div class="pheed-writer">
				<div class="profile">
					<c:if test="${pheed.member.renamedFilename != null}">
						<img src="${pageContext.request.contextPath}/resources/upload/profile/${loginMember.renamedFilename}" alt="프로필사진" />
					</c:if>
					<c:if test="${pheed.member.renamedFilename == null}">
						<i class="fa-solid fa-user-large user-icon"></i>
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
						<span class="pheed-book-title" id="book-title${vs.count}"></span>
						<span class="pheed-book-page">[${pheed.page}p]</span>
						<p><fmt:formatDate value="${enrollDate}" pattern="yyyy.MM.dd HH:mm"/></p>
					</div>
					<p>${pheed.content}</p>
				</div>
				<div class="pheed-sns">
					<div class="pheed-sns-icons">
						<div class="btn-group" role="group" aria-label="Basic example">
							<span class="fa-stack fa-lg h-span">
						  		<i class="fa fa-heart fa-regular fa-stack-1x front" data-pheed-no="${pheed.pheedNo}"></i>
						  		<c:if test="${fn:contains(likesStr, pheed.pheedNo)}">
							  		<i class="fa fa-heart fa-solid fa-stack-1x h-behind" data-pheed-no="${pheed.pheedNo}"></i>
								</c:if>
							</span>
							<span class="fa-stack fa-lg h-span">
						  		<i class="fa fa-regular fa-comment-dots fa-stack-1x front" onclick="pheedComment(this);"></i>
								<input type="hidden" name="pheedNo" value="${pheed.pheedNo}" />
							</span>
							<span class="fa-stack fa-lg b-span">
						  		<i class="fa fa-bookmark fa-regular fa-stack-1x front" data-pheed-no="${pheed.pheedNo}"></i>
							  	<c:if test="${fn:contains(wishStr, pheed.pheedNo)}">
								  	<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind" data-pheed-no="${pheed.pheedNo}"></i>
								</c:if>
							</span>
						  	<button type="button" 
						  			class="btn btn-report float-right m-2" data-no="${pheed.pheedNo}" onclick="openReportModal(this);"><i class="fa-solid fa-ellipsis"></i></button>
							<c:if test="${pheed.member.nickname eq loginMember.nickname}">
							<button type="button" class="float-right btn-sm btn-update mt-3 mb-3 mr-2"  data-pheed-no="${pheed.pheedNo}" onclick="updatePheed(this);">수정</button>	
							</c:if>
							<c:if test="${pheed.member.nickname eq loginMember.nickname || loginMember.memberId eq 'admin'}">
							<button type="button" class="float-right btn-sm btn-delete mt-3 mb-3 mr-2"  data-pheed-no="${pheed.pheedNo}" onclick="deletePheed(this);">삭제</button>	
							</c:if>
						</div>
					</div>
					<div class='likes-div'>						
						<span>좋아요</span>&nbsp;
						<span class='likes' id="likesCnt${pheed.pheedNo}">${pheed.likesCnt}</span>
						<span>개</span>					
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</section>

<div id="sidebar" class="bg-white">
	<button class="btn bg-white close-btn" id="close" onclick="closeComment();">
       <i class="fa fa-times"></i>
    </button>
    <div class="input-group p-3 mb-3">
		<input type="text" class="form-control" name="content" placeholder="댓글을 작성해주세요." aria-label="댓글을 작성해주세요." aria-describedby="button-comment">
		<div class="input-group-append">
			<button class="btn btn-outline-secondary" type="button" id="btn-enroll-comment" onclick="enrollComment();">등록</button>
		</div>
    </div>
    <div class="comment">
		<table class="table table-borderless" id="tbl-comment">
			<tr>
			</tr>
		</table>
    </div>
    <div class="dontclick"></div>
</div>


<input type="hidden" name="cPage" value="1" id="cPage"/>
<script>
function getReadList(cPage) { 
	//console.log(cPage)

	const container = document.querySelector("#content");
    // 비동기로 다음장 가져오기
    $.ajax({
    	url : "${pageContext.request.contextPath}/pheed/getReadList.do",
    	data : {cPage},
    	success(resp){
    		//console.log(resp);
    		let {list, likesStr, wishStr} = resp;
    		if(list.length == 0){
    			console.log('데이터가 없음');
    			$('#loading').text('마지막 페이지 입니다.');
    			window.removeEventListener('scroll', infiniteScroll);
    		}
    		else{
    			let vsCount = (3 * (cPage - 1)) + 1; // cPage : 2 -> 11 ~ 20 / 21 ~ 30... 
    			list.forEach((pheed) => {
    				//console.log(pheed);
	    			const {attach, content, enrollDate, isOpened, itemId, member, memberId, page, pheedNo, likesCnt} = pheed;
	    			let attachNo, originalFilename, renamedFilename;
	    			if(attach != null){
	    				attachNo = attach.attachNo;
	    				originalFilename = attach.originalFilename;
	    				renamedFilename = attach.renamedFilename;
	    			}
	    			const profileFilename = member.renamedFilename;
	    			const {nickname} = member;
    				let div = `
    					<div class="pheed-container shadow bg-white">
    						<div class="pheed-writer">
    							<div class="profile">`;
    								if(profileFilename != null){
			    						div += `<img src="${pageContext.request.contextPath}/resources/upload/profile/${loginMember.renamedFilename}" alt="프로필사진" />`;
    								}
   									else{
   										div += `<i class="fa-solid fa-user-large user-icon"></i>`;
   									}
    							div += `
    							</div>
    							<h2>\${nickname}</h2>
    						</div>
   							<div class="pheed-img">`;
   							if(renamedFilename != null){
   								div += `<img src="${pageContext.request.contextPath}/resources/upload/pheed/\${renamedFilename}" alt="" />`;
   							}
   							div += `</div>
    						<div class="pheed">
    							<div class="pheed-content">
    								<div class="book-info">
    									<span class="pheed-book-title" id="book-title\${vsCount}"></span>
    									<span class="pheed-book-page">[\${page}p]</span>`;
										const enrollDateFmt = `\${enrollDate.year}.\${enrollDate.monthValue}.\${enrollDate.dayOfMonth} \${enrollDate.hour}:\${enrollDate.minute}`;
								div += `
    									<p>\${enrollDateFmt}</p>
    								</div>
    								<p>\${content}</p>
    							</div>
    							<div class="pheed-sns">
    								<div class="pheed-sns-icons">
    									<div class="btn-group" role="group" aria-label="Basic example">
    										<span class="fa-stack fa-lg h-span">
												  <i class="fa fa-heart fa-regular fa-stack-1x front" data-pheed-no=\${pheedNo}></i>`;
												  if(likesStr.includes(pheedNo)){
													  div += `<i class="fa fa-heart fa-solid fa-stack-1x h-behind" data-pheed-no=\${pheedNo}></i>`;
												  }
										div+=`  
    										</span>
    										<span class="fa-stack fa-lg h-span">
    									  		<i class="fa fa-regular fa-comment-dots fa-stack-1x front" onclick="pheedComment(this);"></i>
    											<input type="hidden" name="pheedNo" value="\${pheedNo}" />
    										</span>
    										<span class="fa-stack fa-lg b-span">
    									  		<i class="fa fa-bookmark fa-regular fa-stack-1x front" data-pheed-no=\${pheedNo}></i>`;
												  if(wishStr.includes(pheedNo)){
													  div += `<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind" data-pheed-no=\${pheedNo}></i>`;
												  }					  		
										div+=`  
    										</span>
    									  	<button type="button" 
    									  			class="btn btn-report float-right" data-no="\${pheedNo}"  onclick="openReportModal(this);"><i class="fa-solid fa-ellipsis"></i></button>`;
    									  	if(nickname == '${loginMember.nickname}'){
    									  		div += `<button type="button" class="float-right btn-sm btn-update mt-3 mb-3 mr-2" data-pheed-no=\${pheedNo} onclick="updatePheed(this);">수정</button>`;	
    									  	}
    									  	if(nickname == '${loginMember.nickname}' || ${loginMember.memberId == 'admin'}){
												div += `<button type="button" class="float-right btn-sm btn-delete mt-3 mb-3 mr-2" data-pheed-no=\${pheedNo} onclick="deletePheed(this);">삭제</button>`;	
    									  	}
    									 div+=`
    									</div>
    								</div>
    								<div class='likes-div'>						
	    								<span>좋아요</span>&nbsp;
	    								<span class='likes' id='likesCnt\${pheedNo}'>\${likesCnt}</span>
	    								<span>개</span>					
	    							</div>
    							</div>
    						</div>
    					</div>`;
    				vsCount = vsCount + 1;
    				container.insertAdjacentHTML('beforeend', div);
    			});
   				selectBook(cPage);
   				clickEvent();
    		}
    	},
    	error: console.log
    });
    
}; 

//무한 스크롤
function infiniteScroll(){
	// scrollTop : 현재 위치 | document.height() : 문서 총 길이 | window.innerHeight : 윈도우 내부 창 사이즈 
	//console.log("window scrollTop : ",  $(window).scrollTop()); 
	//console.log("window height : ", $(window).height());
	//console.log("window innerHeight : " ,window.innerHeight);
	//console.log($(window).scrollTop() + window.innerHeight);
	
    if($(window).scrollTop() + window.innerHeight == $(document).height()){
    	let cPage = document.querySelector("#cPage"); 
    	cPage.value = Number(cPage.value) + 1; 
    	console.log(cPage);
        getReadList(cPage.value);
    } 
}
window.addEventListener('scroll', infiniteScroll);

<%-- 피드 댓글 상세보기 연결 --%>
const pheedComment = (e) => {
	const pheedNo = e.nextElementSibling.value;	
	console.log(pheedNo);
	const sidebar = document.querySelector("#sidebar");
	sidebar.classList.add("show-nav");
	const tbl = document.querySelector("#tbl-comment");
	$.ajax({
		url : `${pageContext.request.contextPath}/pheed/selectComments.do?pheedNo=\${pheedNo}`,
		method : 'GET',
		success(resp){
			//console.log(resp);
			tbl.innerHTML = "";
			const {comments} = resp;
			comments.forEach((comment) => {
				//console.log(comment);
				const {pheedCNo, pheedNo, nickname, content, commentRef, createdAt} = comment;
				//console.log(pheedCNo, pheedNo, nickname, content, commentRef, createdAt);
				const {year, monthValue, dayOfMonth, hour, minute, second} = createdAt;
				const date = new Date(year, monthValue, dayOfMonth, hour, minute, second);
				
				const tr = document.createElement("tr");
				const td1 = document.createElement("td");
				const td2 = document.createElement("td");
				const td3 = document.createElement("td");
				const td4 = document.createElement("td");
				/* const btnReply = document.createElement("button"); */
				const btnCDel = document.createElement("button");
				
				if(commentRef == 1){
					tr.classList.add("level2");						
				} else{
					tr.classList.add("level1");						
				}
				td1.classList.add("comment-writer");
				td1.innerHTML = nickname;
				td2.classList.add("comment-content");
				td2.innerHTML = content;
				td3.classList.add("comment-date");
				td3.innerText = date.toLocaleDateString();
				
				td4.classList.add("comment-btn-del");
				td4.innerHTML = "<button type='button' class='btn btn-sm btn-danger btn-cdel' onclick='commentDel();'>삭제</button>";
				
				tr.append(td1, td2, td3, td4);
				tbl.append(tr);
				
			});
		},
		error : console.log
	});
};

<%-- 댓글 작성 버튼 enrollComment--%>


<%-- 삭제 버튼 commentDel --%>



$(document).mouseup(function (e){
	if($("#sidebar").has(e.target).length === 0){
		closeComment();
	}
});

const closeComment = () => {
	const sidebar = document.querySelector("#sidebar");
	sidebar.classList.remove("show-nav");
	sidebar.style.boxShadow = "0 .5rem 1rem rgba(0,0,0,.15)";
	sidebar.style.zIndex="100";
}

function selectBook(cPage){
	// 		1~10 11~20 21~30..
	//cPage  1 	   2     3 ..
	<c:forEach items="${list}" var="pheed">
	for(let i = (((cPage - 1) * 3) + 1); i <= (cPage * 3); i++){
		$.ajax({
			url : '${pageContext.request.contextPath}/search/selectBook.do',
			data : {
				ttbkey : 'ttbiaj96820130001',
				itemIdType : 'ISBN13', 
				ItemId : ${pheed.itemId},
				output : 'js',
				Cover : 'Big',
				Version : '20131101'
			},
			success(resp){
				const {item} = resp;
				const {title, isbn13} = item[0];
				//console.log(title, isbn13);
				document.querySelector(`#book-title\${i}`).innerText = title;
			},
			error : console.log
		});
	}
	</c:forEach>
	
}

window.addEventListener('load', selectBook(1));

<%-- 상단 피드 헤더 바 --%>
let header = document.querySelector("#header-container")
let headerHeight = header.clientHeight;

const pheedHeader = document.querySelector("#pheed-header");
window.onscroll = function () {
	let windowTop = window.scrollY;
	if (windowTop >= headerHeight) {
		pheedHeader.classList.add("drop");
	} 
	else{
		pheedHeader.classList.remove("drop");
	}
};


<%-- 피드 삭제 --%>
const deletePheed = (e) => {
	//console.log(e.dataset.pheedNo);
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송
	
	if(confirm('삭제 시 정보를 되돌이 킬 수 없습니다. 정말 삭제하시겠습니까?')){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/pheed/deletePheed.do",
			data : {pheedNo : e.dataset.pheedNo},
			method : 'post',
			headers,
			success(resp){
				const {msg} = resp;
				alert(msg);
				location.reload();
			},
			error : console.log
		});
	}
};

<%-- 피드 수정 --%>
const updatePheed = (e) => {
	const pheedNo = e.dataset.pheedNo;
	// 수정 폼 요청	
	location.href = "${pageContext.request.contextPath}/pheed/pheedUpdate.do?pheedNo=" + pheedNo;
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
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">작성자</label>
            <input type="text" class="form-control" id="memberId" value="${loginMember.memberId}" readonly>
            <input type="hidden" class="form-control" id="category" value="pheed"/>
            <input type="hidden" class="form-control" id="pheedNo" value=""/>
          </div>
          <div class="form-group">
            <p class="col-form-label">신고 내용</p>
          	<div class="alert alert-danger alert-dismissible fade show" role="alert" id="alert-note" style="display:none">
			  내용을 10자 이상 작성해주세요 !
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
            <textarea class="form-control" id="report-content" name="content" placeholder="신고 내용을 작성해주세요."></textarea>
          </div>
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
	$('#pheedNo').val(e.dataset.no);
	$('#reportModal').modal('show');
}
<%-- 신고창 폼 제출 --%>
const report = () => {
	const category = document.querySelector("#category").value;
	const memberId = document.querySelector('#memberId').value;
	const content = document.querySelector("#report-content").value;
	const pheedNo = document.querySelector('#pheedNo').value;
	
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
				beenziNo : pheedNo
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


<%-- 좋아요 북마크 클릭이벤트 --%>
const clickEvent = () => {
	// 하트 클릭 이벤트 줘
	document.querySelectorAll(".fa-heart").forEach((heart) => {
		heart.addEventListener('click', (e) => {
			
			// 부모한테 이벤트 전파하지마셈
			e.stopPropagation(); 
			
			// 클릭할때마다 상태왔다갔다
			changeIcon(e.target, 'heart');
		});	
	});	
	
	// 북마크 클릭 이벤트 줘
	document.querySelectorAll(".fa-bookmark").forEach((heart) => {
		heart.addEventListener('click', (e) => {
			
			// 부모한테 이벤트 전파하지마셈
			e.stopPropagation(); 
			
			// 클릭할때마다 상태왔다갔다
			changeIcon(e.target, 'bookmark');
		});	
	});	
	
}
window.addEventListener('load', (e) => {
	// 로드할 때 하트 클릭 , 북마크 클릭 이벤트
	clickEvent();
});


const changeIcon = (icon, shape) => {

	let cnt = icon.parentElement.childElementCount;
	let pheedNo = icon.dataset.pheedNo;
	
	const iHeart = `<i class="fa fa-heart fa-solid fa-stack-1x h-behind"></i>`;
	const iBookMark = `<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind"></i>`;
	let memberId = "";
	
	if("${loginMember}"){
         memberId = "${loginMember.username}";			
	}
	 
	console.log(memberId);
	
	// 비동기 처리할 때 security 땜시 token 보내야 함. 
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	if(cnt==1){
		// 비었는데 눌렀는 경우 -> insert
		$.ajax({
			url : "${pageContext.request.contextPath}/pheed/insertLikesWish.do",
			data : {
				shape : shape,
				memberId : memberId,
				pheedNo : pheedNo
			},
			headers,
			method : "POST",
			success(data) {
				console.log('하트/찜 insert 성공');
				
				if(shape=='heart'){
					icon.parentElement.insertAdjacentHTML('beforeend', iHeart);
					
					// 좋아요 수 1 올려
					const likesCntId = "#likesCnt" + pheedNo;
					const likesCnt = document.querySelector(likesCntId);
					likesCnt.innerHTML = Number(likesCnt.innerHTML) + 1;
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
			url : "${pageContext.request.contextPath}/pheed/deleteLikesWish.do",
			data : {
				shape : shape,
				memberId : memberId,
				pheedNo : pheedNo
			},
			headers,
			method : "POST",
			success(data) {
				
				icon.parentElement.removeChild(icon.parentElement.lastElementChild);
				
				if(shape=="heart"){
					// 좋아요 수 1 내려
					const likesCntId = "#likesCnt" + pheedNo;
					const likesCnt = document.querySelector(likesCntId);
					likesCnt.innerHTML = Number(likesCnt.innerHTML) - 1;
				}
				console.log('하트/찜 delete 완료');
				
			},
			error: console.log
		});
	
	}

}
</script>
<div id="loading" class="text-center m-3 p-3"></div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>