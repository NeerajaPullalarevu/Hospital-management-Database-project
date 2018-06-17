package com.model;

public class Nurse {

    protected String nurseID ;
    protected String name;
    protected String departmentKey ;
    protected String patientID;

    public Nurse(String nurseID, String name, String departmentKey, String patientID) {
        this.nurseID = nurseID;
        this.name = name;
        this.departmentKey = departmentKey;
        this.patientID = patientID;
    }

    public Nurse(String nurseID, String name) {
        this.nurseID = nurseID;
        this.name = name;
    }

    public Nurse() {
    }

    public String getNurseID() {
        return nurseID;
    }

    public void setNurseID(String nurseID) {
        this.nurseID = nurseID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartmentKey() {
        return departmentKey;
    }

    public void setDepartmentKey(String departmentKey) {
        this.departmentKey = departmentKey;
    }

    public String getPatientID() {
        return patientID;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }
}
