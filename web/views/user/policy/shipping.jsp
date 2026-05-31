<%-- 
    Document   : shipping
    Created on : Mar 5, 2026, 9:04:04 PM
    Author     : laman
--%>
<%--
  ============================================================
  BAGISTA — Chính sách vận chuyển
  ============================================================
  File JSP: /policy/shipping.jsp (trang tĩnh, không cần Servlet)
  
  Sử dụng includes:
  <%@ include file="/includes/head.jsp" %>
  <%@ include file="/includes/header.jsp" %>
  <%@ include file="/includes/footer.jsp" %>
  ============================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Chính sách vận chuyển</title>
    </head>
    <body class="min-h-screen">
        <% request.setAttribute("activePage", ""); %>
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-3xl mx-auto px-6 py-16">
            <div class="text-center mb-12">
                <svg class="mx-auto w-8 h-8 text-brand-accent mb-4" fill="none" stroke="currentColor" stroke-width="1.2" viewBox="0 0 24 24"><rect x="1" y="3" width="15" height="13"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>
                <h1 class="text-[32px] font-display tracking-[0.2em] text-brand-text mb-3">CHÍNH SÁCH VẬN CHUYỂN</h1>
                <div class="w-16 h-px bg-brand-accent mx-auto mb-4"></div>
                <p class="text-[13px] font-body text-brand-muted max-w-md mx-auto">Giao hàng nhanh chóng, an toàn trên toàn quốc.</p>
            </div>

            <div class="space-y-8">
                <!-- 1. Phạm vi giao hàng -->
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">1. Phạm vi giao hàng</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Bagista giao hàng trên toàn quốc, bao gồm tất cả 63 tỉnh thành Việt Nam. Đối với các khu vực nội thành Hà Nội và TP.HCM, thời gian giao hàng nhanh hơn so với các tỉnh thành khác.</p>
                </div>

                <!-- 2. Thời gian giao hàng -->
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">2. Thời gian giao hàng</h2>
                    <ul class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Nội thành Hà Nội, TP.HCM: 1-2 ngày làm việc</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Các tỉnh thành lân cận: 2-3 ngày làm việc</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Các tỉnh thành xa: 3-5 ngày làm việc</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Vùng sâu, vùng xa, hải đảo: 5-7 ngày làm việc</li>
                    </ul>
                    <p class="mt-2 text-[12px] font-body text-brand-muted italic">*Thời gian giao hàng có thể thay đổi trong các dịp lễ, Tết hoặc do yếu tố thời tiết.</p>
                </div>

                <!-- 3. Phí vận chuyển -->
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">3. Phí vận chuyển</h2>
                    <ul class="space-y-1.5">
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Miễn phí vận chuyển cho đơn hàng từ 1.000.000 VNĐ trở lên</li>
                        <li class="text-[13px] font-body text-brand-text/80 leading-[1.8] flex items-start gap-2"><span class="text-brand-accent mt-1.5 shrink-0">•</span>Đơn hàng dưới 1.000.000 VNĐ: phí vận chuyển 30.000 VNĐ (nội thành) hoặc 50.000 VNĐ (ngoại thành)</li>
                    </ul>
                </div>

                <!-- 4. Đơn vị vận chuyển -->
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">4. Đơn vị vận chuyển</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Bagista hợp tác với các đơn vị vận chuyển uy tín như Giao Hàng Nhanh (GHN), Giao Hàng Tiết Kiệm (GHTK), J&T Express để đảm bảo sản phẩm được giao đến tay khách hàng an toàn và nhanh chóng.</p>
                </div>

                <!-- 5. Theo dõi đơn hàng -->
                <div class="border-l-2 border-brand-accent/30 pl-6">
                    <h2 class="text-[15px] font-display text-brand-text mb-3 tracking-wide">5. Theo dõi đơn hàng</h2>
                    <p class="text-[13px] font-body text-brand-text/80 leading-[1.9]">Sau khi đơn hàng được xác nhận và giao cho đơn vị vận chuyển, Bagista sẽ gửi mã vận đơn qua email hoặc SMS để khách hàng tiện theo dõi trạng thái đơn hàng.</p>
                </div>
            </div>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>
    </body>
</html>

