package com.study.pet;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DAO_3 {
	int doSignup(String user_id,String nickname, String password, String name, String mobile, String mail, String birth, String gender,String zipcode, String adress, String adress2, String salt); //회원가입
	int doApiSignup(String user_id,String nickname, String password, String name, String mobile, String mail, String birth, String gender,String zipcode, String adress, String adress2 ); //sns회원가입
	int doLogin(String user_id, String password); //로그인
	int id_mail_chk(String mail, String user_id); //아이디와 메일을받아 체크
	int updatePass(String user_id, String password,String salt); //비번업데이트
	DTO_3 getEmail(String mail);//이메일과 salt를 가져옴
	DTO_3 getName(String user_id, String password); //이름만 가져옴
	DTO_3 getNickname(String user_id, String password); //닉네임만 가져옴
	String getApiName(String user_id); //API로그인 닉네임만 가져옴
	DTO_3 getSalt(String user_id); //소금과 비번을 가져옴
	int idchk(String user_id); // 아이디 중복체크
	int Nicknamechk(String nickname); // 닉네임 중복체크
}