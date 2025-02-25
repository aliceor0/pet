package com.study.pet;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.mysql.cj.xdevapi.Statement;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

// 윤숙정님 컨트롤러
// 훈련 및 정보 관련, 추가로 동물병원 등등.
@Controller
public class Controller_4<imageService> {

	@Autowired
	private partnerDAO_4 pdao;

	@Configuration
	public class WebMvcConfig implements WebMvcConfigurer {

		@Override
		public void addResourceHandlers(ResourceHandlerRegistry registry) {
			registry.addResourceHandler("/**").addResourceLocations("file:src/main/resources/static/");
		}
	}

	
	// 제휴 메인
	@GetMapping("/partnerMain_4")
	public String partnerMain_4(Model model) {
		ArrayList<partnerDTO_4> alpartner = pdao.partner_board();
		model.addAttribute("alpartner", alpartner);
		return "mall/partnerMain_4";
	}
	
//	@GetMapping("/partnerMain_4")
//    public String partnerMain_4(Model model,
//                                 @RequestParam(name = "page", defaultValue = "1") int page,
//                                 @RequestParam(name = "size", defaultValue = "10") int size) {
//        // 전체 게시물 수
//        int totalPosts = pdao.getTotalPosts();
//
//        // 전체 페이지 수 계산
//        int totalPages = (int) Math.ceil((double) totalPosts / size);
//
//        // 현재 페이지 번호 조정
//        if (page < 1) {
//            page = 1;
//        } else if (page > totalPages) {
//            page = totalPages;
//        }
//
//        // 현재 페이지에 해당하는 제휴업체 목록 가져오기
//        ArrayList<partnerDTO_4> alpartner = pdao.getPartnersByPage(page, size);
//
//        // 모델에 필요한 정보 추가
//        model.addAttribute("alpartner", alpartner);
//        model.addAttribute("currentPage", page);
//        model.addAttribute("totalPages", totalPages);
//
//        return "Mall/partnerMain_4";
//    }

	//제휴업체 글작성
	@GetMapping("/partnerWrite_4")
	public String partnerWrite_4() {
		return "mall/partnerWrite_4";
	}
	
	//공지게시글 삭제
	@GetMapping("/partnerDelete_4")
	public String partnerDelete(HttpServletRequest req) {
		String id = req.getParameter("id");
		int n = pdao.remove(Integer.parseInt(id));
		System.out.println("affacted row=" + n);
		return "redirect:/partnerMain_4";
	}
	
	//제휴업체
	@PostMapping("/dopartner")
	public String dopartner(@RequestParam(value = "id", required = false) String id,
			@RequestParam("category") String category, @RequestParam("title") String title,
			@RequestParam("title_img") String imagePath, @RequestParam("content") String content) {

		System.out.println("content" + content);
		int n;
		if (id == null || id.equals("")) {
			n = pdao.insert(Integer.parseInt(category), title, imagePath, content);
		} else {
			n = pdao.modify(Integer.parseInt(id), Integer.parseInt(category), title, imagePath, content);
		}
		return "redirect:/partnerMain_4";
	}

//	//글작성 정보_새글작성 및 업데이트 메서드
//	@PostMapping("/doinfo")
//	public String doinfo(@RequestParam(value = "id", required = false) String id,
//			@RequestParam("category") String category, @RequestParam("title") String title,
//			@RequestParam("title_img") String imagePath, @RequestParam("content") String content) {
//
//		System.out.println("content" + content);
//		int n;
//		if (id == null || id.equals("")) {
//			n = idao.insert(Integer.parseInt(category), title, imagePath, content);
//		} else {
//			n = idao.modify(Integer.parseInt(id), Integer.parseInt(category), title, imagePath, content);
//		}
//		return "redirect:/infoMain_4";
//	}


//		
//	//업데이트 (수정하기)
//	@GetMapping("/infoUpdate_4")
//	public String infoUpdate_4(@RequestParam("id") int id, Model model) {
//		InformationDTO idto = idao.infoView_4(id);
//		String content = idto.getContent().replace("/final_img/", "/temp_img/");
//		idto.setContent(content);
//		model.addAttribute("information_board", idto);
//		System.out.println("up:" + idto);
//		return "information/infoUpdate_4";
//	}
//
//		

//	
//	//공지사항 view
//	@GetMapping("/infoView_4")
//	public String infoView_4(@RequestParam("id") int id, Model model) {
//		InformationDTO idto = idao.infoView_4(id);
//		model.addAttribute("information_board", idto);
//		return "information/infoView_4";
//	}
//
//
//	//공지게시글 삭제
//	@GetMapping("/infoDelete_4")
//	public String doDelete(HttpServletRequest req) {
//		String id = req.getParameter("id");
//		int n = idao.remove(Integer.parseInt(id));
//		System.out.println("affacted row=" + n);
//		return "redirect:/infoMain_4";
//	}
	
}






