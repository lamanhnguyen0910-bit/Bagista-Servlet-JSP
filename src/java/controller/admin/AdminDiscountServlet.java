/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.DiscountDAO;
import dao.ProductDAO;
import model.Discount;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet(name = "AdminDiscountServlet", urlPatterns = {"/admindiscount", "/adminadddiscount", "/admineditdiscount", "/admindeletediscount"})
public class AdminDiscountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect("login");
            return;
        }

        String path = request.getServletPath();
        DiscountDAO discountDAO = new DiscountDAO();
        ProductDAO productDAO = new ProductDAO();

        // 1. Xử lý logic chuẩn bị dữ liệu cho FORM SỬA
        if ("/admineditdiscount".equals(path)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Discount discount = discountDAO.findById(id);
                if (discount != null) {
                    request.setAttribute("editDiscount", discount);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 2. LUÔN LUÔN lấy danh sách mới nhất để hiển thị ra bảng
        // Đảm bảo "discounts" khớp với biến trong file JSP của bạn
        request.setAttribute("discounts", discountDAO.findAll());
        request.setAttribute("products", productDAO.findAll());

        // 3. Đường dẫn dispatcher: Bỏ dấu "/" ở đầu nếu gặp lỗi 404, hoặc giữ nguyên nếu server của bạn nhận diện đúng
        request.getRequestDispatcher("/views/admin/discounts.jsp").forward(request, response);
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
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        DiscountDAO dao = new DiscountDAO();

        try {
            switch (path) {
                case "/adminadddiscount": {
                    // Phải dùng đúng "startDate" và "endDate" giống như thuộc tính 'name' trong file JSP
                    String startStr = request.getParameter("startDate");
                    String endStr = request.getParameter("endDate");

                    Discount d = new Discount();
                    d.setProductId(Integer.parseInt(request.getParameter("productId")));
                    d.setPercent(Integer.parseInt(request.getParameter("percent")));
                    d.setStartDate(sdf.parse(startStr));
                    d.setEndDate(sdf.parse(endStr));

                    dao.add(d); // Gọi hàm add đã sửa ở bước 1
                    break;
                }
                case "/admineditdiscount": {
                    Discount d = new Discount();
                    // Lưu ý: Kiểm tra ID gửi lên từ form sửa phải đúng tên là "discountId"
                    d.setId(Integer.parseInt(request.getParameter("discountId")));
                    d.setProductId(Integer.parseInt(request.getParameter("productId")));
                    d.setPercent(Integer.parseInt(request.getParameter("percent")));
                    d.setStartDate(sdf.parse(request.getParameter("startDate")));
                    d.setEndDate(sdf.parse(request.getParameter("endDate")));
                    dao.update(d);
                    break;
                }
                case "/admindeletediscount": {
                    int id = Integer.parseInt(request.getParameter("discountId"));
                    dao.delete(id);
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Sau khi POST xong, Redirect về trang danh sách để load lại dữ liệu sạch
        response.sendRedirect("admindiscount");
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        User user = (User) session.getAttribute("user");
        return user != null && "admin".equals(user.getRole());
    }
}
