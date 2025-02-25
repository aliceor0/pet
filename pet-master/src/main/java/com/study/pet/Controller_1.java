package com.study.pet;

import java.io.IOException;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.xhtmlrenderer.util.SystemPropertiesUtil;

import com.study.pet.DAO.BoardDAO;
import com.study.pet.DTO.BoardDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// 곽용민님 컨트롤러
// 분양파트 관련
@Controller
public class Controller_1 {

	@Configuration
	public class WebMvcConfig implements WebMvcConfigurer {

		@Override
		public void addResourceHandlers(ResourceHandlerRegistry registry) {
			registry.addResourceHandler("/**").addResourceLocations("file:src/main/resources/static/");
		}
	}

	@Autowired
	private yougiListDAO yougidao;
//
	@Autowired
	private BoardDAO bdao;

	@Autowired
	private MemberDAO mdao;
	
	public static Object[] showPage(int total, String sPage){
			// 토탈을 받고, 페이지도 받아야함.
		String pageno = "1";// 초기페이지
		if (sPage != null && !sPage.equals("")) {
			pageno = sPage; // 페이지 텍스트
		}
		int page = Integer.parseInt(pageno); // 페이지 String 에서 int 변겅
		int start = (page - 1) * 12; // 시작페이지
		int block = (page - 1) / 12 + 1; // 1개의 페이지의 게시물 갯수블럭 저장
		int lastpage = (int) Math.ceil((double) total / 12); // 마지막페이지
		int showpage = (block - 1) * 12; // 총보여줄 페이지
		ArrayList<Integer> pageNumber = new ArrayList<Integer>();
		for (int i = 0; i < 10 && showpage < lastpage; i++, showpage++) {
		    pageNumber.add(showpage + 1);  // 페이지 번호를 리스트에 추가
		}
		return new Object[] { pageNumber, start, page, lastpage };
	}

	@GetMapping("/parcelOutList")
	public String doList(HttpServletRequest req, HttpSession session, Model model){
	    String type = req.getParameter("type");
	    
	    // 세션에 저장된 검색 조건 가져오기
	    String sessionType = (String) session.getAttribute("type");
	    Integer sessionCategory = (Integer) session.getAttribute("category");
	    System.out.println("sesstype" + sessionType);
	    System.out.println("sesscate" + sessionCategory);
	    // 검색 조건 설정
	    
	    if (type != null && !"1".equals(type)) {
	    	System.out.println("search");
	        sessionType = type; // 세션에 type 저장
	        session.setAttribute("type", sessionType);
	        
	        sessionCategory = Integer.parseInt(req.getParameter("category")); // 세션에 category 저장
	        session.setAttribute("category", sessionCategory);
	    } else { // 검색 없을때
	        System.out.println("noSearch");
	        session.removeAttribute("type"); // 세션에서 type 제거
	        session.removeAttribute("category"); // 세션에서 category 제거
	        sessionType = null;
	        sessionCategory = 0;
	    }

	    // 세션을 이용하여 검색 조건으로 목록 조회
	    ArrayList<yougiListDTO> listTotal = yougidao.yougiList(-1, sessionType, sessionCategory);
	    int total = listTotal.size();
	    System.out.println("total : " + total);
	    
	    Object[] pageInfo = showPage(total, req.getParameter("page"));

	    int start = (int) pageInfo[1];
	    ArrayList<yougiListDTO> list = yougidao.yougiList(start, sessionType, sessionCategory);
	    System.out.println("list : " + list);

	    model.addAttribute("alist", list);
	    model.addAttribute("pageNumber", pageInfo[0]);       // 페이지 번호 리스트
	    model.addAttribute("start", pageInfo[1]);   // 시작 페이지
	    model.addAttribute("page", pageInfo[2]);    // 현재 페이지
	    model.addAttribute("lastpage", pageInfo[3]); // 마지막 페이지

	    return "parcelOut/parcelOutList";
	}
	
	@GetMapping("/parcelWrite")
	public String parcelWrite(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String name = (String) session.getAttribute("name");
		ArrayList<MemberDTO> info = mdao.getInfo(name);
		model.addAttribute("info", info);
		System.out.println(info);

		return "parcelOut/parcelWrite";
	}

	@GetMapping("/parcelUpdate")
	public String percelUpdate(HttpServletRequest req, Model model) {
		String id = req.getParameter("id");
		ArrayList<yougiListDTO> view = yougidao.deDetailView(Integer.parseInt(id));
//		for (int i = 0; i < view.size(); i++) {
//			yougiListDTO item = view.get(i);
//			String content = item.getContent().replace("/ready/", "/complete/");
//			System.out.println("내용은:" + content);
//			item.setContent(content);
//			view.set(i, item);
//		}
		model.addAttribute("view", view);
		return "parcelOut/parcelUpdate";
	}

	@GetMapping("/popup")
	public String doPopup() {
		return "parcelOut/popup";
	}

	@GetMapping("/chatBot")
	public String doChatBot() {
		return "parcelOut/chatBot";
	}

	@GetMapping("/showDetail")
	public String showDetail(HttpServletRequest req, Model model) {
		String id = req.getParameter("id");
//      ArrayList<yougiListDTO> view = yougidao.deDetailView(Integer.parseInt(id));
		ArrayList<yougiListDTO> view = yougidao.deDetailView(Integer.parseInt(id));
		for (int i = 0; i < view.size(); i++) {
			yougiListDTO item = view.get(i);
			String content = item.getContent().replace("/temp_img/", "/final_img/");
			System.out.println("내용은:" + content);
			item.setContent(content);
			view.set(i, item);
		}
		ArrayList<BoardDTO> list = bdao.getComment(Integer.parseInt(id), 1);
		System.out.println("list=" + list);
		model.addAttribute("commentList", list);
		model.addAttribute("view", view);
//      int total = replydao_1.replyTotal_2(Integer.parseInt(id));
//      int lastpage = (int) Math.ceil((double) total / 10);
//      int page=1;
//      model.addAttribute("last", lastpage);
//      model.addAttribute("page", page);
		return "parcelOut/showDetail";
	}

