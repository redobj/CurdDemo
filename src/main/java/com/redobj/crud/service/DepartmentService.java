package com.redobj.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.redobj.crud.bean.Department;
import com.redobj.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	private DepartmentMapper mapper;
	
	/**
	 * 查询所有部门
	 */
	public List<Department> getAll(){
		return mapper.selectByExample(null);
	}
}
