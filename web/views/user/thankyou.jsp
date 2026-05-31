<%-- 
    Document   : thankyou
    Created on : Mar 5, 2026, 9:05:44 PM
    Author     : laman
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Cảm ơn bạn</title>
        <style>
            /* ĐỒNG BỘ MÀU NỀN VÀ MÀU NÂU CHỦ ĐẠO */
            body {
                background-color: #FDFCFB;
            }
            .text-brown {
                color: #8B5E3C;
            }
            .bg-brown {
                background-color: #8B5E3C;
            }
            .btn-brown:hover {
                background-color: #704A30;
            }
        </style>
    </head>
    <body class="min-h-screen">
        <%-- Header --%>
        <c:set var="activePage" value="" scope="request" />
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-md mx-auto px-6 py-24 text-center">
            <%-- Icon thành công màu nâu --%>
            <div class="mb-8">
                <svg class="mx-auto w-16 h-16 text-brown" fill="none" stroke="currentColor" stroke-width="1" viewBox="0 0 24 24">
                <path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/>
                </svg>
            </div>

            <h1 class="text-[28px] font-display tracking-[0.3em] text-brand-text mb-4 uppercase">Cảm ơn bạn!</h1>

            <%-- HIỂN THỊ MÃ ĐƠN HÀNG NẾU CÓ --%>
            <c:if test="${not empty orderId}">
                <p class="text-[10px] tracking-[0.2em] uppercase text-brand-muted mb-2">Mã đơn hàng của bạn</p>
                <p class="text-[18px] font-display font-bold text-brown mb-8">#BA${orderId}</p>
            </c:if>

            <div class="space-y-4 mb-10">
                <p class="text-[14px] font-body text-brand-muted leading-relaxed">
                    Đơn hàng của bạn đã được tiếp nhận thành công. Bagista sẽ sớm liên hệ để xác nhận và giao hàng đến bạn.
                </p>
                <p class="text-[13px] font-body text-brand-muted">
                    Bạn có thể theo dõi trạng thái tại mục <strong>Lịch sử đơn hàng</strong>.
                </p>
            </div>

            <%-- HỆ THỐNG NÚT BẤM CHUẨN URL --%>
            <div class="flex flex-col sm:flex-row gap-4 justify-center">
                <a href="${pageContext.request.contextPath}/profile" 
                   class="bg-brown text-white px-10 py-4 text-[11px] tracking-[0.2em] uppercase font-bold hover:opacity-90 transition-all">
                    Xem đơn hàng
                </a>
                <a href="${pageContext.request.contextPath}/shop" 
                   class="border border-brand-border text-brand-text px-10 py-4 text-[11px] tracking-[0.2em] uppercase font-bold hover:bg-brand-secondary/50 transition-all">
                    Tiếp tục mua sắm
                </a>
            </div>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>
    </body>
</html>