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
				<button class="custom-btn btn-5" data-toggle="modal" data-target="#updateBookModal" onclick="setStatus();"><span>책 상태 변경</span></button>
			</c:if>
			<!-- <button type="submit" class="btn btn-md btn-outline-primary" id="btn-enroll" onclick="bookEnroll();">저장</button> -->
		</div>
	</div>
	<div class="line"></div>
	<div id="book-desc">
		
	</div>
	<div class="line"></div>
</section>

<script>
const setStatus = () => {
	let cont = Array.from(document.querySelectorAll(".form-content"));
	cont.forEach((c) => c.innerHTML = '');
	Array.from(document.querySelectorAll("[name=status]")).forEach((status) => {
		if(status.checked){
			// console.log(status.value);
			document.querySelector("#book-status").value = status.value;
			document.querySelector("#book-status-update").value = status.value;
		}
	});
	
	const statusVal = document.querySelector("#book-status").value;
	const statusUpdateVal = document.querySelector("#book-status-update").value;
	
	const div = `
		<label for="content" class="col-form-label">한줄평(250자 이내):</label>
<textarea class="form-control" id="content" name="content">
<c:if test="${book != null}">${book.content}</c:if>
</textarea>`;
	if(statusVal == '읽음' || statusUpdateVal =='읽음'){
		cont.forEach((c) => {
			c.insertAdjacentHTML('beforeend', div);
		});
	}
};
<%-- 제출 --%>
const bookEnroll = () => {
	if(document.querySelector("#book-status").value == ""){
		alert('책 상태를 선택해주세요.');
		return;
	}
/* 	console.log(document.bookEnrollFrm.score.value);
	console.log(document.bookEnrollFrm.itemId.value);
	console.log(document.bookEnrollFrm.content); */
	document.bookEnrollFrm.submit();
};
const bookUpdate = () => {
	if(document.querySelector("#book-status-update").value == ""){
		alert('책 상태를 선택해주세요.');
		return;
	}
	document.bookUpdateFrm.submit();
};
const bookDelete = () => {
	if(confirm('내 책에서 삭제하시겠습니까? \n한번 삭제된 정보는 되돌릴 수 없습니다.')){
		
	}
};
</script>
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
	            <input type="hidden" class="form-control" name="itemId" value="${param.itemId}">
	            <input type="hidden" name="score" id="book-score" value="0"/>
				<input type="text"  class="form-control" name="status" id="book-status" readonly />
          </div>
			<h4 id="modalBookTitle"></h4>
			<div class="form-group form-content"></div>
        </form:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="bookEnroll();">책등록</button>
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
			<h4 id="modalBookUpdateTitle"></h4>
			<div class="form-group form-content"></div>
        </form:form>
      </div>
      <div class="modal-footer">
      	<button class="custom-btn btn-5 close" data-dismiss="modal" aria-label="Close"  data-toggle="modal" data-target="#moreReadModal"><span>완독일 추가</span></button>
      	
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="bookUpdate();">수정</button>
        <button type="button" class="btn btn-danger" onclick="bookDelete();">삭제</button>
      </div>
    </div>
  </div>
</div>

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
	            <label for="startedAt">시작일</label>
	            <input type="date" name="startedAt" id="startedAt" />
	            <br />
	            <label for="endedAt">종료일</label>
	            <input type="date" name="startedAt" id="endedAt" />
	            <input type="hidden" name="score" value="${book.score}"/>
				<input type="text"  class="form-control" name="status" value="읽음" readonly/>
          </div>
			<h4 id="modalBookTitle"></h4>
			<div class="form-group">
				<label for="content" class="col-form-label">한줄평(250자 이내):</label>
				<textarea class="form-control" name="content" readonly><c:if test="${book != null}">${book.content}</c:if>
				</textarea>
			</div>
        </form:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="document.moreReadFrm.submit();">완독일 추가</button>
      </div>
    </div>
  </div>
</div>



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

window.addEventListener('load', () => {
	//console.log('${book.score}');
	const des = Array.from(document.querySelectorAll(".starRev span"));
	//console.log(des);
	for(let i = 0; i < ${book.score}; i++){
		des[i].classList.add('on');
	}
});

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