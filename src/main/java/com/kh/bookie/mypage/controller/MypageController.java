package com.kh.bookie.mypage.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.bookie.common.HelloSpringUtils;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.member.model.dto.MemberEntity;
import com.kh.bookie.member.model.service.MemberService;
import com.kh.bookie.mypage.model.dto.BookIng;
import com.kh.bookie.mypage.model.dto.Qna;
import com.kh.bookie.mypage.model.service.MypageService;
import com.kh.bookie.search.model.service.SearchService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage")
@Slf4j
public class MypageController {
	
	@Autowired
	MypageService mypageService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	SearchService searchService;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	/* 알라딘API주소 */
	final String ALADDIN_URL = "http://www.aladin.co.kr/ttb/api/";
	
	/* 팔로우페이지 */
	@GetMapping("/follower.do")
	public String follower(Model model, @RequestParam String memberId) {
		Member member = memberService.selectOneMember(memberId);
		model.addAttribute("member", member);
		return "mypage/mypage";
	}
	
	/* 마이페이지 */
	@GetMapping("/mypage.do")
	public void mypage(Model model, @AuthenticationPrincipal Member loginMember) {
		String memberId = loginMember.getMemberId();
		Map<String, Object> map = new HashMap<>();
		try {
			Member member = memberService.selectOneMember(memberId);
			model.addAttribute("member", member);
		} catch (Exception e) {
			log.error("내서재 조회오류", e);
			throw e;
		}
		
	}
	
	@GetMapping("/mypageSetting.do")
	public void mypageSetting() {}
	
	/**
	 * QNA
	 */
	@GetMapping("/qnaList.do")
	public void qnaList(@RequestParam String memberId, Model model){
		try {
			List<Qna> list = mypageService.selectMyQnaList(memberId);
			log.debug("list", list);
			model.addAttribute("list", list);
		} catch (Exception e) {
			log.error("QNA리스트 불러오기 오류",e);
			throw e;
		}
	}
	
	@GetMapping("/qnaEnroll.do")
	public void qnaEnroll() {}
	
	@PostMapping("/enrollQna.do")
	public String qnaEnroll(Qna qna) {
		try {
			log.debug("qna = {}", qna);
			int result = mypageService.qnaEnroll(qna);
		} catch (Exception e) {
			log.error("QNA 글 등록 오류", e);
			e.printStackTrace();
			throw e;
		}
		return "redirect:/mypage/qnaList.do?memberId=" + qna.getMemberId();
	}
	
	@GetMapping("/qnaDetail.do")
	public void qnaDetail(@RequestParam int qnaNo, Model model){
		try {
			Qna qna = mypageService.selectOneQna(qnaNo);
			log.debug("qna = {}", qna);
			model.addAttribute("qna", qna);
		} catch (Exception e) {
			log.error("QNA 상세보기 오류",e);
			throw e;
		}
	}
	
	@GetMapping("/myMiniProfile.do")
	public void myMiniProfile() {}
	
	/* 회원탈퇴 */
	@GetMapping("/deleteMember.do")
	public ResponseEntity<?> deleteMember(@AuthenticationPrincipal Member loginMember) {
		String memberId = loginMember.getMemberId();
		Map<String, Object> map = new HashMap<>();
		try {
			int result = memberService.deleteMember(memberId);
			
			if(result>0) {
				map.put("msg", "성공적으로 회원정보를 삭제했습니다.");
				SecurityContextHolder.clearContext(); // 이 부분을 꼭 따로 추가해 줘야 스프링 시큐리티 탈퇴 시 로그아웃 처리가 됨!!!
			}
			else 
				map.put("msg", "회원정보삭제에 실패했습니다.");
		} catch (Exception e) {
			log.error("회원탈퇴 오류", e);
			e.printStackTrace();
		}
		return ResponseEntity.ok(map);
	}


	@GetMapping("/myMainProfile.do")
	public void myMainProfile(Model model, @AuthenticationPrincipal Member loginMember) {
		log.debug("model = {}", model);
		log.debug("loginMember = {}", loginMember);
		String memberId = loginMember.getMemberId();
		try {
			// 
//			Member member = memberService.selectInterests(memberId);
			
			
		} catch (Exception e) {
			log.error("내프로필 조회 오류", e);
			e.printStackTrace();
		}
	}
	
