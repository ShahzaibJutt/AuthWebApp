<!DOCTYPE html>
<html>
<head>
    <title>AuthWebApp</title>
    <style>
        body {
            background-color: #f2f2f2;
            font-family: Arial, sans-serif;
        }

        .container {
            width: 600px;
            margin: 0 auto;
            margin-top: 100px;
            background-color: #fff;
            padding: 40px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 40px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .button {
            background-color: #4CAF50;
            color: #fff;
            border: none;
            padding: 14px 24px;
            font-size: 18px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }

        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Welcome to our Website</h1>

    <div class="button-container">
        <a href="login.jsp" class="button">Login</a>
        <a href="signup.jsp" class="button">Signup</a>
    </div>
</div>
</body>
</html>
