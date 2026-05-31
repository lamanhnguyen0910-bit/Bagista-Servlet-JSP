/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.*;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList; // Thêm import này
import java.util.List;
import java.util.Locale;

/**
 * Dashboard Admin: thống kê doanh thu, sản phẩm, đơn hàng, khách hàng.
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admindashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Kiểm tra quyền admin
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            ProductDAO productDAO = new ProductDAO();
            OrderDAO orderDAO = new OrderDAO();
            UserDAO userDAO = new UserDAO();
            CategoryDAO categoryDAO = new CategoryDAO();

            NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));

            // 2. Stats
            request.setAttribute("totalRevenue", nf.format(orderDAO.getTotalRevenue()) + " ₫");
            request.setAttribute("totalProducts", productDAO.countAll());
            request.setAttribute("totalOrders", orderDAO.countAll());
            request.setAttribute("totalCustomers", userDAO.countAll());
            request.setAttribute("pendingOrders", orderDAO.countByStatus("Chờ xử lý"));

            // 3. Category stats
            request.setAttribute("categoryStats", categoryDAO.findAll());

            // 4. Product rankings
            List<Product> topSelling = productDAO.getTopSelling(10);
            if (topSelling != null) {
                for (Product p : topSelling) {
                    p.setImage(productDAO.getFirstImage(p.getId()));
                }
            }
            request.setAttribute("topSelling", topSelling);

            List<Product> topRated = productDAO.getTopRated(10);
            if (topRated != null) {
                for (Product p : topRated) {
                    p.setImage(productDAO.getFirstImage(p.getId()));
                }
            }
            request.setAttribute("topRated", topRated);

            request.setAttribute("bottomSelling", productDAO.getBottomSelling(10));
            request.setAttribute("bottomRated", productDAO.getBottomRated(10));

            // 5. Recent data - GIA CỐ PHẦN NÀY ĐỂ HIỂN THỊ CỘT ĐƠN HÀNG
            List<User> recentCustomers = userDAO.getRecentCustomers(5);
            request.setAttribute("recentCustomers", recentCustomers != null ? recentCustomers : new ArrayList<>());

            List<Order> recentOrders = orderDAO.getRecentOrders(5);
            request.setAttribute("recentOrders", recentOrders != null ? recentOrders : new ArrayList<>());

            // 6. Revenue charts - SỬA LỖI ĐỊNH DẠNG BIỂU ĐỒ VÀ CASTING
            List<Object[]> monthlyRaw = orderDAO.getMonthlyRevenue();
            List<Object[]> dailyRaw = orderDAO.getDailyRevenue();

            // Sửa lỗi: Khởi tạo mảng 12 tháng bằng 0 và dùng String parsing để tránh lỗi ép kiểu
            Long[] monthlyDataArray = new Long[12];
            for (int i = 0; i < 12; i++) monthlyDataArray[i] = 0L;

            if (monthlyRaw != null) {
                for (Object[] row : monthlyRaw) {
                    try {
                        if (row[0] != null && row[1] != null) {
                            // Ép về String trước rồi mới parse để an toàn tuyệt đối
                            int monthValue = Integer.parseInt(row[0].toString());
                            int monthIndex = monthValue - 1; // Đưa về index 0-11
                            if (monthIndex >= 0 && monthIndex < 12) {
                                // Xử lý nếu SQL trả về kiểu số thực (vd: 1500.0)
                                monthlyDataArray[monthIndex] = (long) Double.parseDouble(row[1].toString());
                            }
                        }
                    } catch (Exception e) {
                        System.err.println("Lỗi parse dữ liệu tháng: " + e.getMessage());
                    }
                }
            }
            
            // Chuyển sang chuỗi format của Javascript [0, 150000, 0, ...]
            StringBuilder sbMonthly = new StringBuilder("[");
            for (int i = 0; i < 12; i++) {
                sbMonthly.append(monthlyDataArray[i]);
                if (i < 11) sbMonthly.append(",");
            }
            sbMonthly.append("]");
            request.setAttribute("monthlyRevenue", sbMonthly.toString());

            // Xử lý biểu đồ ngày (An toàn casting)
            List<String> dayLabels = new java.util.ArrayList<>();
            List<Long> dayData = new java.util.ArrayList<>();
            
            if (dailyRaw != null && !dailyRaw.isEmpty()) {
                for (Object[] row : dailyRaw) {
                    try {
                        dayLabels.add(row[0] != null ? row[0].toString() : "");
                        long rev = row[1] != null ? (long) Double.parseDouble(row[1].toString()) : 0L;
                        dayData.add(rev);
                    } catch (Exception e) {
                        dayLabels.add("Lỗi");
                        dayData.add(0L);
                    }
                }
            } else {
                dayLabels.add("Chưa có dữ liệu");
                dayData.add(0L);
            }

            request.setAttribute("dailyRevenueLabels", toJsonArray(dayLabels));
            request.setAttribute("dailyRevenue", dayData.toString());

            request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi nạp dữ liệu Admin: " + e.getMessage());
        }
    }

    private String toJsonArray(List<String> list) {
        if (list == null || list.isEmpty()) {
            return "[]";
        }
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            sb.append("\"").append(list.get(i)).append("\"");
            if (i < list.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        return sb.toString();
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
        return "Dashboard Servlet for Bagista Admin";
    }
}