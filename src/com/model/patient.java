package com.model;

import java.sql.Date;

public class patient {
    protected int patientID ;
    protected String Name ;
    protected int phone ;
    protected Date dataBirth ;
    protected String gender ;
    protected String email ;
    protected String address ;
    protected String doctorID ;
    protected Date discharge;
    public patient() {
    }
    public patient(String Name,int phone, Date dataBirth, String gender, String email, String address) {
        this.Name = Name;
        this.phone = phone;
        this.dataBirth = dataBirth;
        this.gender = gender;
        this.email = email;
        this.address = address;
    }

    public patient(int patientID, String firstName, int phone, Date dataBirth, String gender, String email, String address, String doctorID, String nursingID, Date discharge) {
        this.patientID = patientID;
        Name = firstName;
        this.phone = phone;
        this.dataBirth = dataBirth;
        this.gender = gender;
        this.email = email;
        this.address = address;
        this.doctorID = doctorID;
        this.discharge = discharge;
    }

    public int getPatientID() {
        return patientID;
    }

    public void setPatientID(int patientID) {
        this.patientID = patientID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String firstName) {
        Name = firstName;
    }




    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }

    public Date getDataBirth() {
        return dataBirth;
    }

    public void setDataBirth(Date dataBirth) {
        this.dataBirth = dataBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
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

    public String getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }


    public Date getDischarge() {
        return discharge;
    }

    public void setDischarge(Date discharge) {
        this.discharge = discharge;
    }
}
