package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import model.MemberDto;
import model.RentDto;
import model.ReviewDto;

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
			psmt.setString(11, rDto.getCom_name());
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
	
	
	// 회사 실적 ★ ★ ★ ★ ★ ★ ★ ★ ★ ★
	@Override
	public HashMap<String, Integer> getComSaleMonthly( String when) {
		//1.company dto소환
				memberDao memdao= memberDao.getInstance();
				List<MemberDto> comdto = memdao.getComList();
				
				//2.리턴할 해시맵
				HashMap<String, Integer> comSaleMap = new HashMap<>();
				List<String> months = new ArrayList<>();
				for (int i=1; i<13;i++) {
					months.add("0"+i);
					if (months.size()==9) {
						months.add(i+"");
					}
				}

				String curTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
				String thisMonth = curTime.substring(4, 6);
				
				for(int i=0; i<comdto.size();i++) {
					String sql="SELECT SUM(PRICE) FROM RC_RENT WHERE RC_START LIKE '2018-?-%' AND COM_NAME=? ORDER BY COM_NAME";
					
					System.out.println("SQL : "+sql);
					Connection conn=null;
					PreparedStatement psmt = null;
					ResultSet rs = null;
					
						try {
							conn=DBConnection.getConnection();
								System.out.println("1/6 getComSaleMonthly Success");
							psmt=conn.prepareStatement(sql);
							if(when.equals("이번달")) {//각회사의 이번달 실적
								psmt.setString(1, thisMonth);
								psmt.setString(2, comdto.get(i).getMember_name());
							}else if (when.equals("월별")) {//각회사의 월별 실적
								psmt.setString(1, months.get(i));
								psmt.setString(2, comdto.get(i).getMember_name());
							}
							System.out.println("2/6 getComSaleMonthly Success");			
			
							rs=psmt.executeQuery();
								System.out.println("3/6 getComSaleMonthly Success");			
							if(rs.next()) {
								comSaleMap.put(comdto.get(i).getMember_name(), rs.getInt(1));						
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
				//확인출력
				 Iterator<String> mapIter = comSaleMap.keySet().iterator();
			        while(mapIter.hasNext()) {
			            String key = mapIter.next();
			            int value = comSaleMap.get( key );
			            System.out.println("map == "+key+" : "+value);
			        }
				return comSaleMap;
	}

	//월별 차종 판매량★ ★ ★ ★ ★ ★ ★ ★ ★ ★
	@Override
	public HashMap<String, Integer> getCarSaleMonthly() {
		//1.company dto소환
				memberDao memdao= memberDao.getInstance();
				List<MemberDto> comdto = memdao.getComList();
				//리턴할 해시맵		
				HashMap<String, Integer> carSaleMap = new HashMap<>();
				List<String> months = new ArrayList<>();
				for (int i=1; i<13;i++) {
					months.add("0"+i);
					if (months.size()==9) {
						months.add(i+"");
					}
				}

		//SQL - 횟수 뽑아오기 
				for(int i=0; i<comdto.size();i++) {
					String sql = "SELECT COUNT(PRICE) FROM RC_RENT WHERE RC_START LIKE '2018-?-%' AND COM_NAME=? ORDER BY COM_NAME";
					System.out.println("SQL : "+sql);
					
					Connection conn=null;
					PreparedStatement psmt = null;
					ResultSet rs = null;
				
					try {
						conn=DBConnection.getConnection();
							System.out.println("1/6 getCarSaleMonthly Success");
						psmt=conn.prepareStatement(sql);
							psmt.setString(1, months.get(i));
							psmt.setString(2,comdto.get(i).getMember_name());
							System.out.println("2/6 getCarSaleMonthly Success");
						rs=psmt.executeQuery();
							System.out.println("3/6 getCarSaleMonthly Success");			
						if(rs.next()) {
							carSaleMap.put(comdto.get(i).getMember_name(), rs.getInt(1));						
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
				//확인출력
				 Iterator<String> mapIter = carSaleMap.keySet().iterator();
			        while(mapIter.hasNext()) {
			            String key = mapIter.next();
			            int value = carSaleMap.get( key );
			            System.out.println("map == "+key+" : "+value);
			        }
				return carSaleMap;
	}
	
	//리뷰불러오기★ ★ ★ ★ ★ ★ ★ ★ ★ ★
	@Override
	public List<ReviewDto> getReview(String carName, String comName) {

		String sql = " SELECT * FROM RC_REVIEW "
				+ " WHERE COM_NUM=(SELECT SEQ FROM RC_INFO WHERE CAR_NAME=? AND COM_NAME=?)";
		
		System.out.println("sql : "+sql);
		System.out.println("carName : "+carName+"comName : "+comName);
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<ReviewDto> dtoList = new ArrayList<>();
		
		try {
			conn=DBConnection.getConnection();
				System.out.println("1/6 getReview Success");
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, carName);
			psmt.setString(2, comName);
				System.out.println("2/6 getReview Success");
			rs=psmt.executeQuery();
				System.out.println("3/6 getReview Success");
								
			if(rs.next()) {
				int i=1;
				ReviewDto dto=new ReviewDto(rs.getInt(i++), 
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getString(i++),
										  rs.getInt(i++),
										  rs.getInt(i++));
				dtoList.add(dto);
			}else {
				ReviewDto dto= null;
				dtoList.add(dto);
			}
			
			System.out.println("4/6 getReview Success");
		} catch (Exception e) {
			System.out.println("getReview Failed!!!!!!!!");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		for(int i=0; i<dtoList.size() ; i++) {
			System.out.println("review : "+dtoList.get(i));
		}
		return dtoList;
	}
	@Override
	public int getreviewCount(String carName, String comName) {
		String sql = " SELECT COUNT(CONTENT) FROM RC_REVIEW "
				+ " WHERE COM_NUM=(SELECT SEQ FROM RC_INFO WHERE CAR_NAME=? AND COM_NAME=?)";
		
		System.out.println("sql : "+sql);
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int count=0;
		
		try {
			conn=DBConnection.getConnection();
				System.out.println("1/6 getreviewCount Success");
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, carName);
			psmt.setString(2, comName);
				System.out.println("2/6 getreviewCount Success");
			rs=psmt.executeQuery();
				System.out.println("3/6 getreviewCount Success");
			while(rs.next()) {
				count++;
			}
			System.out.println("4/6 getreviewCount Success");
		} catch (Exception e) {
			System.out.println("getreviewCount Failed!!!!!!!!");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("review수 : "+count);
		
		return count;
	}
	
	
	

}