	/* 패스워드 변경 */
	@GetMapping("/myPasswordUpdateFrm.do")
	public void myPasswordUpdateFrm() {}
	
	/* 기존패스워드 체크 */
	@PostMapping("/passwordCheck.do")
	public ResponseEntity<?> passwordCheck(@RequestParam String nowPassword, @AuthenticationPrincipal Member loginMember, Authentication auth){
		log.debug("nowPassword = {}", nowPassword);
		Map<String, Object> map = new HashMap<>();
		try {
			Member member = memberService.selectPassword(loginMember.getMemberId());
			String presentedPassword = member.getPassword(); // 현재 DB저장 비밀번호
			log.debug("presentedPassword = {}", presentedPassword);
			log.debug("{}", bcryptPasswordEncoder.matches(nowPassword, presentedPassword));
		    if (!bcryptPasswordEncoder.matches(nowPassword, presentedPassword)) {
		        map.put("msg", "두 비밀번호가 일치하지 않습니다.");
		        map.put("valid", "0");
		    }
		    else {
		    	map.put("msg", "비밀번호가 일치합니다.");
		    	map.put("valid", "1");
		    }
		} catch (Exception e) {
			log.error("비밀번호 조회 오류", e);
			e.printStackTrace();
		}	
		return ResponseEntity.ok(map);
	}
	