/*
 * @PostMapping("/deleteImage") public ResponseEntity<Object>
 * deleteImage(@RequestBody String imagePath) { try { // 이미지 파일 경로로부터 실제 파일을
 * 삭제합니다. File file = new File(imagePath); if (file.delete()) { return
 * ResponseEntity.ok().build(); // 이미지 파일 삭제 성공 시 200 OK 반환 } else { return
 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).
 * body("Failed to delete image."); // 삭제 실패 시 500 에러 반환 } } catch (Exception e)
 * { return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).
 * body("An error occurred while deleting the image: " + e.getMessage()); } }
 */

//	  @PostMapping("/doinfo") public String doinfo(@RequestParam("id") String
//	  id, @RequestParam("title") String title,
//	  
//	  @RequestParam("content") String content, @RequestParam("info_image1")
//	  MultipartFile info_image1,
//	  
//	  @RequestParam("info_cont2") String info_cont2, @RequestParam("info_image2")
//	  MultipartFile info_image2,
//	  
//	  @RequestParam("info_cont3") String info_cont3, @RequestParam("info_image3")
//	  MultipartFile info_image3,
//	  
//	  @RequestParam("info_writer") String info_writer, HttpServletRequest req,
//	  HttpServletResponse res) throws IOException {
//	  
//	  // 현재 시간 생성 LocalDateTime currentTime = LocalDateTime.now();
//	  
//	  // 현재 시간을 원하는 형식으로 변환하여 문자열로 사용 DateTimeFormatter formatter =
//	  DateTimeFormatter.ofPattern("yyyy-MM-dd"); 
//	  String created = currentTime.format(formatter);
//	  
//	  System.out.println("title" + title);
//	  System.out.println("content" + content);
//	  System.out.println("info_cont2" + info_cont2);
//	  System.out.println("info_cont3" + info_cont3);
//	  System.out.println("info_writer" + info_writer); System.out.println("created"
//	  + created); req.setCharacterEncoding("UTF-8");
//	  res.setContentType("text/html; charset=UTF-8");
//	  
//	  String savePath ="C:\\Users\\1234\\git\\pet\\src\\main\\resources\\static\\image"; 
//	  String uploadFolderPath = Paths.get(savePath).toString();
//	  System.out.println("uploadFolderPath:" + uploadFolderPath);
//	  
//	  String[] imagePaths = new String[3]; MultipartFile[] imageFiles = {info_image1, info_image2, info_image3 }; 
//	  for (int i = 0; i <imageFiles.length; i++) { MultipartFile file = imageFiles[i]; 
//	  	if (file !=null && !file.isEmpty()) { 
//		  // 원본 파일 이름 가져오기 
//				  String info_image = file.getOriginalFilename(); // 덮어쓰기를 방지하기 위해 고유 파일 이름 생성 
//				  String ori_file_name= System.currentTimeMillis() + "_" + info_image; // 서버에 파일 저장 
//				  
//				 
//				  String filePath = Paths.get(uploadFolderPath,ori_file_name).toString();  // 이미지 파일 경로 저장 
//				  System.out.println("Uploaded File Path: " + filePath); file.transferTo(new File(filePath));
//				  imagePaths[i] = ori_file_name; } 
//	  else { // 이미지가 없는 경우 경로를 null로 설정 
//		  imagePaths[i] = null; } }
//	  }
//	  
//	  
//	  // 추가 로직: for (String imagePath : imagePaths) {
//	  System.out.println("Uploaded File Name: " + imagePath); }
//	  
//	  int n; if (id == null || id.equals("")) { n =
//	  idao.insert(title, content, imagePaths[0], info_cont2, imagePaths[1],
//	  info_cont3, imagePaths[2], info_writer, created); } else { // 수정 로직 구현 }
//	  return "redirect:/infoWrite_4"; }

//	 @PostMapping("/doinfo")
//	 public String doinfo(@RequestParam(value = "id", required = false) String id,
//			 			@RequestParam("content") String content) {
//		 
//		 System.out.println("content" + content);
//		 int n;
//			if (id == null || id.equals("")) {
//				n = idao.insert(content);
//			}
//	        return "redirect:/infoWrite_4";
//			}