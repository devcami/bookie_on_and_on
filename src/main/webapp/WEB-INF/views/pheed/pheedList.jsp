<%@page import="com.kh.bookie.pheed.model.dto.Pheed"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pheed.css" />
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="피드" name="title"/>
</jsp:include>
<div id="pheed-container">
	<div id="pheed-header">
		<div class="btns">
			<button type="button" class="btn btn-lg btn-link btn-pheed" onclick="location.href='${pageContext.request.contextPath}/pheed/pheedFList.do'">팔로워</button>
			<button type="button" class="btn btn-lg btn-link btn-pheed" onclick="location.href='${pageContext.request.contextPath}/pheed/pheedCList.do'" id="btn-pheed-c">발견</button>
			<button type="button" class="btn btn-lg btn-link" id="btn-pheed-enroll"><i class="fa-solid fa-plus"></i></button>
		</div>
	</div>
</div>
	<section id="content">
		<c:forEach items="${list}" var="pheed" varStatus="vs">
		<fmt:parseDate value="${pheed.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate"/>
			<div class="pheed-container">
				<div class="pheed-writer">
					<div class="profile">
						<c:if test="${pheed.member.originalFilename != null}">
							<img src="" alt="프로필사진" />
						</c:if>
						<c:if test="${pheed.member.originalFilename == null}">
							<i class="fa-solid fa-user-large user-icon"></i>
						</c:if>
					</div>
					<h2>${pheed.member.nickname}</h2>
				</div>
				<c:if test="${pheed.attach != null}">
					<div class="pheed-img">
						<img src="${pageContext.request.contextPath}/resources/upload/pheed/${pheed.attach.renamedFilename}" alt="" />
					</div>
				</c:if>
				<div class="pheed">
					<div class="pheed-content">
						<div class="book-info">
							<span class="pheed-book-title" id="book-title${vs.count}"></span>
							<span class="pheed-book-page">[${pheed.page}p]</span>
							<p><fmt:formatDate value="${enrollDate}" pattern="yyyy.MM.dd HH:mm"/></p>
						</div>
						<p>${pheed.content}</p>
					</div>
					<div class="pheed-sns">
						<div class="pheed-sns-icons">
							<div class="btn-group" role="group" aria-label="Basic example">
							  <button type="button" class="btn"><i class="fa-regular fa-heart"></i></button>
							  <button type="button" class="btn"><i class="fa-regular fa-comment-dots"></i></button>
							  <button type="button" class="btn"><i class="fa-regular fa-bookmark"></i></button>
							  <button type="button" data-toggle="modal" data-target="#reportModal" 
							  			class="btn" id="btn-report"><i class="fa-solid fa-ellipsis"></i></button>
							</div>
						</div>
						<div class="pheed-sns-cal" id="sns-cal">
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</section>
<script>
window.addEventListener('load', () => {
	const searchApi = 'https://cors-anywhere.herokuapp.com/';
	let bookTitle;
	<c:forEach items="${list}" var="pheed" varStatus="vs">
	$.ajax({
		url : searchApi + "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx",
		data : {
			ttbkey : 'ttbiaj96820130001',
			itemIdType : 'ISBN13', 
			ItemId : ${pheed.itemId},
			output : 'js',
			Version : '20131101'
		},
		success(resp){
			const {item} = resp;
			const {title, isbn13} = item[0];
			document.querySelector("#book-title${vs.count}").innerText = `\${title}`;
		},
		error : console.log
	});
	</c:forEach>
});

<%-- 상단 피드 헤더 바 --%>
let header = document.querySelector("#header-container")
let headerHeight = header.clientHeight;

const pheedHeader = document.querySelector("#pheed-header");
window.onscroll = function () {
	let windowTop = window.scrollY;
	if (windowTop >= headerHeight) {
		pheedHeader.classList.add("drop");
	} 
	else{
		pheedHeader.classList.remove("drop");
	}
};
</script>

<%-- 신고창 모달 --%>
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="reportModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="reportModalLabel">신고</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form name="pheedReportFrm" method="post" action="${pageContext.request.contextPath}/pheed/pheedReport.do">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">작성자</label>
            <input type="text" class="form-control" id="memberId" value="로긴멤버아이디" readonly>
          </div>
          <div class="form-group">
            <p class="col-form-label">신고 내용</p>
          	<div class="alert alert-danger alert-dismissible fade show" role="alert" id="alert" style="display:none">
			  내용을 10자 이상 작성해주세요 !
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
            <textarea class="form-control" id="content" placeholder="신고 내용을 작성해주세요."></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-danger" onclick="report();">신고하기</button>
      </div>
    </div>
  </div>
</div>
<%-- 신고창 폼 제출 --%>
<script>
const report = () => {
	const content = document.querySelector("#content");
	if(!/^(.|\n){10,}$/.test(content.value)){
		$('.alert').alert();
		return;
	}
	
	if(alert('신고를 제출하시겠습니까?')){
		document.pheedReportFrm.submit();	
	}else{
		return;
	}
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>