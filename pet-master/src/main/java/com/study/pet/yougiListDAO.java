package com.study.pet;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.pet.DAO.BoardDAO;
import com.study.pet.DTO.BoardDTO;

@Mapper
public interface yougiListDAO {
   
   ArrayList<yougiListDTO> deDetailView(int id);
   int total();

   
   ArrayList<yougiListDTO> yougiList(int start, String type, int category);
   
   int addParcelOut(int category, String state, String image,String type,String temporaryName,String color, String age, String weight,String gender, int member_id);
   
   
   int modify_1(int id,int category, String state,String image,String type, String temporaryName,String color,  String age,String weight,String gender, int member_id);
   
   
   int doDelete_1(int id);

   
   int change_1(int state,int id);
   BoardDTO infoView_4(String id);
}