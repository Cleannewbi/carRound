package dao;

import java.util.HashMap;
import java.util.List;

import model.RentDto;
import model.ReviewDto;

public interface RentDaoImpl {
	public boolean setReservation(RentDto rDto);
	public HashMap<String, Integer> getOrderCount();
	public HashMap<String,Integer> getOrderPrice();
	public HashMap<String, Integer> getComOrderCount();
	public HashMap<String, Integer> getComOrderPrice();
	public List<RentDto> getRentList();
	
	//★★★★★★★★★★★★★★★★
	
	public HashMap<String, Integer> getComSaleMonthly(int month);
	public HashMap<String, Integer> getCarSaleMonthly(int month);
	public List<String> getCarName();//orderby carname
	public List<String> getComName();//orderby comname
	public List<ReviewDto> getReview(String carName, String comName);
	public int getreviewCount(String carName, String comName);
	public String two(String msg);
}
