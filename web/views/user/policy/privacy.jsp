<%-- 
    Document   : privacy
    Created on : Mar 5, 2026, 9:04:26 PM
    Author     : laman
--%>

<%--
  ============================================================
  BAGISTA — Chính sách bảo mật
  ============================================================
  File JSP: /policy/privacy.jsp (trang tĩnh, không cần Servlet)
  ============================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Chính sách bảo mật</title>
    </head>
    <body class="min-h-screen">
        <% request.setAttribute("activePage", ""); %>
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-3xl mx-auto px-6 py-16">
            <div class="text-center mb-12">
                <svg class="mx-auto w-8 h-8 text-brand-accent mb-4" fill="none" stroke="currentColor" stroke-width="1.2" viewBox="0 0 24 24"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>
                <h1 class="text-[32px] font-display tracking-[0.2em] text-brand-text mb-3">CHÍNH SÁCH BẢO MẬT</h1>
                <div class="w-16 h-px bg-brand-accent mx-auto mb-4"></div>
                <p class="text-[13px] font-body text-brand-muted max-w-md mx-auto">Bảo vệ thông tin cá nhân là ưu tiên hàng đầu của chúng tôi.</p>
            </div>

            <div class="space-y-8">
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">1. Thu thập thông tin</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Khi sử dụng dịch vụ của Bagista, chúng tôi có thể thu thập các thông tin sau:</p>
                    <ul class="space-y-1.5 mt-2">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Họ tên, số điện thoại, email, địa chỉ giao hàng</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Thông tin tài khoản: tên đăng nhập, mật khẩu (được mã hoá)</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Lịch sử mua hàng và thanh toán</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Thông tin thiết bị và trình duyệt khi truy cập website</li>
                    </ul>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">2. Mục đích sử dụng</h2>
                    <ul class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Xử lý đơn hàng và giao hàng</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Liên hệ xác nhận đơn hàng và hỗ trợ khách hàng</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Gửi thông tin khuyến mãi, sản phẩm mới (với sự đồng ý của khách hàng)</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Cải thiện chất lượng dịch vụ và trải nghiệm người dùng</li>
                    </ul>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">3. Bảo mật thông tin</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Bagista cam kết bảo mật tuyệt đối thông tin cá nhân của khách hàng. Chúng tôi sử dụng các biện pháp bảo mật tiêu chuẩn:</p>
                    <ul class="space-y-1.5 mt-2">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Mã hoá SSL cho tất cả giao dịch trên website</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Mật khẩu được mã hoá và không lưu trữ dạng văn bản thuần</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Hạn chế quyền truy cập dữ liệu chỉ cho nhân viên được uỷ quyền</li>
                    </ul>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">4. Chia sẻ thông tin</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Bagista không bán, trao đổi hoặc cho thuê thông tin cá nhân. Trừ các trường hợp:</p>
                    <ul class="space-y-1.5 mt-2">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Chia sẻ với đơn vị vận chuyển để giao hàng</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Theo yêu cầu của cơ quan pháp luật có thẩm quyền</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Với sự đồng ý rõ ràng của khách hàng</li>
                    </ul>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">5. Quyền của khách hàng</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Khách hàng có quyền yêu cầu Bagista cung cấp, chỉnh sửa hoặc xoá thông tin cá nhân của mình bất cứ lúc nào bằng cách liên hệ qua email: bagista@gmail.com</p>
                </div>
            </div>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>
    </body>
</html>

