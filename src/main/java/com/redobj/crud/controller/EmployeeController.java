package com.redobj.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.redobj.crud.bean.Employee;
import com.redobj.crud.bean.Msg;
import com.redobj.crud.service.EmployeeService;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 查询员工数据
	 * @return
	 */
	//@RequestMapping("/emps")
	public String listEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
//		非分页
//		List<Employee> emps = employeeService.getAll();
		
//		引入Pagehelper进行分页
//		在查询前调用，传入页码和页面大小
		PageHelper.startPage(pn,10);
//		startPage后面紧跟的查询就是分页查询 
		List<Employee> emps = employeeService.getAll();
//		使用pageInfo包装查询后的结果，只需要将pageInfo交给页面
		PageInfo<Employee> page = new PageInfo<Employee>(emps,5);
		model.addAttribute("pageInfo",page);
		return "list";
	}
	
	/**
	 * 导入Jackson包，保证ResponseBody正常工作返回json字符串
	 * @param pn
	 * @param model
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		PageHelper.startPage(pn,10);
//		startPage后面紧跟的查询就是分页查询 
		List<Employee> emps = employeeService.getAll();
//		使用pageInfo包装查询后的结果，只需要将pageInfo交给页面
		PageInfo<Employee> page = new PageInfo<Employee>(emps,5);
		return Msg.success().add("pageInfo", page);
	}
}
