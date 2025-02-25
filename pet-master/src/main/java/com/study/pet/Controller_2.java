package com.study.pet;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


// 권오림님 컨트롤러
// 입양파트 관련 
@Controller
public class Controller_2 {

	@GetMapping("/OpenApi")
	public String home() {
		return "OpenApi";
	}
		
//  jps_입양절차안내
	@GetMapping("/adoption/process")
	public String adoptionProcess() {
		return "adoption/adoptionProcess";
	}

//  jps_동물등록제안내
	@GetMapping("/adoption/registration")
	public String adoptionRegistration() {
		return "adoption/adoptionRegistration";
	}

	// API 연동
	@GetMapping("/adoption/list")
	public String AdoptionOpenApi() {
		return "adoption/AdoptionOpenApi";
	}
	
	// 유기동물 상세정보
	@GetMapping("/adoption/view")
	public String adoptionApiView() {
		return "adoption/adoptionApiView";
// >>>>>>> branch 'master' of https://github.com/kekekekekekekike/pet.git
	}
	
	// 동물병원 검색
	@GetMapping("/hospitalSearch")
	public String hospitalSearch() {
		return "adoption/hospitalSearch";
	}
//	// 카카오맵 API 
//	@GetMapping("/mapApi")
//	public String mapApi() {
//		return "adopt/mapApi";
//	}

}
