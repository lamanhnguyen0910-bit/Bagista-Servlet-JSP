/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head><title>Servlet LoginServlet</title></head>");
            out.println("<body><h1>Servlet LoginServlet at " + request.getContextPath() + "</h1></body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("home");
            return;
        }
        request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String identifier = request.getParameter("identifier");
        String password = request.getParameter("password");
        String loginMethod = request.getParameter("loginMethod");

        if (identifier == null || password == null || identifier.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = null;

        // Giữ nguyên Switch-case của bạn
        switch (loginMethod != null ? loginMethod : "username") {
            case "email":
                user = userDAO.findByEmail(identifier);
                break;
            case "phone":
                user = userDAO.findByPhone(identifier);
                break;
            default:
                user = userDAO.findByUsername(identifier);
                break;
        }

        if (user == null) {
            request.setAttribute("errorMessage", "Tài khoản không tồn tại.");
            request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
            return;
        }

        if (!user.isActive()) {
            request.setAttribute("errorMessage", "Tài khoản đã bị khóa.");
            request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
            return;
        }

        // 1. Kiểm tra xem mật khẩu từ DB có bị null hoặc trống không
        String dbHash = user.getPassword();
        if (dbHash != null) {
            dbHash = dbHash.trim(); 
        }

        System.out.println("DEBUG: Password Length from DB: " + (dbHash != null ? dbHash.length() : "NULL"));

        try {
            if (dbHash == null || !BCrypt.checkpw(password, dbHash)) {
                request.setAttribute("errorMessage", "Mật khẩu không đúng.");
                request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
                return;
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Lỗi dữ liệu mật khẩu (Hash không hợp lệ).");
            request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
            return;
        }

        // Đăng nhập thành công
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setMaxInactiveInterval(30 * 60);

        if ("admin".equals(user.getRole())) {
            response.sendRedirect("admindashboard");
        } else {
            response.sendRedirect("home");
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet with BCrypt Check";
    }
}
