package com.usermanage.service;

import com.usermanage.pojo.Employee;

import java.util.List;

public interface EmployeeService {
    public List<Employee> getAll();

    public void saveEmp(Employee employee);

    public boolean checkEmpname(String empName);
}
