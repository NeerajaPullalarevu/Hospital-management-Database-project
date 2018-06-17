<%--
  Created by IntelliJ IDEA.
  User: noura
  Date: 09/05/2018
  Time: 08:38 م
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.model.Doctor" %>
<%@ page import="com.model.patient" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Database Dashboard!</title>
    <link rel="stylesheet" type="text/css" href="css/bulma.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.2/css/bulma.min.css">
    <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>

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
        .is-8 {
            margin-left: 1%;
            margin-top: 3%;
        }

        .hero {
            margin-bottom: 1%;
        }




    </style>
</head>
<body>

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

    <div class="column is-8" >
        <%
            int DoctorID = 3 ; // Default
            Doctor doctor = new Doctor();
            if(request.getParameter("action").equals("show")){
//        System.out.println("heyyyyyyy");
//        //PatientId = Integer.valueOf();
//        PatientId = Integer.parseInt(request.getParameter("userId"));
//        System.out.println(PatientId);

                DoctorID = Integer.parseInt(request.getParameter("userId").toString());
                System.out.println(DoctorID);
                doctor = new dbConnection().getDoctorByID(DoctorID);
            }

        %>
        <section class="hero is-info welcome is-small">
            <div class="hero-body">
                <div class="container">
                    <h1 class="title" style="font-family: 'HSN Sara'">
                        Patients with Dr.<%=doctor.getFirstName()%>
                    </h1>
                </div>
            </div>
        </section>

        <div class="columns">
            <div class="column">
                <table class="table is-bordered is-striped  is-hoverable "  >
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Patient name</th>
                        <th>Gender</th>
                        <th colspan=2>Action</th>

                    </tr>
                    </thead>

                    <tbody>

                    <%
                        ArrayList<patient> patientList = null;
                        try {
                            patientList = new dbConnection().getPatientByDoctor(doctor.getDoctorID());

                        } catch (SQLException e) {
                            e.printStackTrace();
                            System.out.println("Handling error...");
                        }


                    %>
                    <%
                        if(patientList.size()>0){
                            for (patient patient :patientList) {

                    %>
                    <tr>
                        <td><%= patient.getPatientID()%></td>
                        <td><%= patient.getName() %></td>
                        <td><%= patient.getGender()%></td>
                        <td><a href="showPatient.jsp?action=edit&userId=<%=patient.getPatientID()%>"> Update</a></td>


                    </tr>
                    <%
                            }
                        }
                    %>

                    </tbody>
                </table>
            </div>

        </div>

    </div>


</div>


</body>
</html>
