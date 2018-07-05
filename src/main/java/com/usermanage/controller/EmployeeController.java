package com.usermanage.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.usermanage.model.Msg;
import com.usermanage.pojo.Employee;
import com.usermanage.service.EmployeeService;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> map = new HashMap<String, Object>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @ResponseBody
    @RequestMapping(value = "/check")
    public Msg check( String empName){
        String regname = "^[a-z0-9_-]{5,16}$|^[\\u2E80-\\u9FFF]{2,5}$";
        if (!empName.matches(regname)){
            return Msg.fail().add("va_msg","请输入正确的用户名");
        }else {
            boolean b = employeeService.checkEmpname(empName);
            if (b){
                return Msg.fail().add("va_msg","用户名已存在"); //有重名,名字不可用
            }else
                return Msg.success(); //没有重名,名字可用
        }

    }

    /**
     * 查询单个员工信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee emp = employeeService.getEmp(id);
        return Msg.success().add("emp",emp);
    }

    /**
     * 保存修改信息
     * 注意：是emp/{empId}，而不是emp/{id}或其他，这要和Employee的属性名一致
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }


}