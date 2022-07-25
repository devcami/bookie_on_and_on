<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.title}</title>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">


<script src="https://kit.fontawesome.com/1c396dc14f.js" crossorigin="anonymous"></script>

<!-- 글꼴 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addBookPopup.css" />

<script>
<c:if test="${not empty msg}">
	alert('${msg}');
</c:if>
</script>
</head>
<body>

<!-- 책 추가 Modal -->
		<div  id="addBookModal" >
		  <div class="modal-dialog" >
		    <div class="modal-content">
		    
		      <div class="modal-header book-modal-header">
		        <h3 class="modal-title" id="exampleModalCenterTitle">책 추가</h3>	
		      </div>
		      
		      <div id="modal-header-bottom">
			      <h6 class="modal-title" id="exampleModalCenterTitle">추가된 책</h6>
			      <div class="img-btn">
				      <img src="https://image.aladin.co.kr/product/29358/89/covermini/k782837210_2.jpg" style="width:65px;">
				      <button type="button" class="close x-btn" >
				      	 <span aria-hidden="true">&times;</span>
				      </button>				      
			      </div>
			      <div class="img-btn">
				      <img src="https://image.aladin.co.kr/product/29820/33/covermini/8932474753_1.jpg" style="width:65px;">
				      <button type="button" class="close x-btn" >
				      	 <span aria-hidden="true">&times;</span>
				      </button>				      
			      </div>
			      <div class="img-btn">
				      <img src="https://image.aladin.co.kr/product/29358/89/covermini/k782837210_2.jpg" style="width:65px;">
				      <button type="button" class="close x-btn" >
				      	 <span aria-hidden="true">&times;</span>
				      </button>				      
			      </div>
			  </div>
		      
		      <div class="modal-body">		        
		        <div class="searchbar center-block">
					<form 
						name="bookSearchFrm" 
						action="${pageContext.request.contextPath}/club/addBookPopup.do"
						method="GET">
					   <select id="searchType" name="searchType" class="col-2 form-control d-inline form-select">
					      <option ${param.searchType eq "Keyword"? 'selected' : ''} value="Keyword">키워드</option>
					      <option ${param.searchType eq "Title"? 'selected' : ''} value="Title">책제목</option>
					      <option ${param.searchType eq "Author"? 'selected' : ''} value="Author">저자</option>
					      <option ${param.searchType eq "Publisher"? 'selected' : ''} value="Publisher">출판사</option>
					    </select>
					    <input type="text" class="form-control col-md-8 d-inline mx-3" name="searchKeyword" id="searchKeyword" value="${param.searchKeyword ne '' ? param.searchKeyword : '' }" placeholder="검색어를 입력해주세요">
					    <input type="submit" class="mybtn" id="btn-search" value="검색">
					</form>
				</div>
		      </div>
		      
		      <div class="modal-book-container">
				<div class="book-table" onclick="bookEnroll(this);">
					<input type="hidden" name="isbn13" value="9788932474755">
					<table class="tbl">
						<tbody><tr>
							<td rowspan="4">
								<img src="https://image.aladin.co.kr/product/29820/33/covermini/8932474753_1.jpg" style="width:65px;">
							</td>
							<td colspan="5" class="book-title">헤어질 결심 각본</td>
						</tr>
						<tr>
							<td class="book-author">박찬욱, 정서경 (지은이)</td>
						</tr>
						<tr>
							<td colspan="2" class="book-p">출판사 : 을유문화사 🧡 출판일 : 2022-08-05</td>
						</tr>
					</tbody></table>
				</div>
				<div>
					<button class="mybtn btn-plus" onclick="">+</button>
				</div>
			</div>
			
			<div class="modal-book-container">
				<div class="book-table" onclick="bookEnroll(this);">
					<input type="hidden" name="isbn13" value="9788932474755">
					<table class="tbl">
						<tbody><tr>
							<td rowspan="4">
								<img src="https://image.aladin.co.kr/product/29820/33/covermini/8932474753_1.jpg" style="width:65px;">
							</td>
							<td colspan="5" class="book-title">헤어질 결심 각본</td>
						</tr>
						<tr>
							<td class="book-author">박찬욱, 정서경 (지은이)</td>
						</tr>
						<tr>
							<td colspan="2" class="book-p">출판사 : 을유문화사 🧡 출판일 : 2022-08-05</td>
						</tr>
					</tbody></table>
				</div>
				
				<div>
					<button class="mybtn btn-plus" onclick="">+</button>
				</div>
			</div>
			<div id="btn-more-container">
				<button id="btn-more" class="btn gap-2 col-11" type="button">더보기</button>
				<span style="display:none;" id="cPage">5</span>
			</div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary cancel-btn book-btn" data-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-primary enroll-btn book-btn">등록</button>
		      </div>

		  </div>
		</div>
	</div>
	<!-- 책 추가 modal 끝 -->


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

//쿠키 가져오기 함수
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
		setTimeout(() => window.scrollTo(0, intY), 2000);
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



<%-- 검색 제출 시 유효성 검사 & 비동기--%>
document.bookSearchFrm.addEventListener('submit', (e) => {
	const searchKeyword = document.querySelector("#searchKeyword");
	// 숫자, 영문, 한글로 2자 이상
	if(!/^[0-9a-zA-Z가-힣]{2,}$/.test(searchKeyword.value)){
		alert("검색어를 2자 이상 입력해주세요.");
		e.preventDefault();
		return;
	}
	
	console.log('제출됨');
	 
	const searchApi = 'https://cors-anywhere.herokuapp.com/';  // 이것이 cors해결법이야
	const container = document.querySelector("#book-container");
	const query = document.bookSearchFrm.searchKeyword.value;  // 검색어
	const queryType = document.bookSearchFrm.searchType.value; // 검색어 종류
	container.innerHTML = "";
	
	getPage(1, 20);	
	

});


const getPage = (cPage, maxResult) => {
	   console.log(cPage, maxResult);
	   const searchApi = 'https://cors-anywhere.herokuapp.com/';
	   const container = document.querySelector("#book-container");
	   console.log('${param.searchType}', '${param.searchKeyword}');
	   
	   let data = {
	         ttbkey : 'ttbiaj96820130001',
	         QueryType : 'Bestseller',
	         SearchTarget: 'Book',
	         Start : cPage,
	         MaxResults : maxResult,
	         Output : 'js',
	         Cover : 'mini',
	         Version : '20131101'
	   };
	   let url;
	   if('${param.searchType}' == ''){
	      url = searchApi + "http://www.aladin.co.kr/ttb/api/ItemList.aspx";
	   } else{
	      url = searchApi + "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx";
	      data.QueryType = '${param.searchType}';
	   }
	   if('${param.searchKeyword}' != ''){
	      data.Query = '${param.searchKeyword}';
	   }
	   console.log(data);
	   $.ajax({
	      url : url,
	      //https://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbiaj96820130001&Query=aladdin&QueryType=Keyword&MaxResults=10&start=1&SearchTarget=Book&output=js&Version=20131101
	      data : data,
	      success(resp){
	         console.log(resp);
	      },
	      error : console.log
/* 	      complete(){
	         if(cPage == 10){
	            const btn = document.querySelector("#btn-more")
	            btn.disabled = "disabled";
	            btn.style.cursor = "not-allowed";
	         }
	      } */
	   });
	};

</script>
</body>
</html>
