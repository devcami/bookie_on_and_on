<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/search.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="책등록" name="title"/>
</jsp:include>

<sec:authentication property="principal" var="loginMember"/>
<div id="title-header" class="" style="display:none">
	<p id="title-p">
		<i class="fa-solid fa-angle-left" onclick="back()"></i>
	</p>
</div>
<section id="content">
	<div id="book-container">
		<div class="book-image" >
			<img id="book-image" src="" alt="책표지" />
			<h2 id="title"></h2>
			<h5 id="subTitle"></h5>
		</div>
		<div class="line"></div>
		<div class="book-eval">
			<h1>기록</h1>
			<div class="starRev" id="starRev">
				<span class="star starR1">별1_왼쪽</span>
				<span class="star starR2">별1_오른쪽</span>
				<span class="star starR1">별2_왼쪽</span>
				<span class="star starR2">별2_오른쪽</span>
				<span class="star starR1">별3_왼쪽</span>
				<span class="star starR2">별3_오른쪽</span>
				<span class="star starR1">별4_왼쪽</span>
				<span class="star starR2">별4_오른쪽</span>
				<span class="star starR1">별5_왼쪽</span>
				<span class="star starR2">별5_오른쪽</span>
			</div>
			
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="status" id="btnradio1" value="읽고 싶은" autocomplete="off"
			  		${book.status == '읽고 싶은' ? 'checked' : ''}>
			  <label class="btn btn-outline-primary btn-status" for="btnradio1">읽고 싶은</label>
			
			  <input type="radio" class="btn-check" name="status" id="btnradio2" value="읽는 중" autocomplete="off"
			  		${book.status == '읽는 중' ? 'checked' : ''}>
			  <label class="btn btn-outline-primary btn-status" for="btnradio2">읽는 중</label>
			
			  <input type="radio" class="btn-check" name="status" id="btnradio3" value="읽음" autocomplete="off"
			  		${book.status == '읽음' ? 'checked' : ''}>
			  <label class="btn btn-outline-primary btn-status" for="btnradio3">읽음</label>
			  
			  <input type="radio" class="btn-check" name="status" id="btnradio4" value="잠시 멈춘" autocomplete="off"
			  		${book.status == '잠시 멈춘' ? 'checked' : ''}>
			  <label class="btn btn-outline-primary btn-status" for="btnradio4">잠시 멈춘</label>
			  
			  <input type="radio" class="btn-check" name="status" id="btnradio5" value="중단" autocomplete="off"
			  		${book.status == '중단' ? 'checked' : ''}>
			  <label class="btn btn-outline-primary btn-status" for="btnradio5">중단</label>
			  
				<button type="button" class="btn btn-sm btn-secondary" id="btn-deselect" onclick="deselect();">선택해제</button>
			</div>
			<c:if test="${book == null}">
				<button class="custom-btn btn-5" data-toggle="modal" data-target="#enrollBookModal" onclick="setStatus();"><span>등록</span></button>
			</c:if>
			<c:if test="${book != null}">
				<button class="custom-btn btn-5 " data-toggle="modal" data-target="#updateBookModal" onclick="setStatus();"><span>책 상태 변경</span></button>
				<button class="custom-btn btn-5 " data-toggle="modal" data-target="#recentReadModal" onclick="setStatus();"><span>최근 완독일</span></button>
			</c:if>
			<!-- <button type="submit" class="btn btn-md btn-outline-primary" id="btn-enroll" onclick="bookEnroll();">저장</button> -->
		</div>
	</div>
	<div>
		<div id="my-pick" class="text-center mt-3">
			<label>
			    <input type="checkbox" name="myPick" id="myPick" ${book.myPick != null && book.myPick == 1 ? 'checked' : ''}/>
			    <span id="mypickSpan">인생책으로 등록하기 !</span>
			</label>
		</div>
	</div>
	<div class="line"></div>
	<div id="book-desc">
		
	</div>
	<div class="line"></div>
</section>

