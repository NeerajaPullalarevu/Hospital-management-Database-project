
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.model.*" %>
<%@ page import="java.sql.Date" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Calendar" %>

<%--<%@ page import="com.itextpdf.text" %>--%>
<%@page import="com.itextpdf.text.pdf.*" %>
<%--<%@ page import="java.io.FileOutputStream" %>--%>
<%--<%@ page import="java.io.File" %>--%>
<%@ page import="com.itextpdf.text.*" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.File" %>
<%--
  Created by IntelliJ IDEA.
  User: Shalan
  Date: 01/05/2018
  Time: 12:14 م
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    patient patient = null;
    dbConnection dbConnection = null;
    int Age  = 0 ;
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Database Dashboard!</title>
    <link rel="stylesheet" type="text/css" href="css/bulma.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.2/css/bulma.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.10/css/all.css" integrity="sha384-+d0P83n9kaQMCwj8F4RJB66tzIwOKmrdb46+porD/OvrJ+37WqIM7UoBtwHO6Nlg" crossorigin="anonymous">



    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


    <script src="css/jquery-3.3.1.min.js"></script>

    <script type="text/javascript">
        function lookup(inputString) {
            if(inputString.length == 0) {
                $('#suggestions').hide();
            } else {
                $.post("showPatient.jsp", {queryString: ""+inputString+""}, function(data){
                    if(data.length >0) {
                        $('#suggestions').show();
                        $('#autoSuggestionsList').html(data);
                    }
                });
            }
        }
        function fill(thisValue) {
            $('#inputString').val(thisValue);
            setTimeout("$('#suggestions').hide();", 200);
        }
    </script>


    <style type="text/css">

        .columns {
            min-height: 100vh ;
            display: flex ;
            flex-direction: row ;
            justify-content: stretch

        }
        .is-sidebar-menu {
            background: hsl(0, 0%, 29%);
            padding: 2.5rem ;
        }

        .hidden {
            display: none;
        }

        .suggestionsBox {
            position: relative;
            left: 260px;
            margin: 0px 0px 0px 0px;
            width: 200px;
            background-color: #7845DD;
            -moz-border-radius: 7px;
            -webkit-border-radius: 7px;
            border: 2px solid #000;
            color: #fff;
        }
        .suggestionList {
            margin: 0px;
            padding: 0px;
        }
        .suggestionList li {
            margin: 0px 0px 3px 0px;
            padding: 3px;
            cursor: pointer;
        }
        .suggestionList li:hover {
            background-color: #DD45CD;
        }
    </style>
</head>
<div class="columns is-fullheight">
    <div class="column is-2 is-sidebar-menu is-hidden-mobile">
        <aside class="menu">
            <ul class="menu-list">
                <li><a href="dashboard.jsp">Dashboard</a></li>
            </ul>
            <p class="menu-label">Adminstration</p>

            <ul class="menu-list">
                <li><a href="doctor.jsp">Add Doctor</a></li>
                <li><a href="patient.jsp">Add Patient</a></li>
            </ul>

        </aside>
    </div>
<%


    int PatientId = 3 ;

    String requestType = request.getParameter("action") ;
    dbConnection = new dbConnection();

//    if(request.getParameter("action").equals("edit") && request.getParameter("action") != null){
////        System.out.println("heyyyyyyy");
////        //PatientId = Integer.valueOf();
////        PatientId = Integer.parseInt(request.getParameter("userId"));
////        System.out.println(PatientId);
//
//        PatientId = Integer.parseInt(request.getParameter("userId").toString());
//        System.out.println(PatientId);
//    }

