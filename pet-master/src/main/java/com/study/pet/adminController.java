package com.study.pet;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class adminController {

	@Autowired
	private GoodDAO gdao;
	@Autowired
	private MemberDAO mdao;
	@Autowired
	private OrderDAO odao;

	@GetMapping("/admin")
	public String getAdmin() {
		return "mall/admin";
	}

	@GetMapping("/adminorder")
	public String getadminorder() {
		return "mall/adminorder";
	}

	@GetMapping("/addGoods")
	public String getaddGoods() {
		return "mall/addGoods";
	}

	
	@GetMapping("/memberList")
	public String getMemberList() {
		return "mall/memberList";
	}
	
	
	@PostMapping("/memberslist") //관리자창 회원관리목록 불러오는코드
	@ResponseBody
	public String doMembersList(HttpServletRequest req) {
		ArrayList<MemberDTO> alMember = mdao.list();
		JSONArray ja = new JSONArray();
	    for (int i = 0; i < alMember.size(); i++) {
	        JSONObject jo = new JSONObject();
	        jo.put("id", alMember.get(i).id);
	        jo.put("user_id", alMember.get(i).user_id);
	        jo.put("name", alMember.get(i).name);
	        jo.put("mobile", alMember.get(i).mobile);
	        jo.put("mail", alMember.get(i).mail);
	        jo.put("gender", alMember.get(i).gender);
	        jo.put("join_day", alMember.get(i).join_day);
	        jo.put("out_day", alMember.get(i).out_day);
	        jo.put("zipcode", alMember.get(i).zipcode);
	        jo.put("adress", alMember.get(i).adress);
	        jo.put("member_rank", alMember.get(i).member_rank);
	        ja.add(jo);
	        }
		return ja.toJSONString();
	}
	
	@PostMapping("/siuuGoods") // 수정하기위한 상품 id만가져오는곳
	@ResponseBody
	public String doSiuuGoods(@RequestParam("goodsid") String goodsid, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		sess.setAttribute("goodsid", goodsid);
		return "";
	}

	@PostMapping("/goodslist") // 관리자창 상품목록불러오는 코드
	@ResponseBody
	public String doGoodsList(HttpServletRequest req) {
		ArrayList<GoodDTO> alGoods = gdao.list();
		JSONArray ja = new JSONArray();
		for (int i = 0; i < alGoods.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("id", alGoods.get(i).id);
			jo.put("img1", alGoods.get(i).img1);
//	        jo.put("img2", alGoods.get(i).img2);
//	        jo.put("img3", alGoods.get(i).img3);
//	        jo.put("img4", alGoods.get(i).img4);
//	        jo.put("img5", alGoods.get(i).img5);
			jo.put("delpay", alGoods.get(i).delpay);
			jo.put("category", alGoods.get(i).name);
			jo.put("title", alGoods.get(i).title);
			jo.put("price", alGoods.get(i).price);
			jo.put("stock", alGoods.get(i).stock);
			jo.put("discnt", alGoods.get(i).discnt);
			ja.add(jo);
		}
		return ja.toJSONString();
	}

	@GetMapping("/delete") // 삭제
	@ResponseBody
	public String doDelete(HttpServletRequest req) {
		String id = req.getParameter("id");
		gdao.remove(Integer.parseInt(id));
		return "";
	}

	@PostMapping("/update") // 수정 반 미완성
	@ResponseBody
	public String doUpdate(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("goods_id"));
		int category = Integer.parseInt(req.getParameter("category_id"));
		int price = Integer.parseInt(req.getParameter("price"));
		int stock = Integer.parseInt(req.getParameter("stock"));
		int delivery = Integer.parseInt(req.getParameter("delivery"));
		int discnt = Integer.parseInt(req.getParameter("discnt"));
		int update = gdao.upd(id, category, req.getParameter("title"), price, stock, delivery, discnt);
		return "" + update;
	}

	@PostMapping("/getCategoty")
	@ResponseBody
	public String getCategoty() {
		ArrayList<GoodDTO> alGoods = gdao.tkcategory();
		JSONArray ja = new JSONArray();
		for (int i = 0; i < alGoods.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("id", alGoods.get(i).id);
			jo.put("name", alGoods.get(i).name);
			ja.add(jo);
		}
		return ja.toJSONString();
	}

	@PostMapping("/orderList") // 관리자창 주문목록불러오는코드
	@ResponseBody
	public String getOrderList(HttpServletRequest req) {
		int stateNum = Integer.parseInt(req.getParameter("stateNum"));
		ArrayList<OrderDTO> alOrder = odao.orderlist(stateNum);
		JSONArray ja = new JSONArray();
		for (int i = 0; i < alOrder.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("id", alOrder.get(i).id);
			jo.put("order_id", alOrder.get(i).order_id);
			jo.put("member_id", alOrder.get(i).member_id);
			jo.put("goods_name", alOrder.get(i).goods_name);
			jo.put("cnt", alOrder.get(i).cnt);
			jo.put("sales", alOrder.get(i).sales);
			jo.put("delname", alOrder.get(i).delname);
			jo.put("delzipcode", alOrder.get(i).delzipcode);
			jo.put("deladress", alOrder.get(i).deladress);
			jo.put("deladress2", alOrder.get(i).deladress2);
			jo.put("delmobile", alOrder.get(i).delmobile);
			jo.put("delreq", alOrder.get(i).delreq);
			jo.put("delivery_name", alOrder.get(i).delivery_name);
			jo.put("delivery_pay", alOrder.get(i).delivery_pay);
			jo.put("payment_name", alOrder.get(i).payment_name);
			jo.put("orderstate_name", alOrder.get(i).orderstate_name);
			jo.put("created", alOrder.get(i).created);
			jo.put("state", alOrder.get(i).state);
			ja.add(jo);
		}
		return ja.toJSONString();
	}

	@PostMapping("/updateState") // 관리자창 배송진행상황 업데이트(추가수정필요함)
	@ResponseBody
	public String updateState(HttpServletRequest req) {
		int stateNum = Integer.parseInt(req.getParameter("stateNum")) + 1;
		System.out.println(stateNum);
		int id = Integer.parseInt(req.getParameter("id"));
		System.out.println(id);
		int updateS = odao.updatestate(id, stateNum);
		return "";
	}

	   @PostMapping("/view") //addGoods.jsp에 hidden안에 id들어있을경우 id에담긴 테이블가져오기
	   @ResponseBody
	   public String doView(@RequestParam("goods_id") int goods_id) {
		   GoodDTO gdto = gdao.view(goods_id);
		   JSONObject jo = new JSONObject();
		   jo.put("category", gdto.category);
		   jo.put("title", gdto.title);
		   jo.put("price", gdto.price);
		   jo.put("delpay", gdto.delpay);
		   jo.put("stock", gdto.stock);
		   jo.put("content", gdto.content);
		   jo.put("discnt",gdto.discnt);
		   return jo.toJSONString();
	   }
	   
	   @PostMapping("/goodsAdd") //관리자용 상품추가
	   @ResponseBody
	   public String doGoodsAdd(HttpServletRequest req) {
	      String category_id = req.getParameter("category_id");
	      System.out.println(category_id);
	      String title = req.getParameter("title");
	      System.out.println(title);
	      String price = req.getParameter("price");
	      System.out.println(price);
	      String stock = req.getParameter("stock");
	      System.out.println(stock);
	      String delivery = req.getParameter("delivery");
	      System.out.println(delivery);
	      String discnt = req.getParameter("discnt");
	      System.out.println(discnt);
	      String img1 = req.getParameter("img1");
	      System.out.println(img1);
	      String img2 = req.getParameter("img2");
	      System.out.println(img2);
	      String img3 = req.getParameter("img3");
	      System.out.println(img3);
	      String img4 = req.getParameter("img4");
	      System.out.println(img4);
	      String img5 = req.getParameter("img5");
	      System.out.println(img5);
	      String content = req.getParameter("content");
	      System.out.println(content);
	      int n = gdao.goodsAdd(Integer.parseInt(category_id), title,Integer.parseInt(price),Integer.parseInt(discnt), Integer.parseInt(stock), img1, img2,img3,img4,img5,content, Integer.parseInt(delivery)); //insert
	   return "" + n;
	   }
}
