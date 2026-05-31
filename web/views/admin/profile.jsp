<%-- 
    Document   : profile
    Created on : Mar 5, 2026, 9:09:24 PM
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
        <title>Hồ sơ — BAGISTA Admin</title>
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
            .tab-btn.active {
                border-color: #7A5C3E;
                color: #3D3228;
                border-bottom-width: 2px;
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
                    <a href="${pageContext.request.contextPath}/admindashboard" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors"><i data-lucide="layout-dashboard" class="w-4 h-4"></i> Dashboard</a>
                    <a href="${pageContext.request.contextPath}/adminproduct" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors"><i data-lucide="package" class="w-4 h-4"></i> Sản phẩm</a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors"><i data-lucide="shopping-cart" class="w-4 h-4"></i> Đơn hàng</a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors"><i data-lucide="tag" class="w-4 h-4"></i> Danh mục</a>
                    <a href="${pageContext.request.contextPath}/admincustomer" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors"><i data-lucide="users" class="w-4 h-4"></i> Khách hàng</a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors"><i data-lucide="star" class="w-4 h-4"></i> Đánh giá</a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors"><i data-lucide="percent" class="w-4 h-4"></i> Giảm giá</a>
                </nav>
                <div class="border-t border-border p-4">
                    <a href="${pageContext.request.contextPath}/adminprofile" class="sidebar-link active flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground px-2 py-2">Hồ sơ Admin</a>
                    <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground px-2 py-2">Về trang chủ</a>
                </div>
            </aside>

            <div class="flex-1 md:ml-56 flex flex-col min-w-0">
                <main class="flex-1 p-6 overflow-auto">
                    <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground mb-6 uppercase font-bold">Quản lý tài khoản</h1>

                    <c:if test="${not empty successMessage}">
                        <div class="mb-6 p-4 bg-green-50 border border-green-200 text-green-700 text-[12px] font-body">
                            ${successMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="mb-6 p-4 bg-red-50 border border-red-200 text-red-600 text-[12px] font-body">
                            ${errorMessage}
                        </div>
                    </c:if>

                    <div class="flex gap-1 mb-6 border-b border-border">
                        <button onclick="switchTab('info')" class="tab-btn active px-6 py-3 text-[11px] tracking-[0.1em] uppercase font-body transition-colors text-foreground" id="tabInfo">Thông tin cá nhân</button>
                        <button onclick="switchTab('password')" class="tab-btn px-6 py-3 text-[11px] tracking-[0.1em] uppercase font-body transition-colors text-muted-foreground hover:text-foreground" id="tabPassword">Bảo mật & Mật khẩu</button>
                    </div>

                    <div id="infoTab" class="max-w-lg bg-white/40 border border-border p-8 shadow-sm">
                        <form action="${pageContext.request.contextPath}/adminupdateprofile" method="POST" class="space-y-5">
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Họ và tên</label>
                                <input type="text" name="fullName" value="${admin.fullName}" required class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Tên đăng nhập (Username)</label>
                                <input type="text" name="username" value="${admin.username}" disabled class="w-full bg-secondary/30 border border-border px-3 py-2.5 text-[13px] font-body text-muted-foreground cursor-not-allowed" />
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Ngày sinh</label>
                                <input type="date" name="birthday" value="<fmt:formatDate value='${admin.birthday}' pattern='yyyy-MM-dd'/>" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Email</label>
                                <input type="email" name="email" value="${admin.email}" required class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Số điện thoại</label>
                                <input type="text" name="phone" value="${admin.phone}" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Địa chỉ</label>
                                <input type="text" name="address" value="${admin.address}" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                            </div>
                            <button type="submit" class="bg-accent text-accent-foreground px-10 py-3 text-[11px] tracking-[0.15em] uppercase font-body hover:bg-accent/90 transition-all shadow-sm">Cập nhật thông tin</button>
                        </form>
                    </div>

                    <div id="passwordTab" class="max-w-md hidden bg-white/40 border border-border p-8 shadow-sm">
                        <form action="${pageContext.request.contextPath}/adminchangepassword" method="POST" class="space-y-5">
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Mật khẩu hiện tại <span class="text-red-600">*</span></label>
                                <div class="relative">
                                    <input type="password" name="oldPassword" required id="oldPwd" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent pr-10" />
                                    <button type="button" onclick="togglePwd('oldPwd')" class="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground">
                                        <i data-lucide="eye" class="w-4 h-4"></i>
                                    </button>
                                </div>
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Mật khẩu mới <span class="text-red-600">*</span></label>
                                <div class="relative">
                                    <input type="password" name="newPassword" required id="newPwd" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent pr-10" />
                                    <button type="button" onclick="togglePwd('newPwd')" class="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground">
                                        <i data-lucide="eye" class="w-4 h-4"></i>
                                    </button>
                                </div>
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Xác nhận mật khẩu mới <span class="text-red-600">*</span></label>
                                <div class="relative">
                                    <input type="password" name="confirmPassword" required id="confirmPwd" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent pr-10" />
                                    <button type="button" onclick="togglePwd('confirmPwd')" class="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground">
                                        <i data-lucide="eye" class="w-4 h-4"></i>
                                    </button>
                                </div>
                            </div>
                            <button type="submit" class="bg-accent text-accent-foreground px-10 py-3 text-[11px] tracking-[0.15em] uppercase font-body hover:bg-accent/90 transition-all shadow-sm">Đổi mật khẩu</button>
                        </form>
                    </div>
                </main>
            </div>
        </div>

        <script>
            lucide.createIcons();

            function toggleMobileSidebar() {
                document.getElementById('mobileSidebar').classList.toggle('hidden');
            }

            function switchTab(tab) {
                document.getElementById('infoTab').classList.toggle('hidden', tab !== 'info');
                document.getElementById('passwordTab').classList.toggle('hidden', tab !== 'password');

                const btnInfo = document.getElementById('tabInfo');
                const btnPass = document.getElementById('tabPassword');

                if (tab === 'info') {
                    btnInfo.classList.add('active', 'text-foreground');
                    btnInfo.classList.remove('text-muted-foreground');
                    btnPass.classList.remove('active', 'text-foreground');
                    btnPass.classList.add('text-muted-foreground');
                } else {
                    btnPass.classList.add('active', 'text-foreground');
                    btnPass.classList.remove('text-muted-foreground');
                    btnInfo.classList.remove('active', 'text-foreground');
                    btnInfo.classList.add('text-muted-foreground');
                }
            }

            function togglePwd(id) {
                const input = document.getElementById(id);
                input.type = (input.type === 'password') ? 'text' : 'password';
            }
        </script>
    </body>
</html>