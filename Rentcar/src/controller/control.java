package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BbsDao;
import dao.MemManager;
import dto.InfoDto;
import dto.MemberDto;
import dto.ReviewDto;


public class control extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		String command = req.getParameter("command");
		
		if(command.equals("addmem")) {
										
				String id = req.getParameter("id");	
				String password = req.getParameter("password");
				String name = req.getParameter("name");
				
				String phone1 = req.getParameter("phone1");
				String phone2 = req.getParameter("phone2");
				String phone3 = req.getParameter("phone3");
				String phone = phone1 + phone2 + phone3;
				
				String add1 = req.getParameter("add1");
				String add2 = req.getParameter("add2");
				String add3 = req.getParameter("add3");
				String add = add1 + add2 + add3;
				
				String email = req.getParameter("email");
						
				String imgname = req.getParameter("imgname");		// 일반회원은 운전면허, 회사는 배너사진
				System.out.println(imgname);   						
							
				String cardnum1 = req.getParameter("cardnum1");
				String cardnum2 = req.getParameter("cardnum2");
				String cardnum3 = req.getParameter("cardnum3");
				String cardnum4 = req.getParameter("cardnum4");
				
				String cardnum = cardnum1 + cardnum2 + cardnum3 + cardnum4;		// 일반회원 : 결제용 카드번호
	
				
				String auth = req.getParameter("auth");
				MemberDto dto = new MemberDto();
				if(auth.equals("mem")) {
					 dto = new MemberDto(0, id, password, imgname, name, phone, add, email, cardnum, 1);
				}else if(auth.equals("com")) {
					 dto = new MemberDto(0, id, password, imgname, name, phone, add, email, " ", 3);	
				}
						
				MemManager service = MemManager.getInstance();
				boolean b = service.addMem(dto);
				
				if(b){
					System.out.println("성공적으로 추가되었습니다");		
				}else{		
					System.out.println("추가하지 못했습니다");		
				}	
				
				System.out.println(dto.toString());
				
			
				
				
		} else if(command.equals("getlist")) {		// 검색창 -> detail 
			
			BbsDao dao = BbsDao.getInstance();
		
			String Sseq = req.getParameter("info_seq");	// 차 시퀀스
			int seq = Integer.parseInt(Sseq);
			InfoDto dto = dao.getInfoList(seq);			
			req.setAttribute("infolist", dto);
			
			String comname = dto.getCom_name();	
			MemberDto comdto = dao.getCom(comname);   //  com_name(rc_info) = member_name(rc_member)	
			System.out.println(comdto.toString());
			req.setAttribute("comdto", comdto);
			
			/*
			List<BbsDto> list = dao.getBbsList();	// 리뷰 전체 리스트
			req.setAttribute("bbslist", list);		
			*/
		
			List<ReviewDto> list = dao.getBbsList(seq);
			req.setAttribute("bbslist", list);
			
			dispatch("detail.jsp", req, resp);
			
		}
		
		
		
		
	
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);		
	}
	
	
	
	
	
	
	
	
	
	
	
}
