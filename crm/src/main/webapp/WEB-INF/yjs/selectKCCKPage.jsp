<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%-- <base href="<%=basePath%>"> --%>

<title>My JSP 'userslist.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<link rel="<%=basePath%>shortcut icon" href="favicon.ico">
<link href="<%=basePath%>css/bootstrap.min.css?v=3.3.5" rel="stylesheet">
<link href="<%=basePath%>css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
<link href="<%=basePath%>css/plugins/footable/footable.core.css" rel="stylesheet">

 	<script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
<link href="<%=basePath%>css/animate.min.css" rel="stylesheet">
<link href="<%=basePath%>css/style.min.css?v=4.0.0" rel="stylesheet">
<base target="_blank">
</head>

<body>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">

		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>库存仓库信息</h5>
						
						<h5><a href="KCCKControllerCtrl/add.do">添加仓库信息</a></h5>
						<div class="ibox-tools">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a> <a class="dropdown-toggle" data-toggle="dropdown" href="#">
								<i class="fa fa-wrench"></i>
							</a>
							<ul class="dropdown-menu dropdown-user">
								<li><a href="#">选项 01</a></li>
								<li><a href="#">选项 02</a></li>
							</ul>
							<a class="close-link"> <i class="fa fa-times"></i>
							</a>
						</div>
					</div>
					<div class="ibox-content">
					<form action="listPage.do" method="post" target="_self">
					<input type="text" name="cangkuName" id="t1" placeholder="请输入仓库名" style=" width: 200px;height: 30px;font-size: 16pt; ">
   					&nbsp;
		   			<button  id="b1"  type="submit"  class="btn btn-primary btn-lg" 
		   			 style="width: 100px;height: 30px;
		   			border: 1px solid blue;position: absolute;top: 63px;line-height: 10px" >搜索</button>
		   			</form>
		   			<br>
		   			<h2><a href="add.do" target="_self">添加</a></h2>
		   			<br>
						<h2><a id="deleteSelect" target="_self">删除选中</a></h2>
						<table class="footable table table-stripped toggle-arrow-tiny"
							data-page-size="8">
							<thead> 
							<tr>
									<th data-toggle="true"><input type="checkbox" id="selectAll" ></th>
									<th>仓库编号</th>
									<th>仓库名</th>
									<th>备注信息</th>
									<th>公司编号</th>
									<th>最后修改时间</th>
									<th>操作</th>
								</tr>
							</thead>							
							
								<tbody>
								<c:forEach items="${p.list }" var="k">
									<tr style="text-align: center;">
										<td><input type="checkbox" name="c1" class="c1" value="${k.cangkuId}"></td>
										<td>${k.cangkuId }</td>
										<td>${k.cangkuName}</td>
										<td>${k.cangkuNote}</td>
										<td>${k.companyId }</td>
										<td><fmt:formatDate value="${k.cangkuLastModifyTime }"
												pattern="yyyy-MM-dd HH:mm:ss" />
										<td><a
											href="goupdate.do?cangkuId=${k.cangkuId }" target="_self">修改</a>
											/ <a
											href="delete.do?kcck=${k.cangkuId}"
											onclick="return confirm('是否确定删除？')" target="_self">删除</a></td>
		
									</tr>
								</c:forEach>								
							</tbody>
							<tfoot>
								<tr>
									<td style="text-align: center;" colspan="12"><a
									target="_self"
										href="listPage.do?pageNum=${p.firstPage }">首页</a>
										<a target="_self" href="listPage.do?pageNum=${p.prePage }">上一页</a>
										<a target="_self" href="listPage.do?pageNum=${p.nextPage }">下一页</a>
										<a target="_self" href="listPage.do?pageNum=${p.lastPage }">尾页</a>
										当前${p.pageNum }/${p.pages }页，共${p.total }条</td>
								</tr>
						 </tfoot>
							
						</table>

					</div>
				</div>
			</div>
		</div>

</body>

</html>

<script type="text/javascript">
	$(document).ready(function(){
	

		 //全选
		$("#selectAll").click(function(){
			if($(this).prop("checked")){
				$(".c1").prop("checked", true)
			}else{
				$(".c1").prop("checked",false)
			}
		})
	
		//选中删除
		$("#deleteSelect").click(function(){
		
			 var myArr=new Array();
			 var a=""
			myArr=$("input[name='c1']")
			var i
			for(i=0;i<myArr.length;i++){
				if(myArr[i].checked==true){
					a+="ckid="+myArr[i].value+"&";
				}
			}
				var isdelete=confirm("是否确定删除？" );
				if(isdelete){
					location.href="kcckDeleteSelect.do?"+a;
				}
				/* else{
					location.href="listPage.do";
				} */
				
		})
			
				
	})
</script>

