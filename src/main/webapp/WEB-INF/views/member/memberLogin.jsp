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
<jsp:include page="/WEB-INF/views/common/header.jsp">

	<jsp:param value="로그인" name="title"/>
 <div class="global-container">
      <div class="card login form">
        <div class="card-body">
          <h1 class="card-title text-center ">로그인</h1>
          <div class="card-text">
            <form action="/loginPost">
              <div class="form-group">
                <label for="exampeleInputEmail1">회원 아이디👨‍👩‍👦‍👦</label>
                <input type="loginID"
                class="form-control form-control-sm"
                id="id" name="id" placeholder="User ID...">
              </div>
              <div class="form-group">
                <label for="exampeleInputPassword">비밀번호0🔒</label>
                <input type="password"
                class="form-control form-control-sm"
                id="password" name="password" placeholder="User Password...">
              </div>
              <a href="#" style="float: left; font: size 9px text-secondary;">아이디찾기 | 비밀번호 찾기</a>
              <button type="loginsucess" class="btn btn-danger btn-block ">
                로그인
              </button>
              <button type="submit" class="btn btn-primary btn-block">
                회원가입
              </button>

             


            </form>
          </div>
        </div>
      </div>
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



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>