<%--
  Created by IntelliJ IDEA.
  User: zc
  Date: 18-5-29
  Time: 下午10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<link
        href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet">
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script
        src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<head>
    <title>用户管理系统</title>
</head>
<body>
<!-- 搭建显示list -->
<div class = "container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class = "row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary">（首选项）Primary</button>
            <button type="button" class="btn btn-danger">（危险）Danger</button>
        </div>
    </div>
    <!-- 列表 -->
    <div class = "row">
        <div>
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>dept</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>


            </table>
        </div>
    </div>
    <!-- 信息 -->
    <div class = "row">
        <!-- 分页文字信息 -->
        <div class="col-md-6">

        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">

                </ul>
            </nav>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $.ajax({
            url:"${APP_PATH}/emp2",
            data:"pn=1",
            type:"GET",
            success:function(result){
                console.log(result);
                build_emp_table(result);
            }
        });
    });

    function build_emp_table(result) {

        $("#emps_table tbody").empty();

        var emplist = result.valList.PageInfo.list;
        $.each(emplist,function(index,emp){
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            editBtn.attr("edit-id", emp.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            delBtn.attr("del-id", emp.empId);
            var empIdTd = $("<td></td>").append(emp.empId);
            var empNameTd = $("<td></td>").append(emp.empName);
            var genderTd = $("<td></td>").append(emp.gender);
            var emailTd = $("<td></td>").append(emp.email);
            var deptNameTd = $("<td></td>").append(emp.department.deptName);
            var botton = $("<td></td>").append(editBtn).append(" ").append(delBtn);


            var tr = $("<tr></tr>").append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(botton);
            tr.appendTo("#emps_table tbody");
            console.log(index);

        });
    }



</script>
</body>
</html>
