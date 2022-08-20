<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/missionCheck.css" />
<script>
	let arr = new Array();
</script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="미션 승인 페이지" name="title"/>
</jsp:include>
      <div class="row">
        <div class="col-12">
          <div class="row col-12 btn-group">
          	<a href="${pageContext.request.contextPath}/admin/memberList.do" class="btn yellow"    id="member" >회원목록</a>
			<a href="${pageContext.request.contextPath}/admin/reportList.do" class="btn red"    id="report" >신고</a>
			<a href="${pageContext.request.contextPath}/admin/qnaList.do" class="btn purple" id="question">Q & A</a>
			<a href="${pageContext.request.contextPath}/admin/sendAlarm.do" class="btn green"  id="alarm">알림전송</a>
			<a href="${pageContext.request.contextPath}/admin/missionCheck.do" class="btn blue"  id="mission">미션확인</a>
	     </div>
        </div>
      </div>
<section id="content">
	<div id="head">
		<h3>승인 대기중인 미션</h3>
		<h6>*제출된지 오래된 순으로 보여집니다*</h6>
	</div>
	<div id="mission-container">
		<c:forEach items="${list}" var="ms" varStatus="vs">
			<div 
				class="mission-card" 
				data-vs-no="${vs.count}" 
				onclick="openMissionModal(this);"
				id="${ms.missionNo}${ms.memberId}">
				<h5>📙북클럽 [${ms.mission.clubTitle}]</h5>
				<div class="rows">
					<span>${ms.memberId}</span>
					<span>${ms.mission.title}</span>
					<span><fmt:formatNumber value="${ms.mission.point}" pattern="#,###" />원</span>
					<fmt:parseDate value="${ms.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="updatedAt"/>
 					<span><fmt:formatDate value="${updatedAt}" pattern="yyyy/MM/dd HH:mm"/> 제출</span>
				</div>
			</div>
			
			<script>
 				arr.push({ 
					"missionNo" : "${ms.missionNo}",
					"answer" : "${ms.answer}",
					"memberId" : "${ms.memberId}",
					"renamedFilename" : "${ms.renamedFilename}",
					"mendDate" : "${ms.mission.mendDate}",
					"updatedAt" : "${ms.updatedAt}",
					"clubTitle" : "${ms.mission.clubTitle}",
					"missionTitle" : "${ms.mission.title}",
					"missionContent" : "${ms.mission.content}",
					"point" : "${ms.mission.point}",
					"imgSrc" : "${ms.mission.imgSrc}"
					});
			</script>
		</c:forEach>
		
	</div>
	
	<div>
		${pagebar}
	</div>
</section>

<%-- 미션 모달 --%>
	<div class="modal fade" id="missionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 id="clubTitle">📙북클럽 [돈 공부 함께해요] 미션</h5>	 
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body" id="modalMissionWrapper">
	      	<div id="missionInfo">
				<h6 id="missionTitle">책 개시 인증</h6>
				<span id="missionContent">미션 내용 적는 칸입니다.</span>	      	
	      	</div>
			<div id="userAnswer">
				<div id="idDiv">
					<h6>회원 아이디</h6>
					<span id="missionMemberId">tmddbs</span>				
				</div>
				<div id="contentDiv">
					<h6>제출 내용</h6>			
					<img id="missionImg" src="" />
					<span id="missionAnswer">제출한 내용입니다.</span>			
				</div>
			</div>
	      <div class="modal-footer">
	        <button 
	        	type="button" class="btn btn-secondary" id="failBtn" 
	        	data-mission-no=""
	        	data-member-id=""
	        	onclick="missionAgain(this)">
	        	반려</button>
	        <button 
	        	type="button" class="btn btn-enroll" id="passBtn" 
	        	data-mission-no=""
	        	data-member-id=""
	        	onclick="missionPass(this);">
	        	승인</button>
	      </div>
	    </div>
	  </div>
	</div>
	<%-- 미션 모달 끝 --%>


<script>
 	const openMissionModal = (e) => {
 		// console.log(arr);
 		
		const vsNo = e.dataset.vsNo - 1;
		console.log(vsNo);
		console.log(arr[vsNo]);
		
		const titleTag = document.querySelector('#missionTitle');
		const contentTag = document.querySelector('#missionContent');
		const idTag = document.querySelector('#missionMemberId');
		const imgTag = document.querySelector('#missionImg');
		const answerTag = document.querySelector('#missionAnswer');
		const failBtn = document.querySelector('#failBtn');
		const passBtn = document.querySelector('#passBtn');
		
		if(arr[vsNo].renamedFilename == ''){
			console.log('사진 없음');
			imgTag.style.display = 'none';
			
		}
		if(arr[vsNo].renamedFilename != ''){
			console.log('사진 있음');
			imgTag.style.display = '';
			imgTag.src = `${pageContext.request.contextPath}/resources/upload/mission/\${arr[vsNo].renamedFilename}`;
		}
		
		
		titleTag.innerHTML = arr[vsNo].missionTitle;
		contentTag.innerHTML = arr[vsNo].missionContent;
		idTag.innerHTML = arr[vsNo].memberId;
		answerTag.innerHTML = arr[vsNo].answer;
		failBtn.dataset.memberId = arr[vsNo].memberId;
		failBtn.dataset.missionNo = arr[vsNo].missionNo;
		passBtn.dataset.memberId = arr[vsNo].memberId;
		passBtn.dataset.missionNo = arr[vsNo].missionNo;
		
		
		// 미션 모달 보여줘
		$('#missionModal').modal('show');	
		
	}
 	
 
 const missionAgain = (e) => {
	 
	 const missionNo = e.dataset.missionNo;
	 const memberId = e.dataset.memberId;
	 
	 const csrfHeader = '${_csrf.headerName}';
	 const csrfToken = '${_csrf.token}';
	 const headers = {};
	 headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송
	 
	 $.ajax({
		 url: `${pageContext.request.contextPath}/admin/missionAgain.do/\${missionNo}/\${memberId}`,
		 method: "POST",
		 headers,
		 success(resp){
			alert("미션 결과가 성공적으로 반영되었습니다!"); 
			const cardId = "#" + missionNo + memberId;
			$(cardId).remove();
			
			// 미션 모달 숨겨
			$('#missionModal').modal('hide');	
			 
		 },
		 error: console.log
	 });
	 
	 

 }
 
 const missionPass = (e) => {
	 
	 const missionNo = e.dataset.missionNo;
	 const memberId = e.dataset.memberId;
	 
	 const csrfHeader = '${_csrf.headerName}';
	 const csrfToken = '${_csrf.token}';
	 const headers = {};
	 headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송
	 
	 $.ajax({
		 url: `${pageContext.request.contextPath}/admin/missionPass.do/\${missionNo}/\${memberId}`,
		 method: "POST",
		 headers,
		 success(resp){
			 alert("미션 결과가 성공적으로 반영되었습니다!");
			 const cardId = "#" + missionNo + memberId;
		     $(cardId).remove();
			
			 // 미션 모달 숨겨
			 $('#missionModal').modal('hide');	
			 
		 },
		 error: console.log
	 });
	 
 }
 	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>