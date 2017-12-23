package test;


import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.io.Resources;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.redobj.crud.bean.Department;
import com.redobj.crud.bean.Employee;
import com.redobj.crud.bean.EmployeeExample;
import com.redobj.crud.dao.DepartmentMapper;
import com.redobj.crud.dao.EmployeeMapper;

/**
 * 测试dao层的工作
 * @author mr.zou
 * 推荐Spring的项目使用Spring的单元测试，可以自动注入我们需要的组件
 * 1、导入SpringTest
 * 2、ContextConfiguration指定Spring配置文件的位置 
 * 3、直接Autowired需要的组件即可
 */
@ContextConfiguration(locations="classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class MapperTest {
	
	@Autowired
	private DepartmentMapper deptMapper;
	
	/**
	 * 测试departmentMapper
	 * @throws IOException
	 */
	@Test
	public void testCrud() throws IOException {
		/*
		//		1、创建springIoc容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//		2、从容器中获取Mapper
		DepartmentMapper deptMapper = ioc.getBean(DepartmentMapper.class);
		*/
		
		System.out.println(deptMapper);
//		1、插入几个部门
		deptMapper.insertSelective(new Department(null, "宣传部"));
	}

}
