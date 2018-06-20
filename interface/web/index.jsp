<%--
  Created by IntelliJ IDEA.
  User: Shalan
  Date: 24/03/2018
  Time: 04:14 م
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  try {
    Class.forName("com.mysql.jdbc.Driver");
  } catch (ClassNotFoundException e) {
    e.printStackTrace();
  }
%>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Hello Database!</title>
    <link rel="stylesheet" type="text/css" href="css/bulma.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.2/css/bulma.min.css">
  <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
  <style type="text/css">
    #colCenter{
      margin: 5%;
    }
    #logControl {
      margin-left: 35%;
    }


  </style>
</head>
<body>
<section class="section">
  <div class="container">

    <div class="field">
      <div class="field is-horizontal">
						<span class="icon is-medium is-left">
							<i class="fas fa-heartbeat"></i>
						</span>
        <h1 class="title has-icon-left">
          Database project
        </h1>
      </div>
      <div class="field is-horizontal">
        <p class="subtitle">
          Mohey's team!
        </p>
        <span class="icon is-medium is-right">
							<i class="fas fa-bed"></i>
						</span>
      </div>

    </div>
    <div id="colCenter" class="columns is-mobile is-centered">
      <div class="columns is-half">
        <div class="card">
          <div class="card-content">
            <div class="field">
              <label class="label">Username</label>
              <div class="control has-icons-left">
                <input class="input " type="text" placeholder="Enter username" >
                <span class="icon is-small is-left">
											<i class="fas fa-user"></i>
										</span>
              </div>
            </div>

            <div class="field">
              <label class="label">Password</label>
              <div class="control has-icons-left">
                <input class="input " type="Password" placeholder="Enter your password" >
                <span class="icon is-small is-left">
											<i class="fas fa-key"></i>
										</span>
              </div>
            </div>

            <div id="logControl" class="field">
              <div class="control">
                <a href="dashboard.jsp" class="button" name="loginButton">Login</a>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
    </div>
</section>
</body>
</html>
