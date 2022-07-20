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
			action="${pageContext.request.contextPath}/search/searchBook.do"
			method="GET">
			    <select id="searchType" name="searchType" class="col-2 form-control d-inline form-select">
			      <option selected value="bookName">책제목</option>
			      <option value="author">저자</option>
			      <option value="publisher">출판사</option>
			    </select>
			    <input type="text" class="form-control col-md-6 d-inline mx-3" id="inputZip" placeholder="검색어를 입력해주세요">
			    <input type="button" class="btn btn-md btn-primary" id="btn-search" value="검색"/>
		</form>
	</div>
	<div class="" id="book-container">
		<p>베스트 도서 200선</p>
		
	</div>
	<div id='btn-more-container'>
		<button id="btn-more" class="btn gap-2 col-12" type="button">더보기</button>
		<span style="display:none;" id="cPage"></span>
	</div>
</section>
<script>
<%-- paging --%>
window.addEventListener('load', () => {
	getPage(1);
});
document.querySelector("#btn-more").onclick = () => {
	const cPageVal = Number(document.querySelector("#cPage").innerText) + 1;
	getPage(cPageVal);
};
const getPage = (cPage) => {
	const searchApi = 'https://cors-anywhere.herokuapp.com/';
	const container = document.querySelector("#book-container");
	$.ajax({
		url : searchApi + "http://www.aladin.co.kr/ttb/api/ItemList.aspx",
		data : {
			ttbkey : 'ttbiaj96820130001',
			QueryType : 'Bestseller',
			MaxResults : 20,
			start : cPage,
			SearchTarget : 'Book',
			output : 'js',
			Cover : 'mini',
			Version : '20131101'
		},
		success(resp){
			const {item} = resp;
			item.forEach((book) => {
				console.log(book);
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
			document.querySelector("#cPage").innerHTML = cPage;
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
