package com.usermanage.service;

import com.usermanage.mapping.DepartmentMapper;
import com.usermanage.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DepartmentServiceImpl implements DepartmentService{

    @Autowired
    DepartmentMapper departmentMapper;

    @Override
    public List<Department> getAll(){
        List<Department> result = departmentMapper.selectByExample(null);
        return result;

    }
}
