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
import dto.MemberDto;
import dto.RentDto;

public class RentDao implements iRentDao{
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
				+ " ?, ?, ?, ?, ?, ?)";
		
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
			psmt.setString(12, rDto.getCom_name());
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
		iMemManager memdao = MemManager.getInstance();
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
		iMemManager memdao = MemManager.getInstance();
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
	
	//회사별 주문건수★★★★★★★★★★★★★★★★★바뀜
		@Override
		public HashMap<String, Integer> getComOrderCount() {
			//Return용 해시맵
			HashMap<String, Integer> countMap = new HashMap<>();
			
		//1.company dto소환
			iMemManager memdao= MemManager.getInstance();
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
		
		//회사별 주문금액 ★★★★★★★★★★★★★★★★★바뀜
		@Override
		public HashMap<String, Integer> getComOrderPrice() {					
			//Return용 해시맵
				HashMap<String, Integer> priceMap = new HashMap<>();
				
			//1.company dto소환
				iMemManager memdao= MemManager.getInstance();
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

	@Override
	public List<RentDto> getRentList() {

		
		String sql = " SELECT * FROM RC_RENT ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<RentDto> list = new ArrayList<RentDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getCalendarList Success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getCalendarList Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getCalendarList Success");
			
			while(rs.next()) {
				RentDto dto = new RentDto();
				dto.setRent_seq(rs.getInt(1));
				dto.setRent_carname(rs.getString(2));
				dto.setRent_start(rs.getString(3));
				dto.setRent_end(rs.getString(4));
				dto.setCus_id(rs.getString(5));
				dto.setCom_num(rs.getInt(6));
				dto.setPrice(rs.getInt(7));
				dto.setRc_name(rs.getString(8));
				dto.setRc_phone(rs.getString(9));
				dto.setRc_address(rs.getString(10));
				dto.setRc_card(rs.getString(11));
				dto.setRc_photo(rs.getString(12));
				list.add(dto);				
			}
			System.out.println("4/6 getCalendarList Success");
			
		} catch (Exception e) {
			System.out.println("getCalendarList Fail");
		} finally {			
			DBClose.close(psmt, conn, rs);			
		}
			
		return list;
	}

	@Override
	public List<RentDto> getRentList(String id) {	
			
		String sql =	" select * "  
					+	" from rc_rent " 
					+   " where com_name in (select com_name  "
					+   " 					from rc_info "
					+   "					where com_name in (select name " 
					+							 " 				from rc_member  "
					+						"					where id = ? )) ";
					
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<RentDto> list = new ArrayList<RentDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getCalendarList Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 getCalendarList Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getCalendarList Success");
			
			while(rs.next()) {
				RentDto dto = new RentDto();
				dto.setRent_seq(rs.getInt(1));
				dto.setRent_carname(rs.getString(2));
				dto.setRent_start(rs.getString(3));
				dto.setRent_end(rs.getString(4));
				dto.setCus_id(rs.getString(5));
				dto.setCom_num(rs.getInt(6));
				dto.setPrice(rs.getInt(7));
				dto.setRc_name(rs.getString(8));
				dto.setRc_phone(rs.getString(9));
				dto.setRc_address(rs.getString(10));
				dto.setRc_card(rs.getString(11));
				dto.setRc_photo(rs.getString(12));
				list.add(dto);				
			}
			System.out.println("4/6 getCalendarList Success");
			
		} catch (Exception e) {
			System.out.println("getCalendarList Fail");
		} finally {			
			DBClose.close(psmt, conn, rs);			
		}
			
		return list;
	}
	

}
