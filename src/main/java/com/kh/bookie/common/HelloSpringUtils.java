package com.kh.bookie.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class HelloSpringUtils {
	/*
	 * <nav aria-label="Page navigation example">
		  <ul class="pagination pagination-sm justify-content-center">
		    <li class="page-item disabled">
		      <a class="page-link" href="#" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		        <span class="sr-only">Previous</span>
		      </a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item active">
		    	  <span class="page-link">
			        2
			        <span class="sr-only">(current)</span>
			      </span>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    <li class="page-item">
		      <a class="page-link" href="#" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		        <span class="sr-only">Next</span>
		      </a>
		    </li>
		  </ul>
		</nav>
	 */
	
	/**
	 * totalPage 전체 페이지 수
	 * pagebarSize 표시할 페이지 수 5
	 * pageStart ~ pageEnd 
	 * pageNo 증감변수
	 * 
	 * @param cPage
	 * @param numPerPage
	 * @param totalContent
	 * @param url
	 * @return
	 */
	public static String getPagebar(int cPage, int numPerPage, int totalContent, String url) {
		final int pagebarSize = 5;
		StringBuilder pagebar = new StringBuilder();
		url += "?cPage=";
		
		int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
		int pageStart = ((cPage - 1) / pagebarSize) * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		int pageNo = pageStart;
		
		pagebar.append("<ul class=\"pagination pagination-sm justify-content-center\">\n");
		
		// 이전 영역
		if(pageNo == 1) {
			pagebar.append(" <li class=\"page-item disabled\">\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\">\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\n"
					+ "		        <span class=\"sr-only\">Previous</span>\n"
					+ "		      </a>\n"
					+ "		    </li>\n");
		}
		else {
			pagebar.append(" <li class=\"page-item\">\n"
					+ "		      <a class=\"page-link\" href=\"" + url + (pageNo - 1) + "\" aria-label=\"Previous\">\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\n"
					+ "		        <span class=\"sr-only\">Previous</span>\n"
					+ "		      </a>\n"
					+ "		    </li>\n");
		}
		
		// pageNo 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			// 현재페이지
			if(pageNo == cPage) {
				pagebar.append("<li class=\"page-item active\">\n"
						+ "		    	  <span class=\"page-link\">\n"
						+ "			       " + pageNo + "\n"
						+ "			        <span class=\"sr-only\">(current)</span>\n"
						+ "			      </span>\n"
						+ "		    </li>\n");
			}
			// 다른페이지
			else {
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\""+ url + pageNo + "\">" + pageNo + "</a></li>\n");
			}
			pageNo++;
		}
		
		
		// 다음 영역
		if(pageNo > totalPage) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\r\n");
		}
		else {
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"" + url + pageNo + "\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\r\n");
		}
		
		pagebar.append("</ul>");
		return pagebar.toString();
	}
	
	
	public static String getPagebarWithSortType(int cPage, int numPerPage, int totalContent, String url, String sortType) {
		final int pagebarSize = 5;
		StringBuilder pagebar = new StringBuilder();
		url += "?sortType=" + sortType + "&cPage=";
		
		int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
		int pageStart = ((cPage - 1) / pagebarSize) * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		int pageNo = pageStart;
		
		pagebar.append("<ul class=\"pagination pagination-sm justify-content-center\">\n");
		
		// 이전 영역
		if(pageNo == 1) {
			pagebar.append(" <li class=\"page-item disabled\">\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\">\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\n"
					+ "		        <span class=\"sr-only\">Previous</span>\n"
					+ "		      </a>\n"
					+ "		    </li>\n");
		}
		else {
			pagebar.append(" <li class=\"page-item\">\n"
					+ "		      <a class=\"page-link\" href=\"" + url + (pageNo - 1) + "\" aria-label=\"Previous\">\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\n"
					+ "		        <span class=\"sr-only\">Previous</span>\n"
					+ "		      </a>\n"
					+ "		    </li>\n");
		}
		
		// pageNo 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			// 현재페이지
			if(pageNo == cPage) {
				pagebar.append("<li class=\"page-item active\">\n"
						+ "		    	  <span class=\"page-link\">\n"
						+ "			       " + pageNo + "\n"
						+ "			        <span class=\"sr-only\">(current)</span>\n"
						+ "			      </span>\n"
						+ "		    </li>\n");
			}
			// 다른페이지
			else {
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\""+ url + pageNo + "\">" + pageNo + "</a></li>\n");
			}
			pageNo++;
		}
		
		
		// 다음 영역
		if(pageNo > totalPage) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\r\n");
		}
		else {
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"" + url + pageNo + "\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\r\n");
		}
		
		pagebar.append("</ul>");
		return pagebar.toString();
	}
	
	public static String getPagebarForClubBoard(int cPage, int numPerPage, int totalContent, String url,
			Map<String, Object> param) {
		
		final int pagebarSize = 5;
		StringBuilder pagebar = new StringBuilder();
		
		if(param.get("sortType") == null) {
			url += "?clubNo=" + param.get("clubNo") + "&cPage=";			
		}
		else {
			url += "?clubNo=" + param.get("clubNo") + "&sortType=" + param.get("sortType") + "&cPage=";
		}
		
		
		int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
		int pageStart = ((cPage - 1) / pagebarSize) * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		int pageNo = pageStart;
		
		pagebar.append("<ul class=\"pagination pagination-sm justify-content-center\">\n");
		
		// 이전 영역
		if(pageNo == 1) {
			pagebar.append(" <li class=\"page-item disabled\">\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\">\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\n"
					+ "		        <span class=\"sr-only\">Previous</span>\n"
					+ "		      </a>\n"
					+ "		    </li>\n");
		}
		else {
			pagebar.append(" <li class=\"page-item\">\n"
					+ "		      <a class=\"page-link\" href=\"" + url + (pageNo - 1) + "\" aria-label=\"Previous\">\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\n"
					+ "		        <span class=\"sr-only\">Previous</span>\n"
					+ "		      </a>\n"
					+ "		    </li>\n");
		}
		
		// pageNo 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			// 현재페이지
			if(pageNo == cPage) {
				pagebar.append("<li class=\"page-item active\">\n"
						+ "		    	  <span class=\"page-link\">\n"
						+ "			       " + pageNo + "\n"
						+ "			        <span class=\"sr-only\">(current)</span>\n"
						+ "			      </span>\n"
						+ "		    </li>\n");
			}
			// 다른페이지
			else {
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\""+ url + pageNo + "\">" + pageNo + "</a></li>\n");
			}
			pageNo++;
		}
		
		
		// 다음 영역
		if(pageNo > totalPage) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\r\n");
		}
		else {
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"" + url + pageNo + "\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\r\n");
		}
		
		pagebar.append("</ul>");
		return pagebar.toString();
	}

	/**
	 * ex) 20220714_143822333_123.png
	 * @param originalFilename
	 * @return renamedFilename
	 */
	public static String getRenamedFilename(String originalFilename) {
		// 확장자 추출
		int dot = originalFilename.lastIndexOf(".");
		String ext = "";
		if(dot > -1) 
			ext = originalFilename.substring(dot); // .png
		
		// 파일명 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000"); // 001 3자리수 채워줌
		
		return sdf.format(new Date()) + df.format(Math.random() * 1000) + ext; 
	}


	
}
