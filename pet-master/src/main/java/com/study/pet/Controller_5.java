package com.study.pet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.study.pet.DAO.BoardDAO;
import com.study.pet.DTO.BoardDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

// 이광규님 컨트롤러
// 실종 목격 관련, 커뮤니티 및 자원봉사관련
@Controller
public class Controller_5 {

	@Autowired
	private LostAnimalDAO_5 ldao;
	@Autowired
	private BoardDAO bdao;
	@Autowired
	private MemberDAO mdao;
	@Autowired
	private CommunityDAO_5 cdao;

	private static final String IMAGE_DIR = "src/main/resources/static/image_lost/title_img/";

	@Configuration
	public class WebMvcConfig implements WebMvcConfigurer {

		@Override
		public void addResourceHandlers(ResourceHandlerRegistry registry) {
			registry.addResourceHandler("/**").addResourceLocations("file:src/main/resources/static/");
		}
	}

	@PostMapping("/save-image")
	public ResponseEntity<Map<String, Object>> saveImage(@RequestBody Map<String, String> data) {
		Map<String, Object> response = new HashMap<>();

		try {
			String imageData = data.get("imageData");
			byte[] imageBytes = Base64.getDecoder().decode(imageData);

			String fileName = UUID.randomUUID().toString() + "-lost-poster.jpg";
			String filePath = IMAGE_DIR + fileName;

			FileOutputStream fos = new FileOutputStream(filePath);
			fos.write(imageBytes);
			fos.close();

			response.put("success", true);
			response.put("message", "이미지 저장에 성공하였습니다.");
			response.put("fileName", fileName); // Return the saved file name
		} catch (IOException e) {
			response.put("success", false);
			response.put("message", "이미지 저장에 실패하였습니다.");
			e.printStackTrace();
		}

		return ResponseEntity.ok(response);
	}

	@GetMapping("/lost")
	public String goLostBoard(Model model, HttpServletRequest req, HttpSession session) {

		String status = updateSession(session, req.getParameter("status"), "status");
		String animal = updateSession(session, req.getParameter("animal"), "animal");
		String area = updateSession(session, req.getParameter("area"), "area");
		String sort = updateSession(session, req.getParameter("sort"), "sort");

		ArrayList<LostAnimalDTO_5> list = ldao.getLostList(status, animal, area, sort, -1);
		int total = list.size();

		System.out.println("total : " + total);
		Object[] pageInfo = Controller_1.showPage(total, req.getParameter("page"));
		int start = (int) pageInfo[1];

		list = ldao.getLostList(status, animal, area, sort, start);

		model.addAttribute("lostList", list);
		model.addAttribute("pageNumber", pageInfo[0]); // 페이지 번호 리스트
		model.addAttribute("start", start); // 시작 페이지
		model.addAttribute("page", pageInfo[2]); // 현재 페이지
		model.addAttribute("lastpage", pageInfo[3]); // 마지막 페이지
		System.out.println("start" + start);
		System.out.println("page" + pageInfo[2]);
		System.out.println("lastpage" + pageInfo[3]);

		return "lost/lost";
	}



	@GetMapping("/lostPoster")
	public String doPoster(HttpServletRequest req, Model model) {
		String id = req.getParameter("id");
		ArrayList<LostAnimalDTO_5> info = ldao.getLostInfo(Integer.parseInt(id));

		model.addAttribute("animalInfo", info);
		System.out.println(info);

		ArrayList<BoardDTO> list = bdao.getComment(Integer.parseInt(id), 2);
		model.addAttribute("commentList", list);
		return "lost/lostPoster";
	}

	@GetMapping("/lostWrite")
	public String doLostWrite() {
		return "lost/lostWrite";
	}

