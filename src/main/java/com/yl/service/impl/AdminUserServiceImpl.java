package com.yl.service.impl;

import com.yl.dao.AdminUserDao;
import com.yl.modle.AdminUser;
import com.yl.service.IAdminUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author rbf
 * @createdate 2018/12/13 03:15
 * @desriction
 */
@Service
public class AdminUserServiceImpl implements IAdminUserService {
	@Autowired
	private AdminUserDao adminUserDao;

	public List<AdminUser> queryAdminUserAll() {

		return adminUserDao.queryAdminUserAll();
	}

	public AdminUser queryAdminUserByUserName(String userName) {
		return adminUserDao.queryAdminUserByUserName(userName);
	}

	@Override
	@Transactional
	public int addAdminUser(AdminUser adminUser) throws Exception{
			return adminUserDao.addAdminUser(adminUser);
	}

	@Override
	@Transactional
	public int updateAdminUser(AdminUser adminUser) throws Exception{
		return adminUserDao.updateAdminUser(adminUser);
	}

	@Override
	@Transactional
	public int deleteAdminUserByKey(Integer adminId) throws Exception{
		return adminUserDao.deleteAdminUserByKey(adminId);
	}


}
