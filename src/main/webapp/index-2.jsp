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
button {
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
	<!-- Modal -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="addForm">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="empName_input"
									name="empName" placeholder="Employee Name"> <small
									class="help-block"> * 请输入真实姓名 3-16位全英文字符或2-5位全中文字符</small>
							</div>

						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email_input"
									placeholder="Email@redobj.com" name="email"> <small
									class="help-block"> * 请输入正确的邮箱格式 employee@redobj.com</small>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									id="gender_radio1" value="M" name="gender" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									id="gender_radio2" value="W" name="gender"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">所属部门</label>
							<div class="col-sm-6">
								<select class="form-control " name="dId" id="dept">
								</select>
							</div>
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>

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
			<div class="col-md-3 col-md-offset-8"
				style="margin-top: 20px; margin-bottom: 20px">
				<button class="btn btn-primary" id="add_btn">新增</button>
				<button class="btn btn-danger" id="del_btn">删除</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
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
			<div class="col-md-8 col-md-offset-2" id="nav_area"></div>
		</div>

		<!-- 分页信息 -->
		<div class="row" align="center">
			<div class="col-md-8 col-md-offset-2" id="nav_info"></div>
		</div>
	</div>
</body>
<script src="${APP_PATH}/Static/js/jquery.min.js"></script>
<script src="${APP_PATH}/Static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	//总记录数
	var totalRec;

	/* 1、页面加载完成后，直接去发送一个ajax请求，得到数据 */
	$(function() {
		to_page(1);
	});

	$("#add_btn").click(function() {
		/* 清除表单数据 */
		/* reset()方法是DOM对象的方法 */
		$("#addForm")[0].reset();
		$("#addModal input").removeAttr("ajax-va");
		$("#addModal").find(".help-block").empty();
		$("#addModal form div").removeClass("has-success has-error");
		/* 点击新增按钮弹出模态框 */
		$("#addModal").modal({
			backdrop : 'static'
		});
		/* 发送ajax请求获得部门信息 */
		$.ajax({
			url : "${APP_PATH}/depts",
			type : "GET",
			success : function(result) {
				/* console.log(result); */
				setDepts(result);
			}
		});
	});

	/* 填写就检测 */
	$("#empName_input").change(function() {
		/* 发送ajax后端检测 */
		username_check();
	});

	//前端校验
	$("#email_input")
			.change(
					function() {
						var regx = /^([A-Za-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
						regx_select($("#email_input"), regx,
								"* 请输入正确的邮箱格式 employee@redobj.com");
					});

	/* 模态框中的内容发送给服务器保存 */
	$("#saveBtn").click(function() {
		/* 数据校验 */
		 if (regx_data() == false) {
			return;
		} 

		//防止数据为改变不触发ajax
		if ($("#empName_input").attr("ajax-va") == "fail") {
			show_msg($("#empName_input"), false, " 用户名已被使用");
			return false;
		}
		/* alert($("#addModal form").serialize()); */
		$.ajax({
			url : "${APP_PATH}/emp",
			type : "POST",
			/* 使用JQuery封装的方法提取表单数据*/
			data : $("#addModal form").serialize(),
			success : function(result) {
				if(result.code == 100){
					alert(result.msg);
					/* 1、关闭模态框 */
					$('#addModal').modal('hide');
					/* 2、跳转到末页 */
					/* 传入很大的数字比如总记录数，利用PageInfo的reasonable合理化参数属性使其跳转到最后一页 */
					to_page(totalRec);
				}
				if(result.code == 200){
					if(result.extend.fieldError.empName){
						show_msg($("#empName_input"),false,result.extend.fieldError.empName);
					}
					if(result.extend.fieldError.email){
						show_msg($("#email_input"),false,result.extend.fieldError.email);
					}
					
				}
			}
		});
	});

	/* ajax检测用户名 */
	function username_check() {
		var username = $("#empName_input").val();
		$.ajax({
			url : "${APP_PATH}/checkUser",
			data : "username=" + username,
			success : function(result) {
				if (result.code == 100) {
					show_msg($("#empName_input"), true, result.extend.va_msg);
					/* 增加自定义属性方便检测 */
					$('#empName_input').attr("ajax-va", "success");
					return true;
				}
				if (result.code == 200) {
					show_msg($("#empName_input"), false, result.extend.va_msg);
					$('#empName_input').attr("ajax-va", "fail");
					return false;
				}
			}

		});
	}

	/* 前端数据校验函数 */
	function regx_data() {
		var regx_name = /(^[A-Za-z0-9-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
		var regx_email = /^([A-Za-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		if ($("#empName_input").attr("ajax_va")=="success"
				&& regx_select($("#email_input"), regx_email,
						"* 请输入正确的邮箱格式 employee@redobj.com")) {
			return true;
		} else {
			return false;
		}
	}

	/* 检测方法 */
	function regx_select(ele, regx, msg) {
		if (regx.test(ele.val()) == false) {
			show_msg(ele, false, msg);
			return false;
		} else {
			show_msg(ele, true, msg);
		}

	}

	/* 校验信息显示 */
	function show_msg(ele, status, msg) {
		ele.next("small").empty();
		ele.parent().removeClass("has-success has-error");
		if (status) {
			ele.parent().addClass("has-success");
		} else {
			ele.next("small").append(msg)
			ele.parent().addClass("has-error");
		}

	}

	/* 设置部门信息 */
	function setDepts(result) {
		/* 清空信息 */
		$("#dept").empty();
		$.each(result.extend.deptsInfo, function() {
			var temp = $("<option></option>").attr({
				"value" : this.deptId
			}).append(this.deptName);
			$("#dept").append(temp);
		});
	}

	function build_emps_table(result) {
		/* 清空表格信息 */
		$("#empsT tbody").empty();
		var emps = result.extend.pageInfo.list;
		$.each(emps, function(index, item) {
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empName);
			var genderTd = $("<td></td>")
					.append(item.gender == 'M' ? '男' : '女');
			var emailTd = $("<td></td>").append(item.email);
			var deptNameTd = $("<td></td>").append(item.dept.deptName);
			var editBtn = $("<button></button>").addClass(
					"btn btn-primary btn-sm").append("<span></span>").addClass(
					"glyphicon glyphicon-pencil").append("编辑");
			var delBtn = $("<button></button>").addClass(
					"btn btn-danger btn-sm").append("<span></span>").addClass(
					"glyphicon glyphicon-trash").append("删除");
			var btnM = $("<td></td>").append(editBtn).append(delBtn);
			$("<tr></tr>").append(empIdTd).append(empNameTd).append(genderTd)
					.append(emailTd).append(deptNameTd).append(btnM).appendTo(
							"#empsT tbody");
		});
	}

	function build_page_nav_info(result) {
		/* 清空分页信息 */
		$("#nav_info").empty();
		var navInfo = $("<small></small>").css({
			"margin-right" : "10px",
			"color" : "gray"
		}).append(
				"当前页：" + result.extend.pageInfo.pageNum + " 总页数："
						+ result.extend.pageInfo.pages + " 总记录数："
						+ result.extend.pageInfo.total);
		$("#nav_info").append(navInfo);
	}

	function build_page_nav(result) {
		/* 清空分页条 */
		$("#nav_area").empty();
		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
		var previousLi = $("<li></li>").append(
				$("<a></a>").append("&laquo; 上一页"));
		var nextLi = $("<li></li>").append($("<a></a>").append("下一页 &raquo;"));
		var pn = result.extend.pageInfo.navigatepageNums;
		var ul = $("<ul></ul>").addClass("pagination");
		/* 添加首页和上一页 */
		if (result.extend.pageInfo.hasPreviousPage == false) {
			firstPageLi.addClass("disabled");
			previousLi.addClass("disabled");
		} else {
			firstPageLi.click(function() {
				to_page(1);
			});
			previousLi.click(function() {
				to_page(result.extend.pageInfo.pageNum - 1)
			});
		}

		ul.append(firstPageLi).append(previousLi);
		/* 1、2、3... */
		$.each(pn, function(index, item) {
			if (item == result.extend.pageInfo.pageNum) {
				var tempLi = $("<li></li>").addClass("active").append(
						$("<a></a>").append(item));
			} else {
				var tempLi = $("<li></li>").append($("<a></a>").append(item))
						.click(function() {
							to_page(item);
						});
			}
			ul.append(tempLi);
		});
		/* 添加下一页和末页 */
		if (result.extend.pageInfo.hasNextPage == false) {
			nextLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		} else {
			lastPageLi.click(function() {
				to_page(result.extend.pageInfo.pages);
			});

			nextLi.click(function() {
				to_page(result.extend.pageInfo.pageNum + 1);
			});
		}
		ul.append(nextLi).append(lastPageLi);
		$("#nav_area").append($("<nav></nav>").append(ul));
	}

	/* 跳转方法 */
	function to_page(pn) {
		$.ajax({
			url : "${APP_PATH}/emps",
			data : "pn=" + pn,
			type : "GET",
			success : function(result) {
				totalRec = result.extend.pageInfo.total;
				/* console.log(result); */
				/* 1、解析并显示员工数据 */
				build_emps_table(result)
				/* 2、解析并显示分页信息 */
				build_page_nav_info(result);
				/* 3、解析显示分页条 */
				build_page_nav(result);
			}
		});
	}
</script>
</html>