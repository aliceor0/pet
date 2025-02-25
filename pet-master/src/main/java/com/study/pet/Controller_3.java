package com.study.pet;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

// 김진명님 컨트롤러
// 로그인 회원가입 기능구현
@Controller
public class Controller_3 {

    @Autowired
    private DAO_3 dao_3;

    @GetMapping("/naver")
    public String naverlogin() {
    	return "include/naverLogin";
    }
    @GetMapping("/naver2")
    public String naverlogin_2() {
    	return "include/naverLogin_2";
    }
    @GetMapping("/naver3")
    public String naverlogin_3() {
    	return "include/naverLogin_3";
    }
    @GetMapping("/callback")
    public String callback() {
    	return "callback";
    }
    @GetMapping("/callback2")
    public String callback2() {
    	return "callback2";
    }
    @GetMapping("/login")
    public String doLogin() {
        return "loginPage/login";
    }
    @GetMapping("/signup")
    public String doSignup() {
        return "loginPage/signup";
    }
    @GetMapping("/Find_Id_Pw") //아이디 비번창 이동
    public String doFind_Id(HttpServletRequest req) {
        String key = req.getParameter("key"); // key 값 가져오기
        if ("1".equals(key)) { //들어온값이 1이면 아이디찾기
            return "loginPage/Find_Id_Pw";
        } else if ("2".equals(key)) { //들어온값이 2이면 비밀번호찾기
            return "loginPage/Find_Id_Pw2";
        }

        return "loginPage/login";
    }
    
