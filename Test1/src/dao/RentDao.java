package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import model.MemberDto;
import model.RentDto;

public class RentDao implements RentDaoImpl{
	private static RentDao rentDao = new RentDao();
	
	public RentDao() {
		DBConnection.initConnect();
	}
	public static RentDao getInstance() {
		return rentDao;
	}
	
	//RC_RENT INSERT 
	@Override
	public boolean setReservation(RentDto rDto) {
		
		String sql = " INSERT INTO RC_RENT "
				+ " VALUES( SEQ_RC_RENT.NEXTVAL, ?, ?, ?, ?, ?, ?, "
				+ " ?, ?, ?, ?, ?)";
		
		System.out.println("sql : "+sql);
		
		Connection conn=null;
		PreparedStatement psmt = null;
		int count=0;
		
		try {
			conn=DBConnection.getConnection();
				System.out.println("1/6 setReservation Success");
			psmt=conn.prepareStatement(sql);
			psmt.setString(1,rDto.getRent_carname());
			psmt.setString(2, rDto.getRent_start());
			psmt.setString(3, rDto.getRent_end());
			psmt.setString(4, rDto.getCus_id());
			psmt.setInt(5, rDto.getCom_num());
			psmt.setInt(6, rDto.getPrice());
			psmt.setString(7, rDto.getRc_name());
			psmt.setString(8, rDto.getRc_phone());
			psmt.setString(9, rDto.getRc_address());
			psmt.setString(10, rDto.getRc_card());
			psmt.setString(11, rDto.getRc_photo());
				System.out.println("2/6 setReservation Success");
			count=psmt.executeUpdate();
				System.out.println("3/6 setReservation Success");
		} catch (Exception e) {
			System.out.println("setReservation Failed!!!!!!");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0? true:false;
	}
	
	//회원별 주문건수
	@Override
	public HashMap<String, Integer> getOrderCount() {
		
		//userList
		memberDao memdao = new memberDao();
		List<MemberDto> memdtoList = new ArrayList<>();
		memdtoList = memdao.getUserList();
		
		//Return용 해시맵
		HashMap<String, Integer> countMap = new HashMap<>();

		for(int i =0 ; i<memdtoList.size() ; i++) {
			String sql = "SELECT COUNT(PRICE) FROM RC_RENT WHERE CUS_ID='"+memdtoList.get(i).getMember_id().trim()+"'";			
			
			Connection conn=null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			int count=0;
			
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getRentMember Success");
				psmt=conn.prepareStatement(sql);
				rs=psmt.executeQuery();
					System.out.println("3/6 getRentMember Success");
				if(rs.next()) {
					count=rs.getInt(1);
					System.out.println(count);
				}
				countMap.put(memdtoList.get(i).getMember_id(), count);

			} catch (Exception e) {
					System.out.println("getRentMember Failed!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
		}		
		return countMap;
	}
	
	//회원별 주문금액
	@Override
	public HashMap<String, Integer> getOrderPrice() {
		
		//userList
		memberDao memdao = new memberDao();
		List<MemberDto> memdtoList = new ArrayList<>();
		memdtoList = memdao.getUserList();
		
		//Return용 해시맵
		HashMap<String, Integer> priceMap = new HashMap<>();

		for(int i =0 ; i<memdtoList.size() ; i++) {
			String sql = "SELECT SUM(PRICE) FROM RC_RENT WHERE CUS_ID='"+memdtoList.get(i).getMember_id().trim()+"'";
			Connection conn=null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			int count=0;
			
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getRentMember Success");
				psmt=conn.prepareStatement(sql);
				rs=psmt.executeQuery();
					System.out.println("3/6 getRentMember Success");
				if(rs.next()) {
					count=rs.getInt(1);
				}
				priceMap.put(memdtoList.get(i).getMember_id(), count);

			} catch (Exception e) {
					System.out.println("getRentMember Failed!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
		}
		return priceMap;
	}
	
	//회사별 주문건수
	@Override
	public HashMap<String, Integer> getComOrderCount() {
		//Return용 해시맵
		HashMap<String, Integer> countMap = new HashMap<>();
		
	//1.company dto소환
		memberDao memdao= memberDao.getInstance();
		List<MemberDto> comdto = memdao.getComList();
		
	//1. SQL - RC_INFO 의 COM_NAME SELECT
		for(int i=0; i<comdto.size();i++) {
			String sql = "SELECT COM_NAME,COUNT(PRICE) FROM RC_RENT WHERE COM_NAME=? GROUP BY COM_NAME";
			
			Connection conn=null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
				try {
					conn=DBConnection.getConnection();
						System.out.println("1/6 getComOrderPrice Success");
					psmt=conn.prepareStatement(sql);
					psmt.setString(1, comdto.get(i).getMember_name());
					rs=psmt.executeQuery();
						System.out.println("2/6 getComOrderPrice Success");			
					if(rs.next()) {
						countMap.put(comdto.get(i).getMember_name(), rs.getInt(2));						
					}else {
						countMap.put(comdto.get(i).getMember_name(),0);		
					}
				} catch (Exception e) {
						System.out.println("getComOrderPrice 1st Failed!!!!");
					e.printStackTrace();
				}finally {
					DBClose.close(psmt, conn, rs);
				}
		}
		
		//확인출력
		 Iterator<String> mapIter = countMap.keySet().iterator();
	        while(mapIter.hasNext()) {
	            String key = mapIter.next();
	            int value = countMap.get( key );
	            System.out.println("map == "+key+" : "+value);
	        }
	return countMap;
	}
	
	//회사별 주문금액
	@Override
	public HashMap<String, Integer> getComOrderPrice() {					
		//Return용 해시맵
			HashMap<String, Integer> priceMap = new HashMap<>();
			
		//1.company dto소환
			memberDao memdao= memberDao.getInstance();
			List<MemberDto> comdto = memdao.getComList();
			
		//1. SQL - RC_INFO 의 COM_NAME SELECT
			for(int i=0; i<comdto.size();i++) {
				String sql = "SELECT COM_NAME,SUM(PRICE) FROM RC_RENT WHERE COM_NAME=? GROUP BY COM_NAME";
				
				Connection conn=null;
				PreparedStatement psmt = null;
				ResultSet rs = null;
				
					try {
						conn=DBConnection.getConnection();
							System.out.println("1/6 getComOrderPrice Success");
						psmt=conn.prepareStatement(sql);
						psmt.setString(1, comdto.get(i).getMember_name());
						rs=psmt.executeQuery();
							System.out.println("2/6 getComOrderPrice Success");			
						if(rs.next()) {
							priceMap.put(comdto.get(i).getMember_name(), rs.getInt(2));						
						}else {
							priceMap.put(comdto.get(i).getMember_name(),0);		
						}
					} catch (Exception e) {
							System.out.println("getComOrderPrice 1st Failed!!!!");
						e.printStackTrace();
					}finally {
						DBClose.close(psmt, conn, rs);
					}
			}
			
			//확인출력
			 Iterator<String> mapIter = priceMap.keySet().iterator();
		        while(mapIter.hasNext()) {
		            String key = mapIter.next();
		            int value = priceMap.get( key );
		            System.out.println("map == "+key+" : "+value);
		        }
		return priceMap;
	}
	
	// 회사 실적 
	@Override
	public HashMap<String, Integer> getComSaleMonthly(){
		
		//1.company dto소환
		memberDao memdao= memberDao.getInstance();
		List<MemberDto> comdto = memdao.getComList();
		
		//2.리턴할 해시맵
		HashMap<String, Integer> comSaleMap = new HashMap<>();
				
		for(int i=0; i<comdto.size();i++) {
			String sql="SELECT SUM(PRICE) FROM RC_RENT WHERE STARTDATE LIKE '2018-?-%' AND COM_NAME=? ORDER BY COM_NAME";
			
			System.out.println("SQL : "+sql);
			Connection conn=null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
				try {
					conn=DBConnection.getConnection();
						System.out.println("1/6 getComSaleMonthly Success");
					psmt=conn.prepareStatement(sql);
					if() {
						psmt.setString(1, );
					}else if () {
						psmt.setString(1, );
					}
					System.out.println("2/6 getComSaleMonthly Success");			
	
					rs=psmt.executeQuery();
						System.out.println("3/6 getComSaleMonthly Success");			
					if(rs.next()) {
						comSaleMap.put(comdto.get(i).getMember_name(), rs.getInt(2));						
					}else {
						comSaleMap.put(comdto.get(i).getMember_name(),0);		
					}
				} catch (Exception e) {
						System.out.println("getComSaleMonthly Failed!!!!");
					e.printStackTrace();
				}finally {
					DBClose.close(psmt, conn, rs);
				}
		}
		
		
	}
	
	//월별 차종 판매량
	@Override
	public HashMap<String, Integer> getCarSaleMonthly(){

		//1.company dto소환
		memberDao memdao= memberDao.getInstance();
		List<MemberDto> comdto = memdao.getComList();
		//리턴할 해시맵		
		HashMap<String, Integer> carSaleMap = new HashMap<>();
		
		for(int i=0; i<comdto.size();i++) {
			String sql = "SELECT COUNT(PRICE) FROM RC_RENT WHERE STARTDATE LIKE '2018-?-%' AND COM_NAME=? ORDER BY CAR_NAME"
			System.out.println("SQL : "+sql);
			
			Connection conn=null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
		
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getCarSaleMonthly Success");
				psmt=conn.prepareStatement(sql);
					psmt.setString(1, );
					psmt.setString(2,(comdto.get(i).getMember_name());
					System.out.println("2/6 getCarSaleMonthly Success");
				rs=psmt.executeQuery();
					System.out.println("3/6 getCarSaleMonthly Success");			
				if(rs.next()) {
					carSaleMap.put(comdto.get(i).getMember_name(), rs.getInt(2));						
				}else {
					carSaleMap.put(comdto.get(i).getMember_name(),0);		
				}
			} catch (Exception e) {
					System.out.println("getCarSaleMonthly Failed!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
		
	}

}
