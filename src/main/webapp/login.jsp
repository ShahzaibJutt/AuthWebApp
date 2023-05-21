<!DOCTYPE html>
<html>
<head>
  <title>Login Page</title>
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
      position: relative;
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
      font-weight: bold;
    }

    .form-group input[type="submit"]:hover {
      background-color: #45a049;
    }

    /* Popup */
    .popup {
      position: absolute;
      bottom: -80px;
      left: 0;
      height: 50px;
      background-color: #4CAF50;
      color: #fff;
      text-align: center;
      line-height: 50px;
      font-size: 16px;
      border-radius: 20px;
      opacity: 0;
      transition: opacity 0.3s ease-in-out;
      margin-top: 20px;
      font-weight: bold;
      width: 80%;
      margin-left: 10%;
    }

    .popup.show {
      opacity: 1;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Login</h1>
  <form action="loginServlet" method="post" onsubmit="return validateForm()">
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" id="email" name="email" required>
    </div>
    <div class="form-group">
      <label for="password">Password:</label>
      <input type="password" id="password" name="password" required>
    </div>
    <div class="form-group">
      <input type="submit" value="Login">
    </div>
  </form>
  <div id="message-popup" class="popup"></div>
  <p>Don't have an account? <a href="signup.jsp">Signup here</a></p>
</div>


<script>
  function validateForm() {
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;

    // Email validation
    var emailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (!email.match(emailRegex)) {
      showMessage("Please enter a valid email address.");
      return false;
    }

    // Send AJAX request to login servlet
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "loginServlet", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4 && xhr.status === 200) {
        var response = JSON.parse(xhr.responseText);

        // Check the status in the response
        if (response.status === "success") {
          // Password is correct, perform desired action (e.g., redirect to dashboard)
          showMessage("Login Successful");
        } else {
          // Password is incorrect, show error message
          showMessage("Incorrect password. Please try again.");
        }
      }
    };
    xhr.send("email=" + encodeURIComponent(email) + "&password=" + encodeURIComponent(password));

    return false;
  }

  function showMessage(message) {
    var popup = document.getElementById("message-popup");
    popup.innerHTML = message;
    popup.classList.add("show");

    // Automatically hide the message after 3 seconds
    setTimeout(function () {
      popup.classList.remove("show");
    }, 3000);
  }
</script>

</body>
</html>
