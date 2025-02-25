package com.study.pet;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.study.pet.DAO.BoardDAO;
import com.study.pet.DTO.BoardDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

// 통합 게시판 컨트롤러 [1.입양후기, 2.임시보호블로그, 3.자원봉사후기, 4.반려동물정보, 5.기초훈련정보]
@Controller
public class BoardController {
	
	@Autowired
	private BoardDAO bdao;
	@Autowired
	private MemberDAO mdao;
	@Autowired
	private CommunityDAO_5 cdao;
	private final static String rootPath = System.getProperty("user.dir");
	
	
	@Configuration
	public class WebMvcConfig implements WebMvcConfigurer {
		@Override
		public void addResourceHandlers(ResourceHandlerRegistry registry) {
			registry.addResourceHandler("/**").addResourceLocations("file:src/main/resources/static/");
		}
	}
	
	
	/**           1.입양관련 게시판 시작           **/
	// 입양후기 목록조회
	@GetMapping("/adoption/reviews")
	public String adoptionReviews(HttpServletRequest req, Model model) {
		ArrayList<BoardDTO> reviewList = bdao.getBoardList(1, 1, -1);
		int total = reviewList.size();
		System.out.println("total : " + total);
		
		Object[] pageInfo = Controller_1.showPage(total, req.getParameter("page"));
		int start = (int) pageInfo[1];

		reviewList = bdao.getBoardList(1, 1, start);

		model.addAttribute("reviewList", reviewList);
//		System.out.println(reviewList);
		
		model.addAttribute("pageNumber", pageInfo[0]); // 페이지 번호 리스트
		model.addAttribute("start", start); // 시작 페이지
		model.addAttribute("page", pageInfo[2]); // 현재 페이지
		model.addAttribute("lastpage", pageInfo[3]); // 마지막 페이지
		System.out.println("start" + start);
		System.out.println("page" + pageInfo[2]);
		System.out.println("lastpage" + pageInfo[3]);
		
		return "adoption/adoptionReviews";
	}
	
	// 특정 게시물 조회
	@GetMapping("/adoption/reviews/{id}")
	public String showDetail(@PathVariable("id") int id, Model model) {

		System.out.println("id : " + id);
		System.out.println("root" + rootPath);
		BoardDTO info = bdao.showDetail(1, 1, id);
		if (info == null) {
			return "404에러페이지";  // 에러 페이지를 리턴
		}
		
		model.addAttribute("view", info);
		System.out.println(info);
		
		ArrayList<BoardDTO> list = bdao.getComment(id, 1);
		System.out.println("list=" + list);
		model.addAttribute("commentList", list);
		
		
		return "adoption/view";
	}
	
	// 글쓰기페이지 및 게시물 작성은 공통양식 사용
	/**           입양관련 게시판 끝           **/
	
	/**           훈련 및 정보 게시판 시작           **/
	// 훈련및정보 메인
	@GetMapping("/information")
	public String infoMain_4(Model model) {
		ArrayList<BoardDTO> alinfo = bdao.getBoardList(13, 14, -1);
		model.addAttribute("alinfo", alinfo);
		return "information/main";
	}
	
	//반려동물정보
	@GetMapping("/information/animal")
	public String infoMain1_4(Model model) {
		ArrayList<BoardDTO> alinfo = bdao.getBoardList(13, 13, -1);
		model.addAttribute("alinfo", alinfo);
		return "information/animal";
	}
	
	//기초훈련정보
	@GetMapping("/information/traning")
	public String infoMain2_4(Model model) {
		ArrayList<BoardDTO> alinfo = bdao.getBoardList(14, 14, -1);
		model.addAttribute("alinfo", alinfo);
		return "information/traning";
	}
	
	// 정보파트 상세페이지 
	@GetMapping("/information/{category}/{id}")
	public String showDetail(@PathVariable("category") String category, @PathVariable("id") int id, Model model) {
		int categoryNum = "traning".equals(category) ? 14 : 13;
		
		// 잘못된 카테고리 값에 대한 처리
		if (!category.equals("traning") && !category.equals("animal")) {
	        return "404에러페이지";  // 에러 페이지를 리턴
	    }
		
		System.out.println("id : " + id);
		System.out.println("cateNum : " + categoryNum);
		
		BoardDTO info = bdao.showDetail(categoryNum, categoryNum, id);
		if (info == null) {
			return "404에러페이지";  // 에러 페이지를 리턴
		}
		
		model.addAttribute("view", info);
		System.out.println(info);
		return "information/view";
	}
	
