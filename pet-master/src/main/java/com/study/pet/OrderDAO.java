package com.study.pet;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;


//관리자 영역
@Mapper
public interface OrderDAO {
	ArrayList<OrderDTO> list(int x);
	int updatestate(int a, int b);
	ArrayList<OrderDTO> orderlist(int x);
}
