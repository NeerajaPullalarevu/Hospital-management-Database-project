package com;
import com.model.*;

import javax.print.Doc;
import java.sql.*;
import java.util.ArrayList;


public class dbConnection  {
    dbHelper helper = new dbHelper();
    private java.sql.Connection connection ;
    String nameDB = "hcc";
    String URL = "jdbc:mysql://localhost:3306/hcm";
    String USER = "root";
    String PASSWORD = "root";

    protected void setDriver() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    protected Connection setConnection() {
        if(connection == null){
            setDriver();

            try {
                this.connection = DriverManager.getConnection(URL,USER,PASSWORD);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }

    public int insertDoctor(Doctor doctor) throws SQLException {
        int result = 0 ;
        PreparedStatement insertion ;
        String sql = "INSERT INTO `hcm`.`doctor` (`doctor_name`, `Phone`, `Address`, `Specialisation_SpecialisationId`, `Department_Department ID`, `Email`)"
                +" VALUES (?, ?, ?, ?, ?,?);" ;

        insertion = setConnection().prepareStatement(sql);
        insertion.setString(1,doctor.getFirstName()+" "+doctor.getLastName());
        insertion.setInt(2,doctor.getPhone());
        insertion.setString(3,doctor.getAddress());
        insertion.setString(6,doctor.getEmail());
        insertion.setInt(5,doctor.getDepartmentKey());
        insertion.setInt(4,doctor.getSpecializationKey());

        result = insertion.executeUpdate();
        connection.close();
        insertion.close();
        return result ;
    }

    public int insertPatient(patient patient) throws SQLException {
        int result = 0 ;
        PreparedStatement insertion ;
        String sql = "INSERT INTO `hcm`.`patient` (`patientName`, `Phone`, `Address`, `Date of birth`, `Gender`, `Email`)"
                +" VALUES (?, ?, ?, ?, ?, ?);" ;
        insertion = setConnection().prepareStatement(sql);

        insertion.setString(1,patient.getName());
        insertion.setInt(2,patient.getPhone());
        insertion.setString(3,patient.getAddress());
        insertion.setDate(4,patient.getDataBirth());
        insertion.setString(5,patient.getGender());
        insertion.setString(6,patient.getEmail());

        result = insertion.executeUpdate();
        connection.close();
        insertion.close();
        return result ;
    }



    public ResultSet getTestsByID(int ID) throws  SQLException {
        String sql = " SELECT * FROM hcm.patient_has_test where `testPatientID` =" + ID ;
        Statement statement = setConnection().createStatement();
        return  statement.executeQuery(sql);
    }

    public ResultSet getRays() throws  SQLException {
        String sql = "SELECT * FROM hcm.ray" ;
        Statement statement = setConnection().createStatement();
        return  statement.executeQuery(sql);
    }
    public int insertPatientRay(int ID,String name,java.sql.Date now) throws SQLException {
        int result = 0 ;
        PreparedStatement insertion ;
        String sql = "INSERT INTO `hcm`.`patient_has_ray` (`rayPatient_ID`, `name_ray`, `Date_ray`) VALUES(?,?,?)";
        insertion = setConnection().prepareStatement(sql);
        insertion.setInt(1,ID);
        insertion.setString(2,name);
        insertion.setDate(3,now);
        result = insertion.executeUpdate() ;
        insertion.close();
        return result ;
    }
    public String getMedecine(String name) throws SQLException {
        String Code = "";
        String SQL = "SELECT `Name` FROM hcm.medicine where `medicineCode` =" + name ;
        Statement statement = setConnection().createStatement();
        ResultSet rs = statement.executeQuery(SQL);
        while (rs.next()){
            Code = rs.getString(1);
        }
        return Code;
    }
    public int insertPatientMedecine(int ID,String name,java.sql.Date now,int quantity) throws SQLException {
        int result = 0;
        PreparedStatement insertion ;
        String SQL = "INSERT INTO `hcm`.`patient_has_medicine` (`Patient_Patient ID`, `medicine_ID`, `Date`, `Quantity`) " +
                "VALUES (?, ?,?,?)";


        insertion = setConnection().prepareStatement(SQL);

        insertion.setInt(1,ID);
        insertion.setInt(2,Integer.valueOf(name));
        insertion.setDate(3,now);
        insertion.setInt(4,quantity);
        result = insertion.executeUpdate() ;
        insertion.close();
        return result ;

    }
    public void insertBill(int id) throws SQLException {
        int result = 0 ;
        PreparedStatement insertion ;
        String SQL = "Insert into bill (`amount`,`Patient ID`,`bill_date`) VALUES ((\n" +
                "SELECT SUM(procedure_price) FROM bill_view) , ? , DATE(now())\n" +
                ");";
        String sql = "INSERT INTO `hcm`.`patient_has_ray` (`rayPatient_ID`, `name_ray`, `Date_ray`) VALUES(?,?,?)";
        insertion = setConnection().prepareStatement(SQL);
        insertion.setInt(1,id);
        insertion.executeUpdate() ;


    }
    public void getBillPatient(int patientID)  {


        String sql;
        sql = "CREATE OR REPLACE VIEW `hcm`.`bill_view` AS \n" +
                "SELECT `name_ray` as procedure_name,`Date_ray` as procedure_date,`ray`.`Ray_Price` as procedure_price  \n" +
                "\tFROM `hcm`.`patient_has_ray`\n" +
                "INNER JOIN `hcm`.`ray` \n" +
                "\tON `name_ray` = `Ray_Name`\n" +
                "WHERE `rayPatient_ID` = "+ patientID  +
                " UNION  \n" +
                "SELECT `name_test`,`Date_test`,`test`.`Test_Price` \n" +
                "\tFROM `patient_has_test`\n" +
                "INNER JOIN `test` \n" +
                "\tON `Test_Name` = `name_test`\n" +
                "WHERE `testPatientID` =  " + patientID  ;
        //sql = "USE hcm; SELECT name_ray ,Date_ray ,ray.Ray_Price FROM patient_has_ray INNER JOIN hcm.ray ON name_ray = Ray_Name  where rayPatient_ID = 1 UNION SELECT name_test,Date_test,test.Test_Price FROM patient_has_test INNER JOIN hcm.test ON Test_Name = name_test where testPatientID = 1";
        //sql = "SELECT * FROM hcm.bill_view" ;
        Statement  statement = null;
        try {
            statement = setConnection().createStatement();
            //System.out.println(sql);
               statement.execute(sql);
            //System.out.println(" process successfully created!");
            //System.out.println(sql);

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
    public int insertPatientTest(int ID,String name,java.sql.Date now) throws SQLException {
        int result = 0 ;
        PreparedStatement insertion ;
        String sql = "INSERT INTO `hcm`.`patient_has_test` (`testPatientID`, `name_test`, `Date_test`) VALUES(?,?,?)";
        insertion = setConnection().prepareStatement(sql);
        insertion.setInt(1,ID);
        insertion.setString(2,name);
        insertion.setDate(3,now);
        result = insertion.executeUpdate() ;
        insertion.close();
        return result ;
    }

    public int insertTest(String name,float price){
        int result = 0 ;
        String SQL = "INSERT INTO `hcm`.`test` (`Test_Name`, `Test_Price`) VALUES (?,?)" ;
        PreparedStatement insertion ;
        try {
            insertion = setConnection().prepareStatement(SQL);
            insertion.setString(1,name);
            insertion.setFloat(2,price);
            result = insertion.executeUpdate() ;
            insertion.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result ;
    }

    public int insertRay(String name,float price){
        int result = 0 ;
        PreparedStatement insertion ;
        String SQL = "INSERT INTO `hcm`.`ray` (`Ray_Name`, `Ray_Price`) VALUES (?,?)" ;
        try {
            insertion = setConnection().prepareStatement(SQL);
            insertion.setString(1,name);
            insertion.setFloat(2,price);
            result = insertion.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result ;
    }

    public int insertMedicine(String name,int code){
        int __result = 0 ;
        PreparedStatement medicine ;
        String SQL = "INSERT INTO `hcm`.`medicine` (`medicineCode`, `Name`) VALUES (?,?)" ;
        try {
            medicine = setConnection().prepareStatement(SQL);
            medicine.setString(1,name);
            medicine.setInt(2,code);

            __result = medicine.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return __result ;
    }
    public ResultSet getRay(String name) throws  SQLException {
        String sql = "SELECT * FROM hcm.ray where `Ray_Name` = " + "'" + name + "'";
        //System.out.println(sql);
        Statement statement = setConnection().createStatement();
        return  statement.executeQuery(sql);
    }

    public ResultSet getTest(String name) throws  SQLException {
        String sql = "SELECT * FROM hcm.test where `Test_Name` = " + "'" + name + "'";
        //System.out.println(sql);
        Statement statement = setConnection().createStatement();
        return  statement.executeQuery(sql);
    }

    public ResultSet getTests() throws  SQLException {
        String sql = "SELECT * FROM hcm.test ";
        Statement statement = setConnection().createStatement();
        return  statement.executeQuery(sql);
    }

    public ResultSet getRaysByID(int ID) throws  SQLException {
        String sql = " SELECT * FROM hcm.patient_has_ray where `rayPatient_ID` = " + ID ;
        Statement statement = setConnection().createStatement();
        return  statement.executeQuery(sql);
    }

    public Doctor getDoctorByID(int ID) throws SQLException{
        Doctor doctor = new Doctor() ;
        Statement statement = setConnection().createStatement();

        String sql = "SELECT * FROM hcm.doctor WHERE `Doctor_ID` = " + ID ;
        ResultSet resultSet = statement.executeQuery(sql) ;
        while (resultSet.next()){
            doctor.setDoctorID(resultSet.getInt(helper.DOCTOR_ID));
            //System.out.println(resultSet.getString(helper.NAME));
            doctor.setFirstName(resultSet.getString(helper.NAME));
            doctor.setEmail(resultSet.getString(helper.EMAIL));
            doctor.setAddress(resultSet.getString(helper.ADDRESS));
            doctor.setPhone(resultSet.getInt(helper.PHONE));
            doctor.setDepartmentKey(resultSet.getInt(helper.DEPARTMENT));
            doctor.setSpecializationKey(resultSet.getInt(helper.SPECIALIZATION));
            doctor.setGender(resultSet.getString(helper.GENDER));
        }

        return doctor ;
    }
    public patient getPatienByID(int ID) throws SQLException {

        String sql = "SELECT * FROM hcm.patient WHERE `PatientID` = " + ID ;
        Statement statement = setConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql) ;
        patient patient = new patient();
        while (resultSet.next()){

            patient.setPatientID(resultSet.getInt(helper.PATIENT_COL_ID));
            patient.setName(resultSet.getString(helper.PATIENT_COL_NAME));
            patient.setEmail(resultSet.getString(helper.PATIENT_COL_EMAIL));
            patient.setAddress(resultSet.getString(helper.PATIENT_COL_ADDRESS));
            patient.setPhone(resultSet.getInt(helper.PATIENT_COL_PHONE));
            patient.setDataBirth(resultSet.getDate(helper.PATIENT_COL_BIRTH));
            patient.setDoctorID(resultSet.getString(helper.PATIENT_COL_DOCTORid));
            patient.setGender(resultSet.getString(helper.PATIENT_COL_GENDER));
            patient.setDischarge(resultSet.getDate(helper.PATIENT_COL_DISCHARGE));
        }
        return patient ;
    }
    public ArrayList<Doctor> getListDoctors() throws SQLException {
        ArrayList<Doctor> doctorList = new ArrayList<>();
        Statement statement ;
        String sql = "SELECT * FROM hcm.doctor;" ;
        statement = setConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql) ;
        while (resultSet.next()){
            //System.out.println(resultSet.getString(helper.NAME));
            Doctor doctor = new Doctor();
            doctor.setDoctorID(resultSet.getInt(helper.DOCTOR_ID));
            doctor.setFirstName(resultSet.getString(helper.NAME));
            doctor.setEmail(resultSet.getString(helper.EMAIL));
            doctor.setAddress(resultSet.getString(helper.ADDRESS));
            doctor.setPhone(resultSet.getInt(helper.PHONE));
            doctor.setDepartmentKey(resultSet.getInt(helper.DEPARTMENT));
            doctor.setSpecializationKey(resultSet.getInt(helper.SPECIALIZATION));

            doctorList.add(doctor);
        }
        resultSet.close();
        statement.close();
        connection.close();
        return doctorList;

    }


    public ArrayList<patient> getPatientsList() throws SQLException {
        ArrayList<patient> list  = new ArrayList<>();
        Statement statement ;
        String sql = "SELECT * FROM hcm.patient;" ;
        statement = setConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql) ;
        while (resultSet.next()) {
            //System.out.println(resultSet.getString(helper.NAME));
            patient patient = new patient();
            patient.setPatientID(resultSet.getInt(helper.PATIENT_COL_ID));
            patient.setName(resultSet.getString(helper.PATIENT_COL_NAME));
            patient.setEmail(resultSet.getString(helper.PATIENT_COL_EMAIL));
            patient.setAddress(resultSet.getString(helper.PATIENT_COL_ADDRESS));
            patient.setPhone(resultSet.getInt(helper.PATIENT_COL_PHONE));
            patient.setDataBirth(resultSet.getDate(helper.PATIENT_COL_BIRTH));
            patient.setDoctorID(resultSet.getString(helper.PATIENT_COL_DOCTORid));
            patient.setGender(resultSet.getString(helper.PATIENT_COL_GENDER));
            patient.setDischarge(resultSet.getDate(helper.PATIENT_COL_DISCHARGE));
            list.add(patient);
        }
        return list;
    }


    public ArrayList<patient> getPatientByDoctor(int ID) throws SQLException {
        ArrayList<patient> pList  = new ArrayList<>();
        Statement statement ;
        String sql = "SELECT * FROM hcm.patient where `Doctor_Doctor ID` = "+ ID ;
        statement = setConnection().createStatement();
        ResultSet query = statement.executeQuery(sql) ;
        while (query.next()) {
            patient patient_doc = new patient();
            patient_doc.setPatientID(query.getInt(helper.PATIENT_COL_ID));
            patient_doc.setEmail(query.getString(helper.PATIENT_COL_EMAIL));
            patient_doc.setAddress(query.getString(helper.PATIENT_COL_ADDRESS));
            patient_doc.setPhone(query.getInt(helper.PATIENT_COL_PHONE));
            patient_doc.setName(query.getString(helper.PATIENT_COL_NAME));
            patient_doc.setDataBirth(query.getDate(helper.PATIENT_COL_BIRTH));
            patient_doc.setDoctorID(query.getString(helper.PATIENT_COL_DOCTORid));
            patient_doc.setGender(query.getString(helper.PATIENT_COL_GENDER));
            patient_doc.setDischarge(query.getDate(helper.PATIENT_COL_DISCHARGE));
            pList.add(patient_doc);
        }
        return pList;
    }

    public ResultSet getSQL(String sql ) throws SQLException {
        Statement statement ;
        statement = setConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        return resultSet ;
    }

    public int getCount(String table,String column) throws SQLException {
        int count = 0 ;
        Statement statement ;
        String sql = "SELECT COUNT(" + "`"+column+"`" + ")" +" FROM hcm."+ table +" " ;
        statement = setConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            count = resultSet.getInt(1);
        }

        return count;
    }

    public float getSumBillView(String Date) throws SQLException {
        float sum = 0 ;
        String billSumSql = "select SUM(procedure_price) from hcm.bill_view where procedure_date >= '"+Date+"'" ;

        Statement statement;
        statement = setConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(billSumSql);
        while (resultSet.next()) {
            sum = resultSet.getInt(1);
        }

        return sum;

    }

    public int getSum(String table,String column) throws SQLException {
        Statement statement;
        int sum = 0 ;
        String sql = "SELECT COUNT(" + "`"+column+"`" + ")" +" FROM hcm."+ table +" " ;
        statement = setConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            sum = resultSet.getInt(1);
        }

        return sum;

    }

    public boolean searchInTestTable(String name ) throws SQLException {
        int Result  = 0 ;
        String Sql = "SELECT * FROM hcm.test where Test_Name LIKE '%"+name +"%';" ;
        Statement statement ;
        System.out.println(Sql);
        statement = setConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(Sql);
        resultSet.last();
        Result = resultSet.getRow();
        if(Result>0){
            return true;
        }else {
            return false;
        }
    }





}
