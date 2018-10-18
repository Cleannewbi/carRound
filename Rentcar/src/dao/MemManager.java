package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemManager implements iMemManager {

	private static MemManager meManager = new MemManager();
	
	private MemManager() {
		DBConnection.initConnect();
	}
	
	public static MemManager getInstance() {
		return meManager;
	}
	
	@Override
	public boolean addMem(MemberDto dto) {
		
		String sql = " insert into rc_member "
				+ " ( seq, id, password, photo, name, phone, address, email, card, auth ) "
				+ " values( SEQ_RC_MEMBER.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 addMember Success");
		
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 addMember Success");
		

			psmt.setString(1, dto.getMember_id());
			psmt.setString(2, dto.getMember_pw());
			psmt.setString(3, dto.getMember_Photo());
			psmt.setString(4, dto.getMember_name());
			psmt.setString(5, dto.getMember_phone());
			psmt.setString(6, dto.getMember_address());
			psmt.setString(7, dto.getMember_email());
			psmt.setString(8, dto.getMember_card());
			psmt.setInt(9, dto.getMember_auth());
			
			count = psmt.executeUpdate();
			System.out.println("3/6 addMember Success");
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
				DBClose.close(psmt, conn, null);			
		}		
			
			return count>0?true:false;
	}

	@Override
	public boolean idcheck(String id) {
	
			String sql = " select id from rc_member "
					+ " where id = ? ";
		
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			boolean findId = false;
		
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/6 getId Success");
				
				psmt = conn.prepareStatement(sql);
				System.out.println("2/6 getId Success");
				
				psmt.setString(1, id.trim());
				
				rs = psmt.executeQuery();
				System.out.println("3/6 getId Success");
				
				while(rs.next()) {
					findId = true;
				}
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, null);			
			}
			
			System.out.println("findId = " + findId);
			
			return findId;
	}

	@Override
	public MemberDto getCom(String comname) {			// 회사 정보
		
		String sql = " SELECT SEQ, ID, PASSWORD, PHOTO, NAME, PHONE, ADDRESS, EMAIL, CARD, AUTH "
				+ " FROM RC_MEMBER "
				+ " WHERE NAME = ? ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getCom Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, comname);
			System.out.println("2/6 getCom Success");
		
			rs = psmt.executeQuery();
			System.out.println("3/6 getCom Success");
		
			while(rs.next()) {
				int i = 1;
			
			dto = new MemberDto(rs.getInt(i++), rs.getString(i++), rs.getString(i++),
					rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++),
					rs.getString(i++),rs.getString(i++),rs.getInt(i++) );

			}
			System.out.println("4/6 getCom Success");
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(psmt, conn, rs);			
			System.out.println("6/6 S getCom");
		}
		
		return dto;
	}
	
	@Override
	public MemberDto login(String id, String pw) {
		String sql = " SELECT SEQ, ID, PHOTO, NAME, PHONE, ADDRESS, EMAIL, CARD, AUTH "
				+ " FROM RC_MEMBER "
				+ " WHERE ID = ? AND PASSWORD = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto mem = null;
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("login 1/6 Success");
			psmt = conn.prepareStatement(sql);
			System.out.println("login 2/6 Success");
			
			psmt.setString(1, id);
			psmt.setString(2, pw);
			
			rs = psmt.executeQuery();
			System.out.println("login 3/6 Success");
			
			if(rs.next()) {
				int seq = rs.getInt(1);
				String _id = rs.getString(2);
				String photo = rs.getString(3);
				String name = rs.getString(4);
				String phone = rs.getString(5);
				String address = rs.getString(6);
				String email = rs.getString(7);
				String card = rs.getString(8);
				int auth = rs.getInt(9);
				
				mem = new MemberDto(seq, _id, photo, name, phone, address, email, card, auth);
				
			}			
			System.out.println("login 4/6 Success");
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);	
			System.out.println("login 5/6 Success");
		}
		
		return mem;
	}
	
	//모든멤버 가져오기 id랑 name을 넣는파라메타가 달려있음
		@Override
		public MemberDto getMember(String id, int auth) {
			String sql = " SELECT SEQ, ID, PASSWORD, PHOTO, NAME, PHONE, ADDRESS, EMAIL, CARD, AUTH";
			
			if(auth==1) {
				sql+= " FROM RC_MEMBER WHERE ID=?";
				
			}else if(auth==2) {	//carname =>info의 carname 
				sql+= " FROM RC_MEMBER " + 
						" WHERE NAME=?";
			}else if(auth==3) {
				sql+="FROM RC_MEMBER WHERE NOT ID IN ('?') ORDER BY AUTH ASC";
			}
			System.out.println("sql : "+sql);
			System.out.println("ID or name: "+id);

			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			MemberDto dto = null;
			
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getMember Success");
				psmt=conn.prepareStatement(sql);
				psmt.setString(1, id);
					System.out.println("2/6 getMember Success");
				rs=psmt.executeQuery();
					System.out.println("3/6 getMember Success");
				if(rs.next()) {
					int i=1;
					dto=new MemberDto(rs.getInt(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getString(i++),
												rs.getInt(i++));
				}
				System.out.println("4/6 getMember Success");
			} catch (Exception e) {
				System.out.println("getMember Failed!!!!!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			System.out.println("DTO : "+dto);
			return dto;
		}
		
		//개인회원리스트
		@Override
		public List<MemberDto> getUserList() {
			String sql = " SELECT ID, NAME, PHONE, CARD FROM RC_MEMBER "
					+ " WHERE AUTH=1 ORDER BY AUTH ASC ";

			System.out.println("sql : "+sql);

			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			List<MemberDto> dtoList = new ArrayList<>();
			
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getMember Success");
				psmt=conn.prepareStatement(sql);
					System.out.println("2/6 getMember Success");
				rs=psmt.executeQuery();
					System.out.println("3/6 getMember Success");

				while(rs.next()) {	
				 MemberDto dto =new MemberDto(rs.getString(1), 
						 									  rs.getString(2),
						 									  rs.getString(3),
						 									  rs.getString(4));
				dtoList.add(dto);
				}
				System.out.println("4/6 getMember Success");
			} catch (Exception e) {
				System.out.println("getMember Failed!!!!!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			return dtoList;
		}
		
		//기업회원 리스트
		@Override
		public List<MemberDto> getComList() {
			String sql = " SELECT ID, NAME, PHONE, CARD FROM RC_MEMBER "
					+ " WHERE AUTH=2 ORDER BY AUTH ASC ";

			System.out.println("sql : "+sql);

			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			List<MemberDto> dtoList = new ArrayList<>();
			
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getMember Success");
				psmt=conn.prepareStatement(sql);
					System.out.println("2/6 getMember Success");
				rs=psmt.executeQuery();
					System.out.println("3/6 getMember Success");

				while(rs.next()) {	
				 MemberDto dto =new MemberDto(rs.getString(1), 
						 									  rs.getString(2),
						 									  rs.getString(3),
						 									  rs.getString(4));
				dtoList.add(dto);
				}
				System.out.println("4/6 getMember Success");
			} catch (Exception e) {
				System.out.println("getMember Failed!!!!!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			return dtoList;
		}

}
