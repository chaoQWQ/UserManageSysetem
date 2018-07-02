package com.usermanage.controller;

import com.usermanage.model.Msg;
import com.usermanage.pojo.Department;
import com.usermanage.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @RequestMapping("depts")
    @ResponseBody
    public Msg getDeptinfo(){
        List<Department> result = departmentService.getAll();
        return Msg.success().add("alldepts",result);
    }
}
