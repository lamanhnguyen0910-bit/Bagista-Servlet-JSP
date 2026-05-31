/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Quản lý danh mục, màu sắc, kích thước, chất liệu (Admin).
 */
@WebServlet(name = "AdminCategoryServlet", urlPatterns = {"/admincategory", "/adminaddcategory", "/adminupdatecategory", "/admindeletecategory"})
public class AdminCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect("login");
            return;
        }

        CategoryDAO dao = new CategoryDAO();
        String tab = request.getParameter("tab");
        if (tab == null || tab.isEmpty()) {
            tab = "category";
        }

        request.setAttribute("activeTab", tab);
        request.setAttribute("categories", dao.findAll());
        request.setAttribute("colors", dao.findAllColors());
        request.setAttribute("sizes", dao.findAllSizes());
        request.setAttribute("materials", dao.findAllMaterials());

        request.getRequestDispatcher("/views/admin/categories.jsp").forward(request, response);
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
        String tab = request.getParameter("tab");
        if (tab == null) {
            tab = "category";
        }

        CategoryDAO dao = new CategoryDAO();

        switch (path) {
            case "/adminaddcategory":
                addItem(request, dao, tab);
                break;
            case "/adminupdatecategory":
                updateItem(request, dao, tab);
                break;
            case "/admindeletecategory":
                deleteItem(request, dao, tab);
                break;
        }

        response.sendRedirect("admincategory?tab=" + tab);
    }

    private void addItem(HttpServletRequest request, CategoryDAO dao, String tab) {
        String name = request.getParameter("name");
        String desc = request.getParameter("description");

        switch (tab) {
            case "color":
                dao.addColor(name);
                break;
            case "size":
                dao.addSize(name);
                break;
            case "material":
                dao.addMaterial(name);
                break;
            default:
                dao.add(name, desc);
                break;
        }
    }

    private void updateItem(HttpServletRequest request, CategoryDAO dao, String tab) {
        int id = Integer.parseInt(request.getParameter("editItemId"));
        String name = request.getParameter("editName");
        String desc = request.getParameter("editDesc");

        switch (tab) {
            case "color":
                dao.updateColor(id, name);
                break;
            case "size":
                dao.updateSize(id, name);
                break;
            case "material":
                dao.updateMaterial(id, name);
                break;
            default:
                dao.update(id, name, desc);
                break;
        }
    }

    private void deleteItem(HttpServletRequest request, CategoryDAO dao, String tab) {
        int id = Integer.parseInt(request.getParameter("itemId"));
        String deleteProducts = request.getParameter("deleteProducts");
        ProductDAO productDAO = new ProductDAO();

        // LOGIC MỚI: Xử lý theo cấu trúc ProductVariants
        if ("category".equals(tab)) {
            if ("true".equals(deleteProducts)) {
                productDAO.deleteByCategory(id);
            } else {
                productDAO.unlinkCategory(id);
            }
        } else if ("material".equals(tab)) {
            productDAO.unlinkMaterial(id);
        } else if ("color".equals(tab)) {
            // Cập nhật: Xóa các biến thể có màu này trước khi xóa màu gốc
            productDAO.deleteVariantsByColor(id);
        } else if ("size".equals(tab)) {
            // Cập nhật: Xóa các biến thể có size này trước khi xóa size gốc
            productDAO.deleteVariantsBySize(id);
        }

        // Xóa mục gốc trong CategoryDAO
        switch (tab) {
            case "color":
                dao.deleteColor(id);
                break;
            case "size":
                dao.deleteSize(id);
                break;
            case "material":
                dao.deleteMaterial(id);
                break;
            default:
                dao.delete(id);
                break;
        }
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
