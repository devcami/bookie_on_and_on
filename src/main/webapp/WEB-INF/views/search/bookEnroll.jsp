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
			  <input type="radio" class="btn-check" name="status" id="btnradio1" value="읽고 싶은" autocomplete="off">
			  <label class="btn btn-outline-primary btn-status" for="btnradio1">읽고 싶은</label>
			
			  <input type="radio" class="btn-check" name="status" id="btnradio2" value="읽는 중" autocomplete="off">
			  <label class="btn btn-outline-primary btn-status" for="btnradio2">읽는 중</label>
			
			  <input type="radio" class="btn-check" name="status" id="btnradio3" value="읽음" autocomplete="off">
			  <label class="btn btn-outline-primary btn-status" for="btnradio3">읽음</label>
			  
			  <input type="radio" class="btn-check" name="status" id="btnradio4" value="잠시 멈춘" autocomplete="off">
			  <label class="btn btn-outline-primary btn-status" for="btnradio4">잠시 멈춘</label>
			  
			  <input type="radio" class="btn-check" name="status" id="btnradio5" value="중단" autocomplete="off">
			  <label class="btn btn-outline-primary btn-status" for="btnradio5">중단</label>
			  
				<button type="button" class="btn btn-sm btn-secondary" id="btn-deselect" onclick="deselect();">선택해제</button>
			</div>
			<button class="custom-btn btn-5" data-toggle="modal" data-target="#enrollBookModal"><span>등록</span></button>
			<!-- <button type="submit" class="btn btn-md btn-outline-primary" id="btn-enroll" onclick="bookEnroll();">저장</button> -->
		</div>
	</div>
	<div class="line"></div>
	<div id="book-desc">
		
	</div>
	<div class="line"></div>
</section>

<script>
<%-- 제출 --%>
const bookEnroll = () => {
	Array.from(document.querySelectorAll("[name=status]")).forEach((status) => {
		if(status.checked){
			// console.log(status.value);
			document.querySelector("#book-status").value = status.value;
		}
	});
	
	if(document.querySelector("#book-status").value == ""){
		alert('책 상태를 선택해주세요.');
		return;
	}
	console.log(document.querySelector("#book-status").value);
	console.log(document.bookEnrollFrm.score.value);
	console.log(document.bookEnrollFrm.isbn13.value);
	console.log(document.bookEnrollFrm.content);
	
	//document.bookEnrollFrm.submit();
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
        <form:form name="bookEnrollFrm">
          <div class="form-group">
	            <input type="text" class="form-control" id="nickname" value="${loginMember.nickname}" readonly>
	            <input type="hidden" class="form-control" id="member_id" value="${loginMember.memberId}">
	            <input type="hidden" name="score" id="book-score" value="0"/>
				<input type="hidden" name="isbn13" id="book-isbn13" value=""/>
				<input type="hidden" name="book-status" id="book-status" />
          </div>
          <div class="form-group">
          	<c:if test="${document.querySelector('#book-status').value != '읽음'}">
          		<h4 id="modalBookTitle"></h4>
          	</c:if>
          	<c:if test="${document.querySelector('#book-status').value == '읽음'}">
            <label for="content" class="col-form-label">한줄평(250자 이내):</label>
            <textarea class="form-control" id="content" name="content"></textarea>
          	</c:if>
          </div>
        </form:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="bookEnroll();">책등록</button>
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
			
			document.querySelector("#book-isbn13").value = `${isbn13}`;
			document.querySelector("#title-p").innerHTML +=`\${title}`;
			document.querySelector("#title").innerText=`\${title}`;
			document.querySelector("#modalBookTitle").innerText=`\${title}`;
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