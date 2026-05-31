<%-- 
    Document   : return
    Created on : Mar 5, 2026, 9:04:15 PM
    Author     : laman
--%>
<%--
  ============================================================
  BAGISTA — Chính sách đổi trả
  ============================================================
  File JSP: /policy/return.jsp (trang tĩnh, không cần Servlet)
  ============================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Chính sách đổi trả</title>
    </head>
    <body class="min-h-screen">
        <% request.setAttribute("activePage", ""); %>
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-3xl mx-auto px-6 py-16">
            <div class="text-center mb-12">
                <svg class="mx-auto w-8 h-8 text-brand-accent mb-4" fill="none" stroke="currentColor" stroke-width="1.2" viewBox="0 0 24 24"><polyline points="1 4 1 10 7 10"/><path d="M3.51 15a9 9 0 102.13-9.36L1 10"/></svg>
                <h1 class="text-[32px] font-display tracking-[0.2em] text-brand-text mb-3">CHÍNH SÁCH ĐỔI TRẢ</h1>
                <div class="w-16 h-px bg-brand-accent mx-auto mb-4"></div>
                <p class="text-[13px] font-body text-brand-muted max-w-md mx-auto">Đổi trả dễ dàng, bảo vệ quyền lợi khách hàng.</p>
            </div>

            <div class="space-y-8">
                <!-- 1. Điều kiện đổi trả -->
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">1. Điều kiện đổi trả</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Bagista chấp nhận đổi trả sản phẩm trong vòng 7 ngày kể từ ngày khách hàng nhận hàng với các điều kiện sau:</p>
                    <ul class="space-y-1.5 mt-2">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm còn nguyên tem, mác, chưa qua sử dụng</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm không bị hư hỏng, bẩn, hoặc có mùi lạ do khách hàng gây ra</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Còn đầy đủ hộp/túi đựng kèm theo (nếu có)</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Có hoá đơn mua hàng hoặc mã đơn hàng</li>
                    </ul>
                </div>

                <!-- 2. Trường hợp được đổi trả -->
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">2. Trường hợp được đổi trả</h2>
                    <ul class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm bị lỗi do nhà sản xuất (đường may bị lỗi, khoá hỏng, da bong tróc...)</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Giao sai sản phẩm hoặc sai màu sắc so với đơn hàng</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm bị hư hỏng trong quá trình vận chuyển</li>
                    </ul>
                </div>

                <!-- 3. Trường hợp không được đổi trả -->
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">3. Trường hợp không được đổi trả</h2>
                    <ul class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm đã qua sử dụng, giặt, hoặc bị biến dạng</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm thuộc chương trình khuyến mãi, giảm giá đặc biệt (trừ trường hợp lỗi từ nhà sản xuất)</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Quá thời hạn 7 ngày kể từ ngày nhận hàng</li>
                    </ul>
                </div>

                <!-- 4. Quy trình đổi trả -->
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">4. Quy trình đổi trả</h2>
                    <ol class="space-y-1.5 mt-2">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">1.</span>Liên hệ Bagista qua hotline hoặc email để thông báo yêu cầu đổi trả</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">2.</span>Cung cấp mã đơn hàng, hình ảnh sản phẩm và lý do đổi trả</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">3.</span>Bagista xác nhận yêu cầu trong vòng 24 giờ</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">4.</span>Gửi sản phẩm về kho Bagista (chi phí vận chuyển do Bagista chịu nếu lỗi từ chúng tôi)</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">5.</span>Nhận sản phẩm mới hoặc hoàn tiền trong 3-5 ngày làm việc</li>
                    </ol>
                </div>

                <!-- 5. Hoàn tiền -->
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">5. Hoàn tiền</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Trong trường hợp hoàn tiền, Bagista sẽ hoàn lại 100% giá trị sản phẩm qua phương thức thanh toán ban đầu. Thời gian hoàn tiền: 3-5 ngày làm việc đối với chuyển khoản, 7-14 ngày đối với thẻ tín dụng.</p>
                </div>
            </div>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>
    </body>
</html>