<%-- 책 등록 form modal --%>
<div class="modal fade" id="enrollBookModal" tabindex="-1" role="dialog" aria-labelledby="enrollBookModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="enrollBookModalLabel">책 등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form:form name="bookEnrollFrm" action="${pageContext.request.contextPath}/search/bookEnroll.do" method="post">
          <div class="form-group">
	            <input type="text" class="form-control" name="nickname" value="${loginMember.nickname}" readonly>
	            <input type="hidden" class="form-control" name="memberId" value="${loginMember.memberId}">
	            <input type="hidden" class="form-control" name="itemId" value="${param.isbn13}">
	            <input type="hidden" name="score" id="book-score" value="0"/>
				<input type="text"  class="form-control" name="status" id="book-status" value="${book.status}"readonly />
          </div>
			<h4 class="ml-2" id="modalBookTitle"></h4>
			<div class="form-group form-content"></div>
        </form:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="custom-btn btn-5" onclick="bookEnroll();">책등록</button>
      </div>
    </div>
  </div>
</div>


<%-- 책 수정 | 삭제 form modal --%>
<div class="modal fade" id="updateBookModal" tabindex="-1" role="dialog" aria-labelledby="updateBookModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="updateBookModalLabel">책 수정 및 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form:form name="bookUpdateFrm" action="${pageContext.request.contextPath}/search/bookUpdate.do" method="post">
          <div class="form-group">
	            <input type="text" class="form-control" name="nickname" value="${loginMember.nickname}" readonly>
	            <input type="hidden" class="form-control" name="memberId" value="${loginMember.memberId}">
	            <input type="hidden" class="form-control" name="itemId" value="${book.itemId}">
	            <input type="hidden" class="form-control" name="ingNo" value="${book.ingNo}">
	            <input type="hidden" name="score" value="${book.score}"/>
				<input type="text"  class="form-control" name="status" id="book-status-update" readonly />
          </div>
			<h4 class="ml-2" id="modalBookUpdateTitle"></h4>
			<div class="form-group form-content"></div>
        </form:form>
      </div>

      <div class="modal-footer">
        <button type="button" class="custom-btn btn-5" onclick="bookUpdate();">수정완료</button>
        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">취소</button>
        <c:if test="${book.status != '읽음'}">
	        <button type="button" class="btn btn-sm btn-danger" onclick="bookDelete();">삭제</button>
        </c:if>
      </div>
    </div>
  </div>
</div>

<!-- 완독일 리스트 모달 -->
<div class="modal fade" id="recentReadModal" tabindex="-1" role="dialog" aria-labelledby="recentReadModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="recentReadModalLabel">완독일 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body m-2 p-2" id="recentReadList">
		<ul class="list-group">
		</ul>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-outline-success " data-dismiss="modal" aria-label="Close" data-toggle="modal" data-target="#moreReadModal">완독일 추가</button>
      </div>
    </div>
  </div>
</div>

<!-- 완독일 추가 모달 -->
<div class="modal fade" id="moreReadModal" tabindex="-1" role="dialog" aria-labelledby="moreReadModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="moreReadModalLabel">완독일 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form:form name="moreReadFrm" action="${pageContext.request.contextPath}/search/moreRead.do" method="post">
          <div class="form-group">
	            <input type="hidden" class="form-control" name="memberId" value="${loginMember.memberId}">
	            <input type="hidden" class="form-control" name="itemId" id="itemId" value="${param.itemId}">
	            <label for="startedAt" class="m-0">시작일</label>
	            <input type="date" name="startedAt" class="m-2 " id="startedAt" />
	            ~
	            <label for="endedAt" class="m-0">종료일</label>
	            <input type="date" name="endedAt" class="m-2 " id="endedAt" />
	            <input type="hidden" name="score" value="${book.score}"/>
	            <input type="hidden" name="ingNo" value="${book.ingNo}"/>
	            <br />
				<input type="text"  class="form-control" name="status" value="읽음" readonly/>
          </div>
			<h4 class="ml-2" id="moreReadBookTitle"></h4>
			<div class="form-group">
				<label for="content" class="col-form-label">한줄평(250자 이내):</label>
				<textarea class="form-control" name="content" readonly><c:if test="${book != null}">${book.content}</c:if>
				</textarea>
			</div>
        </form:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close"  data-toggle="modal" data-target="#recentReadModal">이전으로</button>
        <button type="button" class="btn btn-outline-success " onclick="document.moreReadFrm.submit();">완독일 추가</button>
      </div>
    </div>
  </div>
</div>

