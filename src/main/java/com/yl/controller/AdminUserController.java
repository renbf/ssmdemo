package com.yl.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.yl.modle.AdminUser;
import com.yl.service.IAdminUserService;
/**
 * @author rbf
 * @createdate 2018/12/13 03:15
 * @desriction
 */
@Controller
@RequestMapping(value = "/adminUser")
public class AdminUserController {
	private Logger logger = LoggerFactory.getLogger(AdminUserController.class);
	@Autowired
	private IAdminUserService adminUserService;
	
	@RequestMapping(value = "/getAdminUserList")
	public ModelAndView getAdminUserList(HttpServletRequest request) {
		List<AdminUser> list = adminUserService.queryAdminUserAll();
		ModelAndView mv = new ModelAndView("adminUser");
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		mv.addAllObjects(result);
		return mv;
	}
	
	@RequestMapping(value = "/addAdminUser",method=RequestMethod.POST)
	@ResponseBody
	public String addAdminUser(AdminUser adminUser) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			adminUserService.addAdminUser(adminUser);
			result.put("code", 1);
			result.put("msg", "新增成功");
			return JSON.toJSONString(result);
		} catch (Exception e) {
			logger.error("新增失败",e);
			result.put("code", 0);
			result.put("msg", "新增失败");
			return JSON.toJSONString(result);
		}
	}
	@RequestMapping(value = "/updateAdminUser",method=RequestMethod.POST)
	@ResponseBody
	public String updateAdminUser(AdminUser adminUser) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			adminUserService.updateAdminUser(adminUser);
			result.put("code", 1);
			result.put("msg", "修改成功");
			return JSON.toJSONString(result);
		} catch (Exception e) {
			result.put("code", 0);
			result.put("msg", "修改失败");
			return JSON.toJSONString(result);
		}
	}
	@RequestMapping(value = "/deleteAdminUserByKey",method=RequestMethod.POST)
	@ResponseBody
	public String deleteAdminUserByKey(Integer adminId) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			adminUserService.deleteAdminUserByKey(adminId);
			result.put("code", 1);
			result.put("msg", "删除成功");
			return JSON.toJSONString(result);
		} catch (Exception e) {
			result.put("code", 0);
			result.put("msg", "删除失败");
			return JSON.toJSONString(result);
		}
	}
}
