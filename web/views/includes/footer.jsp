<%-- 
    Document   : footer
    Created on : Mar 5, 2026, 9:07:00 PM
    Author     : laman
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer class="border-t border-brand-border bg-brand-card">
    <div class="max-w-7xl mx-auto px-6 py-12">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8 mb-10">
            <div>
                <h3 class="text-[18px] tracking-[0.2em] font-display text-brand-text mb-3">BAGISTA</h3>
                <p class="text-[12px] font-body text-brand-muted leading-relaxed">Mang phong cách theo cách của bạn.</p>
            </div>
            <div>
                <h4 class="text-[10px] tracking-[0.2em] uppercase font-body text-brand-text mb-4">Điều hướng</h4>
                <div class="space-y-2">
                    <a href="${pageContext.request.contextPath}/home" class="block text-[12px] font-body text-brand-muted hover:text-brand-text">Trang chủ</a>
                    <a href="${pageContext.request.contextPath}/shop" class="block text-[12px] font-body text-brand-muted hover:text-brand-text">Mua ngay</a>
                    <a href="${pageContext.request.contextPath}/views/user/about.jsp" class="block text-[12px] font-body text-brand-muted hover:text-brand-text">Về chúng tôi</a>
                    <a href="${pageContext.request.contextPath}/views/user/support.jsp" class="block text-[12px] font-body text-brand-muted hover:text-brand-text">Hỗ trợ</a>
                </div>
            </div>
            <div>
                <h4 class="text-[10px] tracking-[0.2em] uppercase font-body text-brand-text mb-4">Chính sách</h4>
                <div class="space-y-2">
                    <a href="${pageContext.request.contextPath}/views/user/policy/shipping.jsp" class="block text-[12px] font-body text-brand-muted hover:text-brand-text">Chính sách vận chuyển</a>
                    <a href="${pageContext.request.contextPath}/views/user/policy/return.jsp" class="block text-[12px] font-body text-brand-muted hover:text-brand-text">Chính sách đổi trả</a>
                    <a href="${pageContext.request.contextPath}/views/user/policy/warranty.jsp" class="block text-[12px] font-body text-brand-muted hover:text-brand-text">Chính sách bảo hành</a>
                    <a href="${pageContext.request.contextPath}/views/user/policy/privacy.jsp" class="block text-[12px] font-body text-brand-muted hover:text-brand-text">Chính sách bảo mật</a>
                    <a href="${pageContext.request.contextPath}/views/user/policy/terms.jsp" class="block text-[12px] font-body text-brand-muted hover:text-brand-text">Điều khoản sử dụng</a>
                </div>
            </div>
            <div>
                <h4 class="text-[10px] tracking-[0.2em] uppercase font-body text-brand-text mb-4">Liên hệ</h4>
                <div class="space-y-2 text-[12px] font-body text-brand-muted">
                    <p>SĐT: 0912 345 678</p>
                    <p>Email: bagista@gmail.com</p>
                    <p>Địa chỉ: Ba Đình, Hà Nội</p>
                </div>
            </div>
        </div>
        <div class="border-t border-brand-border pt-6 text-center">
            <p class="text-[10px] tracking-[0.2em] uppercase text-brand-muted font-body">&copy; 2026 BAGISTA &mdash; All rights reserved</p>
        </div>
    </div>
</footer>

<!-- Common Scripts -->
<script>
    function toggleMobileMenu() {
        document.getElementById('mobileMenu').classList.toggle('open');
        document.getElementById('menuOpenIcon').classList.toggle('hidden');
        document.getElementById('menuCloseIcon').classList.toggle('hidden');
    }
    function toggleUserMenu() {
        document.getElementById('userDropdown').classList.toggle('open');
    }
    // Close user menu on outside click
    document.addEventListener('click', function (e) {
        var dropdown = document.getElementById('userDropdown');
        if (dropdown && !e.target.closest('.relative'))
            dropdown.classList.remove('open');
    });
</script>
