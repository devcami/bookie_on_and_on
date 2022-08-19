<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myBook.css" />
<sec:authentication property="principal" var="loginMember" scope="page"/>
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="책검색" name="title"/>
</jsp:include>

<section id="content">
	<div id="book-status-container">
		<div class="book-eval">
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="status" id="btnradio1" value="읽고 싶은" autocomplete="off" onclick="getItemId(event)">
			  <label class="btn btn-outline-primary btn-status" for="btnradio1">읽고 싶은</label>
			
			  <input type="radio" class="btn-check" name="status" id="btnradio2" value="읽는 중" autocomplete="off" onclick="getItemId(event)">
			  <label class="btn btn-outline-primary btn-status" for="btnradio2">읽는 중</label>
			
			  <input type="radio" class="btn-check" name="status" id="btnradio3" value="읽음" autocomplete="off" onclick="getItemId(event)">
			  <label class="btn btn-outline-primary btn-status" for="btnradio3">읽음</label>
			  
			  <input type="radio" class="btn-check" name="status" id="btnradio4" value="잠시 멈춘" autocomplete="off" onclick="getItemId(event)">
			  <label class="btn btn-outline-primary btn-status" for="btnradio4">잠시 멈춘</label>
			  
			  <input type="radio" class="btn-check" name="status" id="btnradio5" value="중단" autocomplete="off" onclick="getItemId(event)">
			  <label class="btn btn-outline-primary btn-status" for="btnradio5">중단</label>

			  <input type="radio" class="btn-check" name="status" id="btnradio6" value="전체" autocomplete="off" onclick="getAll(event)">
			  <label class="btn btn-outline-primary btn-status" for="btnradio6">전체</label>
			</div>
		</div>
	</div>
	<div id="book-container">
		<p id="resultP"></p>
	</div>
</section>
<script>

<%-- scroll 유지 테스트 --%>
//쿠키 생성 함수
function setCookie(cName, cValue, cDay){
	var expire = new Date();
	expire.setDate(expire.getDate() + cDay);
	cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
	if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
	document.cookie = cookies;
}

// 쿠키 가져오기 함수
function getCookie(cName) {
	cName = cName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cName);
	var cValue = '';
	if(start != -1){
		start += cName.length;
		var end = cookieData.indexOf(';', start);
		if(end == -1)end = cookieData.length;
		cValue = cookieData.substring(start, end);
	}
	return unescape(cValue);
}

<%-- paging --%>
var maxResult = 20;
//var cPage = Number(document.querySelector("#cPage").innerText);
window.addEventListener('load', () => {
	const intY = getCookie("intY");
	const cPageVal = getCookie("cPageVal");
	// console.log(intY, cPageVal);
	if(cPageVal > 1){
		maxResult = cPageVal * maxResult;
	}
	else if(cPageVal > 2){
		maxResult = 40;
	}
	if(intY != 0) {
	 	//쿠키값에 scroll 값이 저장되었을 경우
		console.log("scrollTo : " + intY);
		getPage(1, maxResult);
 		setTimeout(() => window.scrollTo(0, intY), 1000);
	} else {
	 	//scroll 값이 없는 경우
		getPage(1, maxResult);
	 	setTimeout(() => window.scrollTo(0, 0), 1000)
	}
});

window.addEventListener('scroll', (e) => {
	let intY = window.scrollY;	
	setCookie("intY", intY, "1");
	//console.log(nowPage);
	// setCookie("cPageVal", nowPage, "1");
});

function reload(){
	location.reload();
}

function getItemId(event) {	
	const status = event.target.value;
	const container = document.querySelector("#book-container");
	const memberId = "${member.memberId}";
	container.innerHTML = null;
	container.innerHTML = `<p id="resultP"></p>`;
	document.querySelector("#resultP").innerText = '${member.nickname}' + ' 님의 책목록입니다.';
	var itemId = [];
	console.log(status);
	
	/* Ststus에 맞는 itemId찾아오기 */
	$.ajax({
		url: '${pageContext.request.contextPath}/mypage/getItemIdByStatus.do',
		method : "get",
		data : {status :status, memberId :memberId},
		success(data){
			console.log(data);
			itemId = data;
			const divNon = `
				<div>
					<p style="text-align:center"> 검색된 결과가 없습니다. </p>
				</div>`
			if(itemId.length == 0){
				container.insertAdjacentHTML('beforeend', divNon);
			}
			/* 읽고 있는 책 찾아 뿌리기 */
			itemId.forEach((value, index, array)=>{
				$.ajax({
					url: `${pageContext.request.contextPath}/mypage/statusBook.do`,
					data: {
						itemId : value
					},
					method : "get",
					success(data){
						const {item} = data;
						item.forEach((book) => {
							const {isbn13, title, author, publisher, pubDate, cover} = book;
							console.log(isbn13, title, author, publisher, pubDate, cover);
							const div = `
								<c:choose>
									<c:when test="${loginMember.memberId eq member.memberId}">
										<div class="book-table" onclick="bookEnroll(this);">	
									</c:when>
									<c:otherwise>
										<div class="book-table">	
									</c:otherwise>
								</c:choose>
									<input type="hidden" name="isbn13" value=\${isbn13} />
									<table class="tbl">
										<tr>
											<td rowspan="4">
												<img src=\${cover} style="width:65px;" />
											</td>
											<td colspan="5" class="book-title">\${title}</td>
										</tr>
										<tr>
											<td class="book-author">\${author}</td>
										</tr>
										<tr>
											<td colspan="2" class="book-p">출판사 : \${publisher} 🧡 출판일 : \${pubDate}</td>
										</tr>
									</table>
								</div>`;
							container.insertAdjacentHTML('beforeend', div);
						});
			 		},
					error : console.log
				});	
	 		})
		},
		error : console.log
		});
};

