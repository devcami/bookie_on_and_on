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
<section id="content">
	<div id="book-container">
		<div class="book-image" >
			<img id="book-image" src="" alt="책표지" />
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
				<input type="hidden" name="score" id="book-score"/>
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
			  
			</div>
			<button type="button" class="btn btn-sm btn-outline-secondary" onclick="deselect();">선택해제</button>
		</div>
	</div>
	<div class="line"></div>
	<div id="book-desc">
	
	</div>
</section>
<script>
window.addEventListener('load', () => {
	const searchApi = 'https://cors-anywhere.herokuapp.com/';
	const bookContainer = document.querySelector("#book-container");
	const bookDescription = document.querySelector("#book-desc");
	$.ajax({
		url : searchApi + "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx",
		//http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=ttbiaj96820130001&itemIdType=ISBN13&ItemId=9788932474755&output=js&version=20131101
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
			const {title, subInfo, author, pubDate, description, isbn13, cover, categoryId, categoryName, publisher} = item[0];			
			const {subTitle} = subInfo;
			const img = document.querySelector("#book-image");
			img.src = `\${cover}`;
			document.querySelector("#subTitle").innerText=`\${subTitle}`
			const divDescription = `
				<div class="book-des">
					<div class="book-info">
						<h3 class="book-title">\${title}</h3>
						<h5 class="book-author">\${author}</h5>
						<h5 class="book-pub">\${publisher} | \${pubDate}</h5>
					</div>
				</div>
			`;
			bookDescription.insertAdjacentHTML('beforeend', divDescription);
		},
		error : console.log,
	});
});

$('.starRev span').click(function(){
	$(this).parent().children('span').removeClass('on');
	$(this).addClass('on').prevAll('span').addClass('on');

	let {length} = document.querySelectorAll(".on");
	document.querySelector("#book-score").value = length;
	//console.log(length);
	
	return false;
});

const deselect = () => {
	$("input:radio[name='status']").prop('checked', false);	
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>