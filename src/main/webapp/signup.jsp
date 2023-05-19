<%--
  Created by IntelliJ IDEA.
  User: shahzaib
  Date: 19/5/23
  Time: 10:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Signup Page</title>
  <style>
    body {
      background-color: #f2f2f2;
      font-family: Arial, sans-serif;
    }

    .container {
      width: 400px;
      margin: 0 auto;
      margin-top: 100px;
      background-color: #fff;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    h1 {
      text-align: center;
      color: #333;
      margin-bottom: 30px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      font-weight: bold;
    }

    .form-group input[type="text"],
    .form-group input[type="password"],
    .form-group input[type="email"] {
      width: 100%;
      padding: 10px 0px 10px 0px;
      border-radius: 4px;
      border: 1px solid #ccc;
      padding-left: 5px;
    }

    .form-group input[type="submit"] {
      background-color: #4CAF50;
      color: #fff;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      border-radius: 4px;
      cursor: pointer;
      width: 100%;
    }

    .form-group input[type="submit"]:hover {
      background-color: #45a049;
    }
  </style>
  <script>
    function validateForm() {
      var email = document.getElementById("email").value;
      var password1 = document.getElementById("password1").value;
      var password2 = document.getElementById("password2").value;

      // Email validation
      var emailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
      if (!email.match(emailRegex)) {
        alert("Please enter a valid email address.");
        return false;
      }

      // Password validation
      var passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}$/;
      if (!password1.match(passwordRegex)) {
        alert("Password must be at least 6 characters long and contain at least one uppercase letter, one lowercase letter, and one digit.");
        return false;
      }

      if (password1 !== password2) {
        alert("Passwords do not match.");
        return false;
      }

      return true;
    }
  </script>
</head>
<body>
<div class="container">
  <h1>Signup</h1>
  <form action="signupServlet" method="post" onsubmit="return validateForm()">
    <div class="form-group">
      <label for="first_name">First Name:</label>
      <input type="text" id="first_name" name="first_name" required>
    </div>
    <div class="form-group">
      <label for="last_name">Last Name:</label>
      <input type="text" id="last_name" name="last_name" required>
    </div>
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" id="email" name="email" required>
    </div>
    <div class="form-group">
      <label for="password1">Password:</label>
      <input type="password" id="password1" name="password1" required>
    </div>
    <div class="form-group">
      <label for="password2">Confirm Password:</label>
      <input type="password" id="password2" name="password2" required>
    </div>
    <div class="form-group">
      <input type="submit" value="Signup">
    </div>
    <div class="form-group">

    </div>
  </form>
  <p>Already have an account? <a href="login.jsp">Login here</a></p>
</div>
</body>
</html>

