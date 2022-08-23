<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/search.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="책검색" name="title"/>
</jsp:include>
<section id="content">
	<div class="searchbar center-block">
		<form
			name="bookSearchFrm" 
			<%-- action="${pageContext.request.contextPath}/search/searchForm.do" --%>
			<%-- method="GET" --%>>
			    <select id="searchType" name="searchType" class="col-2 form-control d-inline form-select">
			      <option ${param.searchType eq "Keyword"? 'selected' : ''} value="Keyword">키워드</option>
			      <option ${param.searchType eq "Title"? 'selected' : ''} value="Title">책제목</option>
			      <option ${param.searchType eq "Author"? 'selected' : ''} value="Author">저자</option>
			      <option ${param.searchType eq "Publisher"? 'selected' : ''} value="Publisher">출판사</option>
			    </select>
			    <input type="text" class="form-control col-md-8 d-inline mx-3" name="searchKeyword" id="searchKeyword" value="${param.searchKeyword ne '' ? param.searchKeyword : '' }" placeholder="검색어를 입력해주세요">
			    <input type="button" class="btn btn-md btn-primary" id="btn-search" value="검색"/>
		</form>
	</div>
	<div class="" id="book-container">
		<p id="resultP"></p>
		<div id="btn-scroll-to-top-div">
			<a id="btn-scroll-to-top" class="rounded-circle shadow text-center d-flex" href="#">
				<i class="fa-solid fa-arrow-up"></i>
			</a>
		</div>	
	</div>
	<div id='btn-more-container'>
		<button id="btn-more" class="btn gap-2 col-12" type="button">더보기</button>
		<span style="display:none;" id="cPage">1</span>
	</div>

</section>
<script>
document.querySelector("#btn-scroll-to-top").addEventListener('click', (e) => {
	e.stopImmediatePropagation();
});
<%-- 검색 제출 시 유효성 검사 & 비동기--%>
document.querySelector("#btn-search").addEventListener('click', (e) => {
	const searchKeyword = document.querySelector("#searchKeyword");
	// 숫자, 영문, 한글로 2자 이상
	if(!/^[0-9a-zA-Z가-힣\s]{2,}$/.test(searchKeyword.value)){
		alert("검색어를 2자 이상 입력해주세요.");
		e.preventDefault();
		return;
	}
	
	const container = document.querySelector("#book-container");
	const query = document.bookSearchFrm.searchKeyword.value;
	const queryType = document.bookSearchFrm.searchType.value;
	container.innerHTML = "";
	getPage(1, 20);	
});

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
	document.querySelector("#cPage").innerText = cPageVal; 
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
	const nowPage = document.querySelector("#cPage").innerText;
	let intY = window.scrollY;	
	setCookie("intY", intY, "1");
	//console.log(nowPage);
	setCookie("cPageVal", nowPage, "1");
});

document.querySelector("#btn-more").onclick = () => {
	let c = Number(document.querySelector("#cPage").innerText);
	document.querySelector("#cPage").innerText = c + 1;
	maxResult = 20;
	getPage(c + 1, maxResult);
};

const getPage = (cPage, maxResult) => {
	console.log(cPage, maxResult);
	// const searchApi = 'https://cors-anywhere.herokuapp.com/';
	const container = document.querySelector("#book-container");
	console.log('${param.searchType}', '${param.searchKeyword}');
	
	let book = {
			ttbkey : 'ttbiaj96820130001',
			QueryType : 'Bestseller',
			SearchTarget: 'Book',
			Start : cPage,
			MaxResults : maxResult,
			Output : 'js',
			Cover : 'mini',
			Version : '20131101',
			Query : ''
	};
	if('${param.searchType}' == ''){
		//url = '{pageContext.request.contextPath}/search/selectBookList.do' 
		//"http://www.aladin.co.kr/ttb/api/ItemList.aspx";
		document.querySelector("#resultP").innerText = "베스트 도서 200선";
	} else{
		//url = '{pageContext.request.contextPath}/search/selectBookByKeyword.do' 
		//"http://www.aladin.co.kr/ttb/api/ItemSearch.aspx";
		book.QueryType = '${param.searchType}';
		document.querySelector("#resultP").innerText = "검색 결과";
	}
	if('${param.searchKeyword}' != ''){
		book.Query = '${param.searchKeyword}';
	}
	console.log(JSON.stringify(book));
	$.ajax({
		url : `${pageContext.request.contextPath}/search/selectBookList.do`,
		data : book,
		contentType : "application/json; charset=utf-8",
		success(resp){
			//console.log(resp);
			const {item} = resp;
			const divNon = `
				<div>
					<p style="text-align:center"> 검색된 결과가 없습니다. </p>
				</div>`
			if(item.length == 0){
				container.insertAdjacentHTML('beforeend', divNon);
				const btn = document.querySelector("#btn-more")
				btn.disabled = "disabled";
				btn.style.cursor = "not-allowed";
			} 
			item.forEach((book) => {
				const {isbn13, title, author, publisher, pubDate, cover} = book;
				const div = `
					<div class="book-table" onclick="bookEnroll(this);">
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

<%-- 책 클릭 시 내 서재에 등록 폼 --%>
const bookEnroll = (e) => {
	console.log(e.firstElementChild.value);	
	const isbn13 = e.firstElementChild.value;
	location.href = "${pageContext.request.contextPath}/search/bookEnroll.do?isbn13=" + isbn13;
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
