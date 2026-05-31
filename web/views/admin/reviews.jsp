<%-- 
    Document   : reviews
    Created on : Mar 15, 2026, 11:16:28 PM
    Author     : laman
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đánh giá — BAGISTA Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Inter:wght@300;400;500&display=swap" rel="stylesheet" />
        <script>
            tailwind.config = {
                theme: {extend: {
                        fontFamily: {display: ['"Cormorant Garamond"', 'serif'], body: ['Inter', 'sans-serif']},
                        colors: {
                            border: '#C4B9A8', background: '#FAF7F2', foreground: '#3D3228',
                            card: '#FAF7F2', muted: '#EDE8DF', 'muted-foreground': '#8B7E6A',
                            accent: '#7A5C3E', 'accent-foreground': '#FAF7F2',
                            secondary: '#EDE8DF', destructive: '#B91C1C',
                        }
                    }}
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
            .line-clamp-2 {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
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
                    <a href="${pageContext.request.contextPath}/admindashboard" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="layout-dashboard" class="w-4 h-4"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/adminproduct" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="package" class="w-4 h-4"></i> Sản phẩm
                    </a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="shopping-cart" class="w-4 h-4"></i> Đơn hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="tag" class="w-4 h-4"></i> Danh mục
                    </a>
                    <a href="${pageContext.request.contextPath}/admincustomer" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="users" class="w-4 h-4"></i> Khách hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="sidebar-link active flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="star" class="w-4 h-4"></i> Đánh giá
                    </a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
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
                    <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground mb-6 uppercase font-bold">Đánh giá khách hàng</h1>

                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                        <div class="border border-border p-4 bg-white/40">
                            <p class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground mb-1">Tổng đánh giá</p>
                            <p class="text-[20px] font-display text-foreground">${totalReviews}</p>
                        </div>
                        <div class="border border-border p-4 bg-white/40">
                            <p class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground mb-1">Đánh giá TB</p>
                            <p class="text-[20px] font-display text-foreground">⭐ ${avgRating}</p>
                        </div>
                        <div class="border border-border p-4 bg-white/40">
                            <p class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground mb-1">5 sao tuyệt đối</p>
                            <p class="text-[20px] font-display text-green-700">${star5Count}</p>
                        </div>
                        <div class="border border-border p-4 bg-white/40">
                            <p class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground mb-1">1-2 sao (Cần chú ý)</p>
                            <p class="text-[20px] font-display text-destructive">${star12Count}</p>
                        </div>
                    </div>

                    <div class="border border-border overflow-x-auto bg-white/40">
                        <table class="w-full text-[12px] font-body">
                            <thead>
                                <tr class="border-b border-border bg-secondary/30 text-left text-muted-foreground uppercase tracking-widest">
                                    <th class="p-3">Sản phẩm</th>
                                    <th class="p-3">Khách hàng</th>
                                    <th class="p-3">Mức độ</th>
                                    <th class="p-3">Nội dung</th>
                                    <th class="p-3">Ngày gửi</th>
                                    <th class="p-3 text-center">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty reviews}">
                                        <tr><td colspan="6" class="p-10 text-center text-muted-foreground italic">Chưa có đánh giá nào từ khách hàng.</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="r" items="${reviews}">
                                            <tr class="border-b border-border/50 hover:bg-secondary/10 transition-colors">
                                                <td class="p-3 text-foreground font-medium max-w-[180px] truncate uppercase">${r.productName}</td>
                                                <td class="p-3 text-muted-foreground font-medium">${r.username}</td>
                                                <td class="p-3">
                                                    <span class="text-accent font-semibold">⭐ ${r.rating}</span>
                                                </td>
                                                <td class="p-3 text-foreground max-w-[280px]">
                                                    <p class="line-clamp-2 italic" title="${r.comment}">"${r.comment}"</p>
                                                </td>
                                                <td class="p-3 text-muted-foreground whitespace-nowrap">
                                                    <%-- Thay đổi r.date thành r.createdAt để khớp với ReviewDAO --%>
                                                    <fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td class="p-3 text-center">
                                                    <form action="${pageContext.request.contextPath}/admindeletereview" method="POST" onsubmit="return confirm('Bạn chắc chắn muốn xoá đánh giá này?');">
                                                        <input type="hidden" name="reviewId" value="${r.id}" />
                                                        <input type="hidden" name="productId" value="${r.productId}" />
                                                        <button type="submit" class="text-muted-foreground hover:text-destructive transition-colors">
                                                            <i data-lucide="trash-2" class="w-4 h-4"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-4 flex justify-between items-center text-[11px] text-muted-foreground font-body">
                        <span>Hiển thị tất cả các đánh giá gần nhất</span>
                        <span>Tổng cộng: <strong>${totalReviews}</strong> mục</span>
                    </div>
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