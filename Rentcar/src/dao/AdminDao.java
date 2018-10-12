package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class AdminDao implements iAdminDao {
	
	private static AdminDao adminDao = new AdminDao();
	
	private AdminDao() {
		DBConnection.initConnect();
	}
	
	public static AdminDao getInstance() {
		return adminDao;
	}

	@Override
	public boolean deleteUser(int seq) {
		String sql = " DELETE FROM RC_MEMBER"
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 deleteMyPage Success");	
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 deleteMyPage Success");	
			
			count = psmt.executeUpdate();
			System.out.println("3/6 deleteMyPage Success");				
			
		} catch (Exception e) {			
			System.err.println(e);
		} finally{
			DBClose.close(psmt, conn, null);			
			System.out.println("4/6 deleteMyPage Success");	
		}
		
		return count>0?true:false;
	}

	@Override
	public boolean regiAdminUser(MemberDto dto) {
		String sql = " INSERT INTO RC_MEMBER "
				+ " (SEQ, ID, PASSWORD, PHOTO, NAME, PHONE, ADDRESS, EMAIL, CARD, AUTH) "
				+ " VALUES(SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, 관리자, 3) ";
				
		int count = 0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 regiAdminUser Success");	
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 regiAdminUser Success");
			
			psmt.setString(1, dto.getMember_id());
			psmt.setString(2, dto.getMember_pw());
			psmt.setString(3, dto.getMember_Photo());
			psmt.setString(4, dto.getMember_name()+"_admin");
			psmt.setString(5, dto.getMember_phone());
			psmt.setString(6, dto.getMember_address());
			psmt.setString(7, dto.getMember_email());
			
			count = psmt.executeUpdate();
			System.out.println("3/6 regiAdminUser Success");
						
		} catch (Exception e) {
			System.err.println(e);
		} finally {
			DBClose.close(psmt, conn, null);			
		}
				
		return count>0?true:false;
	}
	
	
	
	

}
