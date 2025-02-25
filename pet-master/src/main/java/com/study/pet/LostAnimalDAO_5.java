package com.study.pet;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface LostAnimalDAO_5 {
	ArrayList<LostAnimalDTO_5> getLostInfo(int id);
	ArrayList<LostAnimalDTO_5> getLostList(String status, String animal, String area, String sort, int i);
	int addLostAnimal(String sType, int category, String sImg, String sDescription, String sDate_and_place, String sDate, String sPlace, String sReward, String content, String sMessage, String sPhone_number, int member_id);
	
	ArrayList<LostAnimalDTO_5> getCatchInfo(int id);
	ArrayList<LostAnimalDTO_5> getCatchList();
	int addCatchAnimal(String type, String state, String img, String date, String area, String place, String title, String content, String phone_number, int member_id);
	
}
