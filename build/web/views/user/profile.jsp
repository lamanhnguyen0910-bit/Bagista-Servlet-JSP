<%-- 
    Document   : profile
    Created on : Mar 5, 2026, 9:06:10 PM
    Author     : laman
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Tài khoản</title>
        <style>
            body{
                background:#FAF6F1;
                color:#3D2E22;
                font-family:'Inter',sans-serif
            }
            h1,h2,h3{
                font-family:'Playfair Display',serif
            }
            .tab-content{
                display:none
            }
            .tab-content.active{
                display:block
            }
            .input-line{
                width:100%;
                background:transparent;
                border:none;
                border-bottom:1px solid #E8DFD4;
                padding:8px 0;
                font-size:14px;
                outline:none;
                transition: border-color 0.3s;
            }
            .input-line:focus{
                border-bottom-color:#6B4C3B
            }
            .tab-btn-active {
                background-color: rgba(240, 233, 224, 0.5);
                color: #3D2E22;
                border-right: 2px solid #6B4C3B;
            }
        </style>
    </head>
    <body class="min-h-screen">

        <c:set var="activePage" value="profile" scope="request" />
        <%@ include file="/views/includes/header.jsp" %>

        <div class="max-w-7xl mx-auto px-6 py-12">

            <%-- HIỂN THỊ THÔNG BÁO --%>
            <div class="max-w-5xl mx-auto mb-6">
                <c:if test="${not empty errorMessage}">
                    <div class="p-4 bg-red-50 border border-red-200 text-red-600 text-[12px] font-bold uppercase tracking-widest">
                        ! ${errorMessage}
                    </div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="p-4 bg-green-50 border border-green-200 text-green-700 text-[12px] font-bold uppercase tracking-widest">
                        ✓ ${successMessage}
                    </div>
                </c:if>
            </div>

            <div class="max-w-5xl mx-auto flex flex-col md:flex-row gap-8">
                <aside class="md:w-64 shrink-0">
                    <div class="border border-brand-border bg-white p-5 mb-4 shadow-sm">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-full bg-brand-secondary flex items-center justify-center border border-brand-border">
                                <%-- ĐÃ SỬA: Chống lỗi substring khi fullName bị NULL --%>
                                <span class="text-[14px] font-bold text-brand-accent uppercase">
                                    <c:out value="${not empty user.fullName ? user.fullName.substring(0,1) : user.username.substring(0,1)}" />
                                </span>
                            </div>
                            <div class="overflow-hidden">
                                <%-- ĐÃ SỬA: Hiển thị username nếu fullName trống --%>
                                <p class="text-[13px] font-bold text-brand-text truncate uppercase">
                                    <c:out value="${not empty user.fullName ? user.fullName : user.username}" />
                                </p>
                                <p class="text-[11px] font-medium text-brand-muted truncate">
                                    <c:out value="${not empty user.email ? user.email : 'Chưa cập nhật email'}" />
                                </p>
                            </div>
                        </div>
                    </div>

                    <nav class="border border-brand-border bg-white shadow-sm">
                        <button onclick="switchTab('info')" class="tab-btn w-full flex items-center gap-3 px-5 py-3.5 text-[11px] font-bold uppercase tracking-widest transition-all ${empty param.tab || param.tab == 'info' ? 'tab-btn-active' : 'text-brand-muted hover:bg-brand-bg'}" data-tab="info">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                            Thông tin
                        </button>
                        <button onclick="switchTab('orders')" class="tab-btn w-full flex items-center gap-3 px-5 py-3.5 text-[11px] font-bold uppercase tracking-widest transition-all ${param.tab == 'orders' ? 'tab-btn-active' : 'text-brand-muted hover:bg-brand-bg'}" data-tab="orders">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/></svg>
                            Đơn hàng
                        </button>
                        <button onclick="switchTab('password')" class="tab-btn w-full flex items-center gap-3 px-5 py-3.5 text-[11px] font-bold uppercase tracking-widest transition-all ${param.tab == 'password' ? 'tab-btn-active' : 'text-brand-muted hover:bg-brand-bg'}" data-tab="password">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>
                            Mật khẩu
                        </button>
                        <a href="${pageContext.request.contextPath}/logout" class="w-full flex items-center gap-3 px-5 py-3.5 text-[11px] font-bold uppercase tracking-widest text-brand-destructive hover:bg-red-50 border-t border-brand-border">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                            Đăng xuất
                        </a>
                    </nav>
                </aside>

                <main class="flex-1">
                    <div id="tab-info" class="tab-content ${empty param.tab || param.tab == 'info' ? 'active' : ''}">
                        <form action="${pageContext.request.contextPath}/profile" method="POST" class="bg-white border border-brand-border p-8 shadow-sm">
                            <input type="hidden" name="action" value="updateInfo" />
                            <div class="flex items-center justify-between mb-8 border-b border-brand-border pb-4">
                                <h2 class="text-[14px] tracking-[0.2em] uppercase font-bold text-brand-text font-display">Thông tin cá nhân</h2>
                                <button type="submit" class="text-[10px] tracking-[0.1em] uppercase font-bold text-brand-accent hover:underline">Lưu</button>
                            </div>
                            <div class="space-y-6">
                                <div class="grid md:grid-cols-2 gap-6">
                                    <div><label class="text-[10px] tracking-[0.15em] uppercase text-brand-muted font-bold block mb-1">Họ và tên</label>
                                        <input type="text" name="fullName" value="<c:out value='${user.fullName}'/>" class="input-line" placeholder="Chưa cập nhật" /></div>
                                    <div><label class="text-[10px] tracking-[0.15em] uppercase text-brand-muted font-bold block mb-1">Username (Cố định)</label>
                                        <input type="text" name="username" value="${user.username}" class="input-line opacity-50" readonly /></div>
                                </div>
                                <div class="grid md:grid-cols-2 gap-6">
                                    <div><label class="text-[10px] tracking-[0.15em] uppercase text-brand-muted font-bold block mb-1">Ngày sinh</label>
                                        <input type="date" name="birthday" value="<fmt:formatDate value='${user.birthday}' pattern='yyyy-MM-dd'/>" class="input-line" /></div>
                                    <div><label class="text-[10px] tracking-[0.15em] uppercase text-brand-muted font-bold block mb-1">Email</label>
                                        <input type="email" name="email" value="<c:out value='${user.email}'/>" class="input-line" /></div>
                                </div>
                                <div class="grid md:grid-cols-2 gap-6">
                                    <div><label class="text-[10px] tracking-[0.15em] uppercase text-brand-muted font-bold block mb-1">Số điện thoại</label>
                                        <input type="tel" name="phone" value="<c:out value='${user.phone}'/>" class="input-line" /></div>
                                    <div><label class="text-[10px] tracking-[0.15em] uppercase text-brand-muted font-bold block mb-1">Địa chỉ</label>
                                        <input type="text" name="address" value="<c:out value='${user.address}'/>" class="input-line" /></div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div id="tab-orders" class="tab-content ${param.tab == 'orders' ? 'active' : ''}">
                        <div class="bg-white border border-brand-border p-8 shadow-sm">
                            <h2 class="text-[14px] tracking-[0.2em] uppercase font-bold text-brand-text font-display mb-6">Lịch sử đơn hàng</h2>
                            <div class="space-y-4">
                                <c:choose>
                                    <c:when test="${not empty orders}">
                                        <c:forEach var="order" items="${orders}">
                                            <a href="${pageContext.request.contextPath}/order-detail?id=${order.id}" class="block w-full border border-brand-border p-5 flex items-center justify-between hover:bg-brand-secondary/20 transition-colors group">
                                                <div>
                                                    <p class="text-[13px] font-bold text-brand-text mb-1 uppercase tracking-tighter">Mã đơn: #${order.id}</p>
                                                    <p class="text-[11px] font-medium text-brand-muted">
                                                        <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy"/> · ${order.totalFormatted}
                                                    </p>
                                                </div>
                                                <div class="flex items-center gap-3">
                                                    <span class="text-[9px] font-bold px-2 py-0.5 uppercase tracking-widest
                                                          ${order.status == 'Đã giao' ? 'text-green-700 bg-green-100' : ''}
                                                          ${order.status == 'Đang giao' ? 'text-amber-700 bg-amber-100' : ''}
                                                          ${order.status == 'Chờ xử lý' ? 'text-blue-700 bg-blue-100' : ''}
                                                          ${order.status == 'Đã huỷ' ? 'text-red-700 bg-red-100' : ''}
                                                          ">${order.status}</span>
                                                    <svg class="w-4 h-4 text-brand-muted group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><polyline points="9 18 15 12 9 6"/></svg>
                                                </div>
                                            </a>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-[12px] text-brand-muted text-center py-10">Bạn chưa có đơn hàng nào.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <div id="tab-password" class="tab-content ${param.tab == 'password' ? 'active' : ''}">
                        <form action="${pageContext.request.contextPath}/change-password" method="POST" class="bg-white border border-brand-border p-8 shadow-sm max-w-sm">
                            <h2 class="text-[14px] tracking-[0.2em] uppercase font-bold text-brand-text font-display mb-8">Đổi mật khẩu</h2>
                            <div class="space-y-5">
                                <div class="relative">
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-brand-muted font-bold block mb-1">Mật khẩu cũ</label>
                                    <input type="password" name="oldPassword" id="oldPw" class="input-line pr-10" required />
                                    <button type="button" onclick="togglePw('oldPw')" class="absolute right-0 bottom-2 text-brand-muted hover:text-brand-text">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                    </button>
                                </div>
                                <div class="relative">
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-brand-muted font-bold block mb-1">Mật khẩu mới</label>
                                    <input type="password" name="newPassword" id="newPw" class="input-line pr-10" required />
                                    <button type="button" onclick="togglePw('newPw')" class="absolute right-0 bottom-2 text-brand-muted hover:text-brand-text">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                    </button>
                                </div>
                                <div class="relative">
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-brand-muted font-bold block mb-1">Xác nhận mật khẩu</label>
                                    <input type="password" name="confirmPassword" id="confirmPw" class="input-line pr-10" required />
                                    <button type="button" onclick="togglePw('confirmPw')" class="absolute right-0 bottom-2 text-brand-muted hover:text-brand-text">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                    </button>
                                </div>
                                <button type="submit" class="w-full bg-brand-text text-white py-3 text-[11px] font-bold uppercase tracking-[0.2em] hover:bg-brand-accent transition-all">Cập nhật mật khẩu</button>
                            </div>
                        </form>
                    </div>
                </main>
            </div>
        </div>

        <%@ include file="/views/includes/footer.jsp" %>

        <script>
            function switchTab(tab) {
                document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
                const target = document.getElementById('tab-' + tab);
                if (target)
                    target.classList.add('active');

                document.querySelectorAll('.tab-btn').forEach(b => {
                    const isActive = b.dataset.tab === tab;
                    b.classList.toggle('tab-btn-active', isActive);
                    b.classList.toggle('text-brand-muted', !isActive);
                });
                const url = new URL(window.location);
                url.searchParams.set('tab', tab);
                window.history.pushState({}, '', url);
            }
            function togglePw(id) {
                const input = document.getElementById(id);
                input.type = input.type === 'password' ? 'text' : 'password';
            }
        </script>
    </body>
</html>