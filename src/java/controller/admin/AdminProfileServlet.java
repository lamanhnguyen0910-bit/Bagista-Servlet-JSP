/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import java.io.PrintWriter;
import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import org.mindrot.jbcrypt.BCrypt;

/**
 * Admin Profile: xem & cập nhật thông tin admin, đổi mật khẩu.
 * /AdminProfileServlet → Xem profile /AdminUpdateProfileServlet → Cập nhật
 * thông tin /AdminChangePasswordServlet → Đổi mật khẩu
 */
@WebServlet(name = "AdminProfileServlet", urlPatterns = {"/adminprofile", "/adminupdateprofile", "/adminchangepassword"})
public class AdminProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminProfileServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) request.getSession().getAttribute("user");
        UserDAO userDAO = new UserDAO();
        user = userDAO.findById(user.getId());
        request.getSession().setAttribute("user", user);
        request.setAttribute("admin", user);

        request.getRequestDispatcher("/views/admin/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect("login");
            return;
        }
        request.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();

        if ("/adminchangepassword".equals(path)) {
            changePassword(request, response);
        } else {
            updateProfile(request, response);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));

        String birthdayStr = request.getParameter("birthday");
        if (birthdayStr != null && !birthdayStr.isEmpty()) {
            try {
                user.setBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(birthdayStr));
            } catch (ParseException ignored) {
            }
        }

        UserDAO userDAO = new UserDAO();
        if (userDAO.updateProfile(user)) {
            request.getSession().setAttribute("user", user);
            request.setAttribute("successMessage", "Cập nhật thành công!");
        } else {
            request.setAttribute("errorMessage", "Cập nhật thất bại.");
        }

        request.setAttribute("admin", user);
        request.getRequestDispatcher("/views/admin/profile.jsp").forward(request, response);
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (oldPassword == null || newPassword == null || confirmPassword == null
                || oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin.");
            request.setAttribute("admin", user);
            request.getRequestDispatcher("/views/admin/profile.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("admin", user);
            request.getRequestDispatcher("/views/admin/profile.jsp").forward(request, response);
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("errorMessage", "Mật khẩu mới phải từ 6 ký tự.");
            request.setAttribute("admin", user);
            request.getRequestDispatcher("/views/admin/profile.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User freshUser = userDAO.findById(user.getId());

        if (!BCrypt.checkpw(oldPassword, freshUser.getPassword())) {
            request.setAttribute("errorMessage", "Mật khẩu cũ không đúng.");
            request.setAttribute("admin", user);
            request.getRequestDispatcher("/views/admin/profile.jsp").forward(request, response);
            return;
        }

        String newHash = BCrypt.hashpw(newPassword, BCrypt.gensalt(10));
        if (userDAO.changePassword(user.getId(), newHash)) {
            request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
        } else {
            request.setAttribute("errorMessage", "Đổi mật khẩu thất bại.");
        }

        request.setAttribute("admin", user);
        request.getRequestDispatcher("/views/admin/profile.jsp").forward(request, response);
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        User user = (User) session.getAttribute("user");
        return user != null && "admin".equals(user.getRole());
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
