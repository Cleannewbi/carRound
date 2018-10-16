package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
	
	@Override
	public MemberDto getMember(String id, int auth) {
		String sql = " SELECT SEQ, ID, PASSWORD, PHOTO, NAME, PHONE, ADDRESS, EMAIL, CARD ";
		
		if(auth==1) {
			sql+= " FROM RC_MEMBER WHERE ID=?";
			
		}else if(auth==2) {	//carname =>info의 carname 
			sql+= " FROM RC_MEMBER " + 
					" WHERE NAME=?";
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
											rs.getString(i++));
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
	
	
	
}