/* 페이지 로딩시 전체 책 정보 */
const getPage = (cPage, maxResult) => {
	const memberId = "${member.memberId}";
	console.log(cPage, maxResult);
	const container = document.querySelector("#book-container");
	document.querySelector("#resultP").innerText = '${member.nickname}' + ' 님의 책목록입니다.';

	$.ajax({
		url : '${pageContext.request.contextPath}/mypage/myBookAllItemId.do',
		data : { memberId :memberId },
		success(data){
			console.log(data);
			console.log(data);
			itemId = data;
			const divNon = `
				<div>
					<p style="text-align:center"> 검색된 결과가 없습니다. </p>
				</div>`
			if(itemId.length == 0){
				container.insertAdjacentHTML('beforeend', divNon);
			}
			/* 읽고 있는 책 찾아 뿌리기 */
			itemId.forEach((value, index, array)=>{
				$.ajax({
					url: `${pageContext.request.contextPath}/mypage/statusBook.do`,
					data: {
						itemId : value
					},
					method : "get",
					success(data){
						const {item} = data;
						console.log(item);
						console.log(item.length);
						item.forEach((book) => {
							const {isbn13, title, author, publisher, pubDate, cover} = book;
							console.log("여기어디?2");
							console.log(isbn13, title, author, publisher, pubDate, cover);
							const div = `
								<c:choose>
									<c:when test="${loginMember.memberId eq member.memberId}">
										<div class="book-table" onclick="bookEnroll(this);">	
									</c:when>
									<c:otherwise>
										<div class="book-table">	
									</c:otherwise>
								</c:choose>
									<input type="hidden" name="isbn13" value=\${isbn13} />
									<table class="tbl">
										<tr>
											<td rowspan="4">
												<img src=\${cover} style="width:65px;" />
											</td>
											<td colspan="5" class="book-title">\${title}</td>
										</tr>
										<tr>
											<td class="book-author">\${author}</td>
										</tr>
										<tr>
											<td colspan="2" class="book-p">출판사 : \${publisher} 🧡 출판일 : \${pubDate}</td>
										</tr>
									</table>
								</div>`;
							container.insertAdjacentHTML('beforeend', div);
						});
			 		},
					error : console.log
				});	
	 		})
		},
		error : console.log,
		complete(){
			if(cPage == 10){
				const btn = document.querySelector("#btn-more")
				btn.disabled = "disabled";
				btn.style.cursor = "not-allowed";
			}
		}
	});
};

/* 전체 책 정보 */
function getAll(event){
	const status = event.target.value;
	const container = document.querySelector("#book-container");
	const memberId = "${member.memberId}";
	container.innerHTML = null;
	container.innerHTML = `<p id="resultP"></p>`;
	document.querySelector("#resultP").innerText = '${member.nickname}' + ' 님의 책목록입니다.';
	var itemId = [];
	console.log(status);
	
	$.ajax({
		url: '${pageContext.request.contextPath}/mypage/myBookAllItemId.do',
		method : "get",
		data : {status :status, memberId :memberId},
		success(data){
			console.log(data);
			itemId = data;
			const divNon = `
				<div>
					<p style="text-align:center"> 검색된 결과가 없습니다. </p>
				</div>`
			if(itemId.length == 0){
				container.insertAdjacentHTML('beforeend', divNon);
			}
			/* 읽고 있는 책 찾아 뿌리기 */
			itemId.forEach((value, index, array)=>{
				$.ajax({
					url: `${pageContext.request.contextPath}/mypage/statusBook.do`,
					data: {
						itemId : value
					},
					method : "get",
					success(data){
						const {item} = data;
						item.forEach((book) => {
							const {isbn13, title, author, publisher, pubDate, cover} = book;
							console.log(isbn13, title, author, publisher, pubDate, cover);
							const div = `
								<c:choose>
									<c:when test="${loginMember.memberId eq member.memberId}">
										<div class="book-table" onclick="bookEnroll(this);">	
									</c:when>
									<c:otherwise>
										<div class="book-table">	
									</c:otherwise>
								</c:choose>
									<input type="hidden" name="isbn13" value=\${isbn13} />
									<table class="tbl">
										<tr>
											<td rowspan="4">
												<img src=\${cover} style="width:65px;" />
											</td>
											<td colspan="5" class="book-title">\${title}</td>
										</tr>
										<tr>
											<td class="book-author">\${author}</td>
										</tr>
										<tr>
											<td colspan="2" class="book-p">출판사 : \${publisher} 🧡 출판일 : \${pubDate}</td>
										</tr>
									</table>
								</div>`;
							container.insertAdjacentHTML('beforeend', div);
						});
			 		},
					error : console.log
				});	
	 		})
		},
		error : console.log
		});
};

<%-- 책 클릭 시 내 서재에 등록 폼  --%>
const bookEnroll = (e) => {
	console.log(e.firstElementChild.value);	
	const isbn13 = e.firstElementChild.value;
	location.href = "${pageContext.request.contextPath}/search/bookEnroll.do?isbn13=" + isbn13;
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>