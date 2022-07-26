<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageSetting.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubList.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="내설정" name="title"/>
</jsp:include>
<section id="content">
	<div id="menu">
		<h1>마이프로필Setting</h1>	
		<%-- <sec:authorize access="hasRole('ROLE_ADMIN')"> --%>
			    <button 
			    	id="btn-enroll"
			    	class="btn btn-sm" 
			    	onclick="location.href='${pageContext.request.contextPath}/club/enrollClub.do';">북클럽 등록</button>	    	
		<%-- </sec:authorize> --%>
	</div>
    <div class="quiz-wrapper" >
	    <form id="quiz-form">
	     <h3 style="text-align: center;">Edit Profile</h3>	    
	    	<div class="gravatar">
		      <img id="img-satya" src="${pageContext.request.contextPath}/resources/images/book-club-8.png" alt="내사진">
	    	</div>
	      <p class="form-label">Username:</p>
	        <input class="form-field" type="text" value="Satya007" required readonly>
	      <p class="form-label">Full Name:</p>
	          <input class="form-field" type="text" value="Satyendra Singh" readonly required>
	      <p class="form-label">Date of Birth:</p>
	        <input class="form-field" type="date" min="2001/01/01" required>
	      <p class="form-label">Favorite Color:</p>
	          <input type="color" value="#0000FF">
	      <p class="form-label">Gender</p>
	      <label>
	          <input  type="radio" name="gender" value="male" required>Male
	      </label>
	      <label>
	          <input type="radio" name="gender" value="female" required>Female
	        </label>
	        <label>
	          <input type="radio" name="gender" value="other" required>Other
	        </label>
	        <p class="form-label">WebSite:</p>
	          <input class="form-field" type="url">
	        <p class="form-label">Phone Number:</p>
	           <input class="form-field" type="number" required>
	        <p class="form-label">Bio:</p>
	           <textarea class="form-field" required></textarea>
	        <div id="submit-btn">
	          <input type="submit" value="UPDATE">
	        </div>
	      </form>
	  </div>
</section>

<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>