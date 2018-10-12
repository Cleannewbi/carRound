package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.InfoDto;

public class InfoDao implements iInfoDao {
	
	private static InfoDao infoDao = new InfoDao();
	
	public InfoDao() {
		DBConnection.initConnect();
	}
	
	public static InfoDao getInstance() {
		return infoDao;
	}
	
	// 차목록 출력
	public List<InfoDto> getInfoList() {
		
		String sql = " SELECT SEQ, COM_NAME, CAR_PIC, CAR_NAME, CAR_TYPE, "
				+ " CAR_FUEL, CAR_SIZE, CAR_FEE "
				+ " FROM RC_INFO ";
		System.out.println(sql);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<InfoDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();

			System.out.println("1/6 getInfoList() Success!");
		
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getInfoList() Success!");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getInfoList() Success!");
			
			while(rs.next()) {
				InfoDto dto = new InfoDto(rs.getInt(1),
										  rs.getString(2),
										  rs.getString(3),
										  rs.getString(4),
										  rs.getString(5),
										  rs.getString(6),
										  rs.getString(7),
										  rs.getString(8));
				list.add(dto);
			}
			System.out.println("4/6 getInfoList() Success!");
		} catch (Exception e) {
			System.out.println("getInfoList() Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;
	}

	// 체크한 정보
	@Override
	public List<InfoDto> getChecked(String datas[]) {
		System.out.println("========= Info dao start =========");
		String sql = " SELECT * FROM RC_INFO WHERE ";
		String keyword[] = null;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<InfoDto> list = new ArrayList<>();
		
		for (int i = 0; i < datas.length; i++) {
			keyword = datas[i].split("&");	
			System.out.println("keyword : " + keyword[i] + " length : " + keyword.length);
		}
		
		if(!(datas.length == 0)) {
			for (int i = 0; i < keyword.length; i++) {
				if(keyword[i].equals("SizeA")) {
					sql += " CAR_SIZE = '소형' ";
				}
				else if(keyword[i].equals("SizeB")) {
					sql += " CAR_SIZE = '중형' ";
				}
				else if(keyword[i].equals("SizeC")) {
					sql += " CAR_SIZE = '대형' ";
				}
				else if(keyword[i].equals("TypeSUV")) {
					sql += " CAR_TYPE = 'SUV' ";
				}
				else if(keyword[i].equals("TypeCar")) {
					sql += " CAR_TYPE = '승용차' ";
				}
				else if(keyword[i].equals("TypeVans")) {
					sql += " CAR_TYPE = '밴' ";
				}
				else if(keyword[i].equals("fuelLpg")) {
					sql += " CAR_FUEL =  'LPG' ";
				}
				else if(keyword[i].equals("fuelOil")) {
					sql += " CAR_FUEL =  '가솔린' ";
				}
				else if(keyword[i].equals("fuelElec")) {
					sql += " CAR_FUEL =  '전기' ";
				}
				
				if(keyword.length == (i+1)) {
					break;
				} else {
					sql += " AND ";
				}
			}
			System.out.println("InfoDao  = "+sql);
			try {
				conn = DBConnection.getConnection();
				System.out.println("getChecked 1");
				
				psmt = conn.prepareStatement(sql);
				System.out.println("getChecked 2");
				
				rs = psmt.executeQuery();
				System.out.println("getChecked 3");
				
				while(rs.next()) {
					InfoDto dto = new InfoDto(rs.getInt(1),
											  rs.getString(2),
											  rs.getString(3),
											  rs.getString(4),
											  rs.getString(5),
											  rs.getString(6),
											  rs.getString(7),
											  rs.getString(8));
					list.add(dto);
				}
				for (int i = 0; i < list.size(); i++) {
					System.out.println("결과 : " + list);
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			DBClose.close(psmt, conn, rs);
		
		}
		System.out.println("========= Info dao END =========");
		return list;
	}
	

}
