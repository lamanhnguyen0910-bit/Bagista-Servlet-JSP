/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DiscountDAO;
import dao.OrderDAO;
import model.CartItem;
import model.Order;
import model.OrderDetail;
import model.User;
import model.Discount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.text.NumberFormat;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cartItems");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        DiscountDAO discountDAO = new DiscountDAO();
        for (CartItem item : cart) {
            Discount d = discountDAO.findActiveByProductId(item.getProductId());
            if (d != null) {
                item.setDiscountPercent(d.getPercent());
                item.setSalePrice(d.getSalePrice());
            } else {
                item.setDiscountPercent(0);
                item.setSalePrice(0);
            }
        }

        long total = cart.stream().mapToLong(CartItem::getSubtotal).sum();
        request.setAttribute("cartTotalRaw", total);

        NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
        request.setAttribute("cartTotal", nf.format(total) + " ₫");

        request.setAttribute("cartItems", cart);
        request.getRequestDispatcher("/views/user/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cartItems");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        User user = (User) session.getAttribute("user");
        String recipientName = request.getParameter("recipientName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String payment = request.getParameter("payment");
        String note = request.getParameter("note");

        long total = cart.stream().mapToLong(CartItem::getSubtotal).sum();

        Order order = new Order();
        order.setUserId(user.getId());
        order.setRecipientName(recipientName);
        order.setRecipientPhone(phone);
        order.setRecipientAddress(address);
        order.setPayment(payment != null ? payment : "cod");
        order.setNote(note);
        order.setTotal(total);

        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.createOrder(order);

        if (orderId > 0) {
            for (CartItem item : cart) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderId(orderId);
                detail.setProductId(item.getProductId());

                detail.setVariantId(item.getVariantId());

                detail.setQuantity(item.getQuantity());
                detail.setPrice(item.getEffectivePrice());
                detail.setColor(item.getColor());
                detail.setSize(item.getSize());
                orderDAO.addOrderDetail(detail);

                // Trigger của Lâm sẽ tự động cập nhật bảng Products tổng.
                orderDAO.updateVariantStock(item.getVariantId(), item.getQuantity());
            }

            session.removeAttribute("cartItems");
            session.setAttribute("lastOrderId", orderId);
            response.sendRedirect(request.getContextPath() + "/thankyou");
        } else {
            request.setAttribute("errorMessage", "Đặt hàng thất bại. Vui lòng thử lại.");
            doGet(request, response);
        }
    }
}
