package com.study.pet;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
@Controller
public class mallcontroller {
	
	@Autowired
	private GoodDAO gdao;
	
	@Autowired
	private MemberDAO mdao;
	
	
	
	@GetMapping("/petFood")
	public String petFood(Model model) {
		ArrayList<GoodDTO> petFood = gdao.itemList(15);//음식
		System.out.println(petFood);
		model.addAttribute("petFood", petFood);
		return "mall/petFood";
	}
	
	@GetMapping("/petAll")
	public String petAll(Model model) {
		ArrayList<GoodDTO> petAll = gdao.itemLista();//전체
		System.out.println(petAll);
		model.addAttribute("petAll", petAll);
		return "mall/petAll";
	}
	@GetMapping("/petSupplies")
	public String petClothes(Model model) {
		ArrayList<GoodDTO> petSupplies = gdao.itemList(14);//의류
		System.out.println(petSupplies);
		model.addAttribute("petSupplies", petSupplies);
		return "mall/petSupplies";
	}
	@GetMapping("/detail")
	public String goodsView(@RequestParam("id") String id,Model model) {
	    System.out.println(id);
	    ArrayList<GoodDTO> item = gdao.itemInfo(Integer.parseInt(id));
		System.out.println(item);
		model.addAttribute("itemInfo", item);
		return "mall/detail";
	}
	
	
	@GetMapping("/cart")
	public String getCart(HttpServletRequest req,Model model) {
		HttpSession session = req.getSession();
			    
		String id = (String) session.getAttribute("id");
			    
		if (id != null) {
			ArrayList<GoodDTO> cartItems = gdao.getCart(id);
			model.addAttribute("cartItems", cartItems);
			return "mall/cart";
		}
		return "mall/cart";
	}
	
	@PostMapping("/addCart")
	@ResponseBody
	public String addCart(HttpServletRequest req) {
		String user_id = req.getParameter("member_id");
		System.out.println("user_id : " + user_id);
		int member_id = gdao.getIdNum(user_id);
				
		String goods_id = req.getParameter("goods_id");
		String cnt = req.getParameter("cnt");
		int m = gdao.checkCart(member_id, Integer.parseInt(goods_id));
		System.out.println("member_id : " + member_id);
		System.out.println("goods_id : " + goods_id);
		System.out.println("cnt : " + cnt);
		if(m == 0) {
			int n = gdao.addCart(member_id, Integer.parseInt(goods_id), Integer.parseInt(cnt));
			System.out.println("n:" + n);
			return "" + n;
		} else {
			System.out.println("m:" + m);
			return ""+0;
		}
				
	}
	
	
	@GetMapping("/order")
	public String getOrder(HttpServletRequest req,Model model) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		System.out.println("id는="+id);
		String goods_id = req.getParameter("goodsNumber");
		String cnt = req.getParameter("result");
		String price = req.getParameter("goodsPrice");
		String cart_id = req.getParameter("sendOrder");

		ArrayList<GoodDTO> cartItems = new ArrayList<>();
			
