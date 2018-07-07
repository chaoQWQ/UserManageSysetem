
var totalRecord;
var currentPage;
/**
 * 员工表构建
 * @param result
 */
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
        var checkBoxTd = $("<td><input type='checkbox' class='check_item'></input></td>");
        var empIdTd = $("<td></td>").append(emp.empId);
        var empNameTd = $("<td></td>").append(emp.empName);
        var genderTd = $("<td></td>").append(emp.gender);
        var emailTd = $("<td></td>").append(emp.email);
        var deptNameTd = $("<td></td>").append(emp.department.deptName);
        var botton = $("<td></td>").append(editBtn).append(" ").append(delBtn);


        var tr = $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(botton);
        tr.appendTo("#emps_table tbody");

    });
}

/**
 * 分页信息构建
 * @param result
 */
function build_page_info(result) {
    $("#page_info_area").empty();
    $("#page_info_area").append("当前第"
        + result.valList.PageInfo.pageNum
        + "页,总"
        + result.valList.PageInfo.pages
        + "页,总共"
        + result.valList.PageInfo.total
        + "有条记录")
    totalRecord = result.valList.PageInfo.total;
    currentPage = result.valList.PageInfo.pageNum;

}

/**
 * 分页条构建
 */
function build_page_nav(result) {
    $("#page_nav_area").empty();
    var ul = $("<ul></ul>").addClass("pagination");
    var firstPageLi = $("<li></li>")
        .append($("<a></a>").append("首页").attr("href", "#"));
    var prePageLi = $("<li></li>")
        .append($("<a></a>").append("&laquo;"));
    if (!result.valList.PageInfo.hasPreviousPage) {
        firstPageLi.addClass("disabled");
        prePageLi.addClass("disabled");
    } else {
        firstPageLi.click(function () {
            to_page(1);
        });
        prePageLi.click(function () {
            to_page(result.valList.PageInfo.pageNum - 1);
        });
    }
    var nextPageLi = $("<li></li>")
        .append($("<a></a>").append("&raquo;"));
    var lastPageLi = $("<li></li>")
        .append($("<a></a>").append("尾页").attr("href", "#"));
    if (!result.valList.PageInfo.hasNextPage) {
        lastPageLi.addClass("disabled");
        nextPageLi.addClass("disabled");
    } else {
        lastPageLi.click(function () {
            to_page(result.valList.PageInfo.pages);
        });
        nextPageLi.click(function () {
            to_page(result.valList.PageInfo.pageNum + 1);
        });
    }
    ul.append(firstPageLi).append(prePageLi);
    $.each(result.valList.PageInfo.navigatepageNums, function (index, item) {
        var numLi = $("<li></li>")
            .append($("<a></a>").append(item));
        if (result.valList.PageInfo.pageNum == item) {
            numLi.addClass("active");
        }
        numLi.click(function () {
            to_page(item)
        });
        ul.append(numLi);
    });
    ul.append(nextPageLi).append(lastPageLi);
    var navEle = $("<nav></nav>").append(ul);
    $("#page_nav_area").append(navEle);
}



/**
 * 弹出新增员工模态框
 */

$("#emp_add_motal_btn").click(function() {


    resetform();
    //查询出部门信息显示在下拉框
    getDepts("#dept_add_area");


    //弹出模态框
    $("#empAddModal").modal({
        backdrop : "static" //点击空白处退出模态框
    });

    $("#save_emp_info").unbind('click');
    $("#save_emp_info").click(function () {

        //验证输入
        if (!validata_add_form()){
            return false;
        }


            $.ajax({
            url:"http://localhost:8080/emp",
            type:"post",
            data:$("#emp_add_form").serialize(),
            success:function (result) {
                console.log(result);
                if (result.code == 200) {
                    //关闭模态框
                    $("#empAddModal").modal('hide');
                    //跳转到员工最后一页
                    to_page(totalRecord);
                }else {
                    if (result.valList.errorFields.email!=undefined){
                        show_validate_msg("#email_add_input","error",result.valList.errorFields.email);
                    }else if (result.valList.errorFields.empName!=undefined){
                        show_validate_msg("#empName_add_input","error",result.valList.errorFields.empName);
                    }
                }

            }
        });



    });
});

/**
 * 验证用户名是否重复
 *
 */
$("#empName_add_input").change(function () {
    clearErrorInfo();
    var empname = this.value;
    $.ajax({
        url:"http://localhost:8080/check",
        type:"get",
        data:"empName="+empname,
        success:function (result) {
            if (result.code==100){
                // $("#empName_add_input").parent().addClass("has-error");
                // $("#empName_add_input ").next("span").text(result.valList.va_msg);
                show_validate_msg("#empName_add_input","error",result.valList.va_msg);
                $("#emp_add_form ").attr("formStatus","hasError");
                console.log("aaaa");

            }
            else if(result.code==200){
                // $("#empName_add_input").parent().addClass("has-success");
                show_validate_msg("#empName_add_input","success","");
                $("#emp_add_form ").attr("formStatus","isOk");
                console.log("bbbb");

            }

        }
    })
});


/**
 * 弹出修改信息框
 */
