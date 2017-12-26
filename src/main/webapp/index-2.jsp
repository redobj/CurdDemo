<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- 
	WEB路径：
	不以/开始的相对路径：从当前位置开始找资源
	以/开始的绝对路径：从服务器目录开始找资源
 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${APP_PATH}/Static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<title>员工列表</title>
<style type="text/css">
button{
	margin: 2px
}
td {
	text-align: center;
}

th {
	text-align: center;
}
</style>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1 align="center">
					员工管理系统 <small style="color: gray; font-style: italic;">Designed
						by RedObj</small>
				</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8"
				style="margin-top: 20px; margin-bottom: 20px">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<table class="table table-striped" id="empsT">
				<thead>
					<tr>
						<th>#</th>
						<th><span class="glyphicon glyphicon-user"></span> 姓名</th>
						<th><span class="glyphicon glyphicon-inbox"></span> 性别</th>
						<th><span class="glyphicon glyphicon-envelope"></span> 邮箱</th>
						<th><span class="glyphicon glyphicon-tint"></span> 部门</th>
						<th><span class="glyphicon glyphicon-cog"></span> 操作</th>
					</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>

		<!-- 分页条 -->
		<div class="row" align="center">
			<div class="col-md-6 col-md-offset-4">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					<c:if test="${pageInfo.hasPreviousPage }">
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach items="${pageInfo.navigatepageNums}" var="nav">
						<c:if test="${nav == pageInfo.pageNum}">
							<li class="active"><a href="${APP_PATH}/emps?pn=${nav}">${nav}</a></li>
						</c:if>
						<c:if test="${nav != pageInfo.pageNum}">
							<li><a href="${APP_PATH}/emps?pn=${nav}">${nav}</a></li>
						</c:if>

					</c:forEach>
					<c:if test="${pageInfo.hasNextPage }">
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
					<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
				</ul>
				</nav>
			</div>
		</div>

		<!-- 分页信息 -->
		<div class="row" align="center">
			<div class="col-md-6 col-md-offset-4">
				<small style="margin-right: 10px; color: gray">
					当前页：${pageInfo.pageNum } 总页数：${pageInfo.pages }
					总记录数：${pageInfo.total } 
				</small>
			</div>
		</div>
	</div>
</body>
<script src="${APP_PATH}/Static/js/jquery.min.js"></script>
<script src="${APP_PATH}/Static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	/* 1、页面加载完成后，直接去发送一个ajax请求，得到数据 */
	$(function(){
		$.ajax({
			url:"${APP_PATH}/emps",
			data:"pn=1",
			type:"GET",
			success:function(result){
				/* console.log(result); */
				/* 1、解析并显示员工数据 */
				build_emps_table(result)
				/* 2、解析并显示分页信息 */
			}
		});
	});
	
	function build_emps_table(result){
		var emps = result.extend.pageInfo.list;
		$.each(emps,function(index,item){
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empId);
			var genderTd = $("<td></td>").append(item.gender=='M'?'男':'女');
			var emailTd= $("<td></td>").append(item.email);
			var deptNameTd = $("<td></td>").append(item.dept.deptName); 
			var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm")
							.append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
			var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm")
			.append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
			var btnM = $("<td></td>").append(editBtn).append(delBtn);
			$("<tr></tr>")
			.append(empIdTd)
			.append(empNameTd)
			.append(genderTd)
			.append(emailTd)
			.append(deptNameTd)
			.append(btnM)
			.appendTo("#empsT tbody")
			;
		});
	}
	
	function build_page_nav(result){
		
	}
	
</script>
</html>