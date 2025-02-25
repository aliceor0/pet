package com.study.pet;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface MemberDAO {
	int getIdNum(String a);
	ArrayList<MemberDTO> getInfo(String a);
	
	
	//쇼핑몰 결제 관련 추가
	ArrayList<MemberDTO> myLoad(String userId);
	ArrayList<MemberDTO> list();
	
}
