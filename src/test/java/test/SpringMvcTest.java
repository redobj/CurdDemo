package test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.redobj.crud.bean.Employee;

/**
 * 使用Spring测试模块提供的测试请求功能测试，测试crud请求的正确性
 * @author mr.zou
 *
 */

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml","classpath:springDispatcherServlet.xml"})
public class SpringMvcTest {

	//传入SpringMvc的Ioc
	@Autowired
	WebApplicationContext webApplicationContext;
	//虚拟mvc请求，获取到处理结果
	MockMvc mockMvc ;
	
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	}
	
	@Test
	public void testPage() throws Exception {
//		模拟请求得到返回值 
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		
//		请求成功后，请求域中会有pageInfo
		PageInfo<Employee> pageInfo  =(PageInfo<Employee>) result.getRequest().getAttribute("pageInfo");
		System.out.println("当前页码："+pageInfo.getPageNum());
		System.out.println("总页码："+pageInfo.getPages());
		System.out.println("总记录数："+pageInfo.getTotal());
		System.out.println("在页面需要显示的页码");
		int[] nums = pageInfo.getNavigatepageNums();
		for (int i : nums) {
			System.out.print(i+" ");
		}
		System.out.println();
		List<Employee> emps = pageInfo.getList();
		for (Employee employee : emps) {
			System.out.println(employee.getDept().getDeptName()+employee.getEmpName());
		}
	}
}
