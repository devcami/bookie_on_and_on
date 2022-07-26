<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/miniProfile.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="미니프로필" name="title"/>
</jsp:include>
<section id="content">
	<div id="menu">
		<h1 style="text-align: center;">미니프로필</h1>	
	</div>
	<div class="wrapper">
	  <div class="student-details expanded">
	    <div class="gravatar">
	      <a href="">
		      <img src="${pageContext.request.contextPath}/resources/images/book-club-8.png" alt="내사진" width="200" height="200"/>
	      </a>
	    </div>
	  </div>
	  
	  <div class="forms">
	    <div class="tabs edit-profile">
	      <h3>Edit Profile</h3>
	    </div>
	    <div class="tab-content edit-profile-form-wrap">
	      <form class="edit-profile-form">
	        <div class="form-control first-name">
	          <label for="first-name">Nickname</label>
	          <input type="text" class="textbox" id="first-name" value="꼬두마리">
	        </div>
	        <div class="form-control email">
	          <label for="email">소개</label>
	          <input type="text" class="textbox" id="email" value="한줄소개하이하이">
	        </div>
	        <div class="form-buttons">
	          <button type="submit" class="primary-btn" value="Update Profile">완료</button>
	          <!-- <button type="button" class="secondary-btn cancel" value="Cancel">Cancel</button> -->
	        </div>
	      </form>
	    </div>
	    <div class="tabs change-password">
	      <h3>Change Password</h3>
	    </div>
	    <div class="tab-content change-password-form-wrap">
	      <!--  --><form class="edit-profile-form">
	        <div class="form-control first-name">
	          <label for="current-password">Current Password&#58;</label>
	          <input type="text" class="textbox" id="current-password">
	        </div>
	        <div class="form-control first-name">
	          <label for="new-password">New Password&#58;</label>
	          <input type="text" class="textbox" id="new-password">
	        </div>
	        <div class="form-control email">
	          <label for="confirm-password">Confirm New Password&#58;</label>
	          <input type="text" class="textbox" id="confirm-password">
	        </div>
	        <div class="form-buttons">
	          <button type="submit" class="primary-btn" value="Change Password">Change Password</button>
	          <!-- <button type="button" class="secondary-btn cancel" value="Cancel">Cancel</button> -->
	        </div>
	      </form>
	    </div>
	  </div>
	  
	</div>
</section>

<script>
var profileStates = {
		  editProfile: false,
		  changePassword: false,
		  showDetails:true
		}

		$('.tabs').on('click', function(e) {
		  e.stopPropagation();
		  tabHandler(e.currentTarget);
		})

		$('.cancel').on('click', function(e) {
		  e.stopPropagation();
		  e.preventDefault();
		  pageReset();
		});

		function tabHandler(tab){
		  var editProfileTab = $(tab).hasClass('edit-profile');
		  var changePassTab = $(tab).hasClass('change-password');
		  
		  switch (true) {

		    // if Tab is Edit Profile and Edit Profile is not showing
		    case (editProfileTab && !isEditProfileShowing()):
		      // Check to see if Profile Details are showing. Hide if they are.
		      if (isDetailsShowing()) {
		        profileStates.showDetails = false;
		        $('.student-details').removeClass('expanded');
		      }

		      // Remove .expanded from all content wrappers
		      $('.tab-content').removeClass('expanded');

		      // Add .expanded to edit profile content wrapper
		      $('.edit-profile-form-wrap').addClass('expanded');
		      
		      profileStates.editProfile = true;
		      profileStates.changePassword = false;
		      break;

		    // if Tab is Change Password and Detail is Showing
		    case (changePassTab && !isChangePasswordShowing()):
		      // Check to see if Profile Details are showing. Hide if they are.
		      if (isDetailsShowing()) {
		        profileStates.showDetails = false;
		        $('.student-details').removeClass('expanded');
		      }

		      // Remove .expanded from all content wrappers
		      $('.tab-content').removeClass('expanded');

		      // Add .expanded to edit profile content wrapper
		      $('.change-password-form-wrap').addClass('expanded');
		      profileStates.editProfile = false;
		      profileStates.changePassword = true;
		      break;

		    // if Tab is Edit Profile and Edit Profile is Showing
		    case (editProfileTab && isEditProfileShowing()):
		      pageReset();
		      break;
		    // if Tab is Change Password and Change Password is Shwoing
		    case (changePassTab && isChangePasswordShowing()):
		      pageReset();
		      break;
		  }
		}

		// Reset page to default state
		function pageReset() {
		  $('.tab-content').removeClass('expanded');
		  $('.student-details').addClass('expanded');
		  profileStates.showDetails = true;
		  profileStates.editProfile = false;
		  profileStates.changePassword = false;
		}

		// Check to see if Student Details are being shown
		function isDetailsShowing() {
		  return profileStates.showDetails;
		}

		// Check to see if Change Password form is showing
		function isChangePasswordShowing() {
		  return profileStates.changePassword;
		}

		// Check to see if Edit Profil form is showing
		function isEditProfileShowing() {
		  return profileStates.editProfile;
		}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>