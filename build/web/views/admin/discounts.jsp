<%-- 
    Document   : discount
    Created on : Mar 9, 2026, 3:17:14 PM
    Author     : laman
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Giảm giá — BAGISTA Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
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
            * { box-sizing: border-box; }
            body { font-family: 'Inter', sans-serif; background: #FAF7F2; color: #3D3228; margin: 0; }
            .sidebar-link.active { background: rgba(237,232,223,0.5); border-right: 2px solid #7A5C3E; color: #3D3228; }
            .status-active { color: #16A34A; background: #DCFCE7; }
            .status-upcoming { color: #2563EB; background: #DBEAFE; }
            .status-expired { color: #8B7E6A; background: #EDE8DF; }
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
                    <a href="${pageContext.request.contextPath}/admindashboard" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/adminproduct" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">Sản phẩm</a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">Đơn hàng</a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">Danh mục</a>
                    <a href="${pageContext.request.contextPath}/admincustomer" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">Khách hàng</a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">Đánh giá</a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="sidebar-link active flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">Giảm giá</a>
                </nav>
                <div class="border-t border-border p-4">
                    <a href="${pageContext.request.contextPath}/adminprofile" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground px-2 py-2 transition-colors">Hồ sơ Admin</a>
                    <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground px-2 py-2 transition-colors">Về trang chủ</a>
                </div>
            </aside>

            <div class="flex-1 md:ml-56 flex flex-col min-w-0">
                <header class="md:hidden h-14 flex items-center justify-between px-4 border-b border-border bg-card">
                    <div class="flex items-center gap-2">
                        <span class="text-[16px] tracking-[0.15em] font-display text-foreground uppercase">BAGISTA</span>
                    </div>
                    <button onclick="toggleMobileSidebar()" class="text-foreground">
                        <svg id="menuIcon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
                    </button>
                </header>

                <main class="flex-1 p-6 overflow-auto">
                    <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground mb-6 uppercase">Quản lý giảm giá</h1>

                    <div class="border border-border p-6 mb-6 bg-white/50 shadow-sm">
                        <c:choose>
                            <c:when test="${not empty editDiscount}">
                                <h2 class="text-[12px] tracking-[0.15em] uppercase font-body text-accent mb-4 font-bold">CẬP NHẬT GIẢM GIÁ</h2>
                                <form action="${pageContext.request.contextPath}/admineditdiscount" method="POST">
                                    <input type="hidden" name="discountId" value="${editDiscount.id}" />
                                    <div class="grid md:grid-cols-2 gap-4 mb-4">
                                        <div>
                                            <label class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground block mb-1">Sản phẩm *</label>
                                            <select name="productId" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body focus:outline-none focus:border-accent">
                                                <c:forEach var="p" items="${products}">
                                                    <option value="${p.id}" ${p.id == editDiscount.productId ? 'selected' : ''}>${p.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div>
                                            <label class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground block mb-1">Phần trăm giảm (%) *</label>
                                            <input type="number" name="percent" min="1" max="99" value="${editDiscount.percent}" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body focus:outline-none focus:border-accent" />
                                        </div>
                                        <div>
                                            <label class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground block mb-1">Ngày bắt đầu *</label>
                                            <fmt:formatDate value="${editDiscount.startDate}" pattern="yyyy-MM-dd" var="fmtStart"/>
                                            <input type="date" name="startDate" value="${fmtStart}" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body focus:outline-none focus:border-accent" />
                                        </div>
                                        <div>
                                            <label class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground block mb-1">Ngày kết thúc *</label>
                                            <fmt:formatDate value="${editDiscount.endDate}" pattern="yyyy-MM-dd" var="fmtEnd"/>
                                            <input type="date" name="endDate" value="${fmtEnd}" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body focus:outline-none focus:border-accent" />
                                        </div>
                                    </div>
                                    <div class="flex gap-3">
                                        <button type="submit" class="bg-accent text-accent-foreground px-6 py-2 text-[11px] tracking-[0.15em] uppercase font-body hover:opacity-90 transition-opacity">Lưu thay đổi</button>
                                        <a href="${pageContext.request.contextPath}/admindiscount" class="border border-border px-6 py-2 text-[11px] tracking-[0.15em] uppercase font-body text-muted-foreground hover:text-foreground">Huỷ</a>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <h2 class="text-[12px] tracking-[0.15em] uppercase font-body text-foreground mb-4 font-bold">THÊM GIẢM GIÁ MỚI</h2>
                                <form action="${pageContext.request.contextPath}/adminadddiscount" method="POST">
                                    <div class="grid md:grid-cols-2 gap-4 mb-4">
                                        <div>
                                            <label class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground block mb-1">Sản phẩm *</label>
                                            <select name="productId" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent">
                                                <option value="">-- Chọn sản phẩm --</option>
                                                <c:forEach var="p" items="${products}">
                                                    <option value="${p.id}">${p.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div>
                                            <label class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground block mb-1">Phần trăm giảm (%) *</label>
                                            <input type="number" name="percent" min="1" max="99" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                        </div>
                                        <div>
                                            <label class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground block mb-1">Ngày bắt đầu *</label>
                                            <input type="date" name="startDate" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                        </div>
                                        <div>
                                            <label class="text-[10px] tracking-[0.15em] uppercase font-body text-muted-foreground block mb-1">Ngày kết thúc *</label>
                                            <input type="date" name="endDate" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                        </div>
                                    </div>
                                    <button type="submit" class="bg-accent text-accent-foreground px-6 py-2 text-[11px] tracking-[0.15em] uppercase font-body hover:opacity-90 transition-opacity">Thêm giảm giá</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="border border-border overflow-x-auto bg-white">
                        <table class="w-full text-[12px] font-body">
                            <thead>
                                <tr class="border-b border-border bg-secondary/30 text-left text-muted-foreground">
                                    <th class="p-3 uppercase tracking-wider">Sản phẩm</th>
                                    <th class="p-3 uppercase tracking-wider">Giảm</th>
                                    <th class="p-3 uppercase tracking-wider">Giá gốc</th>
                                    <th class="p-3 uppercase tracking-wider">Giá sale</th>
                                    <th class="p-3 uppercase tracking-wider">Thời gian</th>
                                    <th class="p-3 uppercase tracking-wider">Trạng thái</th>
                                    <th class="p-3 text-center uppercase tracking-wider">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty discounts}">
                                    <tr><td colspan="7" class="p-8 text-center text-muted-foreground italic">Chưa có chương trình giảm giá nào</td></tr>
                                </c:if>

                                <c:forEach var="d" items="${discounts}">
                                    <tr class="border-b border-border/50 hover:bg-secondary/10 transition-colors">
                                        <td class="p-3 text-foreground font-medium max-w-[200px] truncate">${d.productName}</td>
                                        <td class="p-3 text-accent font-bold">-${d.percent}%</td>
                                        <td class="p-3 text-muted-foreground line-through">
                                            <fmt:formatNumber value="${d.productPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </td>
                                        <td class="p-3 text-foreground font-bold">
                                            <fmt:formatNumber value="${d.productPrice * (100 - d.percent) / 100}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </td>
                                        <td class="p-3 text-muted-foreground text-[11px]">
                                            <fmt:formatDate value="${d.startDate}" pattern="dd/MM/yyyy"/> - <br/>
                                            <fmt:formatDate value="${d.endDate}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td class="p-3">
                                            <jsp:useBean id="today" class="java.util.Date" />
                                            <c:choose>
                                                <c:when test="${today > d.endDate}">
                                                    <span class="text-[9px] px-2 py-0.5 rounded uppercase font-bold status-expired">Hết hạn</span>
                                                </c:when>
                                                <c:when test="${today < d.startDate}">
                                                    <span class="text-[9px] px-2 py-0.5 rounded uppercase font-bold status-upcoming">Sắp tới</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-[9px] px-2 py-0.5 rounded uppercase font-bold status-active">Đang chạy</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="p-3 text-center">
                                            <div class="flex items-center justify-center gap-4">
                                                <a href="${pageContext.request.contextPath}/admineditdiscount?id=${d.id}" class="text-muted-foreground hover:text-accent font-bold uppercase text-[10px]">Sửa</a>
                                                <form action="${pageContext.request.contextPath}/admindeletediscount" method="POST" onsubmit="return confirm('Bạn chắc chắn muốn xoá?');" class="inline">
                                                    <input type="hidden" name="discountId" value="${d.id}" />
                                                    <button type="submit" class="text-muted-foreground hover:text-destructive font-bold uppercase text-[10px]">Xoá</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </main>
            </div>
        </div>
    </body>
</html>