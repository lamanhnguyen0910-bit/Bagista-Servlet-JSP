<%-- 
    Document   : support
    Created on : Mar 5, 2026, 9:06:03 PM
    Author     : laman
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--
  ============================================================
  BAGISTA — Hỗ trợ (FAQ, Liên hệ, Chính sách)
  ============================================================
  File JSP: /support.jsp (trang tĩnh, không cần Servlet)
  JS: Accordion FAQ bằng vanilla JS
  ============================================================
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Hỗ trợ</title>
    </head>
    <body class="min-h-screen">
        <% request.setAttribute("activePage", ""); %>
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-3xl mx-auto px-6 py-20 space-y-12">
            <div class="text-center">
                <h1 class="text-[36px] font-display tracking-[0.25em] text-brand-text mb-4">HỖ TRỢ</h1>
                <div class="w-12 h-px bg-brand-accent mx-auto mb-12"></div>
            </div>

            <!-- Liên hệ -->
            <div>
                <h2 class="text-[13px] tracking-[0.2em] uppercase font-display text-brand-text text-center mb-6">Liên hệ với chúng tôi</h2>
                <div class="grid gap-6 md:grid-cols-3">
                    <div class="text-center p-6 border border-brand-border hover:border-brand-accent/50 transition-colors">
                        <svg class="mx-auto w-5 h-5 text-brand-accent mb-3" fill="none" stroke="currentColor" stroke-width="1.2" viewBox="0 0 24 24"><path d="M22 16.92v3a2 2 0 01-2.18 2 19.79 19.79 0 01-8.63-3.07 19.5 19.5 0 01-6-6 19.79 19.79 0 01-3.07-8.67A2 2 0 014.11 2h3a2 2 0 012 1.72 12.84 12.84 0 00.7 2.81 2 2 0 01-.45 2.11L8.09 9.91a16 16 0 006 6l1.27-1.27a2 2 0 012.11-.45 12.84 12.84 0 002.81.7A2 2 0 0122 16.92z"/></svg>
                        <p class="text-[10px] tracking-[0.2em] uppercase text-brand-muted font-body mb-2">Số điện thoại</p>
                        <p class="text-[14px] font-body text-brand-text">0912 345 678</p>
                    </div>
                    <div class="text-center p-6 border border-brand-border hover:border-brand-accent/50 transition-colors">
                        <svg class="mx-auto w-5 h-5 text-brand-accent mb-3" fill="none" stroke="currentColor" stroke-width="1.2" viewBox="0 0 24 24"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                        <p class="text-[10px] tracking-[0.2em] uppercase text-brand-muted font-body mb-2">Email</p>
                        <p class="text-[14px] font-body text-brand-text">bagista@gmail.com</p>
                    </div>
                    <div class="text-center p-6 border border-brand-border hover:border-brand-accent/50 transition-colors">
                        <svg class="mx-auto w-5 h-5 text-brand-accent mb-3" fill="none" stroke="currentColor" stroke-width="1.2" viewBox="0 0 24 24"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0118 0z"/><circle cx="12" cy="10" r="3"/></svg>
                        <p class="text-[10px] tracking-[0.2em] uppercase text-brand-muted font-body mb-2">Địa chỉ</p>
                        <p class="text-[14px] font-body text-brand-text">Ba Đình, Hà Nội</p>
                    </div>
                </div>
            </div>

            <!-- Chính sách links -->
            <div>
                <h2 class="text-[13px] tracking-[0.2em] uppercase font-display text-brand-text text-center mb-6">Chính sách & Điều khoản</h2>
                <div class="grid gap-3 md:grid-cols-2">
                    <a href="policy/shipping.jsp" class="flex items-center justify-between px-5 py-4 border border-brand-border hover:border-brand-accent/50 hover:bg-brand-secondary/30 transition-all group">
                        <span class="text-[13px] font-body text-brand-text">Chính sách vận chuyển</span>
                        <svg class="w-4 h-4 text-brand-muted group-hover:text-brand-accent" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="9 18 15 12 9 6"/></svg>
                    </a>
                    <a href="policy/return.jsp" class="flex items-center justify-between px-5 py-4 border border-brand-border hover:border-brand-accent/50 hover:bg-brand-secondary/30 transition-all group">
                        <span class="text-[13px] font-body text-brand-text">Chính sách đổi trả</span>
                        <svg class="w-4 h-4 text-brand-muted group-hover:text-brand-accent" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="9 18 15 12 9 6"/></svg>
                    </a>
                    <a href="policy/warranty.jsp" class="flex items-center justify-between px-5 py-4 border border-brand-border hover:border-brand-accent/50 hover:bg-brand-secondary/30 transition-all group">
                        <span class="text-[13px] font-body text-brand-text">Chính sách bảo hành</span>
                        <svg class="w-4 h-4 text-brand-muted group-hover:text-brand-accent" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="9 18 15 12 9 6"/></svg>
                    </a>
                    <a href="policy/privacy.jsp" class="flex items-center justify-between px-5 py-4 border border-brand-border hover:border-brand-accent/50 hover:bg-brand-secondary/30 transition-all group">
                        <span class="text-[13px] font-body text-brand-text">Chính sách bảo mật</span>
                        <svg class="w-4 h-4 text-brand-muted group-hover:text-brand-accent" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="9 18 15 12 9 6"/></svg>
                    </a>
                    <a href="policy/terms.jsp" class="flex items-center justify-between px-5 py-4 border border-brand-border hover:border-brand-accent/50 hover:bg-brand-secondary/30 transition-all group">
                        <span class="text-[13px] font-body text-brand-text">Điều khoản sử dụng</span>
                        <svg class="w-4 h-4 text-brand-muted group-hover:text-brand-accent" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="9 18 15 12 9 6"/></svg>
                    </a>
                </div>
            </div>

            <!-- FAQ -->
            <div>
                <h2 class="text-[13px] tracking-[0.2em] uppercase font-display text-brand-text text-center mb-8">Câu hỏi thường gặp</h2>
                <div class="space-y-2">
                    <div class="border border-brand-border px-5">
                        <button onclick="toggleFaq(this)" class="w-full flex items-center justify-between py-4 text-[13px] font-body text-brand-text text-left">
                            Thời gian giao hàng là bao lâu?
                            <svg class="faq-chevron w-4 h-4 text-brand-muted shrink-0" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"/></svg>
                        </button>
                        <div class="faq-answer"><p class="text-[13px] font-body text-brand-muted leading-relaxed pb-4">Đơn hàng sẽ được giao trong vòng 1-2 ngày (nội thành) và 2-5 ngày làm việc (các tỉnh thành khác) trên toàn quốc.</p></div>
                    </div>
                    <div class="border border-brand-border px-5">
                        <button onclick="toggleFaq(this)" class="w-full flex items-center justify-between py-4 text-[13px] font-body text-brand-text text-left">
                            Chính sách đổi trả như thế nào?
                            <svg class="faq-chevron w-4 h-4 text-brand-muted shrink-0" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"/></svg>
                        </button>
                        <div class="faq-answer"><p class="text-[13px] font-body text-brand-muted leading-relaxed pb-4">Bagista hỗ trợ đổi trả trong vòng 7 ngày kể từ ngày nhận hàng, sản phẩm còn nguyên tem mác và chưa qua sử dụng.</p></div>
                    </div>
                    <div class="border border-brand-border px-5">
                        <button onclick="toggleFaq(this)" class="w-full flex items-center justify-between py-4 text-[13px] font-body text-brand-text text-left">
                            Có hỗ trợ thanh toán COD không?
                            <svg class="faq-chevron w-4 h-4 text-brand-muted shrink-0" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"/></svg>
                        </button>
                        <div class="faq-answer"><p class="text-[13px] font-body text-brand-muted leading-relaxed pb-4">Có, chúng tôi hỗ trợ COD trên toàn quốc. Ngoài ra còn hỗ trợ chuyển khoản ngân hàng và ví MoMo.</p></div>
                    </div>
                    <div class="border border-brand-border px-5">
                        <button onclick="toggleFaq(this)" class="w-full flex items-center justify-between py-4 text-[13px] font-body text-brand-text text-left">
                            Sản phẩm có được bảo hành không?
                            <svg class="faq-chevron w-4 h-4 text-brand-muted shrink-0" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"/></svg>
                        </button>
                        <div class="faq-answer"><p class="text-[13px] font-body text-brand-muted leading-relaxed pb-4">Tất cả sản phẩm được bảo hành 6 tháng cho lỗi kỹ thuật. Da thật bảo hành 12 tháng.</p></div>
                    </div>
                    <div class="border border-brand-border px-5">
                        <button onclick="toggleFaq(this)" class="w-full flex items-center justify-between py-4 text-[13px] font-body text-brand-text text-left">
                            Làm sao để theo dõi đơn hàng?
                            <svg class="faq-chevron w-4 h-4 text-brand-muted shrink-0" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"/></svg>
                        </button>
                        <div class="faq-answer"><p class="text-[13px] font-body text-brand-muted leading-relaxed pb-4">Bagista gửi mã vận đơn qua email/SMS. Bạn cũng có thể theo dõi trong Lịch sử đơn hàng trên trang cá nhân.</p></div>
                    </div>
                    <div class="border border-brand-border px-5">
                        <button onclick="toggleFaq(this)" class="w-full flex items-center justify-between py-4 text-[13px] font-body text-brand-text text-left">
                            Tôi có thể huỷ đơn hàng không?
                            <svg class="faq-chevron w-4 h-4 text-brand-muted shrink-0" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"/></svg>
                        </button>
                        <div class="faq-answer"><p class="text-[13px] font-body text-brand-muted leading-relaxed pb-4">Bạn có thể huỷ khi đơn hàng ở trạng thái 'Chờ xử lý'. Khi đã 'Đang giao', bạn có thể từ chối nhận.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>
        <script>
            function toggleFaq(btn) {
                const answer = btn.nextElementSibling;
                const chevron = btn.querySelector('.faq-chevron');
                // Close all others
                document.querySelectorAll('.faq-answer').forEach(a => {
                    if (a !== answer)
                        a.classList.remove('open');
                });
                document.querySelectorAll('.faq-chevron').forEach(c => {
                    if (c !== chevron)
                        c.classList.remove('open');
                });
                answer.classList.toggle('open');
                chevron.classList.toggle('open');
            }
        </script>
    </body>
</html>