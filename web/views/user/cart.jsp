<%-- 
    Document   : cart
    Created on : Mar 5, 2026, 9:05:28 PM
    Author     : laman
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Giỏ hàng</title>
        <style>
            body { background: #FAF6F1; color: #3D2E22; font-family: 'Inter', sans-serif; }
            h1, h3 { font-family: 'Playfair Display', serif; }
        </style>
    </head>
    <body class="min-h-screen">
        <c:set var="activePage" value="cart" scope="request" />
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-4xl mx-auto px-6 py-12">
            <div class="text-center mb-10">
                <h1 class="text-[32px] font-display tracking-[0.25em] text-brand-text mb-2 uppercase font-bold">GIỎ HÀNG</h1>
                <div class="w-12 h-0.5 bg-brand-accent mx-auto"></div>
            </div>

            <c:choose>
                <%-- TRƯỜNG HỢP 1: GIỎ HÀNG TRỐNG --%>
                <c:when test="${empty cartItems}">
                    <div class="text-center py-20 bg-white border border-brand-border shadow-sm">
                        <p class="text-[14px] font-body text-brand-muted mb-6 uppercase tracking-widest">Giỏ hàng của bạn đang trống</p>
                        <a href="${pageContext.request.contextPath}/shop" class="inline-block bg-brand-text text-white px-10 py-4 text-[11px] uppercase tracking-[0.2em] font-bold hover:bg-brand-accent transition-colors">Mua ngay</a>
                    </div>
                </c:when>

                <%-- TRƯỜNG HỢP 2: CÓ SẢN PHẨM --%>
                <c:otherwise>
                    <div class="space-y-0 bg-white border border-brand-border shadow-sm px-8">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="flex items-center gap-6 py-10 border-b border-brand-border last:border-0 relative">
                                
                                <%-- 1. HIỂN THỊ ẢNH --%>
                                <div class="w-28 aspect-[3/4] bg-brand-secondary/50 overflow-hidden shrink-0 border border-brand-border">
                                    <c:set var="img" value="${item.productImage}" />
                                    <c:set var="displayImg" value="${img.startsWith('http') ? img : pageContext.request.contextPath.concat('/assets/images/products/').concat(img)}" />
                                    
                                    <a href="${pageContext.request.contextPath}/product?id=${item.productId}">
                                        <img src="${displayImg}" 
                                             alt="${item.productName}" 
                                             class="w-full h-full object-cover transition-transform duration-500 hover:scale-105"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.jpg'"/>
                                    </a>
                                </div>

                                <%-- 2. THÔNG TIN CHI TIẾT --%>
                                <div class="flex-1 flex flex-col h-full">
                                    <div class="mb-4">
                                        <h3 class="text-[15px] font-bold text-brand-text mb-2 uppercase tracking-wider">${item.productName}</h3>
                                        
                                        <div class="flex items-center gap-3">
                                            <span class="text-[14px] font-medium text-brand-text">${item.formattedPrice}</span>
                                            <c:if test="${item.hasDiscount}">
                                                <span class="text-[12px] text-brand-muted line-through opacity-50">${item.formattedOriginalPrice}</span>
                                            </c:if>
                                        </div>
                                        <p class="text-[11px] font-bold text-brand-muted mt-2 uppercase tracking-tighter opacity-70">${item.colorSizeLabel}</p>
                                    </div>

                                    <%-- NÚT TĂNG GIẢM SỐ LƯỢNG --%>
                                    <div class="flex items-center border border-brand-border w-fit">
                                        <form action="${pageContext.request.contextPath}/cart" method="POST" class="inline">
                                            <input type="hidden" name="action" value="update" />
                                            <input type="hidden" name="variantId" value="${item.variantId}" />
                                            <input type="hidden" name="quantity" value="${item.quantity - 1}" />
                                            <button type="submit" class="px-3 py-1 text-brand-text hover:bg-brand-accent hover:text-white transition-colors" ${item.quantity <= 1 ? 'disabled' : ''}>-</button>
                                        </form>
                                        
                                        <span class="px-5 py-1 text-[13px] font-bold border-x border-brand-border bg-faf6f1/30">${item.quantity}</span>
                                        
                                        <form action="${pageContext.request.contextPath}/cart" method="POST" class="inline">
                                            <input type="hidden" name="action" value="update" />
                                            <input type="hidden" name="variantId" value="${item.variantId}" />
                                            <input type="hidden" name="quantity" value="${item.quantity + 1}" />
                                            <button type="submit" class="px-3 py-1 text-brand-text hover:bg-brand-accent hover:text-white transition-colors">+</button>
                                        </form>
                                    </div>
                                </div>

                                <%-- 3. THÀNH TIỀN VÀ XÓA (PHẦN CẬP NHẬT MỚI) --%>
                                <div class="text-right flex flex-col justify-between items-end self-stretch">
                                    <div class="text-[16px] font-bold text-[#8B5E3C] tracking-tight">
                                        ${item.subtotalFormatted}
                                    </div>

                                    <form action="${pageContext.request.contextPath}/cart" method="POST">
                                        <input type="hidden" name="action" value="remove" />
                                        <input type="hidden" name="variantId" value="${item.variantId}" />
                                        <button type="submit" class="text-brand-muted hover:text-red-800 transition-colors p-1" title="Xóa khỏi giỏ hàng">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                            </svg>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <%-- TỔNG TIỀN VÀ THANH TOÁN --%>
                    <div class="mt-8 bg-white border border-brand-border shadow-sm p-8">
                        <div class="flex items-center justify-between mb-8 pb-6 border-b border-brand-border">
                            <span class="text-[12px] uppercase font-bold tracking-[0.2em] text-brand-muted">Tổng cộng giỏ hàng</span>
                            <span class="text-[20px] font-bold text-brand-text">${cartTotal}</span>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/checkout" 
                           class="block w-full bg-brand-text text-white py-5 text-center text-[11px] uppercase tracking-[0.3em] font-bold hover:bg-brand-accent transition-all duration-300">
                            Tiến hành thanh toán
                        </a>
                        
                        <div class="text-center mt-6">
                            <a href="${pageContext.request.contextPath}/shop" class="text-[10px] uppercase font-bold text-brand-muted hover:text-brand-text transition-colors tracking-widest underline underline-offset-4">
                                Tiếp tục mua sắm
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>
    </body>
</html>