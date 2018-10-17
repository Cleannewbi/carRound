package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import model.MemberDto;

public class memberDao implements memberDaoImpl{
	private static memberDao memDao = new memberDao();
	public memberDao() {
		DBConnection.initConnect();
	}
	public static memberDao getInstance() {
		return memDao;
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