		System.out.println("cart_id : " + cart_id);
		System.out.println("goods_id : " + goods_id);
		System.out.println("id : " + id);
		if (goods_id != null) { // 상세페이지에서 온경우 제품정보를 모아서 처리
			cartItems = gdao.itemInfo(Integer.parseInt(goods_id));
			model.addAttribute("cartItems", cartItems);
			System.out.println("goodsPage");
			ArrayList<MemberDTO> userInfo = mdao.myLoad(id);
			model.addAttribute("userInfo", userInfo);
			model.addAttribute("cnt", cnt);
			model.addAttribute("price", price);
			System.out.println(model);
			
			return "mall/order";
				
		} else if (cart_id != null) { // 카트에서온경우 장바구니정보를 모아서 처리
			String[] orderList = cart_id.split(",");
			System.out.println("cartPage");
			for(int i = 0; i < orderList.length; i++) {
				System.out.println(orderList[i]);
				System.out.println("for진입");
				cartItems.add(gdao.cartOrder(Integer.parseInt(orderList[i])));
			}
			for(int i = 0; i < cartItems.size(); i++) {
				System.out.println(cartItems.get(i));
				System.out.println("fooor");
			}
			model.addAttribute("cartItems", cartItems);
			
			ArrayList<MemberDTO> userInfo = mdao.myLoad(id);
			model.addAttribute("userInfo", userInfo);
			model.addAttribute("cnt", null);
			
			return "mall/order";
			}    
		return "";
	}
	
	@PostMapping("/delCart")
	@ResponseBody
	public String delCart(@RequestParam(value="checked[]") Integer[] cartValues) {
		int n = 0;
		for(int i = 0; i < cartValues.length; i++) {
			int value = cartValues[i];
			System.out.println("value: " + value);
			n = gdao.delCart(value);
		}
		return "" + n;
	}
	
	@PostMapping("/updateCart")
	@ResponseBody
	public String updateCart(HttpServletRequest req) {
		String id = req.getParameter("id");
		String cnt = req.getParameter("cnt");
		int n = gdao.updateCart(Integer.parseInt(id),Integer.parseInt(cnt));
		return "" + n;
	}
	
	@GetMapping("/orderEnd")
	public String getOrderEnd() {
		return "mall/orderEnd";
	}
	
	@PostMapping("/saveOrder")
	@ResponseBody
	public String addOrder(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		
		String goods_id_str = req.getParameter("goods_id");
		String cnt_str = req.getParameter("cnt");
		String price_str = req.getParameter("price");
		
		String g_id = req.getParameter("g_id");

		String cart_id_str = req.getParameter("cart_id");
		int member_id = gdao.getIdNum(id);
		System.out.println("goods_id_str = " + goods_id_str);
		System.out.println("cnt_str = " + cnt_str);
		System.out.println("price_str = " + price_str);
		System.out.println("g_id = " + g_id);
		System.out.println("cart_id_str = " + cart_id_str);
		
//		String[] cart_id = cart_id_str.split(",");

		String delname = req.getParameter("delname");
		String delzipcode = req.getParameter("delzipcode");
		String deladress = req.getParameter("deladress");
		String deladress2 = req.getParameter("deladress2");
		String delmobile = req.getParameter("delmobile");
		String delreq = req.getParameter("delreq");
		String delprice = req.getParameter("delprice");
		String payment = req.getParameter("payment");
		
		System.out.println("delname = " + delname);
		System.out.println("delzipcode = " + delzipcode);
		System.out.println("deladress = " + deladress);
		System.out.println("deladress2 = " + deladress2);
		System.out.println("delmobile = " + delmobile);
		System.out.println("delreq = " + delreq);
		System.out.println("delprice = " + delprice);
		System.out.println("payment = " + payment);
		
		int n = gdao.saveOrder(delname,delzipcode,deladress,deladress2,delmobile,delreq,Integer.parseInt(delprice),Integer.parseInt(payment));
		System.out.println(n);
		int orderId = gdao.getOrderId(delname,delzipcode,deladress,deladress2,delmobile,delreq,Integer.parseInt(delprice),Integer.parseInt(payment));
		System.out.println(orderId);
		
		if(g_id.equals("0")) { // 장바구니에서 온거
			String[] goods_id = goods_id_str.split(",");
			String[] cnt = cnt_str.split(",");
			String[] price = price_str.split(",");
			String[] cart_id = cart_id_str.split(",");
			
			for(int i = 0; i < goods_id.length; i++) {
				int a = gdao.addOrder(member_id,Integer.parseInt(goods_id[i]),Integer.parseInt(cnt[i]),Integer.parseInt(price[i]),orderId);
			}
			for(int i = 0; i < cart_id.length; i++) {
				int b = gdao.delCart(Integer.parseInt(cart_id[i]));
			}
		} else {
			int c = gdao.addOrder(member_id,Integer.parseInt(g_id),Integer.parseInt(cnt_str),Integer.parseInt(price_str),orderId);
		}
		
		return "" + n;
	}
		
}
