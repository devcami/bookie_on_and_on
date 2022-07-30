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
		<i class="fa-solid fa-angle-left" onclick="location.href='${pageContext.request.contextPath}/search/searchForm.do'"></i>
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
				<input type="text"  class="form-control" name="status" id="book-status" readonly />
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
	            <input type="date" name="startedAt" class="m-2 " id="endedAt" />
	            <input type="hidden" name="score" value="${book.score}"/>
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
	
	const div = `
		<label for="content" class="col-form-label">한줄평(250자 이내):</label>
<textarea class="form-control" id="textbox" name="content">
<c:if test="${book != null}">${book.content}</c:if>
</textarea>`;

	/* <label for="startedAt" class="m-0">시작일</label> */
	/* <input type="date" name="startedAt" class="m-2 " id="endedAt" /> */
	
	const startedAtDiv = `<label for="startedAt" class="m-0">시작일</label><input type="date" name='startedAt' class='m-2' value="${book.startedAt}"/>`;
	const endedAtDiv = `<label for="endedAt" class="m-0">종료일</label><input type="date" name='endedAt' class='m-2' value="${book.endedAt}"/>`;

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
	if(document.querySelector("#book-status").value == ""){
		alert('책 상태를 선택해주세요.');
		return false;
	} else if(document.querySelector("#book-status").value == "읽음"){
		//한줄평 유효성검사
		const content = document.querySelector("#textbox");
		if(content.value.length > 250){
			alert('250자 이상 입력할 수 없습니다.')
			return false;
		}
	}
	
 	console.log(document.bookEnrollFrm.score.value);
	console.log(document.bookEnrollFrm.itemId.value);
	console.log(document.bookEnrollFrm.content); 
	document.bookEnrollFrm.submit();
};
const bookUpdate = () => {
	const updateStatus = document.querySelector("#book-status-update").value;
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
			ItemId : ${isbn13},
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
				const {startedAt, endedAt, ingNo} = read;
				console.log(startedAt, endedAt, ingNo);
				if(startedAt.monthValue < 10) startedAt.monthValue = '0' + startedAt.monthValue; 
				if(startedAt.dayOfMonth < 10) startedAt.dayOfMonth = '0' + startedAt.dayOfMonth; 
				if(endedAt.monthValue < 10) endedAt.monthValue = '0' + endedAt.monthValue; 
				if(endedAt.dayOfMonth < 10) endedAt.dayOfMonth = '0' + endedAt.dayOfMonth; 
				
				const started = `\${startedAt.year}-\${startedAt.monthValue}-\${startedAt.dayOfMonth}`; 
				const ended = `\${endedAt.year}-\${endedAt.monthValue}-\${endedAt.dayOfMonth}`; 
				
				const li = `<li class="list-group-item" data-ingNo='\${ingNo}'>\${started} 시작 ~ \${ended} 완독 
							<span class="badge badge-pill badge-secondary bdg-delete float-right ml-2 mt-1">삭제</span> 
							<span class="badge badge-pill bdg-update float-right ml-2 mt-1">수정</span> </li>`;
				container.insertAdjacentHTML('beforeend', li);
			});
		},
		error: console.log
	});
});

<%-- 완독일 수정 --%>

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
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>