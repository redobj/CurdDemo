package com.redobj.crud.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redobj.crud.bean.Msg;
import com.redobj.crud.service.DepartmentService;

/**
 * 处理和部门有关的请求
 * @author mr.zou
 *
 */
@Controller
public class DeptController {
	@Autowired
	private DepartmentService departmentService;
	
	@ResponseBody
	@RequestMapping("/depts")
	public Msg getDepts() {
		return Msg.success().add("deptsInfo", departmentService.getAll());
	}
}
