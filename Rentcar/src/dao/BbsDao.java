package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.InfoDto;
import dto.MemberDto;
import dto.ReviewDto;

public class BbsDao implements iBbsDao {

private static BbsDao bbsdao = new BbsDao();
	
	private BbsDao() {
		DBConnection.initConnect();
	}
	
	public static BbsDao getInstance() {
		return bbsdao;
	}

/*	@Override
	public List<BbsDto> getBbsList() {
		String sql = " select seq, cus_id, title, content, wdate, delnum "
				+ " from rc_review ";
		
		
		String sql = " SELECT SEQ, CUS_ID, TITLE, CONTENT, WDATE, DELNUM "
				+ " FROM RC_REVIEW ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsList Success");
			
			if(conn != null) {
				System.out.println("데이터베이스와 연결 성공");
				}else{
				throw new Exception("데이터베이스를 연결할 수 없습니다.");
				} 

			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsList Success");
			
			if(psmt != null) {
				System.out.println("psmt 연결 성공");
				}else{
				throw new Exception("psmt 연결할 수 없습니다.");
				} 

			
			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsList Success");
						
		
			while(rs.next()) {

				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getInt(6));
				
				list.add(dto);				
			}
			System.out.println("4/6 getBbsList Success");
		} catch (Exception e) {
			System.out.println("getBbsList Fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);			
		}	
		
		return list;
	}
*/
	
	
	@Override
	public InfoDto getInfoList(int seq) {			// 차량 정보
		
		String sql = " SELECT SEQ, COM_NAME, CAR_PIC, CAR_NAME, CAR_TYPE, CAR_FUEL, CAR_SIZE, CAR_FEE "
				+ " FROM RC_INFO"
				+ " WHERE SEQ = ?  ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		InfoDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getInfoList Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getInfoList Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getInfoList Success");
		
			while(rs.next()) {
				int i = 1;
				dto = new InfoDto(rs.getInt(i++), rs.getString(i++), 
						rs.getString(i++), rs.getString(i++), rs.getString(i++), 
						rs.getString(i++), rs.getString(i++), rs.getString(i++));
				
			}
			System.out.println("4/6 getInfoList Success");
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(psmt, conn, rs);			
			System.out.println("6/6 S getBbs");
		}
		
		return dto;
	}

	/*
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
*/
	
	@Override
	public List<ReviewDto> getBbsList(int com_num) {		// 리뷰
		
		String sql = " SELECT SEQ, CUS_ID, TITLE, CONTENT, WDATE, DELNUM, COM_NUM "
				+ " FROM RC_REVIEW "
				+ " WHERE COM_NUM=? ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ReviewDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsList Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, com_num);
			System.out.println("2/6 getInfoList Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getInfoList Success");
		
			while(rs.next()) {
				int i = 1;
				ReviewDto dto = new ReviewDto(rs.getInt(1), rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7));
				
				list.add(dto);		
				
			}
			System.out.println("4/6 getBbsList Success");		
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);			
		}	
		
		return list;
	}

	
	
	
	
	
	
}
