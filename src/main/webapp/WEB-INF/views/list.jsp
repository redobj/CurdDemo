<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
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
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1 align="center">员工管理系统 <small style="color: gray;font-style: italic;">Designed by RedObj</small></h1>
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
				<table class="table table-striped">
					<tr>
						<th>#</th>
						<th><span class="glyphicon glyphicon-user"></span> 姓名</th>
						<th><span class="glyphicon glyphicon-inbox"></span> 性别</th>
						<th><span class="glyphicon glyphicon-envelope"></span> 邮箱</th>
						<th><span class="glyphicon glyphicon-tint"></span> 部门</th>
						<th><span class="glyphicon glyphicon-cog"></span> 操作</th>
					</tr>
					<tr>
						<td>1</td>
						<td>1</td>
						<td>1</td>
						<td>1</td>
						<td>1</td>
						<td>
							<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil"></span>编辑
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash"></span>删除
							</button>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<!-- 分页条 -->
		<div class="row">
			<div class="col-md-6 col-md-offset-4">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="#">首页</a></li>
					<li><a href="#" aria-label="Previous"> <span
							aria-hidden="true">&laquo;</span>
					</a></li>
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#" aria-label="Next"> <span
							aria-hidden="true">&raquo;</span>
					</a></li>
					<li><a href="#">末页</a></li>
				</ul>
				</nav>
			</div>
		</div>

		<!-- 分页信息 -->
		<div class="row">
			<div class="col-md-6 col-md-offset-3" align="center">
				<small style="margin-right: 10px;color: gray;">总记录数：xxx</small>
				<small style="color: gray;">总页数：xxx</small>
			</div>
		</div>
	</div>
</body>
<script src="${APP_PATH}/Static/js/jquery.min.js"></script>
<script src="${APP_PATH}/Static/bootstrap/js/bootstrap.min.js"></script>
</html>