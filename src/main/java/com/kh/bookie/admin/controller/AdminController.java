package com.kh.bookie.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.admin.model.dto.Report;
import com.kh.bookie.admin.model.service.AdminService;
import com.kh.bookie.club.model.dto.MissionStatus;
//github.com/devcami/bookie_on_and_on.git
import com.kh.bookie.common.HelloSpringUtils;
import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.dokoo.model.dto.DokooComment;
import com.kh.bookie.dokoo.model.service.DokooService;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.member.model.service.MemberService;
import com.kh.bookie.mypage.model.dto.Qna;
import com.kh.bookie.mypage.model.dto.QnaComment;
import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedComment;
import com.kh.bookie.pheed.model.service.PheedService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@Slf4j
@SessionAttributes({"next"})
public class AdminController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	AdminService adminService;

	@Autowired
	DokooService dokooService;
	
	@Autowired
	PheedService pheedService;
	
	@GetMapping("/memberList.do")
	public void admin(Model model) {
		try {
			List<Member> list = memberService.selectMemberList();
			log.debug("list = {}",list);
			model.addAttribute("list", list);
		}catch(Exception e){
			log.error("회원괸리 오류",e);
			throw e;
		}
		
	}
	
	@GetMapping("/memberDetail.do")
	public void memberDetail(@RequestParam String memberId, Model model) {
		try {
			Member member = memberService.selectOneMember(memberId);
			model.addAttribute("member", member);
		} catch (Exception e) {
			log.error("회원 상세보기 오류", e);
			e.printStackTrace();
		}
	}
	
	@GetMapping("/missionCheck.do")
	public ModelAndView missionCheck(
			ModelAndView mav,
			HttpServletRequest request,
			@RequestParam(defaultValue = "1") int cPage) {
		try {
			
			Map<String, Object> map = new HashMap<>();	
			int numPerPage = 10;
			int start = ((cPage - 1) * numPerPage) + 1;
			int end = cPage * numPerPage;
			
			map.put("start", start);
			map.put("end", end);
			
			List<MissionStatus> list = adminService.selectMissionStatusListByAdmin(map);
			log.debug("list = {}", list);
			mav.addObject("list", list);
			
			// 페이지 바
			int totalMissionByAdmin = adminService.selectTotalMissionByAdmin();
			String url = request.getRequestURI();
			String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalMissionByAdmin, url);
			mav.addObject("pagebar", pagebar);

		} catch(Exception e) {
			log.error("관리자 미션 확인 오류", e);
			throw e;
		}
		
		return mav;
	}
	
	@PostMapping("/missionAgain.do/{missionNo}/{memberId}")
	public ResponseEntity<?> missionAgain(
			@PathVariable int missionNo,
			@PathVariable String memberId
			) {
		
		try {
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("missionNo", missionNo);
			map.put("memberId", memberId);
//			log.debug("missionNo = {}", missionNo);
//			log.debug("memberId = {}", memberId);
				
			int result = adminService.missionAgain(map);
			
			return ResponseEntity.ok().build();
		} catch(Exception e) {
			log.error("회원 미션 Fail 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
		
	}
	
	@PostMapping("/missionPass.do/{missionNo}/{memberId}")
	public ResponseEntity<?> missionPass(
			@PathVariable int missionNo,
			@PathVariable String memberId
			) {
		
		try {
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("missionNo", missionNo);
			map.put("memberId", memberId);
			
//			log.debug("missionNo = {}", missionNo);
//			log.debug("memberId = {}", memberId);
			
			int result = adminService.missionPass(map);
			
			return ResponseEntity.ok().build();
		} catch(Exception e) {
			log.error("회원 미션 Pass 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
		
	}
	
	
	
	@GetMapping("/sendAlarm.do")
	public void sendAlarm(Model model) {
		try {
			List<Member> list = memberService.selectMemberList();
			log.debug("list = {}",list);
			model.addAttribute("list", list);
		}catch(Exception e){
			log.error("회원괸리 오류",e);
			throw e;
		}
	};
	
	@GetMapping("/selectMemberListByInterest.do")
	public ResponseEntity<?> selectMemberListByInterest(@RequestParam String interest){
		Map<String, Object> map = new HashMap<>();
		try {
			Member member = new Member();
			member.setInterest(interest);
			List<Member> list = memberService.selectMemberListByInterest(member);
			map.put("msg", "관심사별 멤버 불러오기 완료");
			map.put("list", list);
		} catch (Exception e) {
			log.error("관심사별 멤버 불러오기 오류", e);
			map.put("msg", "관심사별 멤버 불러오기 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/insertAlarm.do")
	public ResponseEntity<?> insertAlarm(Alarm alarm){
		Map<String, Object> map = new HashMap<>();
		try {
			int result = adminService.insertAlarm(alarm);
			map.put("msg", "알림 등록 완료");
		} catch (Exception e) {
			log.error("알림 등록 오류", e);
			map.put("msg", "알림 등록 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/reportList.do")
	public void reportList(@RequestParam(defaultValue = "1") int cPage, 
							Model model,
							HttpServletRequest request) {
		try {
			int numPerPage = 10;
			List<Report> list = adminService.selectReportList(cPage, numPerPage);
			log.debug("list = {}",list);
			model.addAttribute("list", list);
			
			// page bar
			int totalContent = adminService.selectTotalReportContent();
			String url = request.getRequestURI();
			String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalContent, url);
			model.addAttribute("pagebar", pagebar);
		}catch(Exception e){
			log.error("신고리스트 불러오기 오류",e);
			throw e;
		}
	}
	
	@GetMapping("/selectReportListByCategory.do")
	public ResponseEntity<?> selectReportListByCategory(
				@RequestParam String category , @RequestParam String status,
				@RequestParam(defaultValue = "1") int cPage,
				HttpServletRequest request){
		Map<String, Object> map = new HashMap<>();
		try {
			List<Report> list = null;
			int numPerPage = 10;
			map.put("cPage", cPage);
			map.put("numPerPage", numPerPage);
			int totalContent = 0;
			
			if(!status.equals("상태") && category.equals("카테고리")) {
				// 상태는 선택되고 카테고리는 전체일 시
				map.put("status", status);
				list = adminService.selectReportListByStatus(map);
				totalContent = adminService.selectTotalReportByStatus(status);
			} 
			else if(status.equals("상태") && category.equals("카테고리")) {
				// 둘다 없을 시
				list = adminService.selectReportList(cPage, numPerPage);
			}
			else if(status.equals("상태")) {
				// 카테고리만 선택 시
				map.put("category", category);
				list = adminService.selectReportListByCategory(map);
				totalContent = adminService.selectTotalReportByCategory(category);
			}
			else if(!status.equals("상태")){
				// 둘다 선택 시
				map.put("category", category);
				map.put("status", status);
				list = adminService.selectReportListByBoth(map);
				totalContent = adminService.selectTotalReportByBoth(map);
			} 
			map.put("list", list);
			
			// page bar
			String url = request.getRequestURI();
			String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalContent, url);
			map.put("pagebar", pagebar);
			
		} catch (Exception e) {
			log.error("신고리스트 -카테고리 불러오기 오류", e);
			map.put("msg", "신고리스트 -카테고리 불러오기 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/selectReportListByStatus.do")
	public ResponseEntity<?> selectReportListByStatus(
			@RequestParam String status, @RequestParam String category,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request){
		Map<String, Object> map = new HashMap<>();
		try {
			int numPerPage = 10;
			int totalContent = 0;
			List<Report> list = null;
			map.put("cPage", cPage);
			map.put("numPerPage", numPerPage);
			
			if(!category.equals("카테고리") && status.equals("상태")){
				// 카테고리는 선택되고 상태는 전체일 시
				map.put("category", category);
				list = adminService.selectReportListByCategory(map);
				
				totalContent = adminService.selectTotalReportByCategory(category);
			} 
			else if(status.equals("상태") && category.equals("카테고리")) {
				// 둘다 없을 시
				list = adminService.selectReportList(cPage, numPerPage);
			}
			else if(category.equals("카테고리")) {
				// 상태만 선택 시
				map.put("status", status);
				list = adminService.selectReportListByStatus(map);
				
				totalContent = adminService.selectTotalReportByStatus(status);
			} 
			else if(!category.equals("카테고리")){
				// 둘다 선택 시
				map.put("category", category);
				map.put("status", status);
				list = adminService.selectReportListByBoth(map);
				totalContent = adminService.selectTotalReportByBoth(map);
			} 
			map.put("list", list);
			
			// page bar
			String url = request.getRequestURI();
			String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalContent, url);
			map.put("pagebar", pagebar);
		} catch (Exception e) {
			log.error("신고리스트 -상태 불러오기 오류", e);
			map.put("msg", "신고리스트 -상태 불러오기 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/reportDetail.do")
	public void reportDetail(@RequestParam int reportNo, Model model) {
		try {
			Report report = adminService.selectOneReport(reportNo);
			model.addAttribute("report", report);
			log.debug("report = {}", report);
			
			if(report.getCategory().equals("dokoo") || report.getCategory().equals("dokoo_comment")) {
				// dokoo - select one dokoo 가져오기
				if(report.getCategory().equals("dokoo")) {
					Dokoo dokoo = dokooService.selectOneDokoo(report.getBeenziNo());
					model.addAttribute("dokoo", dokoo);
				}
				// dokooComment - select one dokoo 가져오기
				else if(report.getCategory().equals("dokoo_comment")){
					int dokooCNo = report.getBeenziNo();
					DokooComment dokooComment = dokooService.selectOneDokooComment(dokooCNo);
					if(dokooComment != null) {
					log.debug("dokooComment = {}", dokooComment);
					int dokooNo = dokooComment.getDokooNo();
					Dokoo dokoo = dokooService.selectOneDokoo(dokooNo);
					log.debug("dokoo = {}", dokoo);
					model.addAttribute("dokoo", dokoo);
					}
				}
				
			} else if(report.getCategory().equals("pheed") || report.getCategory().equals("pheed_comment")){
				// pheed - select one pheed 가져오기
				if(report.getCategory().equals("pheed")) {
					Pheed pheed = pheedService.selectOnePheed(report.getBeenziNo());
					model.addAttribute("pheed", pheed);
					List<PheedComment> commentList = pheedService.selectPheedCommentList(report.getBeenziNo());
					model.addAttribute("commentList", commentList);
				}
				// pheedComment - select one pheed 가져오기
				else if(report.getCategory().equals("pheed_comment")) {
					int pheedCNo = report.getBeenziNo(); // 57
					PheedComment pheedComment = pheedService.selectOnePheedComment(pheedCNo);
					log.debug("pheedComment = {}", pheedComment);
					if(pheedComment != null) {
						int pheedNo = pheedComment.getPheedNo();
						Pheed pheed = pheedService.selectOnePheed(pheedNo);
						log.debug("pheed", pheed);
						model.addAttribute("pheed", pheed);
						List<PheedComment> commentList = pheedService.selectPheedCommentList(pheedNo);
						model.addAttribute("commentList", commentList);
					}
				}
			}
		}catch(Exception e){
			log.error("신고 상세보기 오류",e);
			throw e;
		}
	}
	
	@PostMapping("/reportUpdate.do")
	public String reportUpdate(@RequestParam int reportNo, @RequestParam String status) {
		Map<String, Object> map = new HashMap<>();
		try {
			log.debug("status", status);
			map.put("status", status);
			map.put("reportNo", reportNo);
			int result = adminService.reportUpdate(map);
		} catch (Exception e) {
			log.error("신고 상태 수정 오류", e);
			throw e;
		}
		return "redirect:/admin/reportDetail.do?reportNo=" + reportNo;
	}
	
	@PostMapping("/reportDelete.do")
	public ResponseEntity<?> reportDelete(@RequestParam String category, @RequestParam int beenziNo){
		Map<String, Object> map = new HashMap<>();
		int result = 0;
		try {
			if(category.equals("dokoo")) {
				result = dokooService.deleteDokoo(beenziNo);
			} else if(category.equals("dokoo_comment")) {
				result = dokooService.commentDel(beenziNo);
			} else if(category.equals("pheed")) {
				result = pheedService.deletePheed(beenziNo);
			} else if(category.equals("pheed_comment")) {
				result = pheedService.commentDel(beenziNo);
			}
		} catch (Exception e) {
			log.error("신고 글 삭제 오류", e);
			map.put("msg", "신고 글 삭제 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
		
	}
	
	@GetMapping("/qnaList.do")
	public void qnaList(@RequestParam(defaultValue = "1") int cPage, 
						Model model,
						HttpServletRequest request){
		try {
			int numPerPage = 10;
			List<Qna> list = adminService.selectQnaList(cPage, numPerPage);
			log.debug("list", list);
			model.addAttribute("list", list);
			
			// page bar
			int totalContent = adminService.selectTotalQnaContent();
			String url = request.getRequestURI();
			String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalContent, url);
			model.addAttribute("pagebar", pagebar);
		} catch (Exception e) {
			log.error("QNA리스트 불러오기 오류",e);
			model.addAttribute("msg", "QNA리스트 불러오기 오류");
			throw e;
		}
	}
	
	@GetMapping("/selectQnaListByStatus.do")
	public ResponseEntity<?> selectQnaListByStatus(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam String status, 
			HttpServletRequest request){
		Map<String, Object> map = new HashMap<>();
		try {
			List<Qna> list = null;
			int numPerPage = 10;
			log.debug("status = {}", status);
			if(status.equals("상태")){
				// 전체 검색
				list = adminService.selectQnaList(cPage, numPerPage);
				// page bar
				int totalContent = adminService.selectTotalQnaContent();
				String url = request.getRequestURI();
				String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalContent, url);
				map.put("pagebar", pagebar);
			} 
			else if(!status.equals("상태")) {
				// 상태에 따른 검색
				map.put("status", status);
				map.put("cPage", cPage);
				map.put("numPerPage", numPerPage);
				list = adminService.selectQnaListByStatus(map);
				log.debug("list = {}", list);
				// page bar
				int totalContent = adminService.selectTotalQnaContentByStatus(status);
				String url = request.getRequestURI();
				String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalContent, url);
				map.put("pagebar", pagebar);
			}
			map.put("list", list);
		} catch (Exception e) {
			log.error("신고리스트 -상태 불러오기 오류", e);
			map.put("msg", "신고리스트 -상태 불러오기 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/qnaCommentEnroll.do")
	public String qnaCommentEnroll(QnaComment qnaComment) {
		try {
			log.debug("qnaComment = {}", qnaComment);
			int result = adminService.qnaCommentEnroll(qnaComment);
		} catch (Exception e) {
			log.error("QNA 답변 등록 오류", e);
			e.printStackTrace();
			throw e;
		}
		return "redirect:/mypage/qnaDetail.do?qnaNo=" + qnaComment.getQnaNo();
	}
	
}
