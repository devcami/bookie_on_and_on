<%@page import="org.springframework.security.core.authority.SimpleGrantedAuthority"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.bookie.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자페이지" name="title"/>
</jsp:include>
<section id="content">

<div class="container">
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
    </div>

    <div class="container mt-4">
    	<table class="table table-borderless " id="detail-tbl">
    		<tr>
    			<th scope="row">프로필사진</th>
    			<td>
    				<c:if test="${member.renamedFilename}">
	    				<img src="${pageContext.request.contextPath}/resources/upload/profile/${member.renamedFilename}" alt="프사" style="width:200;"/>
    				</c:if>
    				<c:if test="${!member.renamedFilename}">
    				</c:if>
    			</td>
    		</tr>
    		<tr>
				<th scope="row">아이디</th>    		
				<td>${member.memberId}</td>
    		</tr>
    		<tr>
				<th scope="row">닉네임</th>    		
				<td>${member.nickname}</td>
    		</tr>
    		<tr>
				<th scope="row">이메일</th>    		
				<td>${member.email}</td>
    		</tr>
    		<tr>
				<th scope="row">생일</th>    		
				<td>${member.birthday}</td>
    		</tr>
    		<tr>
				<th scope="row">성별</th>    		
				<td>${member.gender eq 'F' ? '여' : '남'}</td>
    		</tr>
    		<tr>
				<th scope="row">핸드폰</th>    		
				<td>${member.phone}</td>
    		</tr>
    		<tr>
				<th scope="row">포인트</th>    		
				<td>${member.point}</td>
    		</tr>
    		<tr>
				<th scope="row">SNS 주소</th>    		
				<td>${member.sns}</td>
    		</tr>
    		<tr>
				<th scope="row">소개글</th>    		
				<td>${member.introduce}</td>
    		</tr>
    	</table>
    </div>


</section>

<script>
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>