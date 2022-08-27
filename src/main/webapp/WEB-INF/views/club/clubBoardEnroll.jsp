<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubBoardEnroll.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽 게시판 글 작성" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div id="clubBook-container">
	<section id="content">
		<div id="menuDiv">
			<ul>
				<li id="first-li" class="menu-li" style="background-color: #F76E11;"><a href="${pageContext.request.contextPath}/club/clubDetail.do/${clubNo}">메인페이지</a></li>
				<li id="second-li" class="menu-li" style="background-color: #FF9F45;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${clubNo}">북클럽 스토리</a></li>
				<li id="third-li" class="menu-li nowPage" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do?clubNo=${clubNo}">게시판</a></li>
				<li id="fourth-li" class="menu-li" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${clubNo}/${loginMember.username}">미션</a></li>
				<li id="fifth-li" class="menu-li" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/chat/clubChat.do/${clubNo}">채팅</a></li>		
			</ul>
		</div>
		<div id="top-title" class="text-center">
			<h1>📝글 작성📝</h1>
		</div>
		<form:form
			name="boardEnrollFrm"
			method="POST"
			enctype="multipart/form-data"
			action = "${pageContext.request.contextPath}/club/clubBoardEnroll.do">
		<div id="nickname-div">
			<label for="nickname">작성자</label>
			<input type="text" name="nickname" id="nickname" value="${loginMember.nickname}" readonly />
		</div>
		<div id="title-div">
			<label for="title">글 제목</label>
			<input type="text" id="title" name="title"/>
		</div>
		<div id="file-div">
			<div id="file-div-title">
				<label for="file-input">첨부파일</label>
				<span>파일은 최대 3개까지 첨부할 수 있습니다.</span>			
			</div>
			<input type="file" name="upFile" id="file1" multiple />
			<input type="file" name="upFile" id="file2" multiple />
			<input type="file" name="upFile" id="file3" multiple />			
		</div>
		<div id="content-div">
			<label for="editorData">내용</label>
			<textarea class="summernote" name="content"></textarea>
		</div>

		<input type="hidden" name="clubNo" value="${clubNo}" />
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		<div id="btn-div">
			<button>작성</button>
		</div>
		
		</form:form>
	</section>

</div>


<script>
	$(document).ready(function() {
		  $('.summernote').summernote();
		});
	
	$('.summernote').summernote({
		  // 에디터 높이
		  height: 300,
		  // 에디터 한글 설정
		  lang: "ko-KR",
		  // 에디터에 커서 이동 (input창의 autofocus라고 생각하시면 됩니다.)
		  toolbar: [
			    // 글꼴 설정
			    ['fontname', ['fontname']],
			    // 글자 크기 설정
			    ['fontsize', ['fontsize']],
			    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    // 글자색
			    ['color', ['forecolor','color']],
			    // 표만들기
			    ['table', ['table']],
			    // 글머리 기호, 번호매기기, 문단정렬
			    ['para', ['ul', 'ol', 'paragraph']],
			    // 줄간격
			    ['height', ['height']],
			    // 그림첨부, 링크만들기, 동영상첨부
			    ['insert',['picture','link','video']],
			    // 코드보기, 확대해서보기, 도움말
			    ['view', ['codeview','fullscreen', 'help']]
			  ],
			  // 추가한 글꼴
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
			 // 추가한 폰트사이즈
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
			
		});
	
	
	const frmSubmit = () => {
		
		const frm = document.boardEnrollFrm;
		const title = document.querySelector("#title");
		const content = document.querySelector("content");

		
		if(!/^.+$/.test(title.value)){
			frm.preventDefault();
			alert("제목을 작성해주세요.")
			return;
		}
		
		
		
	 	frm.submit();
		
	}
	

	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>