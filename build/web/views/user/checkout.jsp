<%-- 
    Document   : check-out
    Created on : Mar 9, 2026, 5:47:34 PM
    Author     : laman
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Thanh toán</title>
        <style>
            body {
                background-color: #FDFCFB;
            }
            .input-line {
                display: block;
                width: 100%;
                padding: 1.5rem 0.5rem;
                font-size: 14px;
                font-weight: 600;
                letter-spacing: 0.05em;
                color: #262626;
                border-bottom: 2px solid #e5e5e5;
                background-color: transparent;
                outline: none;
                transition: all 0.3s ease;
            }
            .input-line:focus {
                border-bottom-color: #8B5E3C;
            }
            .label-title {
                font-size: 11px;
                font-weight: 700;
                letter-spacing: 0.18em;
                text-transform: uppercase;
                color: #737373;
                margin-bottom: 0.75rem;
                display: block;
            }
            .btn-checkout {
                background-color: #8B5E3C;
                color: #ffffff;
                font-weight: 700;
                font-size: 13px;
                transition: background-color 0.3s ease;
            }
            .btn-checkout:hover {
                background-color: #704A30;
            }
            #bank-info-box {
                display: none;
                animation: slideDown 0.4s ease-out forwards;
            }
            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body class="min-h-screen">
        <c:set var="activePage" value="checkout" scope="request" />
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-5xl mx-auto px-6 py-16">
            <div class="text-center mb-14">
                <h1 class="text-[32px] font-display font-bold tracking-[0.3em] text-brand-text mb-3 uppercase">Thanh toán</h1>
                <div class="w-12 h-0.5 bg-[#8B5E3C] mx-auto"></div>
            </div>

            <div class="grid md:grid-cols-5 gap-16">
                <form action="${pageContext.request.contextPath}/checkout" method="POST" class="md:col-span-3 space-y-10">
                    <div>
                        <label class="label-title">Tên người nhận <span class="text-brand-destructive">*</span></label>
                        <input type="text" name="recipientName" value="${sessionScope.user.fullName}" placeholder="Nguyễn Văn A" class="input-line" required />
                    </div>
                    <div>
                        <label class="label-title">Số điện thoại <span class="text-brand-destructive">*</span></label>
                        <input type="tel" name="phone" value="${sessionScope.user.phone}" placeholder="0912 345 678" class="input-line" required />
                    </div>
                    <div>
                        <label class="label-title">Địa chỉ giao hàng <span class="text-brand-destructive">*</span></label>
                        <input type="text" name="address" value="${sessionScope.user.address}" placeholder="Số nhà, tên đường..." class="input-line" required />
                    </div>

                    <div>
                        <label class="label-title">Phương thức thanh toán <span class="text-brand-destructive">*</span></label>
                        <div class="grid grid-cols-1 gap-4 mt-4">
                            <label class="flex items-center gap-4 border-2 border-brand-border p-6 cursor-pointer hover:border-[#8B5E3C] transition-all bg-white" onclick="toggleBankInfo(false)">
                                <input type="radio" name="payment" value="cod" class="accent-[#8B5E3C] w-5 h-5" checked required /> 
                                <span class="text-[12px] font-bold tracking-wider uppercase">Thanh toán khi nhận hàng (COD)</span>
                            </label>
                            <label class="flex items-center gap-4 border-2 border-brand-border p-6 cursor-pointer hover:border-[#8B5E3C] transition-all bg-white" onclick="toggleBankInfo(true)">
                                <input type="radio" name="payment" value="bank" class="accent-[#8B5E3C] w-5 h-5" /> 
                                <span class="text-[12px] font-bold tracking-wider uppercase">Chuyển khoản ngân hàng</span>
                            </label>
                        </div>

                        <div id="bank-info-box" class="mt-4 p-8 bg-white border-2 border-[#8B5E3C] shadow-lg">
                            <h4 class="text-[12px] tracking-[0.1em] font-bold text-[#8B5E3C] mb-6 uppercase">Thông tin chuyển khoản</h4>
                            <div class="flex flex-col md:flex-row gap-10 items-center">
                                <div class="w-56 h-56 border-2 border-brand-border p-2 bg-white shrink-0">
                                    <img src="https://img.vietqr.io/image/MB-0123456789-compact2.jpg?amount=${cartTotalRaw}&addInfo=BGS%20${sessionScope.user.id}" 
                                         alt="VietQR" class="w-full h-full object-contain">
                                </div>
                                <div class="flex-1 space-y-4 text-[13px] font-body w-full">
                                    <p class="flex justify-between border-b border-brand-border pb-2"><span>Ngân hàng:</span> <span class="font-bold text-brand-text">MB Bank</span></p>
                                    <p class="flex justify-between border-b border-brand-border pb-2"><span>Số tài khoản:</span> <span class="font-bold text-lg text-brand-text">0123456789</span></p>
                                    <p class="flex justify-between border-b border-brand-border pb-2"><span>Chủ tài khoản:</span> <span class="font-bold uppercase text-brand-text">BAGISTA VIETNAM</span></p>
                                    <p class="flex justify-between font-bold text-[#8B5E3C] text-lg"><span>Số tiền:</span> <span>${cartTotal}</span></p>
                                    <div class="pt-4 mt-2">
                                        <p class="text-[11px] font-medium leading-relaxed p-4 bg-[#FDFCFB] border border-brand-border/50">
                                            * Đơn hàng sẽ được xác nhận trong vòng <span class="font-bold text-[#8B5E3C]">1 giờ</span> sau khi chuyển khoản thành công. 
                                            Thông báo xác nhận sẽ được gửi qua <span class="font-bold text-[#8B5E3C]">số điện thoại</span> bạn đã cung cấp.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="w-full btn-checkout py-6 text-[12px] tracking-[0.3em] uppercase font-bold mt-6 shadow-sm">
                        Xác nhận đặt hàng
                    </button>
                </form>

                <div class="md:col-span-2">
                    <div class="bg-white p-8 border-2 border-brand-border sticky top-24 shadow-sm">
                        <h3 class="text-[12px] tracking-[0.2em] font-bold uppercase text-brand-text mb-8 border-b-2 pb-4">Đơn hàng của bạn</h3>
                        <div class="space-y-6 mb-8 max-h-[500px] overflow-y-auto pr-2 custom-scrollbar">
                            <c:forEach var="item" items="${cartItems}">
                                <div class="flex gap-4 border-b border-brand-border/50 pb-4 last:border-0">
                                    <div class="w-20 h-24 bg-neutral-50 overflow-hidden shrink-0">
                                        <c:set var="img" value="${item.productImage}" />
                                        <c:set var="displayImg" value="${img.startsWith('http') ? img : (pageContext.request.contextPath.concat('/assets/images/products/').concat(img))}" />
                                        <img src="${displayImg}" class="w-full h-full object-cover" />
                                    </div>
                                    <div class="flex-1">
                                        <p class="text-[12px] font-bold uppercase tracking-wider text-brand-text truncate">${item.productName}</p>
                                        <p class="text-[11px] font-medium text-brand-muted mt-1 uppercase">${item.colorSizeLabel}</p>
                                        <div class="flex justify-between items-center mt-4">
                                            <span class="text-[11px] font-bold">SL: ${item.quantity}</span>
                                            <span class="text-[14px] font-bold text-[#8B5E3C]">${item.subtotalFormatted}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="border-t-2 pt-6 flex justify-between items-center">
                            <span class="text-[12px] font-bold tracking-[0.2em] uppercase text-brand-muted">Tổng cộng</span>
                            <span class="text-[24px] font-display font-bold text-[#8B5E3C]">${cartTotal}</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%@ include file="/views/includes/footer.jsp" %>
        <script>function toggleBankInfo(show) {
                document.getElementById('bank-info-box').style.display = show ? 'block' : 'none';
            }</script>
    </body>
</html>