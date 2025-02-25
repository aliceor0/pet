package com.study.pet;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface partnerDAO_4 {

	int insert(int parseInt, String title, String imagePath, String content);

	int modify(int parseInt, int parseInt2, String title, String imagePath, String content);

	ArrayList<partnerDTO_4> partner_board();

	int remove(int parseInt);

	/*
	 * int getTotalPosts();
	 * 
	 * ArrayList<partnerDTO_4> getPartnersByPage(int page, int size);
	 */
	

}
