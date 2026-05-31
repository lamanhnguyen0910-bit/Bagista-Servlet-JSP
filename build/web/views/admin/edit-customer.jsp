<%-- 
    Document   : edit-customer
    Created on : Mar 9, 2026, 4:01:15 PM
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
        <title>Sửa khách hàng — BAGISTA Admin</title>
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
                    <a href="${pageContext.request.contextPath}/admincustomer" class="sidebar-link active flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="users" class="w-4 h-4"></i> Khách hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="star" class="w-4 h-4"></i> Đánh giá
                    </a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="percent" class="w-4 h-4"></i> Giảm giá
                    </a>
                </nav>
            </aside>

            <div class="flex-1 md:ml-56 flex flex-col min-w-0">
                <main class="flex-1 p-6 overflow-auto">
                    <div class="flex items-center gap-2 text-[11px] font-body text-muted-foreground mb-6">
                        <a href="${pageContext.request.contextPath}/admincustomer" class="hover:text-foreground transition-colors uppercase">Khách hàng</a>
                        <i data-lucide="chevron-right" class="w-3 h-3"></i>
                        <span class="text-foreground uppercase">Sửa khách hàng</span>
                    </div>

                    <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground mb-6 uppercase font-bold">Sửa khách hàng</h1>

                    <c:if test="${param.error == 'duplicate'}">
                        <div class="mb-6 p-4 bg-red-50 border border-red-200 text-red-600 text-[12px] font-body">
                            Lỗi: ${param.msg == 'email' ? 'Email này đã được sử dụng bởi người dùng khác.' : 'Số điện thoại này đã được sử dụng bởi người dùng khác.'}
                        </div>
                    </c:if>

                    <div class="border border-border p-8 max-w-2xl bg-white/40 shadow-sm">
                        <form action="${pageContext.request.contextPath}/admineditcustomer" method="POST">
                            <input type="hidden" name="id" value="${customer.id}" />

                            <div class="grid grid-cols-2 gap-6 mb-6">
                                <div class="col-span-1">
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1 font-bold">Username</label>
                                    <input type="text" value="${customer.username}" disabled
                                           class="w-full bg-secondary/30 border border-border px-3 py-2 text-[13px] font-body text-muted-foreground cursor-not-allowed" />
                                </div>
                                <div class="col-span-1">
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1 font-bold">Họ và tên <span class="text-red-600">*</span></label>
                                    <input type="text" name="fullName" value="${customer.fullName}" required
                                           class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                </div>
                                <div>
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1 font-bold">Email <span class="text-red-600">*</span></label>
                                    <input type="email" name="email" value="${customer.email}" required
                                           class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                </div>
                                <div>
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1 font-bold">Số điện thoại</label>
                                    <input type="text" name="phone" value="${customer.phone}"
                                           class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                </div>
                                <div>
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1 font-bold">Ngày sinh</label>
                                    <input type="date" name="birthday" 
                                           value="<fmt:formatDate value='${customer.birthday}' pattern='yyyy-MM-dd'/>"
                                           class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                </div>
                                <div>
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1 font-bold">Địa chỉ</label>
                                    <input type="text" name="address" value="${customer.address}"
                                           class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                </div>
                            </div>

                            <div class="border-t border-border pt-4 mb-6">
                                <div class="grid grid-cols-3 gap-4 text-[12px] font-body">
                                    <div>
                                        <span class="text-muted-foreground block text-[10px] tracking-[0.15em] uppercase mb-1">Ngày tham gia</span>
                                        <span class="text-foreground"><fmt:formatDate value="${customer.joinDate}" pattern="dd/MM/yyyy"/></span>
                                    </div>
                                    <div>
                                        <span class="text-muted-foreground block text-[10px] tracking-[0.15em] uppercase mb-1">Trạng thái</span>
                                        <c:choose>
                                            <c:when test="${customer.active}">
                                                <span class="text-green-700 font-bold">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-red-600 font-bold">Bị khoá</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div>
                                        <span class="text-muted-foreground block text-[10px] tracking-[0.15em] uppercase mb-1">Vai trò</span>
                                        <span class="text-foreground capitalize font-bold">${customer.role}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="flex gap-3">
                                <button type="submit" class="bg-accent text-accent-foreground px-10 py-3 text-[11px] tracking-[0.15em] uppercase font-body hover:bg-accent/90 transition-colors shadow-sm">Lưu thay đổi</button>
                                <a href="${pageContext.request.contextPath}/admincustomer" class="border border-border text-foreground px-10 py-3 text-[11px] tracking-[0.15em] uppercase font-body hover:bg-secondary/50 transition-colors inline-flex items-center justify-center">Quay lại</a>
                            </div>
                        </form>
                    </div>
                </main>
            </div>
        </div>

        <script>
            lucide.createIcons();
            function toggleMobileSidebar() {
                var sidebar = document.getElementById('mobileSidebar');
                sidebar.classList.toggle('hidden');
            }
        </script>
    </body>
</html>