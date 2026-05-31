/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;
import util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

/**
 * Xử lý yêu cầu quên mật khẩu. GET: Hiển thị form quên mật khẩu POST: Gửi email
 * đặt lại mật khẩu
 *
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotpassword"})
public class ForgotPasswordServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgotPasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu đã đăng nhập → redirect về home
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("home");
            return;
        }
        request.getRequestDispatcher("/views/user/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập địa chỉ email.");
            request.getRequestDispatcher("/views/user/forgot-password.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByEmail(email.trim());

        if (user == null) {
            request.setAttribute("errorMessage", "Email không tồn tại trong hệ thống.");
            request.getRequestDispatcher("/views/user/forgot-password.jsp").forward(request, response);
            return;
        }

        // Tạo token reset
        String token = UUID.randomUUID().toString();

        // Lưu token vào DB (hết hạn sau 30 phút)
        if (!userDAO.createPasswordResetToken(user.getId(), token)) {
            request.setAttribute("errorMessage", "Có lỗi xảy ra. Vui lòng thử lại.");
            request.getRequestDispatcher("/views/user/forgot-password.jsp").forward(request, response);
            return;
        }

        // Tạo link reset
        String baseUrl = request.getScheme() + "://" + request.getServerName()
                + ":" + request.getServerPort() + request.getContextPath();
        String resetLink = baseUrl + "/resetpassword?token=" + token;

        // Gửi email
        String htmlContent = EmailUtil.buildResetPasswordEmail(resetLink, user.getFullName());
        boolean sent = EmailUtil.sendHtmlEmail(email.trim(), "BAGISTA — Đặt lại mật khẩu", htmlContent);

        if (sent) {
            request.setAttribute("successMessage",
                    "Chúng tôi đã gửi email hướng dẫn đặt lại mật khẩu đến <strong>" + email + "</strong>. "
                    + "Vui lòng kiểm tra hộp thư (và thư mục Spam).");
        } else {
            request.setAttribute("errorMessage", "Gửi email thất bại. Vui lòng thử lại sau.");
        }

        request.getRequestDispatcher("/views/user/forgot-password.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