  //salt생성(비번암호화코드)
    public static String Salt() {
			
			String salt="";
			try {
				SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
				byte[] bytes = new byte[16];
				random.nextBytes(bytes);
				salt = new String(Base64.getEncoder().encode(bytes));
				
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
			return salt;
		}
	
    //sha512(비번암호화코드)
	public static String SHA512(String password, String hash) {
		String salt = hash+password;
		String hex = null;
		
		try {

			MessageDigest msg = MessageDigest.getInstance("SHA-512");
			msg.update(salt.getBytes());
			
			hex = String.format("%128x", new BigInteger(1, msg.digest()));
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return hex;
	}
	
	
	
    @PostMapping("/doLogin_3") //로그인
    @ResponseBody
    public String dologin(HttpServletRequest req) {
//    	String salt = Salt();
        String user_id = req.getParameter("user_id"); //로그인 창 로그인값
        String passwd = req.getParameter("passwd");  //로그인 창 비밀번호 값
        if(dao_3.idchk(user_id)!=1) {
        	return "";
        }
        String saltpass = dao_3.getSalt(user_id).password;  //아이디에 맞는 소금비번을 가져옴
        String salt = dao_3.getSalt(user_id).salt;  //해당 아이디의 소금을 가져옴
        String pw_decrypt = SHA512(passwd, salt); //로그인 창 비밀번호를 해당계정의 소금으로 비벼봄
        System.out.println("로그인비번"+pw_decrypt);
        System.out.println(saltpass.equals(pw_decrypt)); //로그인창 소금비번이랑 계정의 소금비번을 비교
        HttpSession sess = req.getSession();
        int n = dao_3.doLogin(user_id, pw_decrypt);
        if (saltpass.equals(pw_decrypt)) {
            String nickname = dao_3.getNickname(user_id, pw_decrypt).nickname; // DTO_3 객체에서 닉네임을 가져옴
            sess.setAttribute("name", nickname); // 사용자 이름만 세션에 저장
            System.out.println(nickname);
            sess.setAttribute("id", user_id); // 사용자 이름만 세션에 저장
            System.out.println(user_id);
            sess.setMaxInactiveInterval(1800);
            return "" + n;
        } else {
            return "";
        }
    }
    @PostMapping("/doSignup_3") //회원가입
    @ResponseBody
    public String goSignup(HttpServletRequest req) {
        String user_id = req.getParameter("user_id");
        String password = req.getParameter("password");
        String nickname = req.getParameter("userNickname");
        String name = req.getParameter("name");
        String mobile = req.getParameter("mobile"); 
        String mail = req.getParameter("mail"); 
        String birth = req.getParameter("birth"); 
        String adress = req.getParameter("adress"); 
        String zipcode = req.getParameter("zipcode"); 
        String gender = req.getParameter("gender"); 
        String adress2 = req.getParameter("adress2"); 
        
        String salt = Salt(); //암호키 생성
		System.out.println("(salt 생성 완료="+salt+")");
		String pw_encrypt = SHA512(password, salt); //들어온 비밀번호와 암호키를 합체
		System.out.println("(암호화된 비밀번호이자 db에 저장될 문자열="+pw_encrypt+")");
		
        int n = dao_3.doSignup(user_id,nickname , pw_encrypt, name,mobile,mail,birth,gender,zipcode,adress,adress2, salt);
        return "" + n;
    }
    
    
    @PostMapping("/doApiSignup_3") //API SNS 전용 회원가입
    @ResponseBody
    public String goApiSignup(HttpServletRequest req) {
        String user_id = req.getParameter("user_id");
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        String nickname = req.getParameter("userNickname");
        String mobile = req.getParameter("mobile"); 
        String mail = req.getParameter("mail"); 
        String birth = req.getParameter("birth"); 
        String adress = req.getParameter("adress"); 
        String zipcode = req.getParameter("zipcode");
        String gender = req.getParameter("gender");
        String adress2 = req.getParameter("adress2");
        int n = dao_3.doApiSignup(user_id, nickname, password, name,mobile,mail,birth,gender,zipcode,adress,adress2);
        return "" + n;
    }

    @PostMapping("/logout") //로그아웃
    @ResponseBody
    public String dologout(HttpServletRequest req) {
        HttpSession sess = req.getSession();
        sess.invalidate();
        return "1";
    }
    @PostMapping("/getMail") //db이메일과 salt를 가져오는
    @ResponseBody
    public String getMail(HttpServletRequest req) {
        String mail = req.getParameter("mail");
        DTO_3 getUser = dao_3.getEmail(mail); //이메일에맞는 유저id를 가져옴
        if(getUser==null) { //유저아이디가 없으면 3을반환
        	return"3";
        }
        String getUser_2 = getUser.user_id;	//dto에담긴 유저id꺼내오기
        String salt = getUser.salt; 		//dto에 담긴 소금꺼내오기
        if(salt==null||salt.equals("")) { //만약 소금이존재하지않으면 sns이메일
        	return "1";
        }
        // ID의 길이를 확인하여 가운데 일부를 '*'로 변경
        int length = getUser_2.length();
        int start = (length - 2) / 2; // '*'로 가려질 부분의 시작 인덱스
        int end = start + 2; // '*'로 가려질 부분의 끝 인덱스
        String maskedID = getUser_2.substring(0, start) + "**" + getUser_2.substring(end);

        return maskedID;
    }
    @PostMapping("/Check_Mail_Id") //db이메일과 id를 체크해 1을반환
    @ResponseBody
    public String Check_Mail_Id(HttpServletRequest req) {
    	String mail = req.getParameter("mail");
    	String id = req.getParameter("id");
    	int n  = dao_3.id_mail_chk(mail,id); //1을반환한다면 인증된메일과 아이디는 db에 담겨있다
    	if(n==1) {
    		return "1";
    	}else {
    		return "";
    	}
    }
    @PostMapping("/resetPass") //비번초기화
    @ResponseBody
    public String resetPass(HttpServletRequest req) {
    	String id = req.getParameter("id");
    	String newPass=req.getParameter("newPass");
    	String salt = Salt(); //암호화키 생성
		System.out.println("(salt 생성 완료="+salt+")");
		String pw_encrypt = SHA512(newPass, salt); //새로운비밀번호와 암호화키를 합체
		System.out.println("(암호화된 비밀번호이자 db에 저장될 문자열="+pw_encrypt+")");
    	int n = dao_3.updatePass(id, pw_encrypt,salt); //db에 새로운 암호화키와 비밀번호를 해당ID에넣기
    	return "" + n;
    }

    
    
    
    @PostMapping("/idcheck") //아이디 중복체크
    @ResponseBody
    public String doIdcheck(HttpServletRequest req) {
        String user_id = req.getParameter("user_id");
        int n = dao_3.idchk(user_id);
        return "" + n;
    }
    
    @PostMapping("/nicknamecheck") //닉네임 중복체크
    @ResponseBody
    public String doNickNamecheck(HttpServletRequest req) {
        String userNickname = req.getParameter("userNickname");
        int n = dao_3.Nicknamechk(userNickname);
        return "" + n;
    }
    

	@PostMapping("/APIidcheck") //API전용 아이디 중복체크
	@ResponseBody
	public String doApiIdcheck(HttpServletRequest req) {
	    String user_id = req.getParameter("user_id");
	    String mail = req.getParameter("mail");
	    HttpSession sess = req.getSession();
	    sess.setAttribute("id", user_id); // 사용자 이름만 세션에 저장
        String name = dao_3.getApiName(user_id); // DTO_3 객체에서 이름을 가져옴
        sess.setAttribute("name", name); // 사용자 이름만 세션에 저장
        sess.setAttribute("mail", mail); // 사용자 메일만 세션에 저장
	    int n = dao_3.idchk(user_id);
	    return "" + n;
	}
	
	
}