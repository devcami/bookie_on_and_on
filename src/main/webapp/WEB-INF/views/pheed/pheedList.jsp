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
						<img src="${pageContext.request.contextPath}/resources/upload/profile/${pheed.member.renamedFilename}" alt="프로필사진" />
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
						  			class="btn btn-report float-right m-2" data-no="${pheed.pheedNo}" onclick="openReportModal(this);"><i class="fa-solid fa-ellipsis text-dark"></i></button>
							<c:if test="${pheed.member.nickname eq loginMember.nickname}">
							<button type="button" class="float-right btn-sm btn-update mt-3 mb-3 mr-2" onclick="updatePheed();">수정</button>	
							</c:if>
							<c:if test="${pheed.member.nickname eq loginMember.nickname || loginMember.memberId eq 'admin'}">
							<button type="button" class="float-right btn-sm btn-delete mt-3 mb-3 mr-2" onclick="deletePheed();">삭제</button>	
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
    <div id="comment-container">
    	
    </div>
    <div class="dontclick"></div>
</div>


<input type="hidden" name="cPage" value="1" id="cPage"/>
<script>
function getReadList(cPage) { 
	//console.log(cPage)

	const container = document.querySelector("#content");
    // 비동기로 다음장 가져오기
    const url = document.location.href;
    let now;
    if(url == 'http://localhost:9090/bookie/pheed/pheedCList.do'){
     	now = 'C';
    }
    if(url == 'http://localhost:9090/bookie/pheed/pheedFList.do'){
    	now = 'F';
    }
    $.ajax({
    	url : "${pageContext.request.contextPath}/pheed/getReadList.do",
    	data : {cPage, now},
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
			    						div += `<img src="${pageContext.request.contextPath}/resources/upload/profile/\${profileFilename}" alt="프로필사진" />`;
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
    									  		div += `<button type="button" class="float-right btn-sm btn-update mt-3 mb-3 mr-2" onclick="updatePheed();">수정</button>`;	
    									  	}
    									  	if(nickname == '${loginMember.nickname}' || ${loginMember.memberId == 'admin'}){
												div += `<button type="button" class="float-right btn-sm btn-delete mt-3 mb-3 mr-2" onclick="deletePheed();">삭제</button>`;	
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
	const container = document.querySelector("#comment-container");
	const commentDiv = 
		`<%-- 댓글 입력 창 --%>
		<div class="input-group p-2 mb-2">
			<input type="text" class="form-control" name="content" id="comment-content" placeholder="댓글을 작성해주세요."
				aria-label="댓글을 작성해주세요." aria-describedby="button-comment">
			<div class="input-group-append">
			<button class="ml-2" type="button" id="btn-enroll-comment" data-pheed-no="\${pheedNo}" onclick="enrollComment(this);">등록</button>
			</div>
		</div>
		<div id="comment-wrapper" class="p-2">
		</div>`;
	container.insertAdjacentHTML('afterbegin', commentDiv);
	document.querySelector("#comment-wrapper").innerHTML='';
	$.ajax({
		url : `${pageContext.request.contextPath}/pheed/selectComments.do?pheedNo=\${pheedNo}`,
		method : 'GET',
		success(resp){
			//console.log(resp);
			
			
			const {comments} = resp;
				
			comments.forEach((comment) => {
				//console.log(comment);
				const {pheedCNo, pheedNo, nickname, content, commentRef, createdAt, renamedFilename} = comment;
				//console.log(pheedCNo, pheedNo, nickname, content, commentRef, createdAt);
				const {year, monthValue, dayOfMonth, hour, minute, second} = createdAt;
				const date = new Date(year, monthValue, dayOfMonth, hour, minute, second);
				
		        var yy = date.getFullYear();
		        var MM = ('0' + (date.getMonth() + 1)).slice(-2);
		        var dd = ('0' + date.getDate()).slice(-2);
		        var hh = ('0' + date.getHours()).slice(-2); 
		        var mm = ('0' + date.getMinutes()).slice(-2)
		         
		        const fmtCreatedAt = yy + "/" + MM + "/" + dd + " " + hh + ":" + mm		         
				
				
				
				const wrapper = document.querySelector("#comment-wrapper");
				let div = ''; 
				// 일반 댓글
				if(commentRef == 0){
					div +=
					`<div class="co-div flex-center comment-div" id="comment\${pheedCNo}">
						<div class="co-left flex-center">
							<div class="co-writer flex-center">
								<img class="rounded-circle shadow-1-strong m-1"
								<%-- loginMember가 아니고 댓글단 사람 프로필 가져와야돼 --%>
		              			src="${pageContext.request.contextPath}/resources/upload/profile/\${renamedFilename}"
								alt="avatar" width="40" height="40"> <span>\${nickname}</span>
							</div>
							<div class="c-content" id="contentDiv\${pheedCNo}">
								<span id="contentSpan\${pheedCNo}">\${content}</span>
							</div>
						</div>
						<div class="co-right">
							<span class="text-secondary mr-3">\${fmtCreatedAt}</span>
							<div class="text-right">
								<p class="small mb-0" style="color: #aaa;">
					`;
					if(nickname == '${loginMember.nickname}'){
					div +=`
							<a href="#!" class="link-grey" onclick="commentDel(this);"
								data-comment-no="\${pheedCNo}">삭제</a> • 
							<a href="#!" id="updateBtn\${pheedCNo}" class="link-grey" onclick="showCommentUpdate(this);"
								data-comment-no="\${pheedCNo}">수정</a> • 
							<a href="#!" id="commentRefBtn\${pheedCNo}" class="link-grey" onclick="showCommentRefInput(this);"
								data-pheed-no="\${pheedNo}"
								data-comment-no="\${pheedCNo}">답글</a>`;
					}
					div += 
								`</p>
							</div>
						</div>
					</div>`;
					wrapper.insertAdjacentHTML('afterbegin', div);
				}
				
              
				
				// 대댓글
				if(commentRef != 0){
					div += 
					`<div class="co-div flex-center coComment-div" id="coComment\${pheedCNo}">
						<div class="co-left flex-center" style="margin-left: 40px;">
							↳
							<div class="co-writer flex-center">
								<img class="rounded-circle shadow-1-strong m-1"
									<%-- loginMember가 아니고 댓글단 사람 프로필 가져와야돼 --%>
			                        src="${pageContext.request.contextPath}/resources/upload/profile/\${renamedFilename}"
									alt="avatar" width="40" height="40"> <span>\${nickname}</span>
							</div>
							<div class="co-Content" id="contentDiv\${pheedCNo}">
								<span id="contentSpan\${pheedCNo}">\${content}</span>
							</div>
						</div>
						<div class="co-right">
							<span class="text-secondary">\${fmtCreatedAt}</span>
							<div class="small" style="padding-left: 10px;">
								<a href="#!" class="link-grey" onclick="commentDel(this);"
									data-comment-type='coComment'
									data-comment-no="\${pheedCNo}">삭제</a> • 
								<a href="#!"
									id="updateBtn\${pheedCNo}" class="link-grey"
									onclick="showCommentUpdate(this);"
									data-comment-no="\${pheedCNo}">수정</a>
							</div>
						</div>
					</div>`;
					$(`#comment\${commentRef}`).after(div);
				}
				
				
			});
		},
		error : console.log
	});
};


<%------------ 댓글 등록 비동기 ------------%>
const enrollComment = (e) => {
   const pheedNo = e.dataset.pheedNo;
   const commentVal = document.querySelector('#comment-content').value;
   const csrfHeader = '${_csrf.headerName}';
   const csrfToken = '${_csrf.token}';
   const headers = {};
   headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
   
   $.ajax({
      url : '${pageContext.request.contextPath}/pheed/commentEnroll.do',
      method : 'post',
      headers,
      data : {
         nickname : '${loginMember.nickname}',
         pheedNo,
         content : commentVal
      },
      success(resp){
         console.log(resp);
         const {pheedNo, content, pheedCNo} = resp;
         console.log("댓글 등록 후 : ", pheedNo)
         const container = document.querySelector("#comment-wrapper")
         
         var today = new Date();

         var year = today.getFullYear();
         var month = ('0' + (today.getMonth() + 1)).slice(-2);
         var day = ('0' + today.getDate()).slice(-2);
         var hours = ('0' + today.getHours()).slice(-2); 
         var minutes = ('0' + today.getMinutes()).slice(-2)
         
         const createdAt = year + "/" + month + "/" + day + " " + hours + ":" + minutes;
         
         const div = `
               <div class="co-div flex-center comment-div" id="comment\${pheedCNo}">
               <div class="co-left flex-center">
                  <div class="co-writer flex-center">
                     <img 
                        class="rounded-circle shadow-1-strong m-1" 
                        src="${pageContext.request.contextPath}/resources/upload/profile/${loginMember.renamedFilename}" 
                        alt="avatar" width="40" height="40">
                     <span>${loginMember.nickname}</span>
                  </div>
                  <div class="c-content" id="contentDiv\${pheedCNo}">
                        <span id="contentSpan\${pheedCNo}">\${content}</span>      
                  </div>
               </div>
               <div class="co-right">
                  <span class="text-secondary">
                     \${createdAt}
                  </span>
                  <div class="text-right">
                          <p class="small mb-0" style="color: #aaa;">
                             <a href="#!" class="link-grey" onclick="commentDel(this);" data-comment-no="\${pheedCNo}">삭제</a> • 
                             <a href="#!" id="updateBtn\${pheedCNo}" class="link-grey" onclick="showCommentUpdate(this);" data-comment-no="\${pheedCNo}">수정</a> • 
                             <a href="#!" id="commentRefBtn\${pheedCNo}" class="link-grey" onclick="showCommentRefInput(this);" data-pheed-no="\${pheedNo}" data-comment-no="\${pheedCNo}">답글</a>
                          </p>
                       </div>
               </div>                     
            </div>`;
            
            container.insertAdjacentHTML('afterbegin', div);
            document.querySelector('#comment-content').value = '';
               
      },
      error:console.log
   });
   
}

<%-- 댓글 삭제 --%>
const commentDel = (e) => {
   console.log(e.dataset.commentNo);
   const commentNo = e.dataset.commentNo;
   const commentType = e.dataset.commentType;
   
   const csrfHeader = '${_csrf.headerName}';
   const csrfToken = '${_csrf.token}';
   const headers = {};
   headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
   
   if(confirm('댓글을 삭제하시겠습니까?')){
      $.ajax({
         url : '${pageContext.request.contextPath}/pheed/commentDel.do',
         method : 'post',
         headers,
         data : {
        	 pheedCNo : commentNo,
         },
         success(resp){
            let deleteCommentId = '';
            
            if(commentType == 'coComment'){
               deleteCommentId = "#coComment" + commentNo;
            } else {
               deleteCommentId = "#comment" + commentNo;
            }
            
            $(deleteCommentId).remove();
            
         },
         error:console.log
      });
   }
};

<%-- 댓글 수정 화면 바꿔 --%>
let originalComment;
const showCommentUpdate = (e) => {
   const commentNo = e.dataset.commentNo;
   const divId = '#contentDiv' + commentNo;
   const spanId = '#contentSpan' + commentNo;
   
   // const chatNo = '${param.chatNo}';
   // console.log(chatNo);

   const contentDiv = document.querySelector(divId);
   const contentSpan = document.querySelector(spanId);
   
    if(e.innerText == '수정'){
       // 원래 있던 span 안보이게 처리해
       contentSpan.style.display = 'none';
      const contentInnerText = contentSpan.innerText;
      //console.log(contentInnerText);
      // originalComment = contentInnerText;
      
      const input = `
            <input type="text" name="content" id="commentText\${commentNo}" value="\${contentInnerText}" class="updateCommentInput form-control"/>
               <button class="btn" type="button" id="btn-update-comment\${commentNo}" onclick="updateComment(this)" data-comment-no="\${commentNo}">수정</button>`;
      contentDiv.insertAdjacentHTML('beforeend', input);
      
      e.innerText="취소";   
   }
   else{ 
      // 취소 누른 경우
      // 
      $(contentDiv).children('input').remove();
      $(contentDiv).children('button').remove();
      contentSpan.style.display = '';
      //console.log(content);
      e.innerText = "수정";   
   }
/*    const p = document.querySelector(".text-right.mr-2");
   p.style.position = 'relative';
   p.style.bottom = '7px'; */
};

<%-- 댓글 수정 비동기 --%>
const updateComment = (e) => {
   const commentNo = e.dataset.commentNo

   // 원래 댓글 담기는 곳
   const spanId = '#contentSpan' + commentNo;
   const contentSpan = document.querySelector(spanId);
   
   // 인풋색기 버튼색기 가져와
   const inputId = "#commentText" + commentNo; 
   const btnId = "#btn-update-comment" + commentNo;

   // 수정한 내용 들고와
   const commentContent = document.querySelector(inputId).value;
   // console.log("수정한 내용 = ", commentContent);

   
   const csrfHeader = '${_csrf.headerName}';
   const csrfToken = '${_csrf.token}';
   const headers = {};
   headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
   
   $.ajax({
      url: "${pageContext.request.contextPath}/pheed/commentUpdate.do",
      method : "POST",
      headers,
      data : {
         commentNo : commentNo,
         commentContent : commentContent
      },
      success(resp){
         console.log(resp);
         // Input 지워
         $(inputId).remove();
         // 버튼 지워
         $(btnId).remove();
         
         // 원래 내용 추가해
         contentSpan.innerHTML = commentContent;
         // span 보이게 바꿔
         contentSpan.style.display = "";
         
         // 취소로 바꿔
         document.getElementById(`updateBtn\${commentNo}`).innerHTML = '수정';
      },
      error: console.log
   });
   
   
}

<%-- 답글 --%>
const showCommentRefInput = (e) => {
   const commentNo = e.dataset.commentNo;
   const pheedNo = e.dataset.pheedNo;
   
   if(e.innerText == '답글') {
      const div = `
         <div class="co-ref-div" id="coRefDiv\${commentNo}">
            <input type="text" class="co-ref-input" name="content" id="coRef\${commentNo}" placeholder="댓글을 작성해주세요." aria-label="댓글을 작성해주세요." aria-describedby="button-comment">
            <button class="ref-btn" type="button" id="btn-enroll-comment" onclick="enrollCommentRef(this);" data-pheed-no="\${pheedNo}" data-comment-no="\${commentNo}">등록</button>
         </div>
      `;
      
      const commentDivId = "#comment" + commentNo;
      const commentDiv = document.querySelector(commentDivId);
      
      commentDiv.insertAdjacentHTML('afterend', div);
      
      e.innerText = "취소"
   }
   else {
      const coRefDivId = "#coRefDiv" + commentNo;
      $(coRefDivId).remove();
      e.innerText = "답글";
   }
   
};

<%-- 답글 등록 --%>
const enrollCommentRef = (e) => {
   const commentRef = e.dataset.commentNo;
   const pheedNo = e.dataset.pheedNo;
   console.log(pheedNo);
   
   
   // 입력한 내용 들고와
   const coRefInputId = "#coRef" + commentRef;
   const commentContent = document.querySelector(coRefInputId).value;
   
   console.log(commentContent);
   
   const csrfHeader = '${_csrf.headerName}';
   const csrfToken = '${_csrf.token}';
   const headers = {};
   headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
   
   $.ajax({
      url : '${pageContext.request.contextPath}/pheed/commentRefEnroll.do',
      method : 'post',
      headers,
      data : {
         nickname : '${loginMember.nickname}',
       	 pheedNo,
         content : commentContent,
         commentRef : commentRef
      },
      success(data){
         console.log(data);
         const {pheedCNo, nickname} = data;
         
         // 날짜는 못가져오니까 날짜 만들어 시부렁
         var today = new Date();

         var year = today.getFullYear();
         var month = ('0' + (today.getMonth() + 1)).slice(-2);
         var day = ('0' + today.getDate()).slice(-2);
         var hours = ('0' + today.getHours()).slice(-2); 
         var minutes = ('0' + today.getMinutes()).slice(-2)
         
         const createdAt = year + "/" + month + "/" + day + " " + hours + ":" + minutes;
         
         const div = `
            <div class="co-div flex-center coComment-div" id="coComment\${pheedCNo}">
               <div class="co-left flex-center" style="margin-left: 40px;">
               	  ↳
                  <div class="co-writer flex-center">
                     <img 
                        class="rounded-circle shadow-1-strong m-1" 
                        src="${pageContext.request.contextPath}/resources/upload/profile/${loginMember.renamedFilename}" 
                        alt="avatar" width="40" height="40">
                     <span>\${nickname}</span>
                  </div>
                  <div class="co-Content" id="contentDiv\${pheedCNo}">
                     <span id="contentSpan\${pheedCNo}">\${commentContent}</span>                                          
                  </div>
               </div>
               <div class="co-right">
                  <span class="text-secondary">
                     \${createdAt}
                  </span>
                  <div class="small" style="padding-left: 10px;">
                     <a href="#!" class="link-grey" onclick="commentDel(this);" data-comment-type='coComment' data-comment-no="\${pheedCNo}">삭제</a> • 
                     <a href="#!" id="updateBtn\${pheedCNo}" class="link-grey" onclick="showCommentUpdate(this);" data-comment-no="\${pheedCNo}">수정</a>
                  </div>      
               </div>                     
            </div>
         `;
         
         // 댓글 추가하셈 
         const commentDivId = "#comment" + commentRef;
         const commentDiv = document.querySelector(commentDivId)
         commentDiv.insertAdjacentHTML('afterend', div);
         
         // 답댓글 input이랑 btn 담긴 div 삭제하셈
         const coRefDivId = "#coRefDiv" + commentRef;
         $(coRefDivId).remove();
         
         // 답글 버튼 취소에서 다시 답글로 바꾸기 
            const commentRefBtnId = "#commentRefBtn" + commentRef;
         	console.log(commentRefBtnId);
            const commentRefBtn = document.querySelector(commentRefBtnId);
            console.log(commentRefBtn);
            commentRefBtn.innerHTML = '답글';

      },
      error : console.log
   });
   
}


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
	console.log(${fn:length(list)});
	// 얘가 1개가 마지막인데 2번 더돌아서 나는거거든.. innerText.title 오류가..
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
const deletePheed = () => {
	
};

<%-- 피드 수정 --%>
const updatePheed = () => {
	
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