<script>
document.querySelector('#myPick').addEventListener('change', (e) => {
	console.log(e.target.checked);
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송
	
	
	const btnradio3 = document.querySelector("#btnradio3");
	// 읽음 아닐 때
	if(!btnradio3.checked){
		// 체크할라고하면 금지
		if(e.target.checked){
			alert('다 읽은 책만 인생책으로 등록 가능합니다');
			e.target.checked = false;
			return;
		}
	}
	// 읽음일 때 눌렀다면 비동기로 마이픽 변경
	else {
		// 체크하면 -> myPick을 1로 변경			
		if(e.target.checked){
			$.ajax({
				url : '${pageContext.request.contextPath}/search/updateMypick.do',
				method : 'post',
				headers,
				data : {
					memberId : '${loginMember.memberId}',
					itemId : '${param.isbn13}',
					myPick : 1
				},
				success(resp){
					console.log(resp);
					e.target.checked = true;
				},
				error: console.log
			});
		}
		// 취소했다 -> myPick을 0으로 변경
		else{
			$.ajax({
				url : '${pageContext.request.contextPath}/search/updateMypick.do',
				method : 'post',
				headers,
				data : {
					memberId : '${loginMember.memberId}',
					itemId : '${param.isbn13}',
					myPick : 0
				},
				success(resp){
					console.log(resp);
					e.target.checked = false;
				},
				error: console.log
			});
		}
	}
			
		
});

let wpqkf = formatDate('1996-10-15');
let tlwkr = formatDate('1996-10-15');
function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;

    return [year, month, day].join('-');
}


