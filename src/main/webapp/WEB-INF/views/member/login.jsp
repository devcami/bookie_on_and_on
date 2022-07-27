<%@page import="com.kh.bookie.pheed.model.dto.PheedComment"%>
<%@page import="com.kh.bookie.pheed.model.dto.Pheed"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css" />
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp" >
<jsp:param value="로그인" name="title"/>
</jsp:include>
     <div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
    aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
    
    <form:form method="post">
        <div class="modal-body">
            <c:if test="${param.error != null}">
              <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <span class="text-danger">아이디 또는 비밀번호가 일치하지 않습니다.</span>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
            </c:if>
            <div class="form-group">
                <label for="exampeleInputEmail1">회원 아이디👨‍👩‍👦‍👦</label>
                <input type="loginId"
                class="form-control form-control-sm"
                name="memberId"
                placeholder="아이디" required> 
              </div>
            <!-- <div class="form-group">
              <label for="exampleInputPassword1">Password</label>
              <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
            </div> -->
            <div class="form-group">
                <label for="exampeleInputPassword">비밀번호🔒</label>
                <input type="password"
                class="form-control form-control-sm"
                name="password"
                placeholder="비밀번호" required>
              </div>
        </div>
   
        <button type="submit" class="btn btn-danger btn-block "> 로그인 </button>
        <button type="submit" class="btn btn-primary btn-block">회원가입</button>
      </form:form>
  
</div>
    <script>
	

	$("#loginModal")
		.modal()
		.on('hide.bs.modal', (e) => {
			<c:if test="${empty header.referer || fn:contains(header.referer, '/member/memberLogin.do')}">
				location.href = '${pageContext.request.contextPath}';
			</c:if>
			<c:if test="${not fn:contains(header.referer, '/member/memberLogin.do')}">
				location.href = '${header.referer}';
			</c:if>
		});
	</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />