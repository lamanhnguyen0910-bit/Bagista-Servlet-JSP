/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import dao.UserDAO;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AccountServlet", urlPatterns = {"/profile"})
public class AccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            User user = (User) session.getAttribute("user");
            UserDAO userDAO = new UserDAO();

            // Lấy dữ liệu mới nhất từ DB
            User freshUser = userDAO.findById(user.getId());

            if (freshUser != null) {
                if (freshUser.getFullName() == null || freshUser.getFullName().trim().isEmpty()) {
                    freshUser.setFullName(freshUser.getUsername());
                }
                session.setAttribute("user", freshUser);
            }

            // Lấy danh sách đơn hàng
            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = orderDAO.findByUserId(user.getId());

            // Đảm bảo Attribute "orders" không bao giờ null để JSP không bị lỗi trắng trang
            request.setAttribute("orders", (orders != null) ? orders : new ArrayList<Order>());

            request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);

        } catch (Exception e) {
            // Nếu có lỗi phát sinh, in ra log để debug thay vì để trang trắng
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hiển thị hồ sơ.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("updateInfo".equals(action)) {
            updateProfile(request, response, user, session);
        } else {
            response.sendRedirect("profile");
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response,
            User user, HttpSession session) throws ServletException, IOException {

        String newEmail = request.getParameter("email");
        String newPhone = request.getParameter("phone");
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String birthdayStr = request.getParameter("birthday");

        UserDAO userDAO = new UserDAO();

        // 1. Kiểm tra trùng email (chỉ check nếu người dùng có nhập)
        if (newEmail != null && !newEmail.trim().isEmpty()) {
            if (userDAO.existsByEmailExcludeId(newEmail.trim(), user.getId())) {
                request.setAttribute("errorMessage", "Email đã được sử dụng bởi tài khoản khác.");
                doGet(request, response);
                return;
            }
        }

        // 2. Kiểm tra trùng số điện thoại (chỉ check nếu người dùng có nhập)
        if (newPhone != null && !newPhone.trim().isEmpty()) {
            if (userDAO.existsByPhoneExcludeId(newPhone.trim(), user.getId())) {
                request.setAttribute("errorMessage", "Số điện thoại đã được sử dụng bởi tài khoản khác.");
                doGet(request, response);
                return;
            }
        }

        // 3. Gán dữ liệu (Xử lý chuỗi rỗng thành NULL để khớp với Filtered Index trong DB)
        user.setFullName(fullName != null ? fullName.trim() : null);
        user.setEmail((newEmail == null || newEmail.trim().isEmpty()) ? null : newEmail.trim());
        user.setPhone((newPhone == null || newPhone.trim().isEmpty()) ? null : newPhone.trim());
        user.setAddress(address != null ? address.trim() : null);

        if (birthdayStr != null && !birthdayStr.isEmpty()) {
            try {
                user.setBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(birthdayStr));
            } catch (ParseException ignored) {
                user.setBirthday(null);
            }
        } else {
            user.setBirthday(null);
        }

        // 4. Thực thi cập nhật
        if (userDAO.updateProfile(user)) {
            session.setAttribute("user", user);
            request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
        } else {
            request.setAttribute("errorMessage", "Cập nhật thất bại. Vui lòng thử lại.");
        }

        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Account Management Servlet for BAGISTA";
    }
}
