package com.study.pet.DTO;

import lombok.Data;

@Data
public class BoardDTO {
	public int id;
	int member_id;
	int board_id;
	int category;
	String name;
	public String nickname;
	public String content;
	public String created;
	public String updated;
	String title_img;
	String title;
	String state;
	String board;
}