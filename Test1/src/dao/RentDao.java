package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
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
		
		System.out.println("sql loop Start=============== : ");
		for(int i =0 ; i<memdtoList.size() ; i++) {
		
			String sql = "SELECT COUNT(PRICE) FROM RC_RENT WHERE CUS_ID='"+memdtoList.get(i).getMember_id().trim()+"'";
			System.out.println("sql : "+sql);
			
			Connection conn=null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			int count=0;
			
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getRentMember Success");
				psmt=conn.prepareStatement(sql);
			/*		System.out.println("id : "+memdtoList.get(i).getMember_id());
				psmt.setString(1,memdtoList.get(i).getMember_id().trim());
					System.out.println("2/6 getRentMember Success");*/
				rs=psmt.executeQuery();
					System.out.println("3/6 getRentMember Success");
					
				if(rs.next()) {
					count=rs.getInt(1);
					System.out.println(count);
				}
				
				System.out.println(memdtoList.get(i).getMember_id()+" 의 count == "+count);
				countMap.put(memdtoList.get(i).getMember_id(), count);

			} catch (Exception e) {
					System.out.println("getRentMember Failed!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			
		}
		System.out.println("sql loop End=============== : ");
		
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
		
		System.out.println("sql loop Start=============== : ");
		for(int i =0 ; i<memdtoList.size() ; i++) {
		
			String sql = "SELECT COUNT(PRICE) FROM RC_RENT WHERE CUS_ID='"+memdtoList.get(i).getMember_id().trim()+"'";
			System.out.println("sql : "+sql);
			
			Connection conn=null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			int count=0;
			
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getRentMember Success");
				psmt=conn.prepareStatement(sql);
			/*		System.out.println("id : "+memdtoList.get(i).getMember_id());
				psmt.setString(1,memdtoList.get(i).getMember_id().trim());
					System.out.println("2/6 getRentMember Success");*/
				rs=psmt.executeQuery();
					System.out.println("3/6 getRentMember Success");
					
				if(rs.next()) {
					count=rs.getInt(1);
					System.out.println(count);
				}
				
				System.out.println(memdtoList.get(i).getMember_id()+" 의 price == "+count);
				priceMap.put(memdtoList.get(i).getMember_id(), count);

			} catch (Exception e) {
					System.out.println("getRentMember Failed!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			
		}
		System.out.println("sql loop End=============== : ");
		return priceMap;
	}
	
	//회사별 주문건수
	@Override
	public HashMap<String, Integer> getComOrderCount() {
	
		return null;
	}
	

	//회사별 주문금액
	@Override
	public HashMap<String, Integer> getComOrderPrice() {
		
		//comList
		memberDao memdao = new memberDao();
		List<MemberDto> comdtoList = new ArrayList<>();
		comdtoList = memdao.getComList();
		
		//Return용 해시맵
		HashMap<String, Integer> priceMap = new HashMap<>();
		
		System.out.println("sql loop Start=============== : ");
		for(int i =0 ; i<comdtoList.size() ; i++) {
		
			String sql = "SELECT COUNT(PRICE) FROM RC_RENT WHERE CUS_ID='"+memdtoList.get(i).getMember_id().trim()+"'";
			System.out.println("sql : "+sql);
			
			Connection conn=null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			int count=0;
			
			try {
				conn=DBConnection.getConnection();
					System.out.println("1/6 getRentMember Success");
				psmt=conn.prepareStatement(sql);
			/*		System.out.println("id : "+memdtoList.get(i).getMember_id());
				psmt.setString(1,memdtoList.get(i).getMember_id().trim());
					System.out.println("2/6 getRentMember Success");*/
				rs=psmt.executeQuery();
					System.out.println("3/6 getRentMember Success");
					
				if(rs.next()) {
					count=rs.getInt(1);
					System.out.println(count);
				}
				
				System.out.println(comdtoList.get(i).getMember_id()+" 의 price == "+count);
				priceMap.put(comdtoList.get(i).getMember_id(), count);

			} catch (Exception e) {
					System.out.println("getRentMember Failed!!!!");
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			
		}
		System.out.println("sql loop End=============== : ");
		return priceMap;
	}
	
}
