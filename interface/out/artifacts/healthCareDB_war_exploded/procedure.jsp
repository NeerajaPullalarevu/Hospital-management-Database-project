<%@ page import="com.dbConnection" %><%--
  Created by IntelliJ IDEA.
  User: Shalan
  Date: 16/05/2018
  Time: 01:22 ص
  To change this template use File | Settings | File Templates.
--%>
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
    dbConnection dbConnection = new dbConnection();
    String requestAction  = request.getParameter("action");

    if(requestAction != null){
        if(requestAction.equals("Submit Lab")){
            String name = request.getParameter("Name");
            float price = Float.valueOf(request.getParameter("price"));
            dbConnection.insertTest(name,price);
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Successfully inserted!');");
            out.println("location='procedure.jsp';");
            out.println("</script>");

        } else if(requestAction.equals("Submit x-Ray")) {
            String name = request.getParameter("Name");
            float price = Float.valueOf(request.getParameter("price"));
            dbConnection.insertRay(name, price);
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Successfully inserted!');");
            out.println("location='procedure.jsp';");
            out.println("</script>");
        }

        else if(requestAction.equals("Submit Medicine")) {
            String name = request.getParameter("Name");
            int code = Integer.valueOf(request.getParameter("code"));
            dbConnection.insertMedicine(name, code);
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Successfully inserted!');");
            out.println("location='procedure.jsp';");
            out.println("</script>");
        }

    }else {
        System.out.println(getClass().getName() + "error is null" );
    }
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
                <li><a href="doctor.jsp">Add new procedures</a></li>

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
                    <li class="is-active"><a href="#" aria-current="page">Add new procedure</a></li>
                </ul>
            </nav>

            <%--<section class="hero is-info welcome is-small">--%>
                <%----%>
            <%--</section>--%>


            <div class="columns is-multiline">
                <div class="column is-4">
                    <form name="testFrom" action="procedure.jsp" method="GET">
                        <div class="box">
                            <div class="field is-horizontal is-expanded">
                                <div class="field-body">
                                    <div class="field">
                                        <label class="label">Test Name</label>
                                        <div class="control">
                                            <input class="input is-expanded" name="Name"  type="text">
                                        </div>
                                    </div>
                                    <div class="field">
                                        <label class="label">Price</label>
                                        <div class="control">
                                            <input class="input is-expanded" name="price"  type="text">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field">
                                <div class="control">
                                    <input class="button is-success" name="action" type="submit" value="Submit Lab">
                                </div>
                            </div>
                        </div>
                    </form>

                </div>

                <div class="column is-4">
                    <form name="testFrom" action="procedure.jsp" method="GET">
                        <div class="box">
                            <div class="field is-horizontal is-expanded">
                                <div class="field-body">
                                    <div class="field">
                                        <label class="label">x-Ray Name</label>
                                        <div class="control">
                                            <input class="input is-expanded" name="Name"  type="text">
                                        </div>
                                    </div>
                                    <div class="field">
                                        <label class="label">Price</label>
                                        <div class="control">
                                            <input class="input is-expanded" name="price"  type="text">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field">
                                <div class="control">
                                    <input class="button is-success" name="action" type="submit" value="Submit x-Ray">
                                </div>
                            </div>
                        </div>
                    </form>

                </div>

                <div class="column is-4">
                    <form name="testFrom" action="procedure.jsp" method="GET">
                        <div class="box">
                            <div class="field is-horizontal is-expanded">
                                <div class="field-body">
                                    <div class="field">
                                        <label class="label">Medicine Name</label>
                                        <div class="control">
                                            <input class="input is-expanded" name="Name"  type="text">
                                        </div>
                                    </div>
                                    <div class="field">
                                        <label class="label">Medicine Code</label>
                                        <div class="control">
                                            <input class="input is-expanded" name="code"  type="text">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field">
                                <div class="control">
                                    <input class="button is-success" name="action" type="submit" value="Submit Medicine">
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
            </div>



        </main>


    </div>
</div>







</body>
</html>