	/* 패스워드 변경 */
	@PostMapping("/myPasswordUpdate.do")
	public ResponseEntity<?> myPasswordUpdate(@RequestParam String newPasswordCheck, @AuthenticationPrincipal Member loginMember) {
		String newPassword = newPasswordCheck;
		log.debug("newPassword = {}", newPassword);
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		try {
			// 새로운 비밀번호 암호화 처리
			String newEncryptPassword = bcryptPasswordEncoder.encode(newPassword);
			param.put("newPassword", newEncryptPassword);
			param.put("memberId", loginMember.getMemberId());
			
			// db갱신 mvc
			int result = memberService.updatePassword(param);
			
			// 비밀번호/권한정보가 바뀌었을때는 전체 Authentication을 대체 (비번바뀔때는 무조건 이렇게!)
			Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
															loginMember, loginMember.getPassword(), loginMember.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(newAuthentication);
			map.put("msg", "비밀번호를 성공적으로 수정했습니다.");
		} catch (Exception e) {
			log.error("비밀번호 수정 오류!", e);
			map.put("msg", "회원정보 수정오류!");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
	
	/* 내 책정보 */
	@GetMapping("/myBook.do")
	public void myBook() {}

	/* 내 책 전체 itemId 가져오기 */
	@GetMapping("/myBookAllItemId")
	public ResponseEntity<?> myBookAllItemId(@AuthenticationPrincipal Member loginMember){
		String memberId = loginMember.getMemberId();
		List<String> itemIdList = new ArrayList<>();
		try {
			itemIdList = searchService.selectMyBookAllItemId(memberId);
			log.debug("itemIdList = {}", itemIdList);
		} catch (Exception e) {
			log.error("itemId 가져오기 오류", e);
			throw e;
		}
		return ResponseEntity.ok(itemIdList);
	}
	
	/* 내 서재 읽는중 책 itemId 가져오기 */
	@GetMapping("/getItemId")
	public ResponseEntity<?> getItemId(@AuthenticationPrincipal Member loginMember){
		String memberId = loginMember.getMemberId();
		String status = "읽는 중";
		Map<String, Object> param = new HashMap<>();
		param.put("status", status);
		param.put("memberId", memberId);
		List<String> itemIdList = new ArrayList<>();
		try {
			itemIdList = searchService.selectBooKItemId(param);
			log.debug("itemIdList = {}", itemIdList);
			
		} catch (Exception e) {
			log.error("itemId 가져오기 오류", e);
			throw e;
		}
		return ResponseEntity.ok(itemIdList);
	}
	
	/* 내 서재 마이픽 책 itemId 가져오기 */
	@GetMapping("/getmyPickItemId")
	public ResponseEntity<?> getmyPickItemId(@AuthenticationPrincipal Member loginMember){
		String memberId = loginMember.getMemberId();
		String myPick = "1"; // 마이픽이 1로 된 책들 itemId가져오기
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("myPick", myPick);
		List<String> myPickItemIdList = new ArrayList<>();
		try {
			myPickItemIdList = searchService.selectMyPickItemId(param);
			log.debug("myPickItemIdList = {}", myPickItemIdList);
		} catch (Exception e) {
			log.error("myPickItemId 가져오기 오류", e);
			throw e;
		}
		return ResponseEntity.ok(myPickItemIdList);
	}
	
//	/* 내 서재의 책 status별 정보 */
//	@GetMapping("/getItemId.do")
//	public List<Map<String, Object>> getItemId(@AuthenticationPrincipal Member loginMember, @RequestParam String status) {
//			String memberId = loginMember.getMemberId();
//			Map<String, Object> param = new HashMap<>();
//			param.put("memberId", memberId);
//			param.put("status", status);
//			List<Book> bookList = new ArrayList<>();
//			bookList = searchService.selectBooKItemIdByStatus(param);
//			int i = 0;
//			String itemId[] = {};				
//			if(bookList != null && bookList.size() > 0) {
//				for(Book book : bookList) {
//					itemId[i++] = book.getItemId();
//				}
//			}
//			log.debug("itemId = {}", itemId);
//	        String serviceKey = "ttbiaj96820130001";
//	        try {
//	        	for(String id : itemId) {
//	        		String urlStr = "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx";
//	        		urlStr += "?" + URLEncoder.encode("ttbkey", "UTF-8") + "=" + serviceKey;
//	        		urlStr += "&" + URLEncoder.encode("itemIdType", "UTF-8") + "=ISBN";
//	        		urlStr += "&" + URLEncoder.encode("ItemId", "UTF-8") + "="+id;
//	        		urlStr += "&" + URLEncoder.encode("output", "UTF-8") + "=xml";
//	        		urlStr += "&" + URLEncoder.encode("Version", "UTF-8") + "=20131101";
//	        		
//	        		System.out.println(urlStr);
//	        		
//	        		// xml 파싱
//	        		Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(urlStr);
//	        		XPath xpath = XPathFactory.newInstance().newXPath();
//	        		
//	        		NodeList nList = document.getElementsByTagName("item");
//	        		Node nNode = nList.item(0);
//	        		if (nNode.getNodeType() == Node.ELEMENT_NODE) {
//	        			Element eElement = (Element) nNode;
//	        			getTagValue("cover", eElement); // title
//	        			getTagValue("itemId", eElement); // itemId
//	        		}
//	        	};	
//			} catch (Exception e) {
//				log.error("내 책 조회 오류", e);
//			}
//	        return null;
//	    }
//	    
//	      // tag값의 정보를 가져오는 함수
//	   public static String getTagValue(String tag, Element eElement) {
//	          String result = "";
//	       NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
//	       result = nlList.item(0).getTextContent();
//	        System.out.println(result);
//	       return result;
//	   }

	/* 내 서재의 책 status별 정보 */
	@GetMapping("/getItemIdByStatus.do")
	public ResponseEntity<?> getItemId(@AuthenticationPrincipal Member loginMember, @RequestParam String status) {
		String memberId = loginMember.getMemberId();
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("status", status);
		List<String> ItemIdByStatus = new ArrayList<>();
		try {
			ItemIdByStatus = searchService.selectBooKItemIdByStatus(param);
			log.debug("ItemIdByStatus = {}" , ItemIdByStatus);
		} catch (Exception e) {
			log.error("내 책 조회 오류", e);
			throw e;
		}
		return ResponseEntity.ok(ItemIdByStatus);
	}
	
	/* 달력에 뿌려줄 book_ing 가져오기 */
	@GetMapping("/myBookIngList.do")
	public ResponseEntity<?> myBookIngList(@AuthenticationPrincipal Member loginMember){
		String memberId = loginMember.getMemberId();
		List<BookIng> bookIngList = new ArrayList<>();
		try {
			bookIngList = mypageService.SelectMyBookIngList(memberId);
			log.debug("내 부킹부킹붕킹 bookIngList = {}" , bookIngList);
		} catch (Exception e) {
			log.error("bookIng 조회 오류", e);
			throw e;
		}
		return ResponseEntity.ok(bookIngList);
	}
	
	@GetMapping("/myScrap.do")
	public void myScrap() {}

	@GetMapping("/myDokooList.do")
	public void myBookClub() {}
	
	@GetMapping("/myPheedList.do")
	public void myPheed() {}
	
	@GetMapping("/myClubList.do")
	public void myClubList() {}
	
	/* 마이프로필 삭제 */
	@GetMapping("/myProfileDelete.do")
	public String myProfileDelete(@AuthenticationPrincipal Member loginMember, RedirectAttributes redirectAttr) {
		String nickname = loginMember.getNickname(); 
		log.debug("nickname = {}", nickname);
		// 파일저장위치
        String saveDirectory = application.getRealPath("/resources/upload/profile");
		log.debug(loginMember.getRenamedFilename());
		try {
			if(loginMember.getRenamedFilename() != null) {
				Member profileMember =  memberService.selectOneMemberByNickname(nickname);
				log.debug("profileMember = {}", profileMember);
				
				// a. 첨부파일삭제
				String renamedFilename = profileMember.getRenamedFilename();
				File deleteFile = new File(saveDirectory, renamedFilename);
				if(deleteFile.exists()) {
					deleteFile.delete();
					log.debug("{}의 {}파일 삭제", nickname, renamedFilename);
				}
				
				// b. 레코드삭제
				int result = memberService.deleteMemberProfile(nickname);
				log.debug("{}의 MemberProfile 레코드 삭제", nickname);	
			}
			
			redirectAttr.addFlashAttribute("msg", "Mini프로필을 성공적으로 수정했습니다.");
			
		} catch (Exception e) {
			log.error("프로필 삭제 오류", e);
			throw e;
		}
		return "redirect:/mypage/myMiniProfile.do";
	}
	
	/* nicknameCheck */
	@GetMapping("/nicknameCheck.do")
	public ResponseEntity<?> nicknameCheck(@RequestParam String nickname){
		log.debug("nickname = {}", nickname);
		Map<String, Object> map = new HashMap<>();
		try {
			MemberEntity member = memberService.selectOneMemberByNickname(nickname);
			log.debug("member = {}", member);
			boolean available = member == null; // 조회결과가 없으면 true | 있으면 false
			log.debug("available = {}", available);
			
			map.put("available", available);
			map.put("member", member);
			
		} catch (Exception e) {
			log.error("닉네임 중복체크 오류", e);
			map.put("error", e.getMessage());
			map.put("msg", "이용에 불편을 드려 죄송합니다.");
			return ResponseEntity
					.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
					.body(map);
		}
		return ResponseEntity
					.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
					.body(map);
	}
	
	/* 상세프로필 수정 */
	@PostMapping("/myMainProfileUpdate.do")
	public ResponseEntity<?> myMainProfileUpdate(@RequestParam String nickname) {
		return null;
	};
	
	/* 미니프로필 수정 */
	@PostMapping("/myMiniProfileUpdate.do")
	public String myMiniProfileUpdate(@RequestParam String newNickname,
					@RequestParam String sns,
					@RequestParam String introduce,
					RedirectAttributes redirectAttr,
					@RequestParam("upFile") MultipartFile upFile,
					@RequestParam String delFile,
					@AuthenticationPrincipal Member loginMember) throws Exception {
		String nickname = loginMember.getNickname();
		log.debug("upFile = {}", upFile);
		log.debug("delFile = {}", delFile);
		log.debug("sns = {}", sns);
		log.debug("introduce = {}", introduce);
		log.debug("newNickname = {}", newNickname);
		
		// 파일저장위치
        String saveDirectory = application.getRealPath("/resources/upload/profile");
		try {
			// 1. 첨부파일 삭제 (파일 삭제)
			if(delFile == "0" && (loginMember.getRenamedFilename() != null)) {
				Member profileMember =  memberService.selectOneMemberByNickname(nickname);
				log.debug("profileMember = {}", profileMember);
				
				// a. 첨부파일삭제
				String renamedFilename = profileMember.getRenamedFilename();
				File deleteFile = new File(saveDirectory, renamedFilename);
				if(deleteFile.exists()) {
					deleteFile.delete();
					log.debug("{}의 {}파일 삭제", nickname, renamedFilename);
				}
				
				// b. 레코드삭제
				int delResult = memberService.deleteMemberProfile(nickname);
				log.debug("{}의 MemberProfile 레코드 삭제", nickname);
			}
			
			int updateResult;
			Member updateMember = loginMember;
			// 2. 첨부파일 등록 (파일 저장)
			if(upFile.getSize() > 0) {
				log.debug("요기?");
				MultipartFile updateFile = upFile;
				updateMember.setOriginalFilename(updateFile.getOriginalFilename());
				updateMember.setRenamedFilename(HelloSpringUtils.getRenamedFilename(updateFile.getOriginalFilename()));
				updateMember.setNickname(newNickname);
				updateMember.setIntroduce(introduce);
				updateMember.setSns(sns);
				
				File destFile = new File(saveDirectory, updateMember.getRenamedFilename());
				upFile.transferTo(destFile);
				updateResult = memberService.miniUpdateMember(updateMember);	
			}
			else {
				// 3. 맴버 간단수정
				updateMember.setOriginalFilename(loginMember.getOriginalFilename());
				updateMember.setRenamedFilename(loginMember.getRenamedFilename());
				updateMember.setNickname(newNickname);
				updateMember.setIntroduce(introduce);
				updateMember.setSns(sns);
				updateResult = memberService.miniUpdateMember(updateMember);	
				log.debug("updateResult = {}", updateResult);
			}
			redirectAttr.addFlashAttribute("msg", "Mini프로필을 성공적으로 수정했습니다.");
		} 
		catch(Exception e) {
			log.error("미니프로필 수정 오류", e);
			e.printStackTrace();
		}
		return "redirect:/mypage/myMiniProfile.do"; 
	}

	/* status 책 뿌려주기 */
	@GetMapping("/statusBook")
	public ResponseEntity<?> statusBook(@AuthenticationPrincipal Member loginMember, @RequestParam String itemId){
		log.debug("status itemId = {}", itemId);
		return getBookInfo(itemId);
	}
	
	/* 읽고있는 책 뿌려주기 */
	@GetMapping("/myReadingBook")
	public ResponseEntity<?> myReadingBook(@AuthenticationPrincipal Member loginMember, @RequestParam String itemId){
		log.debug("읽는 중 itemId = {}", itemId);
		return getBookInfo(itemId);
	}
	
	/* 마이픽 책 뿌려주기 */
	@GetMapping("/myPickBook")
	public ResponseEntity<?> myPickBook(@AuthenticationPrincipal Member loginMember, @RequestParam String itemId){
		log.debug("마이픽 itemId = {}", itemId);
		return getBookInfo(itemId);
	}
	
	/* 달력에 읽은 책 뿌려주기 */
	@GetMapping("/myEndedAtBook")
	public ResponseEntity<?> myEndedAtBook(@AuthenticationPrincipal Member loginMember, @RequestParam String itemId){
		log.debug("달력 itemId = {}", itemId);
		return getBookInfo(itemId);
	}
	
	/* 알라딘 itemId불러오기 */
	public ResponseEntity<?> getBookInfo(String itemId){
		String ttbkey = "ttbiaj96820130001";
		String itemIdType = "ISBN13"; 
		String output = "js";
		String Cover = "Big";
		String Version = "20131101";
		String url = ALADDIN_URL + "ItemLookUp.aspx?ttbkey=" + ttbkey
				+ "&itemIdType=" + itemIdType
				+ "&ItemId=" + itemId
				+ "&output=" + output
				+ "&Cover=" + Cover
				+ "&Version=" + Version;
		Resource resource = resourceLoader.getResource(url);
		return ResponseEntity.ok(resource);
	}
	
}
