package com.study.pet;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class DTO_3 {
	String user_id;
	String password;
	String name;
	String nickname;
	String mobile;
	String mail;
	String birth;
	String gender;
	String join_day;
	String out_day;
	String zipcode;
	String adress;
	String adress2;
	int member_rank;
	String salt;
}