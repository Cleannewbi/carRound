package dao;

import java.util.HashMap;
import java.util.List;

import dto.RentDto;

public interface iRentDao {
	public boolean setReservation(RentDto rDto);
	public HashMap<String, Integer> getOrderCount();
	public HashMap<String,Integer> getOrderPrice();
	public HashMap<String, Integer> getComOrderCount();
	public HashMap<String, Integer> getComOrderPrice();
	public List<RentDto> getRentList();
	public List<RentDto> getRentList(String id);
}
