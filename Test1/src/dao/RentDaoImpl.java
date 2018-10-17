package dao;

import java.util.HashMap;
import model.RentDto;

public interface RentDaoImpl {
	public boolean setReservation(RentDto rDto);
	public HashMap<String, Integer> getOrderCount();
	public HashMap<String,Integer> getOrderPrice();
	public HashMap<String, Integer> getComOrderCount();
	public HashMap<String, Integer> getComOrderPrice();
}
