/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import java.io.PrintWriter;
import dao.OrderDAO;
import model.Order;
import model.OrderDetail;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Quản lý đơn hàng (Admin). /AdminOrderServlet → Danh sách (lọc theo status)
 * /AdminUpdateOrderStatusServlet → Cập nhật trạng thái /AdminOrderDetailServlet
 * → Chi tiết đơn hàng (AJAX JSON)
 */
@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/adminorder", "/adminupdateorderstatus", "/adminorderdetail"})
public class AdminOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head><title>Servlet AdminOrderServlet</title></head>");
            out.println("<body><h1>Servlet AdminOrderServlet at " + request.getContextPath() + "</h1></body>");
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
        if ("/adminorderdetail".equals(path)) {
            showDetail(request, response);
        } else {
            listOrders(request, response);
        }
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
        if ("/adminupdateorderstatus".equals(path)) {
            updateStatus(request, response);
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");
        OrderDAO orderDAO = new OrderDAO();

        List<Order> orders;
        if (status != null && !status.isEmpty() && !"All".equals(status)) {
            orders = orderDAO.findByStatus(status);
        } else {
            orders = orderDAO.findAll();
        }

        request.setAttribute("orders", orders);
        request.setAttribute("filterStatus", status);
        request.getRequestDispatcher("/views/admin/orders.jsp").forward(request, response);
    }

    // --- PHẦN CẬP NHẬT QUAN TRỌNG NHẤT ---
    private void updateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            OrderDAO orderDAO = new OrderDAO();
            Order currentOrder = orderDAO.findById(orderId);

            // LOGIC BẢO VỆ: Nếu đơn đã bị khách hủy trước đó, không cho admin đổi status nữa
            // Để tránh việc admin vô tình giao đơn hàng mà hệ thống đã hoàn kho
            if (currentOrder != null && !"Đã hủy".equals(currentOrder.getStatus())) {
                orderDAO.updateStatus(orderId, status);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("adminorder");
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = new OrderDAO().findById(id);
        if (order == null) {
            response.setStatus(404);
            response.getWriter().write("{\"error\":\"Order not found\"}");
            return;
        }

        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        StringBuilder json = new StringBuilder("{");
        json.append("\"id\":").append(order.getId()).append(",");
        json.append("\"recipientName\":\"").append(escapeJson(order.getRecipientName())).append("\",");
        json.append("\"recipientPhone\":\"").append(escapeJson(order.getRecipientPhone())).append("\",");
        json.append("\"recipientAddress\":\"").append(escapeJson(order.getRecipientAddress())).append("\",");
        json.append("\"accountUsername\":\"").append(order.getAccountUsername() != null ? escapeJson(order.getAccountUsername()) : "").append("\",");
        json.append("\"payment\":\"").append(escapeJson(order.getPayment())).append("\",");
        json.append("\"status\":\"").append(escapeJson(order.getStatus())).append("\",");
        json.append("\"total\":\"").append(order.getFormattedTotal()).append("\",");
        json.append("\"datetime\":\"").append(order.getDatetime()).append("\",");
        json.append("\"items\":[");
        if (order.getItems() != null) {
            for (int i = 0; i < order.getItems().size(); i++) {
                OrderDetail item = order.getItems().get(i);
                if (i > 0) {
                    json.append(",");
                }
                json.append("{\"name\":\"").append(escapeJson(item.getProductName())).append("\",");
                json.append("\"qty\":").append(item.getQuantity()).append(",");
                json.append("\"price\":\"").append(item.getFormattedPrice()).append("\",");
                json.append("\"color\":").append(item.getColor() != null ? "\"" + escapeJson(item.getColor()) + "\"" : "null").append(",");
                json.append("\"size\":").append(item.getSize() != null ? "\"" + escapeJson(item.getSize()) + "\"" : "null").append("}");
            }
        }
        json.append("]}");
        response.getWriter().write(json.toString());
    }

    private String escapeJson(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t");
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        User user = (User) session.getAttribute("user");
        return user != null && "admin".equals(user.getRole());
    }

    @Override
    public String getServletInfo() {
        return "Admin Order Manager";
    }
}