	@PostMapping("/lostWrite")
	public String doLostUpdate(HttpServletRequest req) {
		String type = req.getParameter("type");
		int category = 5;
		String img = req.getParameter("img");
		String description = req.getParameter("description");
		String date_and_place = req.getParameter("dateAndPlace");
		String date = req.getParameter("date");
		String area = req.getParameter("area");
		String place = req.getParameter("place");
		String reward = req.getParameter("reward");
		String content = req.getParameter("content");
		String phone_number = req.getParameter("phoneNumber");
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		int member_id = mdao.getIdNum(id);

		System.out.println(type);
		System.out.println(img);
		System.out.println(description);
		System.out.println(date_and_place);
		System.out.println(date);
		System.out.println(place);
		System.out.println(reward);
		System.out.println(content);
		System.out.println(area);
		System.out.println(phone_number);
		int n = ldao.addLostAnimal(type, category, img, description, date_and_place, date, area, place, reward, content,
				phone_number, member_id);

		return "redirect:lost";
	}

	@GetMapping("/catch")
	public String goCatchBoard(Model model) {
		ArrayList<LostAnimalDTO_5> list = ldao.getCatchList();
		System.out.println(list);
		model.addAttribute("catchList", list);
		return "lost/catch";
	}

	@GetMapping("/catchPoster")
	public String goCatchPoster(HttpServletRequest req, Model model) {
		String id = req.getParameter("id");
		ArrayList<LostAnimalDTO_5> info = ldao.getCatchInfo(Integer.parseInt(id));

		model.addAttribute("animalInfo", info);
		System.out.println(info);

		ArrayList<BoardDTO> list = bdao.getComment(Integer.parseInt(id), 2);
		model.addAttribute("commentList", list);
		return "lost/catchPoster";
	}

	@GetMapping("/catchWrite")
	public String doCatchWrite(HttpServletRequest req, Model model) {
		String postId = req.getParameter("postId");
		if (postId != null && postId != "") {
			ArrayList<LostAnimalDTO_5> info = ldao.getCatchInfo(Integer.parseInt(postId));
			System.out.println("update" + info);
			model.addAttribute("catchInfo", info);
		}
		return "lost/catchWrite";
	}

	@PostMapping("/catchWrite")
	public String doCatchUpdate(HttpServletRequest req) {
		String type = req.getParameter("type");
		String state = req.getParameter("state");
		String img = req.getParameter("img");
		String date = req.getParameter("date");
		String area = req.getParameter("area");
		String place = req.getParameter("place");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String phone_number = req.getParameter("phoneNumber");
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		String name = (String) session.getAttribute("name");
		System.out.println("id + " + id);
		System.out.println("name + " + name);
		int member_id = mdao.getIdNum(id);

		System.out.println(type);
		System.out.println(img);
		System.out.println(date);
		System.out.println(place);
		System.out.println(title);
		System.out.println(content);
		System.out.println(area);
		System.out.println(phone_number);
		int n = ldao.addCatchAnimal(type, state, img, date, area, place, title, content, phone_number, member_id);

		return "redirect:catch";
	}

	@PostMapping("/addComment")
	@ResponseBody
	public String addcomment(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		int member_id = mdao.getIdNum(id);
		String comment_id = req.getParameter("commentId");
		String post_id = req.getParameter("postId");
		String content = req.getParameter("content");
		String category_id = req.getParameter("categoryId");

		System.out.println("comment_id " + comment_id);
		System.out.println("member_id " + member_id);
		System.out.println("post_id " + post_id);
		System.out.println("content " + content);
		System.out.println("category_id " + category_id);

		int n = 0;
//		새로운 댓글작성시
		if (comment_id == null || comment_id.equals("")) {
			System.out.println("add");
			n = bdao.addComment(member_id, Integer.parseInt(category_id), Integer.parseInt(post_id), content);
//		기존댓글 수정시
		} else {
			System.out.println("modify");
			n = bdao.modifyComment(Integer.parseInt(comment_id), member_id, Integer.parseInt(post_id), content);
		}

		return "" + n;
	}

	@PostMapping("/deleteComment") // 답변 삭제
	@ResponseBody
	public String qnaDelete(HttpServletRequest req) {
		String id = req.getParameter("id");
		System.out.println(id);

		int n = bdao.deleteComment(Integer.parseInt(id));
		System.out.println("delete");
		return "" + n;
	}

