package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;
import dto.RentDto;

public class MyPageDao implements iMyPageDao {
	
	private static MyPageDao myPageDao = new MyPageDao();
	
	private MyPageDao() {
		DBConnection.initConnect();
	}
	public static MyPageDao getInstance() {
		return myPageDao;
	}
	@Override
	public List<MemberDto> getMyPageList(String id) {
		String sql = "SELECT SEQ,ID,PASSWORD,PHOTO,NAME,PHONE,ADDRESS,EMAIL,CARD,AUTH"
				+ " FROM RC_MEMBER "
				+ " WHERE ID = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto dto = null;
		
		List<MemberDto> mylist = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			
			System.out.println("1/6 getMyPageList Success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 getMyPageList Success");
			rs = psmt.executeQuery();
			System.out.println("3/6 getMyPageList Success");
			int i = 1;
			while (rs.next()) {
				 dto = new MemberDto(rs.getInt(i++),
						 rs.getString(i++),rs.getString(i++),rs.getString(i++), rs.getString(i++),rs.getString(i++),
						rs.getString(i++),	rs.getString(i++), rs.getString(i++),rs.getInt(i++));
				
				mylist.add(dto);
			}
			System.out.println("getMyPageList Loading Success");
		} catch (Exception e) {
			System.err.println(e);
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return mylist;
	}
	@Override
	public List<RentDto> getRentPageList(String id) {
		
		String sql = "SELECT SEQ,CARNAME,RC_START,RC_END,CUS_ID,COM_NUM,PRICE"
				+ " FROM RC_RENT"
				+ " WHERE CUS_ID =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<RentDto> rentlist = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getRentPageList Success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 getRentPageList Success");
			rs = psmt.executeQuery();
			System.out.println("3/6 getRentPageList Success");
			int i = 1;
			while (rs.next()) {
				RentDto dto = new RentDto(rs.getInt(i++),
							rs.getString(i++),rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getInt(i++), rs.getInt(i++));
				
				rentlist.add(dto);
			}
			System.out.println("getRentPageList Loading Success");
		} catch (Exception e) {
			System.err.println(e);
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return rentlist;
		
	}
	@Override
	public boolean updateMyPage(MemberDto dto) {
		String sql = " UPDATE RC_MEMBER SET "
				+ "  PHOTO=?, NAME=?, PHONE=?, ADDRESS=?, EMAIL=?, CARD=? "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		int i = 1;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateMyPage Success");
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(i++, dto.getMember_Photo());
			psmt.setString(i++, dto.getMember_name());
			psmt.setString(i++, dto.getMember_phone());
			psmt.setString(i++, dto.getMember_address());
			psmt.setString(i++, dto.getMember_email());
			psmt.setString(i++, dto.getMember_card());
			psmt.setInt(i++, dto.getMember_seq());
			
			System.out.println("2/6 updateMyPage Success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 updateMyPage Success");
			
		} catch (Exception e) {			
			System.err.println(e);
		} finally{
			DBClose.close(psmt, conn, null);
			System.out.println("4/6 updateMyPage Success");
		}		
		
		return count>0?true:false;
	}
	@Override
	public boolean deleteMyPage(int seq) {
		
		String sql = " DELETE FROM RC_MEMBER"
				+ " WHERE SEQ=? AND AUTH=1";
		
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
	public boolean regiCompany(MemberDto dto) {
		String sql = " INSERT INTO RC_MEMBER "
				+ " (SEQ, ID, PASSWORD, PHOTO, NAME, PHONE, ADDRESS, EMAIL, CARD, AUTH) "
				+ " VALUES(SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, 'RentCar_Company', 2) ";
				
		int count = 0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 regiCompany Success");	
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 regiCompany Success");
			
			psmt.setString(1, dto.getMember_id());
			psmt.setString(2, dto.getMember_pw());
			psmt.setString(3, dto.getMember_Photo());
			psmt.setString(4, dto.getMember_name()+"_company");
			psmt.setString(5, dto.getMember_phone());
			psmt.setString(6, dto.getMember_address());
			psmt.setString(7, dto.getMember_email());
			
			count = psmt.executeUpdate();
			System.out.println("3/6 regiCompany Success");
						
		} catch (Exception e) {
			System.err.println(e);
		} finally {
			DBClose.close(psmt, conn, null);			
		}
				
		return count>0?true:false;
	
	}
	@Override
	public boolean getId(String id) {
		String sql = " SELECT ID FROM RC_MEMBER "
				+ " WHERE ID = ? ";
			
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
			System.err.println(e);
		} finally {
			DBClose.close(psmt, conn, null);			
		}
		
		System.out.println("findId = " + findId);
		
		return findId;
	}
	@Override
	public int getSeq(String id) {
		String sql = "SELECT SEQ FROM RC_RENT"
				+ " WHERE CUS_ID =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int seq = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getSeq Success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getSeq Success");
			
			psmt.setString(1, id.trim());
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getSeq Success");
			
			while(rs.next()) {
				seq = rs.getInt(1);
			}
					
		} catch (Exception e) {
			System.err.println(e);
		} finally {
			DBClose.close(psmt, conn, null);			
		}
		
		System.out.println("In DataBase RC_RENT_seq = " + seq);
		
		return seq;
	}
	@Override
	public boolean cancelRes(int seq, String id) {
		String sql = " DELETE FROM RC_RENT"
				+ " WHERE SEQ=? AND CUS_ID=?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 cancelRes Success");	
			System.out.println("DB seq:"+seq+" DB id:"+id);
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			psmt.setString(2, id);
			System.out.println("2/6 cancelRes Success");	
			
			count = psmt.executeUpdate();
			System.out.println("3/6 cancelRes Success");				
			
		} catch (Exception e) {			
			System.err.println(e);
		} finally{
			DBClose.close(psmt, conn, null);			
			System.out.println("4/6 cancelRes Success");	
		}
		
		return count>0?true:false;
	}
	@Override
	public boolean changeDates(int seq) {
		// TODO Auto-generated method stub
		return false;
	}
	
		
	
	
	
	
	
	
	
	
		
	
}
