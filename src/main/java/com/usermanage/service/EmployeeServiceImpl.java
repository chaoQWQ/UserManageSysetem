package com.usermanage.service;

import com.usermanage.mapping.EmployeeMapper;
import com.usermanage.pojo.Employee;
import com.usermanage.pojo.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAll(){
        return employeeMapper.selectAll();
    }

    @Override
    public void saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    @Override
    public boolean checkEmpname(String empName){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        if (employeeMapper.countByExample(example)==0){
            return false;
        }else
            return true;
    }
    @Override
    public Employee getEmp(Integer id){
        Employee e = employeeMapper.selectByPrimaryKeyWithDept(id);
        return e;
    }

    @Override
    public void updateEmp(Employee employee){
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
}
