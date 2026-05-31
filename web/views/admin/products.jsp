<%-- 
    Document   : products
    Created on : Mar 5, 2026, 9:08:04 PM
    Author     : laman
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Sản phẩm — BAGISTA Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Inter:wght@300;400;500&display=swap" rel="stylesheet" />
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {display: ['"Cormorant Garamond"', 'serif'], body: ['Inter', 'sans-serif']},
                        colors: {
                            border: '#C4B9A8', background: '#FAF7F2', foreground: '#3D3228',
                            card: '#FAF7F2', muted: '#EDE8DF', 'muted-foreground': '#8B7E6A',
                            accent: '#7A5C3E', 'accent-foreground': '#FAF7F2',
                            secondary: '#EDE8DF', destructive: '#B91C1C',
                        }
                    }
                }
            }
        </script>
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                font-family: 'Inter', sans-serif;
                background: #FAF7F2;
                color: #3D3228;
                margin: 0;
            }
            .sidebar-link.active {
                background: rgba(237,232,223,0.5);
                border-right: 2px solid #7A5C3E;
                color: #3D3228;
            }
        </style>
    </head>
    <body>
        <div class="min-h-screen flex">
            <aside class="hidden md:flex flex-col w-56 border-r border-border bg-card shrink-0 fixed inset-y-0 left-0 z-30">
                <div class="h-16 flex items-center px-6 border-b border-border">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="text-[18px] tracking-[0.2em] font-display text-foreground uppercase">BAGISTA</a>
                    <span class="ml-2 text-[9px] tracking-[0.15em] uppercase font-body text-accent bg-accent/10 px-2 py-0.5">Admin</span>
                </div>
                <nav class="flex-1 py-4">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="layout-dashboard" class="w-4 h-4"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/adminproduct" class="sidebar-link active flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="package" class="w-4 h-4"></i> Sản phẩm
                    </a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="shopping-cart" class="w-4 h-4"></i> Đơn hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="tag" class="w-4 h-4"></i> Danh mục
                    </a>
                    <a href="${pageContext.request.contextPath}/admincustomer" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="users" class="w-4 h-4"></i> Khách hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="star" class="w-4 h-4"></i> Đánh giá
                    </a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="percent" class="w-4 h-4"></i> Giảm giá
                    </a>
                </nav>
                <div class="border-t border-border p-4">
                    <a href="${pageContext.request.contextPath}/adminprofile" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground px-2 py-2">Hồ sơ Admin</a>
                    <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground px-2 py-2">Về trang chủ</a>
                </div>
            </aside>

            <div class="flex-1 md:ml-56 flex flex-col min-w-0">
                <header class="md:hidden h-14 flex items-center justify-between px-4 border-b border-border bg-card">
                    <span class="text-[16px] tracking-[0.15em] font-display text-foreground uppercase">BAGISTA</span>
                    <button onclick="toggleMobileSidebar()" class="text-foreground">
                        <i id="menuIcon" data-lucide="menu" class="w-5 h-5"></i>
                    </button>
                </header>

                <main class="flex-1 p-6 overflow-auto">
                    <div class="flex items-center justify-between mb-6">
                        <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground uppercase font-bold">Sản phẩm</h1>
                        <a href="${pageContext.request.contextPath}/adminaddproduct" class="flex items-center gap-2 bg-accent text-accent-foreground px-4 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-accent/90 transition-colors">
                            <i data-lucide="plus" class="w-3.5 h-3.5"></i> Thêm sản phẩm
                        </a>
                    </div>

                    <form action="${pageContext.request.contextPath}/adminproduct" method="GET" class="flex flex-col sm:flex-row gap-3 mb-6">
                        <div class="relative flex-1">
                            <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground w-4 h-4"></i>
                            <input type="text" name="search" value="${searchKeyword}" placeholder="Tìm sản phẩm..."
                                   class="w-full bg-transparent border border-border pl-9 pr-4 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                        </div>
                        <select name="category" onchange="this.form.submit()"
                                class="bg-transparent border border-border px-3 py-2 text-[12px] font-body text-foreground focus:outline-none focus:border-accent capitalize">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.name}" ${filterCategory == cat.name ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                        <button type="submit" class="bg-accent text-accent-foreground px-6 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-accent/90">Lọc</button>
                    </form>

                    <div class="border border-border overflow-x-auto bg-white/40 shadow-sm">
                        <table class="w-full text-[12px] font-body">
                            <thead>
                                <tr class="border-b border-border bg-secondary/30 text-left text-muted-foreground uppercase tracking-widest">
                                    <th class="p-3 w-16 text-center">Ảnh</th>
                                    <th class="p-3">Tên sản phẩm</th>
                                    <th class="p-3">Danh mục</th>
                                    <th class="p-3">Màu sắc</th>
                                    <th class="p-3">Size</th>
                                    <th class="p-3">Giá</th>
                                    <th class="p-3 text-center">Tồn</th>
                                    <th class="p-3 text-center">Đã bán</th>
                                    <th class="p-3 text-center">Đánh giá</th>
                                    <th class="p-3 text-center">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty products}">
                                        <tr><td colspan="10" class="p-10 text-center text-muted-foreground italic font-body">Không tìm thấy sản phẩm nào.</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="p" items="${products}">
                                            <tr class="border-b border-border/50 hover:bg-secondary/10 transition-colors">
                                                <td class="p-3">
                                                    <div class="w-10 h-12 bg-secondary/50 overflow-hidden border border-border/50 mx-auto">
                                                        <c:choose>
                                                            <%-- Ảnh link web --%>
                                                            <c:when test="${not empty p.image and p.image.contains('http')}">
                                                                <img src="${p.image}" class="w-full h-full object-cover" onerror="this.src='https://placehold.co/400x500?text=BAG'">
                                                            </c:when>
                                                            <%-- Ảnh upload local --%>
                                                            <c:when test="${not empty p.image}">
                                                                <img src="${pageContext.request.contextPath}/assets/images/products/${p.image}" class="w-full h-full object-cover" onerror="this.src='https://placehold.co/400x500?text=BAG'">
                                                            </c:when>
                                                            <%-- Mặc định --%>
                                                            <c:otherwise>
                                                                <img src="https://placehold.co/400x500?text=BAG" class="w-full h-full object-cover">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                                <td class="p-3 text-foreground font-medium max-w-[150px] truncate uppercase">${p.name}</td>
                                                <td class="p-3 text-muted-foreground capitalize">${p.categoryName != null ? p.categoryName : p.tag}</td>
                                                <td class="p-3 text-muted-foreground text-[10px] capitalize">${p.getColorsFormatted()}</td>
                                                <td class="p-3 text-muted-foreground text-[10px] uppercase">${p.getSizesFormatted()}</td>
                                                <td class="p-3 text-foreground font-semibold">
                                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </td>
                                                <td class="p-3 text-center text-foreground">${p.stock}</td>
                                                <td class="p-3 text-center text-foreground">${p.sold}</td>
                                                <td class="p-3 text-center text-foreground whitespace-nowrap">⭐ ${p.rating}</td>
                                                <td class="p-3">
                                                    <div class="flex items-center justify-center gap-3">
                                                        <a href="${pageContext.request.contextPath}/admineditproduct?id=${p.id}" class="text-muted-foreground hover:text-accent transition-colors" title="Sửa">
                                                            <i data-lucide="edit-3" class="w-4 h-4"></i>
                                                        </a>
                                                        <form action="${pageContext.request.contextPath}/admindeleteproduct" method="POST" class="inline" onsubmit="return confirm('Xoá vĩnh viễn sản phẩm này?')">
                                                            <input type="hidden" name="productId" value="${p.id}" />
                                                            <button type="submit" class="text-muted-foreground hover:text-red-600 transition-colors">
                                                                <i data-lucide="trash-2" class="w-4 h-4"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                    <p class="text-[11px] font-body text-muted-foreground mt-4">Tổng cộng: <strong>${totalProducts}</strong> sản phẩm</p>
                </main>
            </div>
        </div>

        <script>
            // Khởi tạo icon Lucide
            lucide.createIcons();

            function toggleMobileSidebar() {
                var sidebar = document.getElementById('mobileSidebar');
                sidebar.classList.toggle('hidden');
            }
        </script>
    </body>
</html>