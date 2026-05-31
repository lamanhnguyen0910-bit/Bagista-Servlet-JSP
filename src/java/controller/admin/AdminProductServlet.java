/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Product;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 5 * 1024 * 1024, // 5 MB mỗi file
        maxRequestSize = 25 * 1024 * 1024 // 25 MB tổng
)
@WebServlet(name = "AdminProductServlet", urlPatterns = {"/adminproduct", "/adminaddproduct", "/admineditproduct", "/admindeleteproduct"})
public class AdminProductServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "assets/images/products";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();

        // LOGIC ĐIỀU HƯỚNG CHUẨN
        if ("/admineditproduct".equals(path)) {
            showEditForm(request, response);
        } else if ("/adminaddproduct".equals(path)) {
            showAddForm(request, response);
        } else {
            listProducts(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();
        switch (path) {
            case "/adminaddproduct":
                addProduct(request, response);
                break;
            case "/admineditproduct":
                editProduct(request, response);
                break;
            case "/admindeleteproduct":
                deleteProduct(request, response);
                break;
            default:
                response.sendRedirect("adminproduct");
                break;
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        String category = request.getParameter("category");

        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        List<Product> products;
        if ((search != null && !search.isEmpty()) || (category != null && !category.isEmpty())) {
            products = productDAO.searchAdmin(search, category);
        } else {
            products = productDAO.findAll();
        }

        if (products == null) {
            products = new ArrayList<>();
        } else {
            for (Product p : products) {
                String firstImg = productDAO.getFirstImage(p.getId());
                p.setImage(firstImg != null ? firstImg : "");
                p.setColors(productDAO.getColors(p.getId()));
                p.setSizes(productDAO.getSizes(p.getId()));
            }
        }

        request.setAttribute("products", products);
        request.setAttribute("categories", categoryDAO.findAll());
        request.setAttribute("searchKeyword", search != null ? search : "");
        request.setAttribute("filterCategory", category != null ? category : "");
        request.setAttribute("totalProducts", products.size());

        request.getRequestDispatcher("/views/admin/products.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect("adminproduct");
                return;
            }

            int id = Integer.parseInt(idStr);
            Product product = productDAO.findById(id);

            if (product != null) {
                // Nạp dữ liệu ảnh, màu, size hiện tại của sản phẩm
                product.setImages(productDAO.getImages(id));
                product.setColors(productDAO.getColors(id));
                product.setSizes(productDAO.getSizes(id));

                // Nạp danh sách tổng từ Database (Giả định trả về List<Category> và List<String>)
                List<model.Category> categories = categoryDAO.findAll();
                List<String> allColors = categoryDAO.findAllColors();
                List<String> allSizes = categoryDAO.findAllSizes();
                List<String> allMaterials = categoryDAO.findAllMaterials();

                request.setAttribute("product", product);
                request.setAttribute("categories", categories);
                request.setAttribute("colors", allColors);
                request.setAttribute("sizes", allSizes);
                request.setAttribute("materials", allMaterials);

                // Chuyển hướng sang trang JSP
                request.getRequestDispatcher("/views/admin/edit-product.jsp").forward(request, response);
            } else {
                response.sendRedirect("adminproduct");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminproduct");
        }
    }

    // Các hàm addProduct, editProduct, deleteProduct, uploadImages GIỮ NGUYÊN NHƯ CŨ CỦA LÂM
    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        Product product = new Product();
        product.setName(request.getParameter("name"));
        product.setPrice(Long.parseLong(request.getParameter("price")));
        product.setStock(Integer.parseInt(request.getParameter("stock")));
        product.setTag(request.getParameter("tag"));
        product.setDescription(request.getParameter("description"));
        String catName = request.getParameter("category");
        if (catName != null && !catName.isEmpty()) {
            product.setCategoryId(categoryDAO.findIdByName(catName));
        }
        String matName = request.getParameter("material");
        if (matName != null && !matName.isEmpty()) {
            product.setMaterialId(categoryDAO.findMaterialIdByName(matName));
        }
        int productId = productDAO.addProduct(product);
        if (productId > 0) {
            uploadImages(request, productDAO, productId);
            String colorsStr = request.getParameter("colors");
            String sizesStr = request.getParameter("sizes");
            if (colorsStr != null && sizesStr != null) {
                syncVariants(productId, colorsStr, sizesStr, categoryDAO, productDAO);
            }
        }
        response.sendRedirect("adminproduct");
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        int productId = Integer.parseInt(request.getParameter("productId"));
        Product product = productDAO.findById(productId);
        if (product == null) {
            response.sendRedirect("adminproduct");
            return;
        }
        product.setName(request.getParameter("name"));
        product.setPrice(Long.parseLong(request.getParameter("price")));
        product.setStock(Integer.parseInt(request.getParameter("stock")));
        product.setTag(request.getParameter("tag"));
        product.setDescription(request.getParameter("description"));
        String catName = request.getParameter("category");
        if (catName != null && !catName.isEmpty()) {
            product.setCategoryId(categoryDAO.findIdByName(catName));
        }
        String matName = request.getParameter("material");
        if (matName != null && !matName.isEmpty()) {
            product.setMaterialId(categoryDAO.findMaterialIdByName(matName));
        }
        productDAO.updateProduct(product);
        String deletedImages = request.getParameter("deletedImages");
        if (deletedImages != null && !deletedImages.isEmpty()) {
            for (String img : deletedImages.split(",")) {
                productDAO.deleteImage(productId, img.trim());
            }
        }
        uploadImages(request, productDAO, productId);
        String colorsStr = request.getParameter("colors");
        String sizesStr = request.getParameter("sizes");
        syncVariants(productId, colorsStr, sizesStr, categoryDAO, productDAO);
        response.sendRedirect("adminproduct");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("productId"));
        new ProductDAO().deleteProduct(id);
        response.sendRedirect("adminproduct");
    }

    private void syncVariants(int productId, String colorsStr, String sizesStr, CategoryDAO catDAO, ProductDAO proDAO) {
        if (colorsStr == null || sizesStr == null || colorsStr.isEmpty() || sizesStr.isEmpty()) {
            return;
        }
        String[] colors = colorsStr.split(",");
        String[] sizes = sizesStr.split(",");
        for (String cName : colors) {
            int cId = catDAO.findColorIdByName(cName.trim());
            for (String sName : sizes) {
                int sId = catDAO.findSizeIdByName(sName.trim());
                if (cId > 0 && sId > 0) {
                    if (proDAO.getStockByVariant(productId, cName.trim(), sName.trim()) <= -1) {
                        /* Insert Logic */ }
                }
            }
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryDAO categoryDAO = new CategoryDAO();
        request.setAttribute("categories", categoryDAO.findAll());
        request.setAttribute("colors", categoryDAO.findAllColors());
        request.setAttribute("sizes", categoryDAO.findAllSizes());
        request.setAttribute("materials", categoryDAO.findAllMaterials());
        request.getRequestDispatcher("/views/admin/add-product.jsp").forward(request, response);
    }

    private void uploadImages(HttpServletRequest request, ProductDAO productDAO, int productId) {
        try {
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            for (Part part : request.getParts()) {
                if (part.getName().startsWith("image") && part.getSize() > 0 && part.getContentType() != null && part.getContentType().startsWith("image/")) {
                    String fileName = System.currentTimeMillis() + "_" + getFileName(part);
                    part.write(uploadPath + File.separator + fileName);
                    productDAO.addImage(productId, fileName);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        for (String token : header.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown.jpg";
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        return user != null && "admin".equals(user.getRole());
    }
}
