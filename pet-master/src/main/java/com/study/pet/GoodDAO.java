package com.study.pet;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GoodDAO {
	ArrayList<GoodDTO> itemList(int id);
	ArrayList<GoodDTO> itemLista();
	ArrayList<GoodDTO> itemInfo(int id);
	ArrayList<GoodDTO> getCart(String id);
	int checkCart(int a, int b);
	int addCart(int a, int b, int c);
	int getIdNum(String a);
	GoodDTO cartOrder(int a);
	int delCart(int value);
	int updateCart(int a, int b);
	int addOrder(int a, int b, int c, int d, int e);
	int saveOrder(String a, String b, String c, String d, String e, String f, int g,
			int h);
	int getOrderId(String a, String b, String c, String d, String e, String f, int g,
			int h);
	
	
	//관리자 영역
	ArrayList<GoodDTO> list();
	int remove(int x);
	ArrayList<GoodDTO> getOrderList(int id);
	ArrayList<GoodDTO> tkcategory();
	int upd(int id, int category,String title,int price, int stock,int delivery,int discnt);
	GoodDTO view(int x);
	int goodsAdd(int Category_id, String title, int price,int discnt, int stock, String img, String img2, String img3, String img4, String img5, String content,int delivery);
	

}
