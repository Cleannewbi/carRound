package service;

import dao.InfoDao;
import model.InfoDto;

public class InfoDaoService implements InfoDaoServiceImpl {
	InfoDao dao = new InfoDao();
	@Override
	public InfoDto getCarInfo(String Car_name, String comName) {
		return dao.getCarInfo(Car_name, comName);
	}

}