//    else  if( {request.getParameter("checkout")!=null){
//        try {
//            dbConnection.insertBill(PatientId);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }





    if (requestType != null){
        if(requestType.equals("edit")){
            PatientId = Integer.parseInt(request.getParameter("userId").toString());
        } else if(requestType.equals("Checkout")){
            try {
                PatientId = Integer.parseInt(request.getParameter("userId").toString()) ;
                System.out.println("insert patient ...... ! ");
                dbConnection.insertBill(PatientId);
                System.out.println("insert patient successfully! ");

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }else {
        System.out.println("null params");
    }

    try {

        DateFormat dateFormat = new SimpleDateFormat("yyyy");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy");
        patient = dbConnection.getPatienByID(PatientId);
        LocalDateTime now = LocalDateTime.now();
        String dateYear = dateFormat.format(patient.getDataBirth() );
        String nowyear = dtf.format(now );
        Age = Integer.parseInt(nowyear) - Integer.parseInt(dateYear) ;

    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("Handling error...");
    }
%>
    <div class="column is-10-fullhd">
        <div class="tabs is-centered">
            <ul>
                <li id="all-tab" class="is-active">
                    <a onClick="switchToAll()">
                        <span class="icon is-small"><i class="fas fa-address-book"></i></span>
                        <span>Information</span>
                    </a>
                </li>
                <li id="xray-tab">
                    <a onClick="switchToXray()">
                        <span class="icon is-small"><i class="fas fa-x-ray"></i></span>
                        <span>x-rays</span>
                    </a>
                </li>
                <li id="lab-tab">
                    <a onClick="switchToLab()">
                        <span class="icon is-small"><i class="fas fa-vials"></i></span>
                        <span>Lab</span>
                    </a>
                </li>
                <li id="edit-tab">
                    <a onClick="switchToEdit()">
                        <span class="icon is-small"><i class="fa fa-cog"></i></span>
                        <span>Medicine</span>
                    </a>
                </li>
                <li id="bill-tab">
                    <a onClick="switchToBill()">
                        <span class="icon is-small"><i class="fas fa-money-bill-alt"></i></span>
                        <span>Bill</span>
                    </a>
                </li>
            </ul>
            <!--/tabs is-centered-->
        </div>

        <div class="container">
            <div id="all-tab-content">
                    <div class="columns is-multiline is-gapless">
                        <div class="column is-centered is-half">
                            <div class="card-content">

                                <div class="media">
                                    <div class="media-left">
                                        <figure class="image is-128x128">
                                            <img src="https://bulma.io/images/placeholders/96x96.png" alt="Placeholder image">
                                        </figure>
                                    </div>
                                    <div class="media-content">
                                        <p class="title is-4"><%=patient.getName()%></p>
                                        <p class="title is-7"><%=patient.getGender()%></p>
                                        <p class="title is-7"><%=patient.getPhone()%></p>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="column is-half">

                            <!--####################Start form #########################-->

                            <div class="field is-horizontal">
                                <div class="field-label is-normal">
                                    <label class="label">Name</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <p class="control is-expanded ">
                                            <input class="input" type="text" value="<%=patient.getName()%>" placeholder="Name">
                                        </p>
                                    </div>
                                </div>
                            </div>
                                <div class="field is-horizontal">
                                        <div class="field-label is-normal">
                                            <label class="label">Code</label>
                                        </div>
                                    <div class="field-body">
                                        <p class="control is-expanded ">
                                            <input class="input" type="email" placeholder="" value="<%=patient.getPatientID()%>">
                                        </p>
                                    </div>
                                </div>

                            <!--#################### #########################-->

                            <div class="field is-horizontal">
                                <div class="field-label is-normal">
                                    <label class="label">Date of birth</label>
                                </div>
                                <div class="field-body">
                                    <div class="field is-narrow">
                                        <p class="control is-expanded ">
                                            <input class="input" type="email" placeholder="" value="<%=patient.getDataBirth()%>">
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <!--#################### #########################-->

                            <div class="field is-horizontal">
                                <div class="field-label is-normal">
                                    <label class="label">Age</label>
                                </div>
                                <div class="field-body">
                                    <div class="field is-narrow">
                                        <p class="control is-expanded ">
                                            <input class="input" type="email" placeholder="" value="<%=Age%>">
                                        </p>
                                    </div>
                                </div>
                            </div>
                        <!--#################### #########################-->
                            <div class="field is-horizontal">
                                <div class="field-label is-normal">
                                    <label class="label">Address</label>
                                </div>
                                <div class="field-body">
                                    <div class="field is-narrow">
                                        <p class="control is-expanded ">
                                            <input class="input" type="email" placeholder="" value="<%=patient.getAddress()%>">
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <!--#################### #########################-->
                            <div class="field is-horizontal">
                                <div class="field-label is-normal">
                                    <label class="label">Email</label>
                                </div>
                                <div class="field-body">
                                    <div class="field is-narrow">
                                        <p class="control is-expanded ">
                                            <input class="input" type="email" placeholder="" value="<%=patient.getEmail()%>">
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>


            <div class="hidden" id="xray-tab-content">
                <div class="columns">
                    <div class="column">
                        <%
                            ResultSet rs = null;
                            try {
                                rs = dbConnection.getRaysByID(PatientId);
                                System.out.println(rs.getRow());

                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                        <table class="table is-expanded is-bordered is-striped  is-hoverable ">
                            <thead>
                                <tr>
                                    <th>x-Ray name</th>
                                    <th>Date</th>
                                    <th>Price</th>
                                    <th>Doctor</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%while(rs.next()){ %>
                            <tr>
                                <td><%=rs.getString(2)%></td>
                                <td><%=rs.getString(3)%></td>
                                <%
                                    ResultSet subRay = dbConnection.getRay(rs.getString(2));
                                    while(subRay.next()){%>
                                    <td><%=subRay.getString(2)%></td>
                                <%}%>
                                <td><%=dbConnection.getDoctorByID(Integer.valueOf(patient.getDoctorID())).getFirstName()%></td>
                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>
                    <!--############################### ############################ -->
                    <div class="column is-half">

                        <form name="rayForm" action="" method="POST">
                            <div class="box">

                                <div class="field">
                                    <label class="label">X-Ray</label>
                                    <div class="control">
                                        <div class="select">
                                            <select name="ray_name">
                                                <option>Select x-rays</option>
                                                <%
                                                    ResultSet rays_rs = dbConnection.getRays();
                                                    while(rays_rs.next()){ %>
                                                <option value="<%=rays_rs.getString(1)%>"><%=rays_rs.getString(1)%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div>
                                </div>


                                <div class="field is-horizontal is-expanded">
                                    <div class="field-body">
                                        <div class="field">
                                            <label class="label">Doctor ID</label>
                                            <div class="control">
                                                <input class="input is-expanded"  name="doctorID"  type="text">
                                            </div>
                                        </div>

                                    </div>

                                </div>

                                <div id="butSubmit1" class="field">
                                    <div class="control">
                                        <input class="button is-primary" type="submit" name="rayAdd" value="Add">
                                    </div>
                                </div>
                            </div>
                        </form>

                        <% if(request.getParameter("rayAdd")!=null) {
                            int doctorID = Integer.valueOf(request.getParameter("doctorID"));

                            String rayName = request.getParameter("ray_name");
                            java.sql.Date nowTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                            try {
                                dbConnection.insertPatientRay(PatientId, rayName, nowTime);
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }

                        %>

                        <!--############################### End ray part ############################ -->

                    </div>
                </div>
            </div>
            <div class="hidden" id="lab-tab-content">

                <div class="columns">
                    <div class="column is-half">
                        <%
                            ResultSet rs_test = null;
                            try {
                                rs_test = dbConnection.getTestsByID(PatientId);

                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                        <table class="table is-expanded is-bordered is-striped  is-hoverable ">
                            <thead>
                            <tr>
                                <th>Test name</th>
                                <th>Date</th>
                                <th>Price</th>
                                <th>Doctor</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%while(rs_test.next()){ %>
                            <tr>
                                <td><%=rs_test.getString(2)%></td>
                                <td><%=rs_test.getString(3)%></td>
                                <%
                                    ResultSet subTest = dbConnection.getTest(rs_test.getString(2));
                                    while(subTest.next()){%>
                                <td><%=subTest.getString(2)%></td>
                                <%}%>
                                <td><%=dbConnection.getDoctorByID(Integer.valueOf(patient.getDoctorID())).getFirstName()%></td>
                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>

                        <!--############################### ############################ -->
                    <div class="column is-half">
                        <form name="testForm" action="" method="POST">
                            <div class="box">

                                <div class="field">
                                    <label class="label">Test</label>
                                    <div class="control">
                                        <div class="select">
                                            <select name="test">
                                                <option>Select test</option>
                                                <% ResultSet test_rs = dbConnection.getTests();
                                                while (test_rs.next()){

                                                %>
                                                <option value="<%=test_rs.getString(1)%>"><%=test_rs.getString(1)%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="field is-horizontal is-expanded">
                                    <div class="field-body">
                                        <div class="field">
                                            <label class="label">Doctor ID</label>
                                            <div class="control">
                                                <input class="input is-expanded"  name="doctorID"  type="text">
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div id="butSubmit" class="field">
                                    <div class="control">
                                        <input class="button is-primary" type="submit" name="testBtn" value="Add">
                                    </div>
                                </div>

                            </div>
                        </form>
                        <!--############################### End test form ############################ -->

                        <% if(request.getParameter("testBtn")!=null) {
                            int doctorID = Integer.valueOf(request.getParameter("doctorID"));
                            String testName = request.getParameter("test");
                            java.sql.Date nowTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                            try {
                                dbConnection.insertPatientTest(PatientId, testName, nowTime);
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }

                        %>



                    </div>
                </div>

            </div>

            <div class="hidden" id="edit-tab-content">
                <div class="columns">
                    <div class="column is-half">

                        <table class="table is-expanded is-bordered is-striped  is-hoverable ">
                            <thead>
                            <tr>
                                <th>Medecine name</th>
                                <th>Date</th>
                                <th>Quantity</th>
                                <th>Doctor</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                String SQL = "SELECT * FROM hcm.patient_has_medicine where `Patient_Patient ID` ="+ PatientId ;
                                ResultSet medRS = dbConnection.getSQL(SQL);
                                while (medRS.next()){
                            %>
                                <tr>
                                    <td><%=dbConnection.getMedecine(medRS.getString(2))%></td>
                                    <td><%=medRS.getString(3)%></td>

                                    <td><%=medRS.getString(4)%></td>
                                    <td><%=dbConnection.getDoctorByID(Integer.valueOf(patient.getDoctorID())).getFirstName()%></td>

                                </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>

                    <!--############################### ############################ -->
                    <div class="column is-half">
                        <form name="medForm" action="" method="POST">
                            <div class="box">

                                <div class="field">
                                    <label class="label">Medecine</label>
                                    <div class="control">
                                        <div class="select is-multiple">
                                            <select name="medecine">
                                                <option>Select test</option>
                                                <%
                                                    ResultSet rsMedecine = null;
                                                    String sql = "SELECT * FROM hcm.medicine ORDER BY `Name` ASC"  ;

                                                    try {
                                                        rsMedecine = dbConnection.getSQL(sql);

                                                    } catch (SQLException e) {
                                                        e.printStackTrace();
                                                    }
                                                    while (rsMedecine.next()){
                                                %>

                                                <option value="<%=rsMedecine.getString(1)%>"><%=rsMedecine.getString(2)%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="field is-horizontal is-expanded">
                                    <div class="field-body">
                                        <div class="field">
                                            <label class="label">Doctor ID</label>
                                            <div class="control">
                                                <input class="input is-expanded"  name="doctorID"  type="text">
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div class="field is-horizontal is-expanded">
                                    <div class="field-body">
                                        <div class="field">
                                            <label class="label">Quantity</label>
                                            <div class="control">
                                                <input class="input is-expanded"  name="Quantity"  type="text">
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div id="butSubmit" class="field">
                                    <div class="control">
                                        <input class="button is-primary" type="submit" name="addMedecine" value="Add">
                                    </div>
                                </div>

                            </div>
                        </form>
                        <!--############################### End test form ############################ -->

                        <% if(request.getParameter("addMedecine")!=null) {
                            int doctorID = Integer.valueOf(request.getParameter("doctorID"));
                            String testName = request.getParameter("medecine");
                            int Quantity = Integer.valueOf(request.getParameter("Quantity"));
                            java.sql.Date nowTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                            try {
                                dbConnection.insertPatientMedecine(PatientId, testName, nowTime,Quantity);
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }

                        %>



                    </div>
                </div>



            </div>
            <div class="hidden" id="bill-tab-content">
                <div class="columns">

                    <div class="column is-half">
                        <table class="table is-expanded is-bordered is-striped  is-hoverable ">
                            <thead>
                            <tr>
                                <th>Procedure name</th>
                                <th>Date</th>
                                <th>Price</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                dbConnection.getBillPatient(PatientId);
                                String billSQL = "SELECT * FROM hcm.bill_view";
                                ResultSet bill_ResultSet = dbConnection.getSQL(billSQL);
                                //System.out.println(bill_ResultSet);
                                while (bill_ResultSet.next()) {

                            %>
                            <tr>
                                <td><%=bill_ResultSet.getString(1)%></td>
                                <td><%=bill_ResultSet.getString(2)%></td>

                                <td><%=bill_ResultSet.getString(3)%></td>


                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                        <form action="" method="get" target="_blank">
                            <input class="button is-success is-rounded" type="submit" name="action" value="Checkout"  />
                            <input class="button" type="hidden" name="userId" value="<%=PatientId%>"  />
                        </form>


                    </div>

                    <div class="column is-half">

                        <%
                            Document document = new Document();
                            final String FILE_NAME = "C:/Users/noura/IdeaProjects/healthCareDB/itext.pdf";

                            try {
                                PdfWriter.getInstance(document, new FileOutputStream(new File(FILE_NAME)));

                                String bill_SQL = "SELECT * FROM hcm.bill \n" +
                                        " where `Patient ID` = "+PatientId +" order by bill_date desc;" ;

                                String last_bill_date = "" ;
                                ResultSet pdfResultSet = dbConnection.getSQL(bill_SQL);

                                if (pdfResultSet.next()){
                                    last_bill_date = pdfResultSet.getString("bill_date");
                                }
                                System.out.println("last_bill_date: -->" +  last_bill_date);
                                String bill_view_sql = "select * from hcm.bill_view where procedure_date >= '"+last_bill_date+"'" ;
                                ResultSet viewResultSet = dbConnection.getSQL(bill_view_sql);
                                //open
                                document.open();

                                Paragraph title = new Paragraph();
                                title.add("Healthcare Database project");
                                title.setAlignment(Element.ALIGN_CENTER);

                                document.add(title);

                                Paragraph patienName = new Paragraph();
                                patienName.add("Patient Name: " + patient.getName() + "\n");
                                patienName.setAlignment(Element.ALIGN_LEFT);
                                document.add(patienName);

                                Paragraph docName = new Paragraph();
                                docName.add("Doctor Name: " + dbConnection.getDoctorByID(Integer.valueOf(patient.getDoctorID())).getFirstName()+ "\n" ); //no alignment
                                docName.setAlignment(Element.ALIGN_LEFT);
                                docName.setSpacingBefore(10f);
                                document.add(docName);

                                String pattern = "dd MM yyyy";

                                SimpleDateFormat simpleDateFormat =
                                        new SimpleDateFormat(pattern);
                                java.util.Date dateTime = new java.util.Date();
                                Paragraph dateEle = new Paragraph();
                                String date = simpleDateFormat.format(dateTime);
                                dateEle.add("Date: " + date); //no alignment
                                dateEle.setAlignment(Element.ALIGN_RIGHT);
                                document.add(dateEle);

                                Font f = new Font();
                                f.setStyle(Font.BOLD);
                                f.setSize(11);



                                PdfPTable table = new PdfPTable(3);

                                PdfPCell name = new PdfPCell(new Paragraph("Procedure name"));
                                PdfPCell price = new PdfPCell(new Paragraph("Procedure price"));
                                PdfPCell type = new PdfPCell(new Paragraph("Procedure type"));
                                table.setSpacingBefore(20f);

                                table.addCell(name);
                                table.addCell(price);
                                table.addCell(type);
                                while (viewResultSet.next()){
                                    PdfPCell pName = new PdfPCell(new Paragraph(viewResultSet.getString(1)));
                                    PdfPCell pPrice = new PdfPCell(new Paragraph(viewResultSet.getString(3)));
                                    PdfPCell ptype ;
                                    if(dbConnection.searchInTestTable(viewResultSet.getString(1))){
                                         ptype = new PdfPCell(new Paragraph("Lab test"));
                                    }else{
                                         ptype = new PdfPCell(new Paragraph("X-ray"));
                                    }


                                    table.addCell(pName);
                                    table.addCell(pPrice);
                                    table.addCell(ptype);
                                }
                                document.add(table);

                                Paragraph total = new Paragraph();
                                total.add("Total: " + dbConnection.getSumBillView(last_bill_date)); //no alignment
                                total.setAlignment(Element.ALIGN_RIGHT);
                                total.setSpacingBefore(20f);
                                document.add(total);




                                Paragraph Hospital = new Paragraph();
                                Hospital.setSpacingBefore(40f);
                                Hospital.add("Hospital signature                                                                    "); //no alignment
                                Hospital.setAlignment(Element.ALIGN_LEFT);
                                Hospital.add("                  Patient signature "); //no alignment

                                document.add(Hospital);

//
//                                Paragraph signPatient = new Paragraph();
//                                signPatient.add("Patient signature"); //no alignment
//                                signPatient.setAlignment(Element.ALIGN_RIGHT);
//                                signPatient.setSpacingBefore(20f);
//                                document.add(signPatient);

                                //close
                                document.close();
                                pdfResultSet.last();

                                System.out.println("Done " + pdfResultSet.getRow());
                                pdfResultSet.beforeFirst();
                            } catch (DocumentException e) {
                                e.printStackTrace();
                            }


                        %>

                    </div>
                </div>

            </div>
        </div>

    </div>

</div>





<script>
    function switchToAll() {
        removeActive();
        hideAll();
        $("#all-tab").addClass("is-active");
        $("#all-tab-content").removeClass("hidden");
    }

    function switchToXray() {
        removeActive();
        hideAll();
        $("#xray-tab").addClass("is-active");
        $("#xray-tab-content").removeClass("hidden");
    }

    function switchToLab() {
        removeActive();
        hideAll();
        $("#lab-tab").addClass("is-active");
        $("#lab-tab-content").removeClass("hidden");
    }

    function switchToEdit() {
        removeActive();
        hideAll();
        $("#edit-tab").addClass("is-active");
        $("#edit-tab-content").removeClass("hidden");
    }

    function switchToBill() {
        removeActive();
        hideAll();
        $("#bill-tab").addClass("is-active");
        $("#bill-tab-content").removeClass("hidden");
    }

    function removeActive() {
        $("li").each(function() {
            $(this).removeClass("is-active");
        });
    }

    function hideAll(){
        $("#all-tab-content").addClass("hidden");
        $("#xray-tab-content").addClass("hidden");
        $("#lab-tab-content").addClass("hidden");
        $("#edit-tab-content").addClass("hidden");
        $("#bill-tab-content").addClass("hidden");
    }
</script>


</body>
</html>
