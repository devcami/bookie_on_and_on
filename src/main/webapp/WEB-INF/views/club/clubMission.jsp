<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMission.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽 미션" name="title"/>
</jsp:include>
${clubNo}
${memberId}
${missions}
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>
<script>
	let missionArr = new Array();
</script>
<section id="content">
	<div id="menuDiv">
		<ul>
			<li id="first-li" class="menu-li" style="background-color: #F76E11;"><a href="${pageContext.request.contextPath}/club/clubDetail.do/${clubNo}">메인페이지</a></li>
			<li id="second-li" class="menu-li" style="background-color: #FF9F45;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${clubNo}">북클럽 스토리</a></li>
			<li id="third-li" class="menu-li" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do/${clubNo}">게시판</a></li>
			<li id="fourth-li" class="menu-li nowPage" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${clubNo}/${loginMember.username}">미션</a></li>
			<li id="fifth-li" class="menu-li" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/club/clubChat.do/${clubNo}">채팅..?</a></li>		
		</ul>
	</div>

	<div id="menu">
		<h1>🥇나의 미션🥇</h1>	
	</div>
	<div id="mission-wrapper">
		<div class="mission-container">
			<div class="mission-left mission-left-start">
				<span>시작!</span>
			</div>
			<div id="bar-first" class="mission-bar">
				<i class="fa-solid fa-circle fa-circle-border"></i>
				<i class="fa-solid fa-circle fa-circle-inside" style="color: #f8f9fa;"></i>
			</div>
		</div>
		
		<c:forEach items="${missions}" var="mission" varStatus="vs">
		
		<script>
			missionArr.push({ 
				"clubNo": "${mission.clubNo}",
				"missionNo" : "${mission.missionNo}",
				"title" : "${mission.title}",
				"content" : "${mission.content}",
				"mendDate" : "${mission.mendDate}",
				"point" : "${mission.point}",
				"answer" : "${mission.missionStatus.answer}",
				"status" : "${mission.missionStatus.status}",
				"renamedFilename" : "${mission.missionStatus.renamedFilename}",
				"originalFilename": "${mission.missionStatus.originalFilename}"
				});
		</script>
			
			
			<%-- missionStatus가 null인 경우 (기한이 지나지 않고, 아직 수행하지 않은 미션) --%>
			<c:if test="${mission.missionStatus eq null}">
				<div class="mission-container">
					<div class="mission-left">
						<span></span>
					</div>
					<div class="mission-bar">
						<i class="fa-solid fa-circle fa-circle-border"></i>
						<i class="fa-solid fa-circle fa-circle-inside" style="color: #f8f9fa"></i>					
					</div>
					<div class="mission-date-card" >
						<span class="mendDateSpan">~ ${mission.mendDate}</span>
						<div class="mission-card" data-vs-no="${vs.count}" onclick="openMissionDodal(this);">
							<img src="${fn:replace(mission.imgSrc, 'covermini', 'cover')}">
							<div class="mission-info">
								<span>${mission.title}</span>
								<span><fmt:formatNumber value="${mission.point}" pattern="#,###" />원</span>				
							</div>
						</div>
					</div>
				</div>	
			</c:if>	
			
			<%-- missionStatus가 null이 아닌 경우 (미션을 수행했고 상태가 있는 경우) --%>
			<c:if test="${mission.missionStatus ne null}">
				
				<%-- 미션 성공인 경우 --%>
				<c:if test="${mission.missionStatus.status eq 'P'}">
					<div class="mission-container">
						<div class="mission-left statusDiv">
							<span class="status-span" style="background: #ffc107;">성공! +<fmt:formatNumber value="${mission.point}" pattern="#,###" /></span>
						</div>
						<div class="mission-bar">
							<i class="fa-solid fa-circle fa-circle-border"></i>
							<i class="fa-solid fa-circle fa-circle-inside" style="color: #ffc107"></i>					
						</div>
						<div class="mission-date-card" >
							<span class="mendDateSpan">~ ${mission.mendDate}</span>
							<div class="mission-card" data-vs-no="${vs.count}" onclick="openMissionDodal(this);">
								<img src="${fn:replace(mission.imgSrc, 'covermini', 'cover')}" onclick="">
								<div class="mission-info">
									<span>${mission.title}</span>
									<span><fmt:formatNumber value="${mission.point}" pattern="#,###" />원</span>				
								</div>
							</div>
						</div>
					</div>
				</c:if>
				
				
				<%-- 미션 승인 대기중 경우 --%>
				<c:if test="${mission.missionStatus.status eq 'I'}">
					<div class="mission-container">
						<div class="mission-left statusDiv">
							<span class="status-span" style="background: grey;">승인 대기중</span>
						</div>
						<div class="mission-bar">
							<i class="fa-solid fa-circle fa-circle-border"></i>
							<i class="fa-solid fa-circle fa-circle-inside" style="color: #9a9b9b"></i>						
						</div>
						<div class="mission-date-card" >
							<span class="mendDateSpan">~ ${mission.mendDate}</span>
							<div class="mission-card" data-vs-no="${vs.count}" onclick="openMissionDodal(this);">
								<img src="${fn:replace(mission.imgSrc, 'covermini', 'cover')}" onclick="">
								<div class="mission-info">
									<span>${mission.title}</span>
									<span><fmt:formatNumber value="${mission.point}" pattern="#,###" />원</span>				
								</div>
							</div>
						</div>
					</div>
				</c:if>	
				
				<%-- 미션 보류인 경우 --%>
				<c:if test="${mission.missionStatus.status eq 'A'}">
					<div class="mission-container">
						<div class="mission-left" style="transform: translateY(-4px);">
							<span class="status-again">미션을 다시 확인해주세요!</span>
						</div>
						<div class="mission-bar">
							<i class="fa-solid fa-circle fa-circle-border"></i>
							<i class="fa-solid fa-circle fa-circle-inside" style="color: #9a9b9b"></i>						
						</div>
						<div class="mission-date-card">
							<span class="mendDateSpan">~ ${mission.mendDate}</span>
							<div class="mission-card" data-vs-no="${vs.count}" onclick="openMissionDodal(this);">
								<img src="${fn:replace(mission.imgSrc, 'covermini', 'cover')}" onclick="">
								<div class="mission-info">
									<span>${mission.title}</span>
									<span><fmt:formatNumber value="${mission.point}" pattern="#,###" />원</span>				
								</div>
							</div>
						</div>
					</div>
				</c:if>	
				
				<%-- 미션 기한 마감으로 실패인 경우 --%>
				<c:if test="${mission.missionStatus.status eq 'F'}">
					<div class="mission-container">
						<div class="mission-left statusDiv">
							<span class="status-span" style="background: red;">실패!</span>
						</div>
						<div class="mission-bar">
							<i class="fa-solid fa-circle fa-circle-border"></i>
							<i class="fa-solid fa-circle fa-circle-inside" style="color: red"></i>						
						</div>
						<div class="mission-date-card">
							<span class="mendDateSpan">~ ${mission.mendDate}</span>
							<div class="mission-card" data-vs-no="${vs.count}" onclick="openMissionDodal(this);">
								<img src="${fn:replace(mission.imgSrc, 'covermini', 'cover')}" onclick="openMissionDodal(this);">
								<div class="mission-info">
									<span>${mission.title}</span>
									<span><fmt:formatNumber value="${mission.point}" pattern="#,###" />원</span>				
								</div>
							</div>
						</div>
					</div>
				</c:if>	
			
			
			</c:if>	
		</c:forEach>
		
		<div class="mission-container">
			<div class="mission-left mission-left-start">
				<span>끝!</span>
			</div>
			<div id="bar-first" id="mission-bar-last">
				<i class="fa-solid fa-circle fa-circle-border-last"></i>
				<i class="fa-solid fa-circle fa-circle-inside-last" style="color: #f8f9fa;"></i>
			</div>
		</div>
		
	</div>