	// 경기도 병원 및 전국보호소 api
	@GetMapping("/information/hospital")
	public String htest() {
		return "information/hospital";
	}
	
	
	/**           훈련 및 정보 게시판 끝           **/

	@GetMapping("/{board}/new")
	public String goWrite(@PathVariable("board") String board, Model model) {

		if (!List.of("adoption", "community", "information").contains(board)) {
			return "404에러페이지로"; // 또는 적절한 에러 페이지로 리다이렉트
		}

		ArrayList<categoryDTO_4> category = bdao.category();
		model.addAttribute("categoryList", category);
		model.addAttribute("board", board);
		System.out.println(category);
		System.out.println(board);
		return "community/write";
	}
	
	@GetMapping("/{board}/edite/{id}")
	public String goEdite(@PathVariable("board") String board, @PathVariable("id") int id, Model model) {
		int categoryNum1 = 0;
		int categoryNum2 = 0;

		if (board.equals("adoption")) {
		    categoryNum1 = categoryNum2 = 1;
		} else if (board.equals("community")) {
		    categoryNum1 = 9;
		    categoryNum2 = 12;
		} else if (board.equals("information")) {
		    categoryNum1 = 13;
		    categoryNum2 = 14;
		} else {
		    return "404 에러페이지로";
		}

		BoardDTO info = bdao.showDetail(categoryNum1, categoryNum2, id);
		if (info == null) {
			return "404에러페이지";  // 에러 페이지를 리턴
		}
		
		String content = info.getContent().replace("/final_img/", "/temp_img/");
		info.setContent(content);
		
        List<String> imageFileNames = new ArrayList<>();
        Pattern pattern = Pattern.compile("/temp_img/([^/]+\\.\\w+)");
        Matcher matcher = pattern.matcher(content);
        
        while (matcher.find()) {
            imageFileNames.add(matcher.group(1));
        }
		
        moveImagesToMain(imageFileNames, board, String.valueOf(id));
		model.addAttribute("view", info);
		System.out.println(info);
		model.addAttribute("board", board);
		System.out.println(board);
		
		return "community/edite";
	}

	@PostMapping("/{board}/new")
	@ResponseBody
	public String doWrite(HttpServletRequest req, @PathVariable("board") String board, @RequestBody Map<String, Object> requestData) {
		
	    HttpSession session = req.getSession();
	    String user_id = (String) session.getAttribute("id");
	    int member_id = mdao.getIdNum(user_id);
	    
		String content = (String) requestData.get("content");
		String id = (String) requestData.get("id");
		String category = (String) requestData.get("category");
		String title = (String) requestData.get("title");
		String title_img = (String) requestData.get("title_img");
		List<String> imageFileNames = (List<String>) requestData.get("imageFileNames");
		String operationType = (String) requestData.get("operationType");

		System.out.println("content" + content);
		System.out.println("id" + id);
		System.out.println("category" + category);
		System.out.println("title" + title);
		System.out.println("title_img" + title_img);
		System.out.println("imageFileNames" + imageFileNames);
		System.out.println("operationType" + operationType);

		moveImagesToMain(imageFileNames, operationType, id);
		int n = bdao.insertBoard(Integer.parseInt(category), title, title_img, content, member_id);
		return "" + n;
	}
	
