<%-- 
    Document   : about
    Created on : Mar 5, 2026, 9:05:53 PM
    Author     : laman
--%>
<!--
  ============================================================
  BAGISTA — Về chúng tôi
  ============================================================
  File JSP: /about.jsp (trang tĩnh, không cần Servlet)
  ============================================================
-->

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--
============================================================
BAGISTA — Về chúng tôi
============================================================
File JSP: /about.jsp (trang tĩnh, không cần Servlet)
============================================================
-->
<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Chính sách bảo mật</title>
    </head>
    <body class="min-h-screen">
        <% request.setAttribute("activePage", ""); %>
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-3xl mx-auto px-6 py-20">
            <div class="text-center">
                <h1 class="text-[36px] font-display tracking-[0.25em] text-brand-text mb-4">VỀ CHÚNG TÔI</h1>
                <div class="w-12 h-px bg-brand-accent mx-auto mb-12"></div>
            </div>
            <div class="space-y-6 text-[14px] leading-[2] font-body text-brand-text/80">
                <p>Bagista là thương hiệu chuyên cung cấp các sản phẩm túi xách thời trang dành cho những người trẻ hiện đại, năng động và yêu thích phong cách tinh tế. Với mong muốn mang đến sự tự tin trong từng bước đi, Bagista không chỉ bán túi – mà còn mang đến một phong cách sống.</p>
                <p>Tại Bagista, mỗi sản phẩm đều được lựa chọn kỹ lưỡng từ chất liệu, kiểu dáng đến từng đường may, đảm bảo sự bền đẹp và tính ứng dụng cao trong cuộc sống hàng ngày. Dù bạn là sinh viên, nhân viên văn phòng hay người yêu thích thời trang, Bagista luôn có những thiết kế phù hợp với cá tính và nhu cầu của bạn.</p>
                <p>Chúng tôi tin rằng một chiếc túi tốt không chỉ để đựng đồ, mà còn thể hiện gu thẩm mỹ và bản sắc riêng. Vì vậy, Bagista luôn cập nhật xu hướng mới, kết hợp giữa sự tối giản và hiện đại để tạo nên những sản phẩm vừa thanh lịch vừa thực tế.</p>
                <p class="text-center text-[16px] italic font-display text-brand-accent mt-10">"Bagista – Mang phong cách theo cách của bạn."</p>
            </div>
        </section>
        <%@ include file="/views/includes/footer.jsp" %>
    </body>
</html>
