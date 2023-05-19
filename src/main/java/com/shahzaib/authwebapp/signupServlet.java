package com.shahzaib.authwebapp;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "signup", value = "/signupServlet")
public class signupServlet extends HttpServlet {
    String url;
    Connection con;

    public void init() {
        url = "jdbc:postgresql://localhost/web?user=shahzaib&password=4646";
        try {
            con = DriverManager.getConnection(url);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PreparedStatement pst;
        int res;
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String email = request.getParameter("email");
        String password1 = request.getParameter("password1");
        String password2 = request.getParameter("password2");
        response.setContentType("text/html");
        try {
            pst = con.prepareStatement("SELECT email FROM \"user\" WHERE email = ?");
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                response.sendError(HttpServletResponse.SC_CONFLICT, "Email already exists");
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (!password1.equals(password2)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Passwords do not match");
            return;
        }
        String saltvalue = PassBasedEnc.getSaltvalue(30);
        String hashedPassword = PassBasedEnc.generateSecurePassword(password1, saltvalue);
        try {
            pst = con.prepareStatement("INSERT INTO \"user\" (first_name, last_name, email, password_salt_value, hashed_password) VALUES (?, ?, ?, ?, ?)");
            pst.setString(1, first_name);
            pst.setString(2, last_name);
            pst.setString(3, email);
            pst.setString(4, saltvalue);
            pst.setString(5, hashedPassword);
            res = pst.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        if (res > 0) {
            out.println("<h1>" + "User Created Successfully!" + "</h1>");
            out.println("<a href=\"login.jsp\">Login here</a>");
        } else {
            out.println("<h1>" + "Error has been occurred in the process of user creation!" + "</h1>");
        }
        out.println("</body></html>");
    }

    public void destroy() {
        try {
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}