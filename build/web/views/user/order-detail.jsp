<%-- 
    Document   : order-detail
    Created on : Mar 16, 2026, 3:09:10 PM
    Author     : laman
--%>

<<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Chi tiết đơn hàng</title>
        <style>
            body {
                background: #FAF6F1;
                color: #3D2E22;
                font-family: 'Inter', sans-serif;
            }
            h1, h2, h3 {
                font-family: 'Playfair Display', serif;
            }
            .tab-btn-active {
                background-color: rgba(240, 233, 224, 0.5);
                color: #3D2E22;
                border-right: 2px solid #6B4C3B;
            }
            /* Style cho khung chi tiết đơn hàng giống ảnh Lâm gửi */
            .order-container {
                background: white;
                border: 1px solid #E8DFD4;
                padding: 40px;
            }
            .status-tag {
                padding: 4px 12px;
                font-size: 10px;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 0.1em;
                border-radius: 4px;
            }
        </style>
    </head>
    <body class="min-h-screen">

        <c:set var="activePage" value="profile" scope="request" />
        <%@ include file="/views/includes/header.jsp" %>

        <div class="max-w-7xl mx-auto px-6 py-12">

            <div class="max-w-5xl mx-auto flex flex-col md:flex-row gap-8">

                <%-- SIDEBAR (Giữ y nguyên profile.jsp của Lâm) --%>
                <aside class="md:w-64 shrink-0">
                    <div class="border border-brand-border bg-white p-5 mb-4 shadow-sm">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-full bg-brand-secondary flex items-center justify-center border border-brand-border">
                                <span class="text-[14px] font-bold text-brand-accent uppercase">
                                    <c:out value="${not empty user.fullName ? user.fullName.substring(0,1) : user.username.substring(0,1)}" />
                                </span>
                            </div>
                            <div class="overflow-hidden">
                                <p class="text-[13px] font-bold text-brand-text truncate uppercase text-left">
                                    <c:out value="${not empty user.fullName ? user.fullName : user.username}" />
                                </p>
                                <p class="text-[11px] font-medium text-brand-muted truncate text-left">
                                    <c:out value="${not empty user.email ? user.email : 'Chưa cập nhật email'}" />
                                </p>
                            </div>
                        </div>
                    </div>

                    <nav class="border border-brand-border bg-white shadow-sm">
                        <a href="profile?tab=info" class="w-full flex items-center gap-3 px-5 py-3.5 text-[11px] font-bold uppercase tracking-widest text-brand-muted hover:bg-brand-bg transition-all">
                            Thông tin cá nhân
                        </a>
                        <a href="profile?tab=orders" class="tab-btn-active w-full flex items-center gap-3 px-5 py-3.5 text-[11px] font-bold uppercase tracking-widest transition-all">
                            Lịch sử đơn hàng
                        </a>
                        <a href="profile?tab=password" class="w-full flex items-center gap-3 px-5 py-3.5 text-[11px] font-bold uppercase tracking-widest text-brand-muted hover:bg-brand-bg transition-all">
                            Đổi mật khẩu
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="w-full flex items-center gap-3 px-5 py-3.5 text-[11px] font-bold uppercase tracking-widest text-red-500 border-t border-brand-border hover:bg-red-50 transition-all">
                            Đăng xuất
                        </a>
                    </nav>
                </aside>

                <%-- NỘI DUNG CHI TIẾT ĐƠN HÀNG (MAIN) --%>
                <main class="flex-1">
                    <%-- Nút quay lại nhỏ ở trên --%>
                    <div class="mb-4">
                        <a href="profile?tab=orders" class="text-[11px] text-brand-muted hover:text-brand-text uppercase tracking-widest transition-colors">
                            ← Quay lại
                        </a>
                    </div>

                    <div class="order-container shadow-sm">
                        <%-- Header: Mã đơn và Trạng thái --%>
                        <div class="flex justify-between items-start mb-10">
                            <h2 class="text-[20px] tracking-widest text-brand-text uppercase font-display">ORD${order.id}</h2>
                            <span class="status-tag
                                  ${order.status == 'Chờ xử lý' ? 'bg-blue-100 text-blue-700' : ''}
                                  ${order.status == 'Đã hủy' ? 'bg-red-100 text-red-700' : ''}
                                  ${order.status == 'Đã giao' ? 'bg-green-100 text-green-700' : ''}
                                  ">
                                ${order.status}
                            </span>
                        </div>

                        <%-- Thông tin chi tiết --%>
                        <div class="space-y-2 mb-10 text-[13px] text-brand-text">
                            <p><span class="text-brand-muted">Thời gian đặt:</span> ${order.datetime}</p>
                            <p><span class="text-brand-muted">Người nhận:</span> ${order.recipientName}</p>
                            <p><span class="text-brand-muted">SĐT:</span> ${order.recipientPhone}</p>
                            <p><span class="text-brand-muted">Địa chỉ:</span> ${order.recipientAddress}</p>
                        </div>

                        <%-- Danh sách sản phẩm (Dòng kẻ ngang thanh mảnh) --%>
                        <div class="border-t border-brand-border pt-6 space-y-6">
                            <c:forEach var="item" items="${details}">
                                <div class="flex justify-between items-end pb-4 border-b border-brand-border last:border-0 group">
                                    <div>
                                        <p class="text-[14px] font-bold uppercase text-brand-text mb-1">${item.productName}</p>
                                        <p class="text-[11px] text-brand-muted uppercase tracking-wider">
                                            ${item.colorSizeLabel} · x${item.quantity}
                                        </p>
                                    </div>
                                    <p class="text-[14px] font-bold text-brand-text">${item.formattedPrice}</p>
                                </div>
                            </c:forEach>
                        </div>

                        <%-- Tổng tiền --%>
                        <div class="mt-8 pt-6 flex justify-between items-center">
                            <span class="text-[12px] uppercase tracking-[0.2em] font-bold text-brand-muted">Tổng cộng</span>
                            <span class="text-[20px] font-display text-brand-text font-bold">${order.totalFormatted}</span>
                        </div>

                        <%-- NÚT HỦY ĐƠN HÀNG (MÀU ĐỎ NHẠT/TINH TẾ) --%>
                        <c:if test="${order.status == 'Chờ xử lý'}">
                            <form action="order-detail" method="POST" class="mt-12" onsubmit="return confirm('Bạn có chắc chắn muốn huỷ đơn hàng này? Hàng sẽ được hoàn trả về kho.')">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="id" value="${order.id}">
                                <button type="submit" class="w-full py-4 border border-red-500 text-red-600 text-[11px] uppercase font-bold tracking-[0.2em] hover:bg-red-600 hover:text-white transition-all duration-300">
                                    Huỷ đơn hàng
                                </button>
                            </form>
                        </c:if>
                    </div>
                </main>
            </div>
        </div>

        <%@ include file="/views/includes/footer.jsp" %>
    </body>
</html>