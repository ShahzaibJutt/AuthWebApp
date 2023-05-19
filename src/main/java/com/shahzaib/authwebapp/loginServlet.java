package com.shahzaib.authwebapp;

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
        url = "jdbc:postgresql://localhost/web?user=shahzaib&password=4646";
        try {
            con = DriverManager.getConnection(url);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PreparedStatement st;
        ResultSet rs;
        response.setContentType("text/html");
        try{
            String emailtoSearch = request.getParameter("email");
            String pass = request.getParameter("password");
            String email = null;
            String passwordSaltValue = null;
            String hashedPassword = null;
            st = con.prepareStatement("SELECT * FROM \"user\" WHERE email = ?");
            st.setString(1,emailtoSearch);
            rs = st.executeQuery();
            while(rs.next()){
                email = rs.getString("email");
                hashedPassword = rs.getString("hashed_password");
                passwordSaltValue = rs.getString("password_salt_value");
            }
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            if (emailtoSearch.equals(email)){
                boolean status = PassBasedEnc.verifyUserPassword(pass, hashedPassword, passwordSaltValue);
                if(status){
                    out.println("<h1>" + "Login Successful!" + "</h1>");
                }
                else{
                    out.println("<h1>" + "Email or password mismatch!" + "</h1>");
                }
            }
            else{
                out.println("<h1>" + "Email or password mismatch!" + "</h1>");
            }
            out.println("</body></html>");
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void destroy(){
        try {
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
