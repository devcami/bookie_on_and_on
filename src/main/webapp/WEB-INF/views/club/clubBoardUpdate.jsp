<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubBoardUpdate.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽 게시판 글 수정" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div id="clubBook-container">
	<section id="content">
		<div id="menuDiv">
			<ul>
				<li id="first-li" class="menu-li" style="background-color: #F76E11;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${club.clubNo}">메인페이지</a></li>
				<li id="second-li" class="menu-li" style="background-color: #FF9F45;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${club.clubNo}">북클럽 스토리</a></li>
				<li id="third-li" class="menu-li nowPage" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do?clubNo=${club.clubNo}">게시판</a></li>
				<li id="fourth-li" class="menu-li" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${club.clubNo}/${loginMember.username}">미션</a></li>
				<li id="fifth-li" class="menu-li" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/chat/clubChat.do/${club.clubNo}">채팅</a></li>		
			</ul>
		</div>
		<div id="board-div">
			<form:form
				name="boardUpdateFrm"
				method="POST"
				enctype="multipart/form-data"
				action = "${pageContext.request.contextPath}/club/clubBoardUpdate.do">
			<div id="content-top">
				<div id="top-title" class="text-center">
					<h1>📝글 수정📝</h1>
				</div>
				<div id="nickname-div">
					<label for="nickname">작성자</label>
					<input type="text" name="nickname" id="nickname" value="${loginMember.nickname}" readonly />
				</div>
				<div id="title-div">
					<label for="title">글 제목</label>
					<input type="text" id="title" name="title" value="${clubBoard.title}"/>
				</div>
			</div>
			<div id="content-bottom">
				<div id="file-div">
					<div id="file-div-title">
						<label for="file-input">첨부파일</label>
						<span>파일은 최대 3개까지 첨부할 수 있습니다.</span>			
					</div>
					<c:forEach items="${clubBoard.chatAttachments}" var="attach" varStatus="vs">
						<div class="img-div" id="imgDiv${attach.attachNo}">
							<img src="${pageContext.request.contextPath}/resources/upload/club/${attach.renamedFilename}" class="imgs" />
							<button type="button" class="img-del-btn" data-attach-no="${attach.attachNo}" onclick="deleteFile(this);">삭제</button>			
						</div>		
					</c:forEach>
					${vs}
					<div id="input-file-div">
						<%-- 여기에 새로 추가되는 파일이 들어감 --%>					
					</div>
				</div>
				<div id="content-div">
					<label for="editorData">내용</label>
					<textarea class="summernote" name="content">
					${clubBoard.content}
					</textarea>
				</div>		
				<div id="btn-div">
					<button>작성</button>
				</div>

				<input type="hidden" name="clubNo" value="${clubBoard.clubNo}" />
				<input type="hidden" name="chatNo" value="${clubBoard.chatNo}" />
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />				
				
				
			</div>
			</form:form>
		</div>
		
	</section>

</div>


<script>
let i = 0;
	$(document).ready(function() {
		$('.summernote').summernote();
		console.log($("#input-file-div")); 
		console.log("${clubBoard.chatAttachments.size()}")
		
		const div = document.querySelector("#input-file-div");
		const attachSize = "${clubBoard.chatAttachments.size()}";
		
		// 페이지가 로드될 때 첨부할 수 있는 파일 남은 개수만큼 input 태그 추가해라
		for(i = 0; i < 3-attachSize; i++){
			const inputTag = `<input type="file" name="upFile" id="file\${i+1}" multiple />`;
			div.insertAdjacentHTML('beforeend', inputTag);
		}
		  
	});
	
	// 기존 파일 삭제 눌렀을 때
	const deleteFile = (e) => {
		console.log(e);
		
		// 먼저 이미지랑 삭제 버튼 담긴 div 지워버려
		const attachNo = e.dataset.attachNo;
		const divId = "#imgDiv" + attachNo;
		$("#file-div").find(divId).remove();
		
		// 그리고 폼 가장 아래에 input[name=delFile]로 추가해
		const frm = document.boardUpdateFrm;
		const delInputTag = `<input type="hidden" name="delFile" value="\${attachNo}"/>`
		frm.insertAdjacentHTML('beforeend', delInputTag);
		
		// 그리고 파일 하나 삭제됐으니까 새로 파일 추가할 수 있는 input 태그 넣어
		const div = document.querySelector("#input-file-div");
		const inputTag = `<input type="file" name="upFile" id="file\${i+1}" multiple />`;
		div.insertAdjacentHTML('beforeend', inputTag);
		
		i++;
		
		
	}
	
	$('.summernote').summernote({
		  // 에디터 높이
		  height: 300,
		  // 에디터 한글 설정
		  lang: "ko-KR",
		  // 에디터에 커서 이동 (input창의 autofocus라고 생각하시면 됩니다.)
		  focus : true,
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
		
/* 		const frm = document.boardEnrollFrm;
		const title = document.querySelector("#title");
		const content = document.querySelector("content");

		
		if(!/^.+$/.test(title.value)){
			frm.preventDefault();
			alert("제목을 작성해주세요.")
			return;
		}
		
		
		
	 	frm.submit(); */
		
	}
	

	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>