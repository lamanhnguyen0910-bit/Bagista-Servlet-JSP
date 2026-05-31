<%-- 
    Document   : header
    Created on : Mar 5, 2026, 9:06:54 PM
    Author     : laman
--%>

<%--
  ============================================================
  BAGISTA — Common Header
  ============================================================
  Sử dụng: <%@ include file="/includes/header.jsp" %>
  
  Yêu cầu:
  - Servlet set: request.setAttribute("cartCount", int)
  - Session: sessionScope.user (nếu đã đăng nhập)
  - Session: sessionScope.user.role (kiểm tra admin)
  
  Trang hiện tại: set biến "activePage" trước khi include:
  <% request.setAttribute("activePage", "home"); %>
  Giá trị: home, shop, about, support
  ============================================================
--%>


<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="sticky top-0 z-50 bg-brand-bg/95 backdrop-blur-sm border-b border-brand-border">
    <div class="max-w-7xl mx-auto px-6 flex items-center justify-between h-16">
        <a href="${pageContext.request.contextPath}/home" class="text-[22px] tracking-[0.25em] font-display text-brand-text">BAGISTA</a>

        <!-- Desktop Navigation -->
        <nav class="hidden md:flex items-center gap-8">
            <a href="${pageContext.request.contextPath}/home" class="text-[11px] tracking-[0.15em] uppercase font-body ${activePage == 'home' ? 'text-brand-text' : 'text-brand-muted hover:text-brand-text'}">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/shop" class="text-[11px] tracking-[0.15em] uppercase font-body ${activePage == 'shop' ? 'text-brand-text' : 'text-brand-muted hover:text-brand-text'}">Mua ngay</a>
            <a href="${pageContext.request.contextPath}/views/user/about.jsp" class="text-[11px] tracking-[0.15em] uppercase font-body ${activePage == 'about' ? 'text-brand-text' : 'text-brand-muted hover:text-brand-text'}">Về chúng tôi</a>
            <a href="${pageContext.request.contextPath}/views/user/support.jsp" class="text-[11px] tracking-[0.15em] uppercase font-body ${activePage == 'support' ? 'text-brand-text' : 'text-brand-muted hover:text-brand-text'}">Hỗ trợ</a>
        </nav>

        <div class="flex items-center gap-5">
            <!-- Cart -->
            <a href="${pageContext.request.contextPath}/cart" class="relative text-brand-text hover:text-brand-accent">
                <svg class="w-[18px] h-[18px]" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 01-8 0"/></svg>
                <c:if test="${cartCount > 0}">
                    <span class="absolute -top-2 -right-2 w-4 h-4 bg-brand-accent text-brand-accent-fg text-[9px] flex items-center justify-center rounded-full font-body">${cartCount}</span>
                </c:if>
            </a>

            <!-- User Menu (Desktop) -->
            <div class="hidden md:block relative">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <button onclick="toggleUserMenu()" class="text-brand-text hover:text-brand-accent">
                            <svg class="w-[18px] h-[18px]" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                        </button>
                        <div id="userDropdown" class="user-dropdown absolute right-0 top-full mt-2 z-50 bg-brand-bg border border-brand-border shadow-lg min-w-[160px]">
                            <a href="${pageContext.request.contextPath}/profile" class="flex items-center gap-2 px-4 py-3 text-[11px] tracking-[0.1em] uppercase font-body text-brand-text hover:bg-brand-secondary/50 border-b border-brand-border">Tài khoản</a>
                            <c:if test="${sessionScope.user.role == 'admin'}">
                                <a href="${pageContext.request.contextPath}/admindashboard" class="flex items-center gap-2 px-4 py-3 text-[11px] tracking-[0.1em] uppercase font-body text-brand-accent hover:bg-brand-secondary/50 border-b border-brand-border">Quản trị</a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-2 px-4 py-3 text-[11px] tracking-[0.1em] uppercase font-body text-brand-muted hover:bg-brand-secondary/50">Đăng xuất</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/views/user/login.jsp" class="text-brand-text hover:text-brand-accent">
                            <svg class="w-[18px] h-[18px]" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Mobile Menu Button -->
            <button onclick="toggleMobileMenu()" class="md:hidden text-brand-text" id="mobileMenuBtn">
                <svg id="menuOpenIcon" class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
                <svg id="menuCloseIcon" class="w-5 h-5 hidden" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
            </button>
        </div>
    </div>

    <!-- Mobile Menu -->
    <div id="mobileMenu" class="mobile-menu md:hidden border-t border-brand-border bg-brand-bg">
        <div class="px-6 py-4 space-y-3">
            <a href="${pageContext.request.contextPath}/home" class="block text-[12px] tracking-[0.12em] uppercase font-body ${activePage == 'home' ? 'text-brand-text' : 'text-brand-muted'}">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/shop" class="block text-[12px] tracking-[0.12em] uppercase font-body ${activePage == 'shop' ? 'text-brand-text' : 'text-brand-muted'}">Mua ngay</a>
            <a href="${pageContext.request.contextPath}/views/user/about.jsp" class="block text-[12px] tracking-[0.12em] uppercase font-body ${activePage == 'about' ? 'text-brand-text' : 'text-brand-muted'}">Về chúng tôi</a>
            <a href="${pageContext.request.contextPath}/views/user/support.jsp" class="block text-[12px] tracking-[0.12em] uppercase font-body ${activePage == 'support' ? 'text-brand-text' : 'text-brand-muted'}">Hỗ trợ</a>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/profile" class="block text-[12px] tracking-[0.12em] uppercase font-body text-brand-muted">Tài khoản</a>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/admindashboard" class="block text-[12px] tracking-[0.12em] uppercase font-body text-brand-accent">Quản trị</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout" class="block text-[12px] tracking-[0.12em] uppercase font-body text-brand-muted">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/views/user/login.jsp" class="block text-[12px] tracking-[0.12em] uppercase font-body text-brand-muted">Đăng nhập</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>