//为“编辑”按钮绑定点击事件
$(document).on("click",".edit_btn", function () {
    //清除之前信息
    $("#dept_update_area").html('');
    //填入信息到模态框
    getDepts("#dept_update_area");
    var thisId = $(this).attr("edit-id");
    console.log("当前id:"+thisId);
    getEmp(thisId);

    //打开模态框
    $("#empUpdateModal").modal({
        backdrop : "static" //点击空白处退出模态框
    });

    $("#update_emp_info").click(function() {
        //校验邮箱
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式输入错误");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //保存员工数据
        $.ajax({
            url : "http://localhost:8080/emp/" + thisId,
            type : "PUT",
            data : $("#emp_updata_form").serialize(),
            success : function(result) {
                if (result.code == 200) {
                    //关闭模态框
                    $("#empUpdateModal").modal("hide");
                    //回到本页面
                    to_page(currentPage);
                } else {
                    alert("更新失败");
                }
            }
        });
    });


});

/**
 * 单个删除操作
 */
$(document).on("click", ".delete_btn",function () {
    var thisId = $(this).attr("del-id");
    console.log($(this).parents());
    console.log($(this).parent());
    var empName = $(this).parents("tr").find("td:eq(2)").text();
    if (confirm("确认删除【"+empName+"】吗?")) {
        $.ajax({
            url : "http://localhost:8080/emp/" + thisId,
            type : "delete",
            success : function (result) {
                to_page(currentPage);
                alert("删除成功");
            }
        });
    }

});


/**
 * 批量删除功能
 */
$("#check-all").click(function(){
    $(".check_item").prop("checked",$(this).prop("checked"));
});
//单选点满，全选按钮也要勾上
$(document).on("click",".check_item",function(){
    //判断是否全部勾选
    var flag = $(".check_item:checked").length==$(".check_item").length;
    $("#check-all").prop("checked",flag);
});

//点击全部删除
$("#emp_delete_all_btn").click(function(){
    var empNames = "";
    var del_idstr = "";
    $.each($(".check_item:checked"),function(index,item){
        empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
        del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
    });
    empNames = empNames.substring(0,empNames.length-1);
    del_idstr = del_idstr.substring(0,del_idstr.length-1);
    if(confirm("确认删除"+empNames+"?")){
        $.ajax({
            url:"http://localhost:8080/emp/" + del_idstr,
            type:"DELETE",
            success:function(result){
                to_page(currentPage);
            }
        });
    }
});

/**
 * 验证表单输入信息
 * @returns {boolean}
 */
function validata_add_form() {
    //清除之前的报错信息
    clearErrorInfo();

    var empName = $("#empName_add_input").val();
    var regName = /^[a-z0-9_-]{5,16}$|^[\u2E80-\u9FFF]{2,5}$/;
    if ($("#emp_add_form").attr("formStatus")=="isOk"){
        if (!regName.test(empName)) {
            $("#empName_add_input").parent().addClass("has-error");
            $("#empName_add_input ").next("span").text('请输入正确的用户名');
            return false;
        }
        else{
            $("#empName_add_input").parent().addClass("has-success");
        }
    }else if ($("#emp_add_form").attr("formStatus")=="hasError") {
        $("#empName_add_input").parent().addClass("has-error");
        $("#empName_add_input ").next("span").text('用户名已存在');
        return false;
    }


    var empEmail = $("#email_add_input").val();
    var regEmail = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
    if (!regEmail.test(empEmail)){
        $("#email_add_input").parent().addClass("has-error");
        $("#email_add_input").next("span").text('请输入正确的邮箱');
        return false;
    }
    else {
        $("#email_add_input").parent().addClass("has-success");
    }

    return true;
}

function show_validate_msg(ele, status, msg) {
    if ("success" == status) {
        $(ele).parent().addClass("has-success");
        $(ele).next("span").text("");
    } else if ("error" == status) {
        $(ele).parent().addClass("has-error");
        $(ele).next("span").text(msg);
    }
}

function resetform() {
    $("#emp_add_form")[0].reset();
    $("#dept_add_area").html('');
    clearErrorInfo();
}
function clearErrorInfo() {
    $("#empName_add_input").parent().removeClass("has-error has-success");
    $("#email_add_input").parent().removeClass("has-error has-success");
    $("#empName_add_input").next("span").text('');
    $("#email_add_input").next("span").text('');
}

function getEmp(id) {
    $.ajax({
        url : "http://localhost:8080/emp/" + id,
        type : "GET",
        success : function(result) {
            var empData = result.valList.emp;
            $("#empName_update_static").text(empData.empName);
            $("#email_update_input").val(empData.email);
            $("#empUpdateModal input[name=gender]").val([ empData.gender ]);
            $("#empUpdateModal select").val([ empData.dId ]);
        }
    })
}

function getDepts(ele) {
    $.ajax({
        url: "http://localhost:8080/depts",
        type: "GET",
        success: function (result) {
            console.log(result);
            var deptInfo = result.valList.alldepts;
            $.each(deptInfo, function (index, item) {
                var option = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                option.appendTo(ele);
            });
        }
    });

}

