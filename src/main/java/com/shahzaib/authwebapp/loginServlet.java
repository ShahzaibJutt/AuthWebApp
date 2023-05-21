package com.shahzaib.authwebapp;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "login", value = "/loginServlet")
public class loginServlet extends HttpServlet {
    String url;
    Connection con;

    public void init() {
        Dotenv dotenv = Dotenv.configure().directory("/home/shahzaib/IdeaProjects/AuthWebApp").ignoreIfMalformed().ignoreIfMissing().load();

        String host = dotenv.get("HOST");
        String database = dotenv.get("DB_NAME");
        String username = dotenv.get("DB_USERNAME");
        String password = dotenv.get("DB_PASSWORD");
        url = "jdbc:postgresql://" + host + "/" + database + "?user=" + username + "&password=" + password;
        try {
            con = DriverManager.getConnection(url);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PreparedStatement st;
        ResultSet rs;
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            String emailtoSearch = request.getParameter("email");
            String pass = request.getParameter("password");
            String email = null;
            String passwordSaltValue = null;
            String hashedPassword = null;
            st = con.prepareStatement("SELECT * FROM \"user\" WHERE email = ?");
            st.setString(1, emailtoSearch);
            rs = st.executeQuery();
            while (rs.next()) {
                email = rs.getString("email");
                hashedPassword = rs.getString("hashed_password");
                passwordSaltValue = rs.getString("password_salt_value");
            }
            PrintWriter out = response.getWriter();
            if (emailtoSearch.equals(email)) {
                boolean status = PassBasedEnc.verifyUserPassword(pass, hashedPassword, passwordSaltValue);
                if (status) {
                    out.println("{\"status\": \"success\"}");
                } else {
                    out.println("{\"status\": \"failure\", \"message\": \"Incorrect password.\"}");
                }
            } else {
                out.println("{\"status\": \"failure\", \"message\": \"Incorrect password.\"}");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void destroy() {
        try {
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
