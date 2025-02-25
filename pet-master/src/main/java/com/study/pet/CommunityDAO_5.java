package com.study.pet;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommunityDAO_5 {
	ArrayList<CommunityDTO_5> getVolunteerList();
	int addVolunteer(int member_id, String title, String agent, String adress, String name, String phoneNumber, String recruitStart,
			String recruitEnd, String volunStart, String volunEnd, String date, String time, String homePage);
	ArrayList<CommunityDTO_5> getVolunteerInfo(int id);

}