const setStatus = () => {
	let cont = Array.from(document.querySelectorAll(".form-content"));
	cont.forEach((c) => c.innerHTML = '');
	
	let statusVal = document.querySelector("#book-status").value;
	let statusUpdateVal = document.querySelector("#book-status-update").value;
	
	Array.from(document.querySelectorAll("[name=status]")).forEach((status) => {
		if(status.checked){
			document.querySelector("#book-status").value = status.value;
			document.querySelector("#book-status-update").value = status.value;
			statusVal = status.value;
			statusUpdateVal = status.value;
		}
	});
	
	console.log("statusVal : " + statusVal);
	console.log("statusUpdateVal : " + statusUpdateVal);
	
	const div = `
		<label for="content" class="col-form-label">한줄평(250자 이내):</label>
<textarea class="form-control" id="textbox" name="content">
<c:if test="${book != null}">${book.content}</c:if>
</textarea>`;

	/* <label for="startedAt" class="m-0">시작일</label> */
	/* <input type="date" name="startedAt" class="m-2 " id="endedAt" /> */
	
	var realEnd;
	var realStart;
	if(wpqkf == "1996-10-15") {
		realEnd = '${book.endedAt}' 
	}
	else {
		realEnd = wpqkf;
	}
	
	if(tlwkr == "1996-10-15"){
		realStart = '${book.startedAt}' 
	}
	else {
		realStart = tlwkr;
	}
	
	const startedAtDiv = `<label for="startedAt" class="m-0">시작일</label><input type="date" id="startedVal" name='startedAt' class='m-2' value="\${realStart}"/>`;
	const endedAtDiv = `<label for='endedAt' class='m-0'>종료일</label><input type='date' id="endedVal" name='endedAt' class='m-2' value='\${realEnd}' />`;

	
	/* 읽음 선택 시 시작 완독 날짜추가 */
	if(statusVal == '읽음' || statusUpdateVal =='읽음'){
		cont.forEach((c) => {
			c.insertAdjacentHTML('beforeend', startedAtDiv);
			c.insertAdjacentHTML('beforeend', endedAtDiv);
			c.insertAdjacentHTML('beforeend', div);
		});
	}
	/* 읽는 중 선택 시 시작 날짜추가 */
	if(statusVal == '읽는 증' || statusUpdateVal == '읽는 중') {
		cont.forEach((c) => {
			c.insertAdjacentHTML('beforeend', startedAtDiv);
		});
	}
	

};
<%-- 제출 --%>
const bookEnroll = () => {
	const content = document.querySelector("#textbox");
	if(document.querySelector("#book-status").value == ""){
		alert('책 상태를 선택해주세요.');
		return false;
	} else if(document.querySelector("#book-status").value == "읽음"){
		//한줄평 유효성검사
		if(content.value.length > 250){
			alert('250자 이상 입력할 수 없습니다.')
			return false;
		}
	}
	
 	console.log(document.bookEnrollFrm.score.value);
	console.log(document.bookEnrollFrm.itemId.value);
	if(content){
		content.value.replace(/\"/g,"&quot;");
		console.log(content.value);
	}
	
	document.bookEnrollFrm.submit();
};
const bookUpdate = () => {
	const updateStatus = document.querySelector("#book-status-update").value;
	console.log("updateStatus : " + updateStatus + "${book.status}");
	if(updateStatus == "" || updateStatus == '${book.status}'){
		if(updateStatus == '읽음'){
			document.bookUpdateFrm.submit();
			return;
		}
		alert('변경할 책 상태를 선택해주세요.');
		return false;
	}
	document.bookUpdateFrm.submit();
};
const bookDelete = () => {
	if(confirm('내 책에서 삭제하시겠습니까? \n한번 삭제된 정보는 되돌릴 수 없습니다.')){
		console.log(document.bookDelFrm.ingNo);
		console.log(document.bookDelFrm.memberId);	
		console.log(document.bookDelFrm.itemId);	
		document.bookDelFrm.submit();
	}
};
</script>
<form:form name="bookDelFrm" method="post" action="${pageContext.request.contextPath}/search/bookDelete.do">
	<input type="hidden" name="memberId" value="${loginMember.memberId}" />
	<input type="hidden" name="itemId" value="${param.isbn13}" />
	<input type="hidden" name="ingNo" value="${book.ingNo}" />
</form:form>

<script>
<%-- 상단 제목 바 --%>
let imgDiv = document.querySelector(".book-image");
let header = document.querySelector("#header-container")
let headerHeight = header.clientHeight;
let imgDivHeight = imgDiv.clientHeight;

const titlebar = document.querySelector("#title-header");
window.onscroll = function () {
	let windowTop = window.scrollY;
	if (windowTop >= imgDivHeight + headerHeight) {
		titlebar.classList.add("drop");
		titlebar.style.display = "inline";
	} 
	else {
		titlebar.classList.remove("drop");
		titlebar.style.display = "none";
	}
};

window.addEventListener('load', () => {
	const bookContainer = document.querySelector("#book-container");
	const bookDescription = document.querySelector("#book-desc");
	$.ajax({
		url : '${pageContext.request.contextPath}/search/selectBook.do',
		data : {
			ttbkey : 'ttbiaj96820130001',
			itemIdType : 'ISBN13', 
			ItemId : ${param.isbn13},
			output : 'js',
			Cover : 'Big',
			Version : '20131101'
		},
		success(resp){
			const {item} = resp;
			console.log(item);
			let {title, subInfo, author, pubDate, description, isbn13, cover, customerReviewRank, categoryId, categoryName, publisher} = item[0];			
			if(customerReviewRank == 0){
				customerReviewRank = '리뷰가 없습니다.';
			} else{
				customerReviewRank += '점';
			}
			const {subTitle, itemPage} = subInfo;
			const img = document.querySelector("#book-image");
			img.src = `\${cover}`;
			
			document.querySelector("#itemId").value = `${isbn13}`;
			document.querySelector("#title-p").innerHTML +=`\${title}`;
			document.querySelector("#title").innerText=`\${title}`;
			document.querySelector("#modalBookTitle").innerText=`\${title}`;
			document.querySelector("#modalBookUpdateTitle").innerText=`\${title}`;
			document.querySelector("#moreReadBookTitle").innerText=`\${title}`;
			document.querySelector("#subTitle").innerText=`\${subTitle}`;
			const divDescription = `
				<div class="book-info">
					<h5 class="book-author">저자 : \${author}</h5>
					<p class="book-pub">출판사 : \${publisher} | 출판일 : \${pubDate}</h5>
					<p class="cate">카테고리 : \${categoryName}</p>
					<p class="page">페이지 : \${itemPage}p</p>
					<h6 class="aladin-score">알라딘 별점 : 
							\${customerReviewRank}
					</h6>
					
					<div>
						<p class="desc">\${description}</p>
					</div>
				</div>
			`;
			bookDescription.insertAdjacentHTML('beforeend', divDescription);
		},
		error : console.log
	});
});

$('.starRev span').click(function(){
	$(this).parent().children('span').removeClass('on');
	$(this).addClass('on').prevAll('span').addClass('on');

	let {length} = document.querySelectorAll(".on");
	document.querySelector("#book-score").value = length;
	//console.log(length);
	
	btnradio3.checked="true";
	
	return false;
});

<%-- 로드될 때 저장된 별점 기록 채우기 & 완독일 리스트 불러오기 --%>
window.addEventListener('load', () => {
	//console.log('${book.score}');
	const des = Array.from(document.querySelectorAll(".starRev span"));
	//console.log(des);
	<c:if test="${book != null}">
		for(let i = 0; i < ${book.score}; i++){
			des[i].classList.add('on');
		}
	</c:if>
	
	$.ajax({
		url : '${pageContext.request.contextPath}/search/selectReadList.do',
		data : {
			itemId : '${param.isbn13}',
			memberId : '${loginMember.memberId}'
		},
		success(resp){
			//console.log(resp);
			const container = document.querySelector("#recentReadList");
			
			resp.forEach((read) => {
				// 읽는중, 읽음인 경우
				if(read.startedAt){
					
					const {startedAt, endedAt, ingNo} = read;
					console.log(startedAt, endedAt, ingNo);
					const StartMV = startedAt.monthValue;
					let endMV;
					let ended;
					if(endedAt != null){
						endMV = endedAt.monthValue;
						if(endedAt.dayOfMonth < 10) endedAt.dayOfMonth = '0' + endedAt.dayOfMonth; 
						ended = `\${endedAt.year}-\${endMV}-\${endedAt.dayOfMonth}`; 
					}
					
					if(startedAt.dayOfMonth < 10) startedAt.dayOfMonth = '0' + startedAt.dayOfMonth; 
					const started = `\${startedAt.year}-\${StartMV}-\${startedAt.dayOfMonth}`; 
					
					// 읽음 으로 처리된 애만 완독일에 추가
					if(endedAt != null){
						const li = `<li class="list-group-item item" data-ingNo='\${ingNo}' data-started='\${started}' data-ended='\${ended}'>\${started} 시작 ~ \${ended} 완독 
									<span class="badge badge-pill badge-secondary bdg-delete float-right ml-2 mt-1" onclick="moreReadDelete(this);">삭제</span> 
									<span class="badge badge-pill bdg-update float-right ml-2 mt-1" onclick="moreReadUpdate(this);">수정</span> </li>`;
						container.insertAdjacentHTML('beforeend', li);
					}
				}
			});
		},
		error: console.log
	});
});

<%-- 완독일 수정 --%>
const moreReadUpdate = (e) => {
	if(document.querySelector(".list-group-item.inner-item")){
		document.querySelector(".list-group-item.inner-item").remove();
	}
	//<label for="endedAt" class="m-0">종료일</label>
	//<input type="date" name="startedAt" class="m-2 " id="startedAt" />
	const ingNo = e.parentElement.dataset.ingno;
	const sta = e.parentElement.dataset.started;
	const end = e.parentElement.dataset.ended;
	console.log(sta,end);
	const li = `<li class="list-group-item inner-item">
				<label for="moreReadStartedAt" class="m-0">시작일</label>
				<input type="date" name="moreReadStartedAt" id="read-update-start" class="m-2" value='\${sta}'/>
				<label for="moreReadStartedAt" class="m-0">종료일</label>
				<input type="date" name="moreReadEndedAt" id="read-update-end" class="m-2" value='\${end}' />
				<input type="hidden" name="moreReadIngNo" id="read-update-ingNo" value='\${ingNo}' />
				<button type="button" class="btn btn-outline-success btn-sm" onclick="updateDate();">변경</button>
				</li>`;
	// 새로운 li추가
 	e.parentElement.insertAdjacentHTML('afterend', li);
}

const updateDate = () => {
	
	let ingNo = document.querySelector("#read-update-ingNo").value;
	let startedAt = document.querySelector("#read-update-start").value;
	let endedAt = document.querySelector("#read-update-end").value;
	console.log(ingNo, startedAt, endedAt);
	
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
	
	
	//`<li class="list-group-item" data-ingNo='\${ingNo}' 
	// 			data-started='\${started}' data-ended='\${ended}'>\${started} 시작 ~ \${ended} 완독 
	
	$.ajax({
		url : '${pageContext.request.contextPath}/search/moreReadUpdate.do',
		method : 'POST',
		headers,
		data : {
			ingNo,
			startedAt,
			endedAt
		},
		success(resp){
			console.log(resp);
			const {book} = resp;
			const newStartedAt = book.startedAt;
			const newEndedAt = book.endedAt;
			const thisIngNo = book.ingNo;
			const originli = document.querySelector("#read-update-ingNo").parentElement.previousElementSibling;
			
			
			if(newStartedAt.monthValue < 10) newStartedAt.monthValue = '0' + newStartedAt.monthValue; 
			if(newStartedAt.dayOfMonth < 10) newStartedAt.dayOfMonth = '0' + newStartedAt.dayOfMonth; 
			if(newEndedAt.monthValue < 10) newEndedAt.monthValue = '0' + newEndedAt.monthValue; 
			if(newEndedAt.dayOfMonth < 10) newEndedAt.dayOfMonth = '0' + newEndedAt.dayOfMonth; 
			
			const startFmt = `\${newStartedAt.year}-\${newStartedAt.monthValue}-\${newStartedAt.dayOfMonth}`; 
			endFmt = `\${newEndedAt.year}-\${newEndedAt.monthValue}-\${newEndedAt.dayOfMonth}`; 
			
			originli.dataset.started = startFmt;
			originli.dataset.ended = endFmt;
			originli.innerHTML = `\${startFmt} 시작 ~ \${endFmt} 완독
				<span class="badge badge-pill badge-secondary bdg-delete float-right ml-2 mt-1" onclick="moreReadDelete(this);">삭제</span> 
				<span class="badge badge-pill bdg-update float-right ml-2 mt-1" onclick="moreReadUpdate(this);">수정</span>`;
			document.querySelector(".list-group-item.inner-item").remove();
			
			
			// 현재 책을 수정한 경우 책 수정에서 날짜 변경
			<c:if test="${not empty book}">
				
			if(${book.ingNo} == thisIngNo){
				console.log('(전)수정- 시작일', document.querySelector("[name=bookUpdateFrm] [name=startedAt]").value);
				console.log('(전)수정- 종료일', document.querySelector("[name=bookUpdateFrm] [name=endedAt]").value);
				document.querySelector("[name=bookUpdateFrm] [name=startedAt]").value = startFmt;
				document.querySelector("[name=bookUpdateFrm] [name=endedAt]").value = endFmt;
				console.log('(후)수정- 시작일', document.querySelector("[name=bookUpdateFrm] [name=startedAt]").value);
				console.log('(후)수정- 종료일', document.querySelector("[name=bookUpdateFrm] [name=endedAt]").value);
				wpqkf = formatDate(endFmt);
				tlwkr = formatDate(startFmt);
			}
			</c:if>
			
		},
		error : console.log
	});	
};

<%-- 완독일 삭제 --%>
const moreReadDelete = (e) => {
	const ingNo = e.parentElement.dataset.ingno;
	const memberId = '${loginMember.memberId}';
	const itemId = '${param.isbn13}';
	console.log(ingNo, memberId, itemId);
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
	
	$.ajax({
		url : '${pageContext.request.contextPath}/search/moreReadDelete.do',
		method : 'POST',
		headers,
		data : {
			ingNo : ingNo,
			itemId : itemId,
			memberId : memberId
		},
		success(resp){
			console.log(resp);
			const {msg} = resp; 
			e.parentElement.remove();
			// 현재 책을 삭제한 경우 reload
			<c:if test="${not empty book}">
			if(ingNo == ${book.ingNo}){
				alert(`\${msg}`);
				window.location.reload();
			}
			</c:if>
		},
		error : console.log
	});
};



document.querySelectorAll(".btn-check").forEach((select) => {
	if(select.id != 'btnradio3'){
		select.addEventListener('click' , () => {
			$('.starRev span').removeClass('on');
			if(document.querySelector("#book-score").value != "0"){
				alert('별점은 다 읽은 책에만 등록할 수 있습니다.');
				document.querySelector("#book-score").value = "0";
			}
			
		});
	}
		
});

const deselect = () => {
	$("input:radio[name='status']").prop('checked', false);
	$('.starRev span').removeClass('on');
	document.querySelector("#book-status").value = "";
	document.querySelector("#book-score").value = "0";
};

function back(){
	history.back();
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>