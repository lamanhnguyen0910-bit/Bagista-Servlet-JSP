/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.OrderDAO;
import dao.UserDAO;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.io.PrintWriter;

@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admincustomer", "/adminaddcustomer",
    "/admintogglecustomer", "/admineditcustomer", "/admindeletecustomer"})
public class AdminUserServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminUserServlet at " + request.getContextPath() + "</h1>");
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

        String path = request.getServletPath();

        if ("/admineditcustomer".equals(path)) {
            int id = Integer.parseInt(request.getParameter("id"));
            UserDAO userDAO = new UserDAO();
            User customer = userDAO.findById(id);
            if (customer == null || "admin".equals(customer.getRole())) {
                response.sendRedirect("admincustomer");
                return;
            }
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/views/admin/edit-customer.jsp").forward(request, response);
            return;
        }

        // Default: list customers
        String search = request.getParameter("search");
        UserDAO userDAO = new UserDAO();
        OrderDAO orderDAO = new OrderDAO();

        List<User> customers;
        if (search != null && !search.isEmpty()) {
            customers = userDAO.search(search);
        } else {
            customers = userDAO.findAll();
        }

        for (User customer : customers) {
            List<Order> orders = orderDAO.findByUserId(customer.getId());
            customer.setTotalOrders(orders.size());
            long totalSpent = orders.stream()
                    .filter(o -> "Đã giao".equals(o.getStatus()))
                    .mapToLong(Order::getTotal)
                    .sum();
            customer.setTotalSpent(totalSpent);
        }

        request.setAttribute("customers", customers);
        request.setAttribute("searchKeyword", search);
        request.setAttribute("totalCustomers", customers.size());
        request.getRequestDispatcher("/views/admin/customers.jsp").forward(request, response);
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

        switch (path) {
            case "/adminaddcustomer":
                addCustomer(request, response);
                break;
            case "/admintogglecustomer":
                toggleCustomer(request, response);
                break;
            case "/admindeletecustomer":
                deleteCustomer(request, response);
                break;
            case "/admineditcustomer":
                editCustomer(request, response);
                break;
            default:
                response.sendRedirect("admincustomer");
                break;
        }
    }

    private void addCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        UserDAO userDAO = new UserDAO();
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (userDAO.existsByUsername(username)) {
            response.sendRedirect("admincustomer?error=duplicate&msg=username");
            return;
        }
        if (email != null && !email.isEmpty() && userDAO.existsByEmail(email)) {
            response.sendRedirect("admincustomer?error=duplicate&msg=email");
            return;
        }
        if (phone != null && !phone.isEmpty() && userDAO.existsByPhone(phone)) {
            response.sendRedirect("admincustomer?error=duplicate&msg=phone");
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(org.mindrot.jbcrypt.BCrypt.hashpw("123456", org.mindrot.jbcrypt.BCrypt.gensalt(10)));
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        userDAO.register(user);
        response.sendRedirect("admincustomer");
    }

    private void editCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        UserDAO userDAO = new UserDAO();
        int id = Integer.parseInt(request.getParameter("id"));

        User user = userDAO.findById(id);
        if (user == null || "admin".equals(user.getRole())) {
            response.sendRedirect("admincustomer");
            return;
        }

        String newEmail = request.getParameter("email");
        String newPhone = request.getParameter("phone");

        // Kiểm tra trùng email (trừ chính user đang sửa)
        if (newEmail != null && !newEmail.isEmpty() && userDAO.existsByEmailExcludeId(newEmail, id)) {
            response.sendRedirect("admineditcustomer?id=" + id + "&error=duplicate&msg=email");
            return;
        }
        // Kiểm tra trùng số điện thoại (trừ chính user đang sửa)
        if (newPhone != null && !newPhone.isEmpty() && userDAO.existsByPhoneExcludeId(newPhone, id)) {
            response.sendRedirect("admineditcustomer?id=" + id + "&error=duplicate&msg=phone");
            return;
        }

        user.setFullName(request.getParameter("fullName"));
        user.setEmail(newEmail);
        user.setPhone(newPhone);
        user.setAddress(request.getParameter("address"));

        String birthdayStr = request.getParameter("birthday");
        if (birthdayStr != null && !birthdayStr.isEmpty()) {
            try {
                user.setBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(birthdayStr));
            } catch (Exception e) {
                /* ignore parse error */ }
        } else {
            user.setBirthday(null);
        }

        userDAO.adminUpdateUser(user);
        response.sendRedirect("admincustomer");
    }

    private void toggleCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        new UserDAO().toggleActive(userId);
        response.sendRedirect("admincustomer");
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        new UserDAO().deleteUser(customerId);
        response.sendRedirect("admincustomer");
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
