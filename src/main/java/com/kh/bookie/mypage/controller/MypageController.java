package com.kh.bookie.mypage.controller;

import java.io.File;
import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.service.ClubService;
import com.kh.bookie.common.HelloSpringUtils;
import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.dokoo.model.service.DokooService;
import com.kh.bookie.member.model.dto.Follower;
import com.kh.bookie.member.model.dto.Interest;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.member.model.dto.MemberEntity;
import com.kh.bookie.member.model.service.MemberService;
import com.kh.bookie.mypage.model.dto.BookIng;
import com.kh.bookie.mypage.model.dto.Qna;
import com.kh.bookie.mypage.model.service.MypageService;
import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.service.PheedService;
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
	ClubService clubService;
	
	@Autowired
	DokooService dokooService;
	
	@Autowired
	PheedService pheedService;
	
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
	public void mypage(Model model, @AuthenticationPrincipal Member loginMember, @RequestParam String memberId) {
		log.debug("마이페이지 memberId = {}", memberId);
		try {
			Member member = memberService.selectOneMember(memberId);
			log.debug("이 죽일놈의 사진 초기화 = {}" ,member.getRenamedFilename());
			model.addAttribute("member", member);
		} catch (Exception e) {
			log.error("파이페이지 조회오류", e);
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
	
	@GetMapping("/getFollow.do")
	public ResponseEntity<?> getFollow(@RequestParam String memberId, @AuthenticationPrincipal Member loginMember) {
		Map<String, Object> map = new HashMap<>();
		try {
			int followersCnt = mypageService.getFollowers(memberId);
			int followingCnt = mypageService.getFollowing(memberId);
			
			map.put("followingCnt", followingCnt);	
			map.put("followersCnt", followersCnt);	
			
			// 넘길 때 로그인 유저의 팔로워 같이 넘기기
			String loginMemberId = loginMember.getMemberId();
			List<Follower> followerList = searchService.selectFollowerList(loginMemberId);
			if(!followerList.isEmpty()) {
				String followers = "";
				for(Follower follower : followerList) {
					 followers += follower.getFollowingMemberId() + ",";
				}
				map.put("followers", followers);
			}
		} catch (Exception e) {
			log.error("팔로워 가져오기 오류", e);
			e.printStackTrace();
		}
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/followList.do")
	public void followList(@RequestParam String memberId, Model model, @RequestParam String follower, @AuthenticationPrincipal Member loginMember) {
		try {
			String loginMemberId = loginMember.getMemberId();
			List<Follower> list = null;
			List<Follower> myFollowerList = null;
			if(follower.equals("follower")) {
				list = mypageService.selectFollowerList(memberId);
				model.addAttribute("followerList", list);
			} else if(follower.equals("following")) {
				list = mypageService.selectFollowingList(memberId);
				model.addAttribute("followingList", list);
			}
			
			// 로그인 한 사람의 팔로워 목록 같이 보내기
			myFollowerList = searchService.selectFollowerList(loginMemberId);
			model.addAttribute("myFollowerList", myFollowerList);
			
		} catch (Exception e) {
			log.error("팔로우 리스트 조회 오류", e);
			e.printStackTrace();
		}
	}
	
	
	@GetMapping("/myMiniProfile.do")
	public void myMiniProfile(@RequestParam String memberId, Model model) {
		log.debug("미니프로필수정 memberId = {}", memberId);
		try {
			Member member = memberService.selectOneMember(memberId);
			model.addAttribute("member", member);
		} catch (Exception e) {
			log.error("미니프로필 조회오류", e);
			throw e;
		}
	}
	
	/* 회원탈퇴 */
	@GetMapping("/deleteMember.do")
	public ModelAndView deleteMember(@AuthenticationPrincipal Member loginMember) {
		String memberId = loginMember.getMemberId();
		Map<String, Object> map = new HashMap<>();
		ModelAndView mv = new ModelAndView();
		try {
			int result = memberService.deleteMember(memberId);
			
			if(result>0) {
				mv.addObject("msg", "성공적으로 회원정보를 삭제했습니다.");
				mv.setViewName("/mypage/mypage");
				SecurityContextHolder.clearContext(); // 이 부분을 꼭 따로 추가해 줘야 스프링 시큐리티 탈퇴 시 로그아웃 처리가 됨!!!
				return mv;
			}
			else {
				mv.addObject("msg", "회원정보삭제에 실패했습니다.");
				mv.setViewName("/mypage/mypageSetting");
				return mv;
			}
		} catch (Exception e) {
			log.error("회원탈퇴 오류", e);
			e.printStackTrace();
		}
		return mv;
	}


	@GetMapping("/myMainProfile.do")
	public void myMainProfile(Model model, @AuthenticationPrincipal Member loginMember) {
		String memberId = loginMember.getMemberId();
		log.debug("여긴나와? = {}", "여기가문제야?");
		log.debug("미니프로필수정 memberId = {}", memberId);
		try {
			Member member = memberService.selectOneMember(memberId);
			Interest interest = memberService.selectInterestBymemberId(memberId);
			log.debug("관심장르가져와 interest = {}", interest);
			model.addAttribute("member", member);
			model.addAttribute("interest", interest);
		} catch (Exception e) {
			log.error("마이페이지 조회오류", e);
			throw e;
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
		        map.put("msg", "기존비밀번호와 일치하지 않습니다.");
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
	public ModelAndView myPasswordUpdate(@RequestParam String newPasswordCheck, @AuthenticationPrincipal Member loginMember) {
		String newPassword = newPasswordCheck;
		ModelAndView mv = new ModelAndView();
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
			mv.addObject("msg", "비밀번호를 성공적으로 수정했습니다.");
			mv.setViewName("/mypage/mypageSetting");
			return mv;
		} catch (Exception e) {
			log.error("비밀번호 수정 오류!", e);
			mv.addObject("msg", "비밀번호 수정실패 다시 확인하세요.");
			mv.setViewName("/mypage/mypageSetting");
			return mv;
		}
	}
	
	/* 내 책정보 */
	@GetMapping("/myBook.do")
	public void myBook(Model model, @RequestParam String memberId) {
		log.debug("마이북맴버아이디 = {}",memberId);
		try {
			Member member = memberService.selectOneMember(memberId);
			log.debug("마이북member = {}",member);
			model.addAttribute("member", member);
		} catch (Exception e) {
			log.error("member 조회오류", e);
			throw e;
		}
	}

	/* 내 책 전체 itemId 가져오기 */
	@GetMapping("/myBookAllItemId")
	public ResponseEntity<?> myBookAllItemId(@AuthenticationPrincipal Member loginMember, @RequestParam String memberId){
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
	@GetMapping("/getIngItemId")
	public ResponseEntity<?> getItemId(@RequestParam String memberId){
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
	public ResponseEntity<?> getmyPickItemId(@RequestParam String memberId){
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
	


	/* 내 서재의 책 status별 정보 */
	@GetMapping("/getItemIdByStatus.do")
	public ResponseEntity<?> getItemId(@RequestParam String status, @RequestParam String memberId) {
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
	public ResponseEntity<?> myBookIngList(@RequestParam String memberId){
		List<BookIng> bookIngList = new ArrayList<>();
		try {
			bookIngList = mypageService.SelectMyBookIngList(memberId);

		} catch (Exception e) {
			log.error("bookIng 조회 오류", e);
			throw e;
		}
		return ResponseEntity.ok(bookIngList);
	}
	
	/* 스크랩 독후감목록 */
	@GetMapping("/myScrap.do")
	public ModelAndView myScrap(
			@RequestParam(defaultValue = "1") int cPage, 
			ModelAndView mav, 
			HttpServletRequest request, 
			@AuthenticationPrincipal Member loginMember) {
		
		try {
			 Map<String, Object> map = new HashMap<>();	
			 log.debug("여기온게 맞아? = {} ", "여기온게맞아??");
			 log.debug("authentication member = {} ", loginMember);
		     log.debug("authentication member = {} ", loginMember.getMemberId());
			
			String memberId = loginMember.getMemberId();
			int numPerPage = 10;
			
			// 목록 조회
			
			int start = ((cPage - 1) * numPerPage) + 1;
			int end = cPage * numPerPage;
			
			map.put("cPage", cPage);
			map.put("numPerPage", numPerPage);
			map.put("memberId", memberId);
			map.put("start", start);
			map.put("end", end);

			List<Dokoo> list = mypageService.selectWishMyDokooList(map);
			log.debug("list = {}", list);
			mav.addObject("list", list);

			// pagebar
			int totalMyDokoo = mypageService.selectTotalMyWishDokoo(memberId);
			log.debug("totalMyDokoo = {}", totalMyDokoo);
			String url = request.getRequestURI();
			String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalMyDokoo, url);
			mav.addObject("pagebar", pagebar);
			mav.addObject("totalMyDokoo", totalMyDokoo);
			mav.addObject("cPage", cPage);
			
			mav.setViewName("mypage/myScrap");
		} catch (Exception e) {
			log.error("독후감 목록 조회 오류", e);
			mav.addObject("msg", "독후감 목록 조회 오류");
		}
		return mav;
	}

	/* 스크랩 피드리스트 */
	@GetMapping("/myScrapPheedCList.do")
	public ModelAndView myScrapPheedCList(ModelAndView mav, @AuthenticationPrincipal Member loginMember) {
		try {
			Map<String, Object> map = new HashMap<>();
	        log.debug("authentication member = {} ", loginMember);
	        log.debug("authentication member = {} ", loginMember.getMemberId());
	        String memberId = loginMember.getMemberId();
	        	
			// 멤버 있으면 북클럽 찜 리스트 가져와 
			List<String> pheedWishList = pheedService.getPheedWishListbyMemberId(loginMember.getUsername());
			
			String wishStr = "";
			for(int i = 0; i < pheedWishList.size(); i++) {
				wishStr += pheedWishList.get(i);
				wishStr +=  ",";
			}
			
			mav.addObject("wishStr", wishStr);
			
			// 멤버 있으면 북클럽 하트 리스트 가져와 
			List<String> pheedLikesList = pheedService.getPheedLikesListbyMemberId(loginMember.getUsername());
			
			String likesStr = "";
			for(int j = 0;  j < pheedLikesList.size(); j++) {
				likesStr += pheedLikesList.get(j);
				likesStr +=  ",";
			}
			mav.addObject("likesStr", likesStr);

			
			
			// 목록 조회
			int cPage = 1;
			int numPerPage = 3;
			map.put("cPage", cPage);
			map.put("numPerPage", numPerPage);
			map.put("memberId", memberId);
			
			List<Pheed> list = mypageService.selectWishMyPheedFList(map);
			log.debug("list = {}", list);
			mav.addObject("list", list);
			
			mav.setViewName("mypage/myScrapPheedCList");
			
		} catch (Exception e) {
			log.error("위시피드 목록 조회 오류", e);
			mav.addObject("msg", "위시피드 목록 조회 오류");
			throw e;
		}
		return mav;
	}
	
	/* 스크랩 북클럽리스트 */
	@GetMapping("/myScrapClubList.do")
	public ModelAndView myScrapClubList(
			@RequestParam(required = false, defaultValue = "1") int cPage,
			@RequestParam(required = false) String sortType,
			ModelAndView mav,
			HttpServletRequest request,
			@AuthenticationPrincipal Member loginMember
			) {
		
		try {
			
			log.debug("sortType = {}", sortType);
	        log.debug("authentication member = {} ", loginMember);
			
	        
	        String memberId = loginMember.getMemberId();

			List<String> clubWishList = clubService.getClubWishListbyMemberId(loginMember.getMemberId());

			
			String wishStr = "";
			for(int i = 0; i < clubWishList.size(); i++) {
				wishStr += clubWishList.get(i);
				wishStr +=  ",";
			}
			
			mav.addObject("wishStr", wishStr);
			
			// 멤버 있으면 북클럽 하트 리스트 가져와 
			List<String> clubLikesList = clubService.getClubLikesListbyMemberId(loginMember.getUsername());
			
			String likesStr = "";
			for(int j = 0;  j < clubLikesList.size(); j++) {
				likesStr += clubLikesList.get(j);
				likesStr +=  ",";
			}
			mav.addObject("likesStr", likesStr);
				
			
			Map<String, Object> map = new HashMap<>();	
			int numPerPage = 3;
			int start = ((cPage - 1) * numPerPage) + 1;
			int end = cPage * numPerPage;
			
			map.put("memberId", memberId);
			map.put("sortType", sortType);
			map.put("start", start);
			map.put("end", end);
			
			List<Club> list = mypageService.selectMyScrapClubList(map);
			mav.addObject("list", list);
			
			log.debug("여기 = {}", list);
			
			// 페이지 바
			int totalMyClub = mypageService.selectTotalMyWishClub(map);
			String url = request.getRequestURI();
			String pagebar = "";
			if(sortType == null) {
				pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalMyClub, url);				
			}
			else {
				pagebar = HelloSpringUtils.getPagebarWithSortType(cPage, numPerPage, totalMyClub, url, sortType);
			}
			mav.addObject("pagebar", pagebar);
			mav.addObject("sortType", sortType);
			
			mav.setViewName("mypage/myScrapClubList");
		} catch(Exception e) {
			log.error("내가 신청한 북클럽 조회 오류!!", e);
			mav.addObject("msg", "내가 신청한 북클럽 조회에 실패했습니다!");
			throw e;
		}
		
		return mav;
	}
	
	@GetMapping("/myDokooList.do")
	public ModelAndView myBookClub(
			@RequestParam(defaultValue = "1") int cPage, 
			ModelAndView mav, 
			HttpServletRequest request, 
			@AuthenticationPrincipal Member loginMember) {
		
		try {
			 Map<String, Object> map = new HashMap<>();	
				
			 log.debug("authentication member = {} ", loginMember);
		     log.debug("authentication member = {} ", loginMember.getMemberId());
			
			String memberId = loginMember.getMemberId();
			int numPerPage = 10;
			
			
			// 목록 조회
			
			int start = ((cPage - 1) * numPerPage) + 1;
			int end = cPage * numPerPage;
			
			
			map.put("cPage", cPage);
			map.put("numPerPage", numPerPage);
			map.put("memberId", memberId);
			map.put("start", start);
			map.put("end", end);

			List<Dokoo> list = mypageService.selectMyDokooList(map);
			log.debug("list = {}", list);
			mav.addObject("list", list);
			
			// pagebar
			int totalMyDokoo = mypageService.selectTotalMyDokoo(memberId);
			String url = request.getRequestURI();
			String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalMyDokoo, url);
			mav.addObject("pagebar", pagebar);
			mav.addObject("totalMyDokoo", totalMyDokoo);
			mav.addObject("cPage", cPage);
			
			mav.setViewName("mypage/myDkList");
		} catch (Exception e) {
			log.error("독후감 목록 조회 오류", e);
			mav.addObject("msg", "독후감 목록 조회 오류");
		}
		return mav;
	}
	
	@GetMapping("/myPheedList.do")
	public ModelAndView myPheed(
			ModelAndView mav, 
			@AuthenticationPrincipal Member loginMember) {
		try {
			
			Map<String, Object> map = new HashMap<>();
	        log.debug("authentication member = {} ", loginMember);
	        log.debug("authentication member = {} ", loginMember.getMemberId());
	        String memberId = loginMember.getMemberId();
				
	        	
			// 멤버 있으면 북클럽 찜 리스트 가져와 
			List<String> pheedWishList = pheedService.getPheedWishListbyMemberId(loginMember.getUsername());
			
			String wishStr = "";
			for(int i = 0; i < pheedWishList.size(); i++) {
				wishStr += pheedWishList.get(i);
				wishStr +=  ",";
			}
			
			mav.addObject("wishStr", wishStr);
			
			// 멤버 있으면 북클럽 하트 리스트 가져와 
			List<String> pheedLikesList = pheedService.getPheedLikesListbyMemberId(loginMember.getUsername());
			
			String likesStr = "";
			for(int j = 0;  j < pheedLikesList.size(); j++) {
				likesStr += pheedLikesList.get(j);
				likesStr +=  ",";
			}
			mav.addObject("likesStr", likesStr);
			
			
			
			// 목록 조회
			int cPage = 1;
			int numPerPage = 3;
			map.put("cPage", cPage);
			map.put("numPerPage", numPerPage);
			map.put("memberId", memberId);
			
			List<Pheed> list = mypageService.selectMyPheedList(map);
			log.debug("list = {}", list);
			mav.addObject("list", list);
			
			mav.setViewName("mypage/myPhd");
			
		} catch (Exception e) {
			log.error("내가 작성한 피드 목록 조회 오류", e);
			mav.addObject("msg", "내가 작성한 피드 목록 조회 오류");
			throw e;
		}
		return mav;
		
	}
	
	@GetMapping("/myClubList.do")
	public ModelAndView myClubList(
			@RequestParam(required = false, defaultValue = "1") int cPage,
			@RequestParam(required = false) String sortType,
			ModelAndView mav,
			HttpServletRequest request,
			@AuthenticationPrincipal Member loginMember
			) {
		
		try {
			
			log.debug("sortType = {}", sortType);
	        log.debug("authentication member = {} ", loginMember);
			
	        
	        String memberId = loginMember.getMemberId();

			List<String> clubWishList = clubService.getClubWishListbyMemberId(loginMember.getMemberId());

			
			String wishStr = "";
			for(int i = 0; i < clubWishList.size(); i++) {
				wishStr += clubWishList.get(i);
				wishStr +=  ",";
			}
			
			mav.addObject("wishStr", wishStr);
			
			// 멤버 있으면 북클럽 하트 리스트 가져와 
			List<String> clubLikesList = clubService.getClubLikesListbyMemberId(loginMember.getUsername());
			
			String likesStr = "";
			for(int j = 0;  j < clubLikesList.size(); j++) {
				likesStr += clubLikesList.get(j);
				likesStr +=  ",";
			}
			mav.addObject("likesStr", likesStr);
				
			
			Map<String, Object> map = new HashMap<>();	
			int numPerPage = 6;
			int start = ((cPage - 1) * numPerPage) + 1;
			int end = cPage * numPerPage;
			
			map.put("memberId", memberId);
			map.put("sortType", sortType);
			map.put("start", start);
			map.put("end", end);
			
			List<Club> list = mypageService.selectMyClubList(map);
			mav.addObject("list", list);
			
			log.debug("여기 = {}", list);
			
			// 페이지 바
			int totalMyClub = mypageService.selectTotalMyClub(map);
			String url = request.getRequestURI();
			String pagebar = "";
			if(sortType == null) {
				pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalMyClub, url);				
			}
			else {
				pagebar = HelloSpringUtils.getPagebarWithSortType(cPage, numPerPage, totalMyClub, url, sortType);
			}
			mav.addObject("pagebar", pagebar);
			mav.addObject("sortType", sortType);
			
		} catch(Exception e) {
			log.error("내가 신청한 북클럽 조회 오류!!", e);
			mav.addObject("msg", "내가 신청한 북클럽 조회에 실패했습니다!");
			throw e;
		}
		
		return mav;
		
	}
	
	/* 마이프로필 삭제 */
	@PostMapping("/myProfileDelete.do")
	public String myProfileDelete(@RequestParam String memberId, RedirectAttributes redirectAttr) {
		Member member = memberService.selectOneMember(memberId);
		String nickname = member.getNickname(); 
		log.debug("nickname = {}", nickname);
		// 파일저장위치
        String saveDirectory = application.getRealPath("/resources/upload/profile");
		log.debug(member.getRenamedFilename());
		try {
			if(member.getRenamedFilename() != null) {
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
				int result = memberService.deleteMemberProfile(memberId);
				log.debug("{}의 MemberProfile 레코드 삭제", memberId);	
			}
			
		} catch (Exception e) {
			log.error("프로필 삭제 오류", e);
			throw e;
		}
		return "redirect:/mypage/myMiniProfile.do?memberId=" + memberId;
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
	public String myMainProfileUpdate(RedirectAttributes redirectAttr,
												Member updateMember,
												@RequestParam(required = false) ArrayList<String> interest,
												@RequestParam String introduce,
												@RequestParam("upFile") MultipartFile upFile,
												@RequestParam String delFile,
												@RequestParam String memberId) {
		Member member = memberService.selectOneMember(updateMember.getMemberId());
		String nickname = member.getNickname();
		String[] interests = updateMember.getInterest().split(",");
		log.debug("birthday = {}", updateMember.getBirthday());
		
		// 파일저장위치
        String saveDirectory = application.getRealPath("/resources/upload/profile");
		try {
			// 1. 첨부파일 삭제 (파일 삭제)
			if(delFile == "0" && (member.getRenamedFilename() != null)) {
				Member profileMember =  memberService.selectOneMemberByNickname(member.getNickname());
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
			int updateInterest;
			Member newMember = member;
			Map<String, Object> param = new HashMap<>();
			param.put("memberId", memberId);
			param.put("interests", interests);
			// 2. 첨부파일 등록 (파일 저장)
			if(upFile.getSize() > 0) {
				log.debug("요기?");
				MultipartFile updateFile = upFile;
				newMember.setOriginalFilename(updateFile.getOriginalFilename());
				newMember.setRenamedFilename(HelloSpringUtils.getRenamedFilename(updateFile.getOriginalFilename()));
				newMember.setNickname(updateMember.getNickname());
				newMember.setIntroduce(updateMember.getIntroduce());
				newMember.setGender(updateMember.getGender());
				newMember.setEmail(updateMember.getEmail());
				newMember.setSns(updateMember.getSns());
				newMember.setPhone(updateMember.getPhone());
				newMember.setBirthday(updateMember.getBirthday());
				
				File destFile = new File(saveDirectory, newMember.getRenamedFilename());
				upFile.transferTo(destFile);
				updateResult = memberService.mainUpdateMember(newMember);	
				updateInterest = memberService.updateInterests(param);
			}
			else {
				// 3. 맴버 간단수정
				newMember.setOriginalFilename(member.getOriginalFilename());
				newMember.setRenamedFilename(member.getRenamedFilename());
				newMember.setNickname(updateMember.getNickname());
				newMember.setIntroduce(updateMember.getIntroduce());
				newMember.setGender(updateMember.getGender());
				newMember.setEmail(updateMember.getEmail());
				newMember.setSns(updateMember.getSns());
				newMember.setPhone(updateMember.getPhone());
				newMember.setBirthday(updateMember.getBirthday());
				updateResult = memberService.mainUpdateMember(newMember);		
				updateInterest = memberService.updateInterests(param);
			}
			redirectAttr.addFlashAttribute("msg", updateMember.getNickname() + "님의 정보를 성공적으로 수정했습니다.");
		} 
		catch(Exception e) {
			log.error("메인프로필 수정 오류", e);
			e.printStackTrace();
		}
		return "redirect:/mypage/myMainProfile.do"; 
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

		String memberId = loginMember.getMemberId();
		Member member = memberService.selectOneMember(memberId);
		// 파일저장위치
        String saveDirectory = application.getRealPath("/resources/upload/profile");
		try {
			// 1. 첨부파일 삭제 (파일 삭제)
			if(delFile == "0" && (member.getRenamedFilename() != null)) {
				
				// a. 첨부파일삭제
				String renamedFilename = member.getRenamedFilename();
				File deleteFile = new File(saveDirectory, renamedFilename);
				if(deleteFile.exists()) {
					deleteFile.delete();
				}
				
				// b. 레코드삭제
				int delResult = memberService.deleteMemberProfile(memberId);
			}
			
			int updateResult;
			// 2. 첨부파일 등록 (파일 저장)
			if(upFile.getSize() > 0) {
				MultipartFile updateFile = upFile;
				member.setOriginalFilename(updateFile.getOriginalFilename());
				member.setRenamedFilename(HelloSpringUtils.getRenamedFilename(updateFile.getOriginalFilename()));
				member.setNickname(newNickname);
				member.setIntroduce(introduce);
				member.setSns(sns);
				
				File destFile = new File(saveDirectory, member.getRenamedFilename());
				upFile.transferTo(destFile);
				updateResult = memberService.miniUpdateMember(member);	
			}
			else {
				// 3. 맴버 간단수정
				member.setOriginalFilename(member.getOriginalFilename());
				member.setRenamedFilename(member.getRenamedFilename());
				member.setNickname(newNickname);
				member.setIntroduce(introduce);
				member.setSns(sns);
				updateResult = memberService.miniUpdateMember(member);	
				log.debug("updateResult = {}", updateResult);
			}
			redirectAttr.addFlashAttribute("msg", "공개 프로필을 성공적으로 수정했습니다.");
		} 
		catch(Exception e) {
			log.error("미니프로필 수정 오류", e);
			e.printStackTrace();
		}
		return "redirect:/mypage/mypage.do?memberId=" + loginMember.getMemberId(); 
	}

	/* status 책 뿌려주기 */
	@GetMapping("/statusBook")
	public ResponseEntity<?> statusBook(@RequestParam String itemId){
		log.debug("status itemId = {}", itemId);
		return getBookInfo(itemId);
	}
	
	/* 읽고있는 책 뿌려주기 */
	@GetMapping("/myReadingBook")
	public ResponseEntity<?> myReadingBook(@RequestParam String itemId){
		log.debug("읽는 중 itemId = {}", itemId);
		return getBookInfo(itemId);
	}
	
	/* 마이픽 책 뿌려주기 */
	@GetMapping("/myPickBook")
	public ResponseEntity<?> myPickBook(@RequestParam String itemId){
		log.debug("마이픽 itemId = {}", itemId);
		return getBookInfo(itemId);
	}
	
	/* 달력에 읽은 책 뿌려주기 */
	@GetMapping("/myEndedAtBook")
	public ResponseEntity<?> myEndedAtBook(@RequestParam String itemId){
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
	
}
