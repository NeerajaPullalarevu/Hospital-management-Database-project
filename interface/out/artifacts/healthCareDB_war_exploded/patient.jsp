<%--
  Created by IntelliJ IDEA.
  User: shalan
  Date: 27/03/2018
  Time: 10:45 م
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.dbConnection" %>
<%@ page import="com.dbHelper" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.model.patient" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hello Database!</title>
    <link rel="stylesheet" type="text/css" href="css/bulma.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.2/css/bulma.min.css">
    <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    <style type="text/css">

        #butSubmit{
            margin-left: 40% ;
            margin-top: 2% ;
        }
        .columns {
            min-height: 100vh ;
            display: flex;
            flex-direction: row;
            justify-content: stretch

        }
        .is-sidebar-menu {
            background: hsl(0, 0%, 29%);
            padding: 2.5rem ;
        }
        .box{
            margin: 5%
        }
        .is-sidebar-menu li a{
            color: hsl(0, 0%, 100%);
        }


    </style>
    <title>Add patient</title>
</head>
<body>
<div class="columns is-fullheight is-8">
    <div class="column is-2 is-sidebar-menu is-mobile ">
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
    <div class="column is-2">
    </div>
    <div class="column is-centered is-mobile is-narrow ">
        <form name="patientForm" action="" method="POST">
            <div class="box">

                <div class="field is-horizontal is-expanded">
                    <div class="field-body">
                        <div class="field">
                            <label class="label">First Name</label>
                            <div class="control">
                                <input class="input is-expanded" id="firstNameID" name="first"  type="text">
                            </div>
                        </div>
                        <div class="field">
                            <label class="label">Last Name</label>
                            <div class="control">
                                <input class="input is-expanded" id="lastNameID" name="last"  type="text">
                            </div>
                        </div>
                    </div>

                </div>

                <div class="field ">
                    <label class="label">Email</label>
                    <div class="control has-icons-left">
                        <input class="input is-expanded"  name="Email"  type="text">
                        <span class="icon is-small is-left">
                            <i class="fas fa-envelope"></i>
                        </span>
                    </div>
                </div>

                <div class="field">
                    <label class="label">Gender</label>
                    <div class="control">
                        <div class="select">
                            <select name="Gender">
                                <option>Select gender</option>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="field">
                    <label class="label">Address</label>
                    <div class="control">
                        <input class="input is-expanded" name="Address"  type="text">
                    </div>
                </div>

                <div class="field">
                    <label class="label">Phone number</label>
                    <div class="control has-icons-left">
                        <input class="input is-expanded"  name="Phone"  type="text">
                        <span class="icon is-small is-left">
							<i class="fas fa-phone"></i>
                        </span>
                    </div>
                </div>

                <div class="field">
                    <label class="label">Data of birth</label>
                    <div class="control">
                        <input id="datepickerDemo2" class="input" name="dateBirth" type="text" placeholder="e.g 2015-03-31">
                    </div>
                </div>


                <div id="butSubmit" class="field">
                    <div class="control">
                        <input class="button is-primary" type="submit" name="submit" value="submit">
                    </div>
                </div>

            </div>
        </form>

        <%
            dbHelper helper = new dbHelper();
            if(request.getParameter(helper.SUBMIT)!=null) {
                String firstName = request.getParameter("first");
                String lastName = request.getParameter("last");
                int phone = Integer.valueOf(request.getParameter("Phone"));
                String email = request.getParameter("Email");
                String address = request.getParameter("Address");
                String gender = request.getParameter("Gender");
                String dateStr = request.getParameter("dateBirth");
                Date dateBirth = Date.valueOf(dateStr);
                System.out.println(dateBirth);

                int result = 0;
                try {
                    result = new dbConnection().insertPatient(
                            new patient(firstName+" "+ lastName,phone,dateBirth,gender,email,address)
                    );
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                System.out.println(result);
                System.out.println("Yup...Success!");


            }
           //

        %>

    </div>





</div>
</body>
</html>