</section>

	<%-- 미션 모달 --%>
	<div class="modal fade" id="missionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 id="modalStatus"></h5>	 
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body" id="modalMissionWrapper">
	      	  <div class="modal-body-top">		 	         	
		        <h3 class="modal-title" id="modalTitle"></h3>
		        <h5 id="modalEndDate"></h5>
	      	  </div>
		 	  <p id="modalContent"></p>
		 	  <div class="mission-user">
		 	  	<div>
		 	  	  <img style="display: none;" src="" id="profile-img" />
				  <button style="display: none;" type="button" class="btn" data-mission-no='0' id="deleteBtn" onclick="deleteFile();">삭제</button>		 	  	
		 	  	</div>
			 	  <input type="file" name="upFile" id="upfile" class="mt-1 mb-2" onchange="loadImage(this);" />
			 	  <textarea name="answer" id="answer" rows="4" style="width: 100%;"></textarea>		 	  		 	  
				  <input type="hidden" name="memberId" value="${loginMember.username}" />			  
			  	  <input type="hidden" name="delFile" id="delFile" />
		 	  </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-enroll" id="submitBtn" onclick="missionComplete(this);">제출</button>
	      </div>
	    </div>
	  </div>
	</div>
	<%-- 미션 모달 끝 --%>

	


<script>
	// console.log(missionArr);
	
