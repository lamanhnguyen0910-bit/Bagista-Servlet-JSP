<%-- 
    Document   : terms
    Created on : Mar 5, 2026, 9:04:33 PM
    Author     : laman
--%>
<%--
  ============================================================
  BAGISTA — Điều khoản sử dụng
  ============================================================
  File JSP: /policy/terms.jsp (trang tĩnh, không cần Servlet)
  ============================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Điều khoản sử dụng</title>
    </head>
    <body class="min-h-screen">
        <% request.setAttribute("activePage", ""); %>
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-3xl mx-auto px-6 py-16">
            <div class="text-center mb-12">
                <svg class="mx-auto w-8 h-8 text-brand-accent mb-4" fill="none" stroke="currentColor" stroke-width="1.2" viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>
                <h1 class="text-[32px] font-display tracking-[0.2em] text-brand-text mb-3">ĐIỀU KHOẢN SỬ DỤNG</h1>
                <div class="w-16 h-px bg-brand-accent mx-auto mb-4"></div>
                <p class="text-[13px] font-body text-brand-muted max-w-md mx-auto">Vui lòng đọc kỹ trước khi sử dụng dịch vụ của chúng tôi.</p>
            </div>

            <div class="space-y-8">
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">1. Chấp nhận điều khoản</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Bằng việc truy cập và sử dụng website Bagista, bạn đồng ý tuân thủ và chịu ràng buộc bởi các điều khoản và điều kiện sau đây. Nếu không đồng ý với bất kỳ phần nào của các điều khoản này, vui lòng không sử dụng website.</p>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">2. Tài khoản người dùng</h2>
                    <ul class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Bạn phải cung cấp thông tin chính xác và đầy đủ khi đăng ký tài khoản</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Bạn chịu trách nhiệm bảo mật tài khoản và mật khẩu của mình</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Mọi hoạt động dưới tài khoản của bạn đều thuộc trách nhiệm của bạn</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Bagista có quyền khoá hoặc xoá tài khoản vi phạm điều khoản sử dụng</li>
                    </ul>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">3. Đặt hàng và thanh toán</h2>
                    <ul class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Giá sản phẩm trên website đã bao gồm thuế VAT</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Đơn hàng chỉ được xác nhận khi Bagista gửi email/SMS xác nhận</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Bagista có quyền từ chối đơn hàng nếu phát hiện thông tin không chính xác</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Giá sản phẩm có thể thay đổi mà không cần thông báo trước</li>
                    </ul>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">4. Quyền sở hữu trí tuệ</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Tất cả nội dung trên website bao gồm nhưng không giới hạn: hình ảnh, văn bản, logo, thiết kế giao diện đều thuộc quyền sở hữu của Bagista. Nghiêm cấm sao chép, phân phối hoặc sử dụng cho mục đích thương mại.</p>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">5. Giới hạn trách nhiệm</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Bagista không chịu trách nhiệm cho bất kỳ thiệt hại nào phát sinh từ việc sử dụng hoặc không thể sử dụng website, bao gồm nhưng không giới hạn: mất dữ liệu, gián đoạn dịch vụ, lỗi hệ thống.</p>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">6. Thay đổi điều khoản</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Bagista có quyền thay đổi các điều khoản sử dụng bất cứ lúc nào. Các thay đổi sẽ có hiệu lực ngay khi được đăng tải trên website.</p>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">7. Liên hệ</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Mọi thắc mắc về điều khoản sử dụng, vui lòng liên hệ:</p>
                    <ul class="space-y-1.5 mt-2">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Email: bagista@gmail.com</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Hotline: 0912 345 678</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Địa chỉ: Ba Đình, Hà Nội</li>
                    </ul>
                </div>
            </div>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>
    </body>
</html>