	@PostMapping("/getComment")
	@ResponseBody
	public String getComment(HttpServletRequest req) {
		String id = req.getParameter("id");
		String category_id = req.getParameter("categoryId");
		System.out.println("id : " + id);
		System.out.println("category_id : " + category_id);

		String pageno = "1";
		if (req.getParameter("page") != null && !req.getParameter("page").equals("")) {
			pageno = req.getParameter("page");
		}
		int page = Integer.parseInt(pageno);
		int start = (page - 1) * 10;
		ArrayList<BoardDTO> comment = bdao.getComment2(Integer.parseInt(id), Integer.parseInt(category_id), start);
		System.out.println("comment : " + comment);

		JSONArray ja = new JSONArray();
		for (int i = 0; i < comment.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("id", comment.get(i).id);
			jo.put("nickname", comment.get(i).nickname);
			jo.put("content", comment.get(i).content);
			jo.put("created", comment.get(i).created);
			jo.put("updated", comment.get(i).updated);
			ja.add(jo);
		}
		System.out.println("ja : " + ja);
		return ja.toJSONString();
	}

	@GetMapping("/volunteer")
	public String goVolunteer(Model model) {
		ArrayList<CommunityDTO_5> list = cdao.getVolunteerList();
		System.out.println(list);
		model.addAttribute("volunteerList", list);
		return "community/volunteer";
	}

	@GetMapping("/volunteerWrite")
	public String goVolunteerWrite() {
		return "community/volunteerWrite";
	}

	@GetMapping("/volunteerView")
	public String goVolunteerView(HttpServletRequest req, Model model) {
		String page = req.getParameter("page");
		ArrayList<CommunityDTO_5> info = cdao.getVolunteerInfo(Integer.parseInt(page));

		model.addAttribute("Info", info);
		System.out.println(info);
		return "community/volunteerView";
	}

	@PostMapping("/addVolunteer")
	@ResponseBody
	public String addVolunteer(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		System.out.println("id = " + id);
		int member_id = mdao.getIdNum(id);
		String title = req.getParameter("title");
		String agent = req.getParameter("agent");
		String adress = req.getParameter("adress");
		String name = req.getParameter("name");
		String phoneNumber = req.getParameter("phoneNumber");
		String recruitPeriod = req.getParameter("recruitPeriod");
		String volunteerPeriod = req.getParameter("volunteerPeriod");
		String date = req.getParameter("date");
		String time = req.getParameter("time");
		String homePage = req.getParameter("homePage");
		String img = req.getParameter("img");
		String content = req.getParameter("content");

		System.out.println("member_id = " + member_id);
		System.out.println("title = " + title);
		System.out.println("agent = " + agent);
		System.out.println("adress = " + adress);
		System.out.println("name = " + name);
		System.out.println("phoneNumber = " + phoneNumber);
		System.out.println("recruitPeriod = " + recruitPeriod);
		System.out.println("volunteerPeriod = " + volunteerPeriod);
		System.out.println("date = " + date);
		System.out.println("time = " + time);
		System.out.println("homePage = " + homePage);
		System.out.println("img = " + img);
		System.out.println("content = " + content);

		int n = 0;
		n = cdao.addVolunteer(member_id, title, agent, adress, name, phoneNumber, recruitPeriod, volunteerPeriod, date,
				time, homePage, img, content);
		return "" + n;
	}

	@GetMapping("/fosterBlog")
	public String gofosterBlog(Model model) {
		ArrayList<BoardDTO> list = bdao.getBoardList(7, 7, -1);
		System.out.println(list);
		model.addAttribute("blogList", list);
		return "community/fosterBlog";
	}

	@GetMapping("/volunteerReport")
	public String goVolunteerReport(Model model) {
//		ArrayList<LostAnimalDTO_5> list = ldao.getCatchList();
//		System.out.println(list);
//		model.addAttribute("catchList", list);
		return "community/fosterBlog";
	}


	@GetMapping("/view")
	public String goView(HttpServletRequest req, Model model) {
		String id = req.getParameter("id");
		ArrayList<BoardDTO> view = bdao.getView(Integer.parseInt(id));
		System.out.println(view);
		model.addAttribute("blogView", view);
		return "community/view";
	}
	
	private String updateSession(HttpSession session, String param, String key) {
		if (param != null && !"전체".equals(param)) {
			session.setAttribute(key, param);
			return param;
		} else {
			session.removeAttribute(key);
			return null;
		}
	}

}
