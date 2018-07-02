package com.usermanage.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.usermanage.model.Msg;
import com.usermanage.pojo.Employee;
import com.usermanage.service.EmployeeService;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

//    /**
//     *普通返回数据
//     * @param pn
//     * @param model
//     * @return
//     */
//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model){
//
//        PageHelper.startPage(pn,5);
//        List<Employee> emps = employeeService.getAll();
//        PageInfo page = new PageInfo(emps);
//        model.addAttribute("pageInfo",page);
//        return "userlist";
//    }


    /**
     * 返回json
     *
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    //返回json需要maven导入jackson-databind
    public Msg getEmpsJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5,"emp_id asc");
        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps);
        return Msg.success().add("PageInfo", page);
    }

    /**
     * 保存员工信息
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/check")
    public Msg check( String empName){
        boolean b = employeeService.checkEmpname(empName);
        if (b){
           return Msg.fail(); //有重名,名字不可用
        }else
           return Msg.success(); //没有重名,名字可用
    }


}