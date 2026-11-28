package com.musicplaylist.controller;
import com.musicplaylist.util.DBConnection;import jakarta.servlet.*;import jakarta.servlet.annotation.*;import jakarta.servlet.http.*;import org.mindrot.jbcrypt.BCrypt;import java.io.*;import java.sql.*;
@WebServlet("/register") public class RegisterServlet extends HttpServlet {
 protected void doGet(HttpServletRequest q,HttpServletResponse p)throws ServletException,IOException{q.getRequestDispatcher("/register.jsp").forward(q,p);}
 protected void doPost(HttpServletRequest q,HttpServletResponse p)throws ServletException,IOException{
 String n=q.getParameter("username"),e=q.getParameter("email"),pw=q.getParameter("password");
 if(n==null||e==null||pw==null||n.isBlank()||e.isBlank()||pw.length()<6){q.setAttribute("error","Enter all details; password must be at least 6 characters.");doGet(q,p);return;}
 try(Connection c=DBConnection.getConnection();PreparedStatement s=c.prepareStatement("INSERT INTO users(username,email,password) VALUES(?,?,?)")){
 s.setString(1,n.trim());s.setString(2,e.trim().toLowerCase());s.setString(3,BCrypt.hashpw(pw,BCrypt.gensalt()));s.executeUpdate();p.sendRedirect(q.getContextPath()+"/login?registered=1");
 }catch(SQLIntegrityConstraintViolationException x){q.setAttribute("error","Email already registered.");doGet(q,p);}catch(SQLException x){throw new ServletException(x);}
 }}