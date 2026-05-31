<%-- 
    Document   : customers
    Created on : Mar 5, 2026, 9:09:11 PM
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
        <title>Khách hàng — BAGISTA Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
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
            .modal-overlay {
                display: none;
                position: fixed;
                inset: 0;
                z-index: 50;
                background: rgba(61,50,40,0.3);
                backdrop-filter: blur(4px);
                justify-content: center;
                align-items: center;
            }
            .modal-overlay.show {
                display: flex;
            }
        </style>
    </head>
    <body>
        <div class="min-h-screen flex">
            <aside class="hidden md:flex flex-col w-56 border-r border-border bg-card shrink-0 fixed inset-y-0 left-0 z-30">
                <div class="h-16 flex items-center px-6 border-b border-border">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="text-[18px] tracking-[0.2em] font-display text-foreground">BAGISTA</a>
                    <span class="ml-2 text-[9px] tracking-[0.15em] uppercase font-body text-accent bg-accent/10 px-2 py-0.5">Admin</span>
                </div>
                <nav class="flex-1 py-4">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/adminproduct" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Sản phẩm</a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Đơn hàng</a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Danh mục</a>
                    <a href="${pageContext.request.contextPath}/admincustomer" class="sidebar-link active flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Khách hàng</a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Đánh giá</a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Giảm giá</a>
                </nav>
                <div class="border-t border-border p-4">
                    <a href="${pageContext.request.contextPath}/adminprofile" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground px-2 py-2">Hồ sơ Admin</a>
                    <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground px-2 py-2">Về trang chủ</a>
                </div>
            </aside>

            <div class="flex-1 md:ml-56 flex flex-col min-w-0">
                <header class="md:hidden h-14 flex items-center justify-between px-4 border-b border-border bg-card">
                    <div class="flex items-center gap-2">
                        <span class="text-[16px] tracking-[0.15em] font-display text-foreground">BAGISTA</span>
                        <span class="text-[8px] tracking-[0.1em] uppercase font-body text-accent bg-accent/10 px-1.5 py-0.5">Admin</span>
                    </div>
                    <button onclick="toggleMobileSidebar()" class="text-foreground">
                        <svg id="menuIcon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
                        <svg id="closeIcon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="hidden"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                    </button>
                </header>

                <main class="flex-1 p-6 overflow-auto">
                    <div class="flex items-center justify-between mb-6">
                        <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground uppercase">Khách hàng</h1>
                        <button onclick="document.getElementById('addModal').classList.add('show')" class="flex items-center gap-2 bg-accent text-accent-foreground px-4 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-accent/90 transition-colors">
                            + Thêm khách hàng
                        </button>
                    </div>

                    <form action="${pageContext.request.contextPath}/admincustomer" method="GET" class="relative max-w-sm mb-6">
                        <svg class="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
                        <input type="text" name="search" value="${searchKeyword}" placeholder="Tìm khách hàng..."
                               class="w-full bg-transparent border border-border pl-9 pr-4 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                    </form>

                    <div class="border border-border overflow-x-auto">
                        <table class="w-full text-[12px] font-body">
                            <thead>
                                <tr class="border-b border-border bg-secondary/30 text-left text-muted-foreground">
                                    <th class="p-3">Họ tên</th>
                                    <th class="p-3">Username</th>
                                    <th class="p-3">Email</th>
                                    <th class="p-3">SĐT</th>
                                    <th class="p-3">Số đơn</th>
                                    <th class="p-3">Tổng chi tiêu</th>
                                    <th class="p-3 text-center">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${customers}">
                                    <tr class="border-b border-border/50 hover:bg-secondary/10 transition-colors">
                                        <td class="p-3 text-foreground font-medium">${c.fullName}</td>
                                        <td class="p-3 text-muted-foreground">${c.username}</td>
                                        <td class="p-3 text-muted-foreground">${c.email}</td>
                                        <td class="p-3 text-muted-foreground">${c.phone}</td>
                                        <td class="p-3 text-foreground">${c.totalOrders}</td>
                                        <td class="p-3 text-foreground font-medium">
                                            <fmt:formatNumber value="${c.totalSpent}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                        </td>
                                        <td class="p-3">
                                            <div class="flex items-center justify-center gap-2">
                                                <a href="${pageContext.request.contextPath}/admineditcustomer?id=${c.id}" class="text-muted-foreground hover:text-foreground transition-colors" title="Sửa">
                                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 00-2 2v14a2 2 0 002 2h14a2 2 0 002-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 013 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                                                </a>
                                                <form action="${pageContext.request.contextPath}/admindeletecustomer" method="POST" class="inline" onsubmit="return confirm('Xoá khách hàng này?')">
                                                    <input type="hidden" name="customerId" value="${c.id}" />
                                                    <button type="submit" class="text-muted-foreground hover:text-red-600 transition-colors" title="Xoá">
                                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6m3 0V4a2 2 0 012-2h4a2 2 0 012 2v2"/></svg>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty customers}">
                                    <tr>
                                        <td colspan="7" class="p-10 text-center text-muted-foreground font-body">Không tìm thấy khách hàng nào.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                    <p class="text-[11px] font-body text-muted-foreground mt-3">${totalCustomers} khách hàng</p>

                    <div id="addModal" class="modal-overlay" onclick="this.classList.remove('show')">
                        <div class="bg-background border border-border p-8 max-w-lg w-full mx-4" onclick="event.stopPropagation()">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="text-[16px] font-display tracking-[0.15em] text-foreground uppercase">Thêm khách hàng mới</h3>
                                <button onclick="document.getElementById('addModal').classList.remove('show')" class="text-muted-foreground hover:text-foreground">✕</button>
                            </div>
                            <form action="${pageContext.request.contextPath}/adminaddcustomer" method="POST">
                                <div class="grid grid-cols-2 gap-4 mb-6">
                                    <div>
                                        <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1">Username <span class="text-red-600">*</span></label>
                                        <input type="text" name="username" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                    </div>
                                    <div>
                                        <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1">Họ và tên</label>
                                        <input type="text" name="fullName" class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                    </div>
                                    <div>
                                        <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1">Email <span class="text-red-600">*</span></label>
                                        <input type="email" name="email" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                    </div>
                                    <div>
                                        <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1">SĐT</label>
                                        <input type="text" name="phone" class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                    </div>
                                </div>
                                <div class="flex gap-3">
                                    <button type="submit" class="bg-accent text-accent-foreground px-6 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-accent/90">Lưu khách hàng</button>
                                    <button type="button" onclick="document.getElementById('addModal').classList.remove('show')" class="border border-border text-foreground px-6 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-secondary/50">Huỷ</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script>
            function toggleMobileSidebar() {
                document.getElementById('mobileSidebar').classList.toggle('hidden');
                document.getElementById('menuIcon').classList.toggle('hidden');
                document.getElementById('closeIcon').classList.toggle('hidden');
            }
        </script>
    </body>
</html>