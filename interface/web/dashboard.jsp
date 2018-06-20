<%--
  Created by IntelliJ IDEA.
  User: Shalan
  Date: 24/03/2018
  Time: 04:21 م
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.*" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Database Dashboard!</title>
    <link rel="stylesheet" type="text/css" href="css/bulma.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.2/css/bulma.min.css">
    <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>

    <style type="text/css">

        @font-face {
            font-family: 'ArabicFont'; /*a name to be used later*/
            src: local('css/Tajawal-Bold') ; /*URL to font*/
        }

        .columns {
            min-height: 100vh ;
            display: flex ;
            flex-direction: row ;
            justify-content: stretch

        }
        .aside {
            background: hsl(0, 0%, 29%);
            padding: 2.5rem ;
        }
        .box{
            margin: 5%
        }

        .button {
            margin-left: 5%;
            position: center;
        }

        .aside li a{
            color: hsl(0, 0%, 100%);
        }

        .title{

            font-family:  ArabicFont;
        }


    </style>
</head>
<body>
<%

    int doctorCount = new dbConnection().getCount("doctor","Doctor_ID");
    int patientCount = new dbConnection().getCount("patient","PatientID");

    //int result = connection.getCount("doctor","Doctor ID");

%>

<div class="wrapper">
    <div class="columns">

        <aside class="column is-2 aside">
            <ul class="menu-list">
                <li><a href="dashboard.jsp">Dashboard</a></li>
            </ul>
            <p class="menu-label">Adminstration</p>

            <ul class="menu-list">
                <li><a href="doctor.jsp">Add Doctor</a></li>
                <li><a href="patient.jsp">Add Patient</a></li>
            </ul>


            <p class="menu-label">Procedures</p>

            <ul class="menu-list">
                <li><a href="procedure.jsp">Add new procedures</a></li>

            </ul>


            <p class="menu-label">Pharmacy</p>

            <ul class="menu-list">
                <li><a href="doctor.jsp">Add Medicine</a></li>

            </ul>
        </aside>

        <main class="column main">
            <nav class="breadcrumb is-small" aria-label="breadcrumbs">
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li class="is-active"><a href="#" aria-current="page">Dashboard</a></li>
                </ul>
            </nav>

            <section class="hero is-info welcome is-small">
                <div class="hero-body">
                    <div class="container">
                        <h1 class="title" style="font-family: 'HSN Sara'">
                            Welcome....!
                        </h1>
                        <h2 class="subtitle">
                            I hope you are having a great day!
                        </h2>
                    </div>
                </div>
            </section>


            <div class="columns is-multiline">
                <div class="column is-2">
                        <div class="tile is-parent is-centered is-variable">
                            <article class="tile is-child box">
                                <p class="title"><%=Integer.toString(doctorCount)%></p>
                                <p class="subtitle">Doctors</p>
                            </article>


                        </div>

                    <a href="showDoc.jsp" class="button is-primary ">Show doctors</a>

                </div>

                <div class="column is-2">
                    <div class="tile is-parent is-centered is-variable">
                        <article class="tile is-child box">
                            <p class="title"><%=Integer.toString(patientCount)%></p>
                            <p class="subtitle">Patients</p>
                        </article>


                    </div>

                    <a href="allPatients.jsp" class="button is-primary ">Show patient</a>

                </div>
            </div>

        </main>


    </div>
</div>







</body>
</html>