	@PostMapping("/doSalesRegistration")
	public String doSalesRegistration(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String id = req.getParameter("id");
		String title_img = req.getParameter("title_img");
		String category = req.getParameter("category");
		String type = req.getParameter("type");
		String temporaryName = req.getParameter("temporaryName");
		String color = req.getParameter("color");
		String gender = req.getParameter("gender");
		String age = req.getParameter("age");
		String weight = req.getParameter("weight");
		String content = req.getParameter("content");
		HttpSession session = req.getSession();
		String user_id = (String) session.getAttribute("id");
		int member_id = mdao.getIdNum(user_id);
		int n = 0;

		if (id == null || id.equals("")) {
			System.out.println("add");
			n = yougidao.addParcelOut(Integer.parseInt(category), title_img, type, temporaryName, color,
					age, weight, gender, content, member_id);
		} else {
			System.out.println("modify");
			n = yougidao.modify_1(Integer.parseInt(id), Integer.parseInt(category), title_img, type,
					temporaryName, color, age, weight, gender, content, member_id);
		}
		return "redirect:/parcelOutList";
	}

	@PostMapping("/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req) {
		String id = req.getParameter("id");
		int n = yougidao.doDelete_1(Integer.parseInt(id));
		return n + "";
	}

	@PostMapping("/doState")
	@ResponseBody
	public String doState(HttpServletRequest req) {
		String id = req.getParameter("id");
		String state = req.getParameter("state");
		int n = yougidao.change_1(Integer.parseInt(state), Integer.parseInt(id));
		return "" + n;
	}

//   //한개의 페이지별 테이블 나누기 ajax버전
//   @PostMapping("/replyList")
//   @ResponseBody
//   public String doReplyList(HttpServletRequest req) {
//      String pageno = "1";
//      System.out.println("페이지는"+req.getParameter("page"));
//      int total = replydao_1.replyTotal();
//      if (req.getParameter("page") != null && !req.getParameter("page").equals("")) {
//         pageno = req.getParameter("page");
//      }
//      int page = Integer.parseInt(pageno);
//      int start = (page - 1) * 10;
//      System.out.println("시작="+start);
//      int block = (page - 1) / 10 + 1;
//      int lastpage = (int) Math.ceil((double) total / 10);
//      int showpage = (block - 1) * 10;
//      ArrayList<Integer> a = new ArrayList<Integer>();
//      for (int i = 1; i <= 10; i++) {
//         showpage++;
//         a.add(showpage);
//         if (showpage == lastpage)
//            break;
//      }
//      String id = req.getParameter("id");
//      ArrayList<replyDTO_1> replyList = replydao_1.replyList(Integer.parseInt(id), start);
//      JSONArray ja = new JSONArray();
//      for (int i = 0; i < replyList.size(); i++) {
//         JSONObject jo = new JSONObject();
//         jo.put("id", replyList.get(i).getId());
//         jo.put("name", replyList.get(i).getNickName());
//         jo.put("content", replyList.get(i).getContent());
//         jo.put("time", replyList.get(i).getCreated());
//         ja.add(jo);
//      }
//      return ja.toJSONString();
//   }
//
//   @PostMapping("/replyInsert")
//   @ResponseBody
//   public String doReplyInsert(HttpServletRequest req) {
//      String reply_id = req.getParameter("reply_id");
//      String nickName = req.getParameter("nickName");
//      String content = req.getParameter("content");
//      int n = 0;
//      if (content.equals("") || content == null) {
//         n = 0;
//      } else {
//         n = replydao_1.replyInsert(Integer.parseInt(reply_id), nickName, content);
//      }
//      return "" + n;
//   }
//
//   @PostMapping("/replyDelete")
//   @ResponseBody
//   public String doReplyDelete(HttpServletRequest req) {
//      String id = req.getParameter("id");
//      int n = replydao_1.replyDelete(Integer.parseInt(id));
//      return "" + n;
//   }
//
//   @PostMapping("/replyModifiy")
//   @ResponseBody
//   public String doReplyModifiy(HttpServletRequest req) {
//      String id = req.getParameter("id");
//      String nickName = req.getParameter("nickName");
//      String content = req.getParameter("content");
//      int n = replydao_1.replyModifiy(Integer.parseInt(id), nickName, content);
//      return "" + n;
//   }
//

	// 페이지네이션 ajax 버전(페이지 숫자)
	@GetMapping("/showpage")
	@ResponseBody
	public String showpage(HttpServletRequest req) {
		String id = req.getParameter("id");
		System.out.println("id=" + id);
		int total = bdao.pagetotal(Integer.parseInt(id));
		System.out.println("총갯수=" + total);
		String pageno = "1";
		if (req.getParameter("page") != null && !req.getParameter("page").equals("")) {
			pageno = req.getParameter("page");
		}
		int page = Integer.parseInt(pageno);
		int start = (page - 1) * 1;
		int block = (page - 1) / 1 + 1;
		int lastpage = (int) Math.ceil((double) total / 1);
		int showpage = (block - 1) * 1;
		ArrayList<Integer> a = new ArrayList<Integer>();
		if (total != 0) {
			for (int i = 1; i <= 10; i++) {
				showpage++;
				a.add(showpage);
				if (showpage == lastpage)
					break;
			}
		}
		return "" + a;
	}
}