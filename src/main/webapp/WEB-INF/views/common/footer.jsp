<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	</section>
	
	<footer>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
		  	</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav mr-auto">
			    	<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/board/boardList.do">게시판</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/todo/todoList.do">Todo</a></li>
                    <!-- 데모메뉴 DropDown -->
                    <!--https://getbootstrap.com/docs/4.1/components/navbar/#supported-content-->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Demo
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/demo/devForm.do">Dev 등록</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/demo/devList.do">Dev 목록</a>
                        </div>
				    </li>
			    </ul>
			    <c:if test="${not empty loginMember}">
			    	<span><a href="${pageContext.request.contextPath}/member/memberDetail.do">${loginMember.name}</a>님, 안녕하세요.</span>
	                &nbsp;
			    	<button class="btn btn-outline-success my-2 my-sm-0" type="button" onclick="location.href='${pageContext.request.contextPath}/member/memberLogout.do';" >로그아웃</button>
			    </c:if>
			    <c:if test="${empty loginMember}">
				    <button class="btn btn-outline-success my-2 my-sm-0" type="button" onclick="location.href='${pageContext.request.contextPath}/member/memberLogin.do';" >로그인</button>
	                &nbsp;
	                <button class="btn btn-outline-success my-2 my-sm-0" type="button" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do';">회원가입</button>
			    </c:if>
			 </div>
		</nav>
	</footer>
	
</div>
</body>
</html>
