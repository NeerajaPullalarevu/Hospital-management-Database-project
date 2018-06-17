package com.model;

public class Department {
    protected String departmentID ;
    protected String name;

    public Department() {
    }

    public Department(String departmentID, String name) {
        this.departmentID = departmentID;
        this.name = name;
    }

    public String getDepartmentID() {
        return departmentID;
    }

    public void setDepartmentID(String departmentID) {
        this.departmentID = departmentID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
