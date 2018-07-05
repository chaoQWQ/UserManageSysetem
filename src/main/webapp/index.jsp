<%--
  Created by IntelliJ IDEA.
  User: zc
  Date: 18-5-29
  Time: 下午10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>--%>
<html>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<%--<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">--%>
<%--<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>--%>
<%--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<%--<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>--%>
<script src="${APP_PATH}/static/jquery-1.9.1.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<head>
    <title>用户管理系统</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="bookmark" href="favicon.ico" type="image/x-icon" />
</head>
<body>

<!-- 新增员工模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="text-center" id="myModalLabel"><span style="color: #2b669a">添加员工</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_add_form">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName_add_input"
                                   name="empName" placeholder="张三">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email_add_input"
                                   name="email" placeholder="xxx@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="gender1_add_input" name="gender"
                               class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline"> <input type="radio"
                                                                name="gender" id="gender1_add_input" value="男"
                                                                checked="checked"> 男
                            </label> <label class="radio-inline"> <input type="radio"
                                                                         name="gender" id="gender2_add_input" value="女"> 女
                        </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept_add_area" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_area">

                            </select>
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="save_emp_info">保存</button>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- 信息修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="text-center" id="myModalLabel2"><span style="color: #2b669a">信息修改</span></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_updata_form">
                    <div class="form-group">
                        <label for="empName_update_static" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email_update_input"
                                   name="email" placeholder="xxx@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="gender1_update_input" name="gender"
                               class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline"> <input type="radio"
                                                                name="gender" id="gender1_update_input" value="男"
                                                                checked="checked"> 男
                            </label> <label class="radio-inline"> <input type="radio"
                                                                         name="gender" id="gender2_update_input" value="女"> 女
                        </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept_update_area" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_area">

                            </select>
                        </div>
                    </div>
                </form>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="update_emp_info">保存</button>
                </div>
            </div>
        </div>

    </div>
</div>


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
            <button type="button" class="btn btn-primary" id="emp_add_motal_btn">新增员工</button>
            <button type="button" class="btn btn-danger" id="testmodal">（危险）</button>
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
        <div class="col-md-6" id="page_info_area">

        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                console.log(result);
                build_emp_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }




</script>
<script type="text/javascript" src="static/index.js"></script>
</body>
</html>
