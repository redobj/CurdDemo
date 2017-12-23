package test;


import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.util.UUID;

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
import com.redobj.crud.bean.DepartmentExample;
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
	
	@Autowired
	private EmployeeMapper empMapper;
	
//	批处理的SqlSession
	@Autowired
	private SqlSession sqlSession;
	
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
		
		/**
		 * Department部门层测试
		 */
//		1、插入几个部门
//		deptMapper.insertSelective(new Department(null, "宣传部"));
//		2、更新部门信息
//		deptMapper.updateByPrimaryKey(new Department(3, "宣传部"));
//		3、删除部门信息
//		deptMapper.deleteByPrimaryKey(3);
//		4、查询部门信息
//		List<Department> depts = deptMapper.selectByExample(new DepartmentExample());
//		for(Department d:depts) {
//			System.out.println(d.getDeptName());
//		}
		
		/**
		 * Employee 员工层测试
		 */
//		1、插入几个员工
//		empMapper.insertSelective(new Employee(null, "ChenShidong", "M", "ChenShidong@redobjwork.com", 1));
//		2、删除员工
//		empMapper.deleteByPrimaryKey(2);
//		3、修改员工
//		empMapper.updateByPrimaryKey(new Employee(1, "Jerry", "M", "Jerry@redobjwork.com", 2));
//		4、查询员工WithDepartment
//		List<Employee> emps = empMapper.selectByExampleWithDept(new EmployeeExample());
//		for(Employee e : emps) {
//			System.out.println(e.getEmpName()+"  "+e.getDept().getDeptName());
//		}
		
		/**
		 * 批量插入多个员工，使用可以执行批量操作的SqlSession
		 */
		
//		批量操作(配置文档中配置了sqlSession的executorType为BETCH)
//		EmployeeMapper em = sqlSession.getMapper(EmployeeMapper.class);
//		for(int i = 0;i<1000;i++) {
//			String uid = UUID.randomUUID().toString().substring(0, 7);
////			int r = (int)(Math.floor(Math.random()*7+1));
//			int r = new Random().nextInt(7)+1;
//			em.insertSelective(new Employee(null, uid, (r%2==0?"M":"W"), uid+"@redobjwork.com", r));
//		}
	
	}

}
