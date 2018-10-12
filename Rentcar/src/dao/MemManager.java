package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

	

	
	
	
	
	
	
	
	
	
}
