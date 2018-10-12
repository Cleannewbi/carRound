package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.DBClose;
import db.DBConnection;
import model.InfoDto;

public class InfoDao implements InfoDaoImpl {
	
	private static InfoDao infoDao = new InfoDao();
	
	public InfoDao() {
		DBConnection.initConnect();
	}
	
	public static InfoDao getInstance() {
		return infoDao;
	}
	
	@Override
	public InfoDto getCarInfo(String Car_name) {

		String sql = " SELECT SEQ, COM_NAME, CAR_PIC, CAR_NAME, CAR_TYPE, CAR_FUEL, CAR_SIZE, CAR_FEE "
				+ " FROM RC_INFO "
				+ " WHERE CAR_NAME=?";
		System.out.println("sql : "+sql);

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		InfoDto dto= null;
		
		try {
			conn=DBConnection.getConnection();
				System.out.println("1/6 getCarInfo Success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, Car_name);
				System.out.println("2/6 getCarInfo Success");
			rs=psmt.executeQuery();
				System.out.println("3/6 getCarInfo Success");
				
				if(rs.next()) {
					int i=1;
					dto = new InfoDto(rs.getInt(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++));
				}
				System.out.println("4/6 getCarInfo Success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("getCarInfo Failed!!!!!!!!!");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("5/6 getCarInfo Success");
		}
		return dto;
	}

}
