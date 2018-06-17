package com.model;

public class Doctor {
    protected int doctorID ;
    protected String firstName ;
    protected String lastName ;
    protected String email ;
    protected String address ;
    protected int departmentKey ;
    protected int specializationKey ;
    protected boolean status ;
    protected int phone ;
    protected String Gender ;

    public String getGender() {
        return Gender;
    }

    public void setGender(String gender) {
        Gender = gender;
    }

    public Doctor() {
    }

    public Doctor(int doctorID, String firstName, String lastName, String email, String address, int departmentKey, int specializationKey, int phone,boolean status) {
        this.doctorID = doctorID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.address = address;
        this.departmentKey = departmentKey;
        this.specializationKey = specializationKey;
        this.status = status;
        this.phone = phone;
    }

    public Doctor(String firstName, String lastName, String email, String address, int departmentKey, int specializationKey, int phone) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.address = address;
        this.departmentKey = departmentKey;
        this.specializationKey = specializationKey;
        this.phone = phone;
    }

    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getDepartmentKey() {
        return departmentKey;
    }

    public void setDepartmentKey(int departmentKey) {
        this.departmentKey = departmentKey;
    }

    public int getSpecializationKey() {
        return specializationKey;
    }

    public void setSpecializationKey(int specializationKey) {
        this.specializationKey = specializationKey;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }
}
