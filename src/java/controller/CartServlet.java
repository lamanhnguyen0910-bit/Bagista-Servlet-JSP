/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DiscountDAO;
import dao.ProductDAO;
import model.CartItem;
import model.Discount;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = getCart(session);

        refreshDiscountPrices(cart);

        request.setAttribute("cartItems", cart);
        request.setAttribute("cartTotal", formatTotal(cart));
        request.setAttribute("cartTotalRaw", calculateTotal(cart));
        request.setAttribute("cartCount", cart.size());

        request.getRequestDispatcher("/views/user/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        List<CartItem> cart = getCart(session);
        String action = request.getParameter("action");

        switch (action != null ? action : "") {
            case "add":
                addToCart(request, cart);
                break;
            case "update":
                updateCart(request, cart);
                break;
            case "remove":
                removeFromCart(request, cart);
                break;
        }

        cart.removeIf(item -> item.getQuantity() <= 0);
        session.setAttribute("cartItems", cart);

        String referer = request.getHeader("Referer");
        if ("add".equals(action) && referer != null && !referer.contains("/cart")) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("cart");
        }
    }

    private void addToCart(HttpServletRequest request, List<CartItem> cart) {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int variantId = Integer.parseInt(request.getParameter("variantId")); // NHẬN TỪ JSP
            int quantity = 1;
            try {
                quantity = Integer.parseInt(request.getParameter("quantity"));
            } catch (Exception ignored) {
            }

            String color = request.getParameter("color");
            String size = request.getParameter("size");

            // DUYỆT GIỎ HÀNG BẰNG variantId
            for (CartItem item : cart) {
                if (item.getVariantId() == variantId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    return;
                }
            }

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findById(productId);
            if (product != null) {
                // Tạo item mới với variantId
                CartItem item = new CartItem(
                        product.getId(),
                        variantId,
                        product.getName(),
                        product.getImage(),
                        product.getPrice(),
                        quantity,
                        color,
                        size
                );

                // Áp dụng Discount
                DiscountDAO discountDAO = new DiscountDAO();
                Discount discount = discountDAO.findActiveByProductId(productId);
                if (discount != null) {
                    item.setDiscountPercent(discount.getPercent());
                    item.setSalePrice(product.getPrice() - (product.getPrice() * discount.getPercent() / 100));
                }

                cart.add(item);
            }
        } catch (NumberFormatException ignored) {
        }
    }

    private void updateCart(HttpServletRequest request, List<CartItem> cart) {
        try {
            int variantId = Integer.parseInt(request.getParameter("variantId")); // DÙNG variantId
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            for (CartItem item : cart) {
                if (item.getVariantId() == variantId) {
                    item.setQuantity(Math.max(0, quantity));
                    break;
                }
            }
        } catch (NumberFormatException ignored) {
        }
    }

    private void removeFromCart(HttpServletRequest request, List<CartItem> cart) {
        try {
            int variantId = Integer.parseInt(request.getParameter("variantId")); // DÙNG variantId
            cart.removeIf(item -> item.getVariantId() == variantId);
        } catch (NumberFormatException ignored) {
        }
    }

    private void refreshDiscountPrices(List<CartItem> cart) {
        DiscountDAO discountDAO = new DiscountDAO();
        for (CartItem item : cart) {
            Discount discount = discountDAO.findActiveByProductId(item.getProductId());
            if (discount != null) {
                item.setDiscountPercent(discount.getPercent());
                item.setSalePrice(item.getPrice() - (item.getPrice() * discount.getPercent() / 100));
            } else {
                item.setDiscountPercent(0);
                item.setSalePrice(0);
            }
        }
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cartItems");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cartItems", cart);
        }
        return cart;
    }

    private long calculateTotal(List<CartItem> cart) {
        return cart.stream().mapToLong(CartItem::getSubtotal).sum();
    }

    private String formatTotal(List<CartItem> cart) {
        NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
        return nf.format(calculateTotal(cart)) + " ₫";
    }
}