/*********** 미션 모달 열어 *************/
const openMissionDodal = (e) => {
	const vsNo = e.dataset.vsNo - 1;
	const mission = missionArr[vsNo];
	console.log(mission);
	
	const title = document.querySelector('#modalTitle');
	const endDate = document.querySelector('#modalEndDate');
	const status = document.querySelector('#modalStatus');
	const content = document.querySelector('#modalContent');
	const answer = document.querySelector('#answer');
	const submitBtn = document.querySelector("#submitBtn");
	const deleteBtn = document.querySelector("#deleteBtn");
	const upFile = document.querySelector("#upFile");
	
	// 모달 안에 내용 비워
	title.innerHTML = '';
	endDate.innerHTML = '';
	status.innerHTML = '';
	content.innerHTML = '';
	answer.value ='';
	
	let statusStr =''
	
	switch(mission.status){
	case "P":
		statusStr = '🎉미션 성공🎉';
		submitBtn.style.display = 'none';
		// 이미지 src renamedFilename으로 설정해
		
		// textarea readonly로 바꿔
		
		// 파일선택 버튼 안보이게 해
		upFile.style.display = 'none';
		break;
	case "F":
		statusStr = '💔미션 실패💔'
		submitBtn.style.display = 'none';
		answer.style.display = 'none';
		upFile.style.display = 'none';
		break;
	case "I":
		statusStr = '⏳승인 대기중⏳';
		submitBtn.style.display = 'none';
		// 이미지 src renamedFilename으로 설정해
		
		// textarea readonly로 바꿔
		$("#answer").attr("readonly", true);
		break;
	case "A":
		statusStr = '💦다시 제출해주세요💦';
		// textarea readonly 해제해
		$("#answer").attr("readonly", false);
		submitBtn.style.display = '';
		upFile.style.display = '';
		answer.style.display = '';
		deleteBtn.dataset.missionNo = mission.missionNo;
		break;
	default:
		statusStr = '😊미션을 수행해주세요😊'; 
		// textarea readonly 해제해
		$("#answer").attr("readonly", false);
		submitBtn.style.display = '';
		upFile.style.display = '';
		answer.style.display = '';
		deleteBtn.dataset.missionNo = mission.missionNo;
		break;
	}
	
	// 모달 안에 내용 채워
	title.innerHTML = mission.title;
	endDate.innerHTML = '~' + mission.mendDate + ' 까지';
	status.innerHTML = statusStr;
	content.innerHTML = mission.content;
	answer.value = mission.answer;
	
	// 미션 모달 보여줘
	$('#missionModal').modal('show');		
	
}
	
/************** 미션 status 등록해 ***************/
 
const missionComplete = () => {
	
	const answer = document.querySelector('#answer').value;	
	
	
	if(answer == ''){
		alert('내용을 작성해주세요');
		return;
	}
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송
	
	let formData = new FormData();
	formData.append("memberId", "${loginMember.username}");
	formData.append("answer", answer);
	
	
	// 등록할 파일 있니? 
	const isUpFile = document.querySelector("#upFile").value;
	if(isUpFile != ''){
		const upFile = $("input[name='upFile']")[0].files[0];
		formData.append("upFile", upFile);
	} 		
	
	// 삭제할 파일 있니?
	const isDelFile = document.querySelector("#delFile").value;
	if(isDelFile != ''){
		const delFile = $("input[name='delFile']")[0].files[0];
		formData.append("delFile", delFile);
	} 
	
	$.ajax({
		url: "${pageContext.request.contextPath}/club/clubMissionComplete.do",
		method: "POST",
		headers,
		processData:false,
		contentType: false,
		data : formData,
		success(resp){
			console.log(resp);
		},
		error: console.log
	});

	
}

const loadImage = (input) => {
    // console.log(input.files);
    if(input.files[0]){
       const fr = new FileReader();
       fr.readAsDataURL(input.files[0]);
       fr.onload = (e) => {
    	  document.querySelector("#profile-img").style.display = '';
    	  document.querySelector("#deleteBtn").style.display = '';
          // console.log(e.target.result);
          document.querySelector("#profile-img").src = e.target.result
       }
    }
 }   
 
const deleteFile = (e) => {
	console.log(e.dataset.missionNo);
	
	// console.log(document.querySelector("#profile-img").src);
	
	// 먼저 이미지랑 삭제 버튼 담긴 div 지워버려	
	document.querySelector("#profile-img").style.display = 'none';
	document.querySelector("#profile-img").src = '';
	document.querySelector("#deleteBtn").style.display = 'none';

	// input[name=upFile]안에 value도 지워
	document.querySelector("#upFile").value = '';
	
	
	// 그리고 아래에 delFile 추가해 
	document.querySelector("#delFile").value = '';
	
	
	// 그리고 파일 하나 삭제됐으니까 새로 파일 추가할 수 있는 input 태그 넣어
/* 	const div = document.querySelector("#input-file-div");
	const inputTag = `<input type="file" name="upFile" id="file\${i+1}" multiple />`;
	div.insertAdjacentHTML('beforeend', inputTag); */
	
	
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>