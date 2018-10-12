package service;

import dao.InfoDao;
import model.InfoDto;

public class InfoDaoService implements InfoDaoServiceImpl {
	InfoDao dao = new InfoDao();
	@Override
	public InfoDto getCarInfo(String Car_name) {
		return dao.getCarInfo(Car_name);
	}

}
