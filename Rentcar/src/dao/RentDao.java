package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
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
	
	//회사별 주문건수
	@Override
	public HashMap<String, Integer> getComOrderCount() {
		//1.준비 comList
			iMemManager memdao = MemManager.getInstance();
			List<MemberDto> comdtoList = new ArrayList<>();
			comdtoList = memdao.getComList();
					
			// Return용 해시맵
			HashMap<String, Integer> countMap = new HashMap<>();
			
			//sql 의 seq / sql2의 name 
			List<Integer> com_numList = new ArrayList<>();
			List<String> com_nameList = new ArrayList<>();
				
		//2. SQL -  RC_RENT 의 COM_NUM SELECT
			String sql = "SELECT COM_NUM FROM RC_RENT";
			
			Connection conn=null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
	
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getComOrderCount Success");
				psmt=conn.prepareStatement(sql);
				rs=psmt.executeQuery();
					System.out.println("2/6 getComOrderCount Success");
					
				while(rs.next()) {
					com_numList.add(rs.getInt(1));
				}
	
			} catch (Exception e) {
					System.out.println("getComOrderCount 1st Failed!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}

		//3. SQL2 - RC_INFO 의 COM_NAME SELECT
			for (int i=0; i<com_numList.size();i++) {
				String sql2 = "SELECT COM_NAME FROM RC_INFO WHERE SEQ=?";
	
				try {
					conn=DBConnection.getConnection();
						System.out.println("3/6 getComOrderCount Success");
					psmt=conn.prepareStatement(sql2);
					psmt.setInt(1, com_numList.get(i));
					rs=psmt.executeQuery();
						System.out.println("4/6 getComOrderCount Success");			
					if(rs.next()) {
						com_nameList.add(rs.getString(1));
					}
				} catch (Exception e) {
						System.out.println("getComOrderCount 2nd Failed!!!!");
					e.printStackTrace();
				}finally {
					DBClose.close(psmt, conn, rs);
				}
				System.out.println(i+"번째 com_numList : "+com_nameList.get(i));
			}

		//4. 뽑아온 COM_NAME과 비교할 dto(기업) 이름
			List<String> comdtonameList =new ArrayList<>();
			for(int i=0; i<comdtoList.size() ; i++) {
				comdtonameList.add(comdtoList.get(i).getMember_name());
			}
			
		//5. 비교작업
			int count=0;
			for(int i = 0; i<comdtonameList.size(); i++){
				   for(int j = 0; j<com_nameList.size(); j++){
				   if(comdtonameList.get(i).equals(com_nameList.get(j))) {
				     count++;
				     System.out.println(i+"번째 dtoList : "+comdtonameList.get(i)+" / "+j+"번째 comList : "+com_nameList.get(j));
				   }
				  }
				   countMap.put(comdtonameList.get(i), count);
				   count=0;
				}		
		return countMap;
	}
	
	//회사별 주문금액
	@Override
	public HashMap<String, Integer> getComOrderPrice() {
		//1.준비 comList
			iMemManager memdao = MemManager.getInstance();
			List<MemberDto> comdtoList = new ArrayList<>();
			comdtoList = memdao.getComList();
					
			//Return용 해시맵
			HashMap<String, Integer> priceMap = new HashMap<>();
			
			//sql 의 seq / sql2의 name 
			List<Integer> com_numList = new ArrayList<>();
			List<String> com_nameList = new ArrayList<>();
				
		//2. SQL -  RC_RENT 의 COM_NUM SELECT
			String sql = "SELECT SEQ FROM RC_RENT";
			
			Connection conn=null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
	
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getComOrderCount Success");
				psmt=conn.prepareStatement(sql);
				rs=psmt.executeQuery();
					System.out.println("2/6 getComOrderCount Success");
					
				while(rs.next()) {
					com_numList.add(rs.getInt(1));
				}
	
			} catch (Exception e) {
					System.out.println("getComOrderCount 1st Failed!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
	
		//3. SQL2 - RC_INFO 의 COM_NAME SELECT
			for (int i=0; i<com_numList.size();i++) {
				String sql2 = "SELECT SUM(PRICE), COM_NUM FROM RC_RENT WHERE COM_NUM=? GROUP BY COM_NUM";
	
				try {
					conn=DBConnection.getConnection();
						System.out.println("3/6 getComOrderCount Success");
					psmt=conn.prepareStatement(sql2);
					psmt.setInt(1, com_numList.get(i));
					rs=psmt.executeQuery();
						System.out.println("4/6 getComOrderCount Success");			
					if(rs.next()) {
						com_nameList.add(rs.getString(1));
					}
				} catch (Exception e) {
						System.out.println("getComOrderCount 2nd Failed!!!!");
					e.printStackTrace();
				}finally {
					DBClose.close(psmt, conn, rs);
				}
				System.out.println(i+"번째 com_numList : "+com_nameList.get(i));
			}
	
		//4. 뽑아온 COM_NAME과 비교할 dto(기업) 이름
			List<String> comdtonameList =new ArrayList<>();
			for(int i=0; i<comdtoList.size() ; i++) {
				comdtonameList.add(comdtoList.get(i).getMember_name());
			}
			
		//5. 비교작업
			int count=0;
			for(int i = 0; i<comdtonameList.size(); i++){
				   for(int j = 0; j<com_nameList.size(); j++){
				   if(comdtonameList.get(i).equals(com_nameList.get(j))) {
				     count++;
				     System.out.println(i+"번째 dtoList : "+comdtonameList.get(i)+" / "+j+"번째 comList : "+com_nameList.get(j));
				   }
				  }
				   priceMap.put(comdtonameList.get(i), count);
				   count=0;
				}		
		
		return priceMap;
	}
	
	
	
	
	
}
