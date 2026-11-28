package com.musicplaylist.controller;
import com.musicplaylist.util.DBConnection;import jakarta.servlet.*;import jakarta.servlet.annotation.*;import jakarta.servlet.http.*;import org.mindrot.jbcrypt.BCrypt;import java.io.*;import java.sql.*;
@WebServlet("/login") public class LoginServlet extends HttpServlet {
 protected void doGet(HttpServletRequest q,HttpServletResponse p)throws ServletException,IOException{q.getRequestDispatcher("/login.jsp").forward(q,p);}
 protected void doPost(HttpServletRequest q,HttpServletResponse p)throws ServletException,IOException{
 try(Connection c=DBConnection.getConnection();PreparedStatement s=c.prepareStatement("SELECT id,username,password FROM users WHERE email=?")){
 s.setString(1,q.getParameter("email").trim().toLowerCase());try(ResultSet r=s.executeQuery()){if(r.next()&&BCrypt.checkpw(q.getParameter("password"),r.getString("password"))){HttpSession h=q.getSession();h.setAttribute("userId",r.getInt("id"));h.setAttribute("username",r.getString("username"));p.sendRedirect(q.getContextPath()+"/dashboard");return;}}
 q.setAttribute("error","Incorrect email or password.");doGet(q,p);
 }catch(SQLException x){throw new ServletException(x);}
 }}