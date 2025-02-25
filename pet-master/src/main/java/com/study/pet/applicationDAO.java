package com.study.pet;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface applicationDAO {
	int application(String name,String mobile,String substityteMobile,String email,	String gender,String age,String zipCode,String address,String detailedAddress,String job,String takeCare);
}
