/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.ProductDAO;
import dao.ReviewDAO;
import model.Review;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.io.PrintWriter;

/**
 * Quản lý đánh giá (Admin). GET: /AdminReviewServlet → Danh sách reviews POST:
 * /AdminDeleteReviewServlet → Xoá review (cập nhật lại rating sản phẩm)
 */
@WebServlet(name = "AdminReviewServlet", urlPatterns = {"/adminreview", "/admindeletereview"})
public class AdminReviewServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminReviewServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminReviewServlet at " + request.getContextPath() + "</h1>");
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

        ReviewDAO reviewDAO = new ReviewDAO();
        List<Review> reviews = reviewDAO.findAll();

        // Tính thống kê
        int total = reviews.size();
        int star5 = 0, star12 = 0;
        double sum = 0;
        for (Review r : reviews) {
            sum += r.getRating();
            if (r.getRating() == 5) {
                star5++;
            }
            if (r.getRating() <= 2) {
                star12++;
            }
        }
        double avg = total > 0 ? sum / total : 0;

        request.setAttribute("reviews", reviews);
        request.setAttribute("totalReviews", total);
        request.setAttribute("avgRating", String.format("%.1f", avg));
        request.setAttribute("star5Count", star5);
        request.setAttribute("star12Count", star12);

        request.getRequestDispatcher("/views/admin/reviews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect("login");
            return;
        }

        String path = request.getServletPath();
        if ("/admindeletereview".equals(path)) {
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            String productIdStr = request.getParameter("productId");

            ReviewDAO reviewDAO = new ReviewDAO();
            reviewDAO.delete(reviewId);

            // Cập nhật lại rating trung bình của sản phẩm sau khi xoá review
            if (productIdStr != null && !productIdStr.isEmpty()) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    new ProductDAO().updateRating(productId);
                } catch (NumberFormatException ignored) {
                }
            }
        }

        response.sendRedirect("adminreview");
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
