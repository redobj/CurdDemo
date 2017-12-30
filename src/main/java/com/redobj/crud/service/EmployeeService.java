package com.redobj.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.redobj.crud.bean.Employee;
import com.redobj.crud.bean.EmployeeExample;
import com.redobj.crud.bean.EmployeeExample.Criteria;
import com.redobj.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper empMapper;

	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		return empMapper.selectByExampleWithDept(null);
	}

	/**
	 * 插入员工数据
	 * @param emp
	 */
	public void insertService(Employee emp) {
		empMapper.insertSelective(emp);
	}

	/**
	 * 检测员工姓名是否重复
	 * @param username
	 * @return true为可用
	 */
	public boolean checkUser(String username) {
		EmployeeExample example = new EmployeeExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andEmpNameEqualTo(username);
		long count = empMapper.countByExample(example);
		return count==0;
	}

	/**
	 * 员工查询
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = empMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * 员工更新
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		empMapper.updateByPrimaryKeySelective(employee);
	}
	
}