	@PutMapping("/{board}/edite")
	@ResponseBody
	public String goUpdate(HttpServletRequest req, @PathVariable("board") String board, @RequestBody Map<String, Object> requestData) {
		
	    HttpSession session = req.getSession();
	    String user_id = (String) session.getAttribute("id");
	    int member_id = mdao.getIdNum(user_id);
	    
		String content = (String) requestData.get("content");
		String id = (String) requestData.get("id");
		String category = (String) requestData.get("category");
		String title = (String) requestData.get("title");
		String title_img = (String) requestData.get("title_img");
		List<String> imageFileNames = (List<String>) requestData.get("imageFileNames");
		String operationType = (String) requestData.get("operationType");

		System.out.println("content" + content);
		System.out.println("id" + id);
		System.out.println("category" + category);
		System.out.println("title" + title);
		System.out.println("title_img" + title_img);
		System.out.println("imageFileNames" + imageFileNames);
		System.out.println("operationType" + operationType);

		int n = bdao.modifyBoard(Integer.parseInt(id), Integer.parseInt(category), title, title_img, content);
		id = "";
		moveImagesToMain(imageFileNames, operationType, id);
		return "" + n;
	}
	
	
	//카테고리 분류
	@PostMapping("/category")
	@ResponseBody
	public String category() {
		ArrayList<categoryDTO_4> alcategory = bdao.category();
		System.out.println("size" + alcategory.size());

		JSONArray ja = new JSONArray();
		for (int i = 0; i < alcategory.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("id", alcategory.get(i).getId());
			jo.put("name", alcategory.get(i).getName());
			jo.put("state", alcategory.get(i).getState());
			ja.add(jo);
		}
		return ja.toJSONString();
	}
	
	
	@PostMapping("/titleuploadImage")
	public ResponseEntity<?> titleuploadImage(@RequestParam("file") MultipartFile file,
	                                          @RequestParam("boardType") String boardType) {
	    try {
	        String savePath = rootPath + "\\src\\main\\resources\\static\\image_" + boardType + "\\title_img";

	        String uploadFolderPath = Paths.get(savePath).toString();
	        String imageName = file.getOriginalFilename();
	        String imageFileName = UUID.randomUUID().toString() + "_" + imageName;
	        String filePath = Paths.get(uploadFolderPath, imageFileName).toString();
	        file.transferTo(new File(filePath));

	        return ResponseEntity.ok().body(Map.of("success", true, "imageFileName", imageFileName));
	    } catch (IOException e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false, "message", "Error occurred while uploading image"));
	    }
	}


	// 이미지 업로드
	@PostMapping("/uploadImage")
	public ResponseEntity<?> uploadImage(@RequestParam("file") MultipartFile file,
	                                     @RequestParam("boardType") String boardType) {
	    try {
	        String savePath = rootPath + "\\src\\main\\resources\\static\\image_" + boardType + "\\temp_img";

	        String uploadFolderPath = Paths.get(savePath).toString();
	        String imageName = file.getOriginalFilename();
	        String imageFileName = UUID.randomUUID().toString() + "_" + imageName;
	        String filePath = Paths.get(uploadFolderPath, imageFileName).toString();

	        // 이미지 크기 조정
	        BufferedImage originalImage = ImageIO.read(file.getInputStream());
	        int width = (int) (30 * 25.4); // 20 cm를 픽셀로 변환
	        int height = (int) (20 * 25.4);
	        Image resizedImage = originalImage.getScaledInstance(width, height, Image.SCALE_SMOOTH);
	        BufferedImage resizedBufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
	        resizedBufferedImage.getGraphics().drawImage(resizedImage, 0, 0, null);
	        // 조절된 이미지 저장
	        ImageIO.write(resizedBufferedImage, "jpg", new File(filePath)); // 이미지를 JPEG 파일로 저장합니다.

	        // 이미지 업로드 성공 시, 이미지 파일 경로를 응답합니다.
	        return ResponseEntity.ok().body(Map.of("success", true, "imageFileName", imageFileName));
	    } catch (IOException e) {
	        e.printStackTrace();
	        // 업로드 실패 시, 내부 서버 오류를 응답합니다.
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false));
	    }
	}
	
	// 이미지 이동시켜주는 메소드
	public static ResponseEntity<?> moveImagesToMain(@RequestBody List<String> imageFileNames,
			@RequestParam("storageType") String storageType, @RequestParam("id") String id) {
		try {
			System.out.println("List : " + imageFileNames);

			String srcDirPath = rootPath + "\\src\\main\\resources\\static\\image_" + storageType;
			String destDirPath = rootPath + "\\src\\main\\resources\\static\\image_" + storageType;
			
			System.out.println("id : " + id);
			if (id == null || id.isEmpty()) {
				System.out.println("new");
			    srcDirPath += "\\temp_img";
			    destDirPath += "\\final_img";
			} else {
				System.out.println("edite");
			    srcDirPath += "\\final_img";
			    destDirPath += "\\temp_img";
			}
	        
			for (String imageName : imageFileNames) {
				File srcFile = new File(srcDirPath + File.separator + imageName);
				File destFile = new File(destDirPath + File.separator + imageName);

				if (srcFile.exists()) {
					Files.move(Paths.get(srcFile.getAbsolutePath()), Paths.get(destFile.getAbsolutePath()),
							StandardCopyOption.REPLACE_EXISTING);
					System.out.println("movetoMain: " + imageName);
				}
			}
			return ResponseEntity.ok().body(Map.of("success", true));
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false));
		}
	}

}
