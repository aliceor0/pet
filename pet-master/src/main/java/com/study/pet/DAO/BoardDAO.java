package com.study.pet.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.pet.categoryDTO_4;
import com.study.pet.DTO.BoardDTO;

@Mapper
public interface BoardDAO {
	ArrayList<BoardDTO> getComment(int id, int category_id);
	int addComment(int user_id, int category_id, int post_id, String content);
	int modifyComment(int comment_id, int user_id, int post_id, String content);
	int deleteComment(int id);
	ArrayList<BoardDTO> getReply(int super_id);
	
	int pagetotal(int post_id);
	ArrayList<BoardDTO> getComment2(int id, int category_id,int start);
	
	ArrayList<BoardDTO> getBoardList(int category, int category2, int i);
	int insertBoard(int parseInt, String title, String imagePath, String content, int member_id);
	ArrayList<BoardDTO> getView(int parseInt);

	
	ArrayList<BoardDTO> infoMain_4();


	BoardDTO showDetail(int categoryNum1, int categoryNum2, int id);

	int modify(int p1, int p2, String p3,String p4, String p5);

	int remove(int id);
	
	ArrayList<categoryDTO_4> category();
	int modifyBoard(int parseInt, int member_id, String title_img, String content, String title);
	
	
}