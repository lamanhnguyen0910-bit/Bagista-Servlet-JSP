<%-- 
    Document   : warranty
    Created on : Mar 5, 2026, 9:04:43 PM
    Author     : laman
--%>
<%--
  ============================================================
  BAGISTA — Chính sách bảo hành
  ============================================================
  File JSP: /policy/warranty.jsp (trang tĩnh, không cần Servlet)
  ============================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Chính sách bảo hành</title>
    </head>
    <body class="min-h-screen">
        <% request.setAttribute("activePage", ""); %>
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-3xl mx-auto px-6 py-16">
            <div class="text-center mb-12">
                <svg class="mx-auto w-8 h-8 text-brand-accent mb-4" fill="none" stroke="currentColor" stroke-width="1.2" viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                <h1 class="text-[32px] font-display tracking-[0.2em] text-brand-text mb-3">CHÍNH SÁCH BẢO HÀNH</h1>
                <div class="w-16 h-px bg-brand-accent mx-auto mb-4"></div>
                <p class="text-[13px] font-body text-brand-muted max-w-md mx-auto">Bagista cam kết chất lượng sản phẩm và luôn đồng hành cùng bạn sau mỗi giao dịch.</p>
            </div>

            <div class="space-y-8">
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">1. Phạm vi bảo hành</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Tất cả sản phẩm túi xách chính hãng của Bagista đều được bảo hành cho các lỗi kỹ thuật phát sinh từ quá trình sản xuất. Bảo hành áp dụng cho các lỗi về đường may, khoá kéo, phụ kiện kim loại, khoá bấm và quai đeo.</p>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">2. Thời gian bảo hành</h2>
                    <ul class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm da thật: bảo hành 12 tháng kể từ ngày mua</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm da PU: bảo hành 6 tháng kể từ ngày mua</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm nhung & vải: bảo hành 6 tháng kể từ ngày mua</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Phụ kiện kim loại (khoá, móc, chốt): bảo hành 6 tháng</li>
                    </ul>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">3. Trường hợp được bảo hành</h2>
                    <ul class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Đường may bị bung, chỉ tuột trong điều kiện sử dụng bình thường</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Khoá kéo bị hỏng, kẹt không do tác động ngoại lực</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Phụ kiện kim loại bị oxy hoá, bong tróc lớp mạ sớm</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Quai đeo bị đứt, tuột tại vị trí gắn</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Lớp lót bên trong bị bong, rách do lỗi sản xuất</li>
                    </ul>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">4. Trường hợp không được bảo hành</h2>
                    <ul class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Hư hỏng do sử dụng sai cách: mang quá tải, tiếp xúc hoá chất, nhiệt độ cao</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Trầy xước, phai màu tự nhiên do quá trình sử dụng</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm đã tự ý sửa chữa, thay đổi cấu trúc</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Hư hỏng do thiên tai, ngập nước, cháy nổ</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Sản phẩm không có hoá đơn mua hàng hoặc phiếu bảo hành</li>
                    </ul>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">5. Quy trình bảo hành</h2>
                    <ol class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">1.</span>Liên hệ Bagista qua hotline 0912 345 678 hoặc email bagista@gmail.com</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">2.</span>Cung cấp mã đơn hàng, hình ảnh sản phẩm và mô tả lỗi</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">3.</span>Bagista xác nhận yêu cầu bảo hành trong vòng 24-48 giờ</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">4.</span>Gửi sản phẩm về kho Bagista (phí vận chuyển do Bagista chịu)</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">5.</span>Kiểm tra và sửa chữa trong vòng 5-10 ngày làm việc</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent font-display shrink-0 w-5">6.</span>Gửi trả sản phẩm đã sửa chữa miễn phí</li>
                    </ol>
                </div>

                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">6. Lưu ý quan trọng</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Bagista khuyến nghị quý khách bảo quản sản phẩm đúng cách: tránh để ẩm ướt kéo dài, không tiếp xúc trực tiếp với ánh nắng mặt trời, sử dụng túi chống bụi kèm theo khi không sử dụng. Điều này giúp kéo dài tuổi thọ và giữ được vẻ đẹp của sản phẩm.</p>
                </div>
            </div>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>
    </body>
</html>

