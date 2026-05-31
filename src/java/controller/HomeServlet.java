/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DiscountDAO;
import dao.ProductDAO;
import model.Discount;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        DiscountDAO discountDAO = new DiscountDAO();

        // Lấy dữ liệu
        List<Product> newProducts = productDAO.getNewProducts(4);
        List<Product> hotProducts = productDAO.getHotProducts(4);
        List<Product> bestsellerProducts = productDAO.getBestsellerProducts(4);

        // Inject discount
        injectDiscounts(newProducts, discountDAO);
        injectDiscounts(hotProducts, discountDAO);
        injectDiscounts(bestsellerProducts, discountDAO);

        // Đẩy attribute sang JSP
        request.setAttribute("newProducts", newProducts);
        request.setAttribute("hotProducts", hotProducts);
        request.setAttribute("bestsellerProducts", bestsellerProducts);

        // Cart count
        HttpSession session = request.getSession(false);
        int cartCount = 0;
        if (session != null && session.getAttribute("cart") != null) {
            List<?> cart = (List<?>) session.getAttribute("cart");
            cartCount = cart.size();
        }
        request.setAttribute("cartCount", cartCount);

        // Điều hướng về JSP
        request.getRequestDispatcher("/views/user/home.jsp").forward(request, response);
    }

    private void injectDiscounts(List<Product> products, DiscountDAO discountDAO) {
        if (products == null) {
            return;
        }
        for (Product p : products) {
            Discount d = discountDAO.findActiveByProductId(p.getId());
            if (d != null) {
                p.setDiscountPercent(d.getPercent());
                p.setSalePrice(d.getSalePrice());
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Home Servlet for Bagista";
    }
}
