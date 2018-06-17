<%--
  Created by IntelliJ IDEA.
  User: shalan
  Date: 24/03/2018
  Time: 04:21 م
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.dbConnection" %>
<%@ page import="com.dbHelper" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.model.Doctor" %>
<%@ page import="javax.print.Doc" %>
<%@ page import="java.sql.ResultSet" %>

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
            margin-left: 40%
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
</head>
<body>
    <%
    dbConnection dbConnection = new dbConnection() ;
    %>
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
        <form name="doctorForm" action="" method="GET">
            <div class="box">
                <div class="field is-horizontal is-expanded">
                    <div class="field-body">
                        <div class="field">
                            <label class="label">First Name</label>
                            <div class="control">
                                <input class="input is-expanded" id="firstNameID" name="Name"  type="text">
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
                    <div class="field">
                        <label class="label">Department</label>
                        <div class="control">
                            <div class="select">
                                <select name="Department">
                                    <option>Select department</option>
                                    <%
                                        ResultSet rs = null;
                                        String sql = "SELECT * FROM hcm.department"  ;

                                        try {
                                            rs = dbConnection.getSQL(sql);

                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                        while (rs.next()){
                                    %>

                                    <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                    <%}%>

                                </select>
                            </div>

                            <div class="field">
                                <label class="label" >Specialization</label>
                                <div class="control">
                                    <div class="select">
                                        <select name="Specialization">
                                            <option>Select Specialization</option>
                                            <%
                                                ResultSet rs_s = null;
                                                String SQL = "SELECT * FROM hcm.specialisation"  ;

                                                try {
                                                    rs_s = dbConnection.getSQL(SQL);

                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                                while (rs_s.next()){
                                            %>

                                            <option value="<%=rs_s.getString(1)%>"><%=rs_s.getString(2)%></option>
                                            <%}%>

                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>

                <div id="butSubmit" class="field">
                    <div class="control">
                        <input class="button is-primary" type="submit" name="submit" value="submit">
                    </div>
                </div>

            </div>
        </form>

    </div>




</div>



<%



        //dbConnection dbConnection = new dbConnection(URL,USER,PASSWORD,DB);
        dbHelper helper = new dbHelper();
        if(request.getParameter(helper.SUBMIT)!=null) {
            String Firstname = request.getParameter(helper.NAME);
            String lastName = request.getParameter(helper.LAST);
            String department = request.getParameter(helper.DEP);
            String specialization = request.getParameter(helper.SPEC);
            String Address = request.getParameter(helper.ADDRESS);
            String PhoneStr = request.getParameter(helper.PHONE);
            int Phone  = Integer.parseInt(PhoneStr);
            String Email = request.getParameter(helper.EMAIL);
            int departmentKey = Integer.valueOf(department) ;
            int specialKey =Integer.valueOf(specialization) ;

            try {
                int result = dbConnection.insertDoctor(new Doctor(Firstname,lastName,Email,
                                                                        Address,departmentKey,
                                                                        specialKey,Phone));
                System.out.println(result);
                System.out.println("Yup...Success!");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }




%>
</body>
</html>