package com.redobj.crud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	
	/**
	 * 根据id查询单个员工
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public  Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		if(employee!=null) {			
			return Msg.success().add("emp", employee);
		}else {
			return Msg.fail();
		}
	}
	
	/**
	 * 用Ajax直接发送PUT请求引发的血案
	 * 请求体中有数据，但是Employee无法封装
	 * 原因：
	 * 		Tomcat ：
	 * 				1、将请求体中的数据封装为map	
	 * 				2、SpringMVC封装POJO对象是，会把每个对象的值调用request.getParameter()获取
	 * 		Tomcat检测到是PUT请求后不会进行封装map，只有POST请求才封装请求体
	 * 
	 * 要支持PUT请求，还需要封装PUT请求中的数据
	 * 1、配置上HttpPutFormContentFilter
	 * 2、将请求体的解析封装成Map
	 * 3、request被重新包装，重写request.getParameter()方法被重写，就会从自己的封装的map中取值
	 * 
	 * 根据id修改员工
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg updateEmp(Employee employee) {
		System.out.println(employee.getEmail());
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	
	/**
	 * 插入员工
	 * 1、支持JSR303校验
	 * 2、导入Hibernate-Validator
	 * @param emp Spring根据表单自动封装的Employee对象
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="emp",method=RequestMethod.POST)
	public Msg insertEmp(@Valid Employee emp,BindingResult result) {
		if(result.hasErrors()) {
//			校验失败，返回失败信息
			Map<String,Object> maps = new HashMap<String,Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				maps.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("fieldError", maps);
		}else {
			if(employeeService.checkUser(emp.getEmpName())) {
				
				employeeService.insertService(emp);
				return Msg.success();
			}else {
				return Msg.fail().add("fieldError","用户名已被使用");
			}
		}
	}
	
	
	/**
	 * 检测用户名是否重复
	 * @param username
	 * @return 
	 */
	@ResponseBody
	@RequestMapping("/checkUser")
	public Msg checkUser(String username) {
		//先判断用户名是否合法
		String regx = "(^[A-Za-z0-9-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		if(!username.matches(regx)) {
			return Msg.fail().add("va_msg", "* 请输入真实姓名 3-16位全英文字符或2-5位全中文字符");
		}
		if(employeeService.checkUser(username)) {
			return Msg.success().add("va_msg", "✅ 用户名可用");
		}else {
			return Msg.fail().add("va_msg", " 用户名已被使用");
		}
		
	}
	
}
