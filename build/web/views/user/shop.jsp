<%-- 
    Document   : shop
    Created on : Mar 5, 2026, 9:05:05 PM
    Author     : laman
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ include file="/views/includes/head.jsp" %>
        <title>BAGISTA — Cửa hàng</title>
        <style>
            body {
                background:#FAF6F1;
                color:#3D2E22;
                font-family:'Inter',sans-serif;
            }
            h1,h2,h3 {
                font-family:'Playfair Display',serif;
            }
            .product-card:hover {
                transform:translateY(-4px);
            }
            .filter-checkbox:checked + span {
                background-color: #6B4C3B;
                color: #FAF6F1;
                border-color: #6B4C3B;
            }
        </style>
    </head>
    <body class="min-h-screen">

        <c:set var="activePage" value="shop" scope="request" />
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-7xl mx-auto px-6 py-12">
            <div class="text-center mb-10">
                <h1 class="text-[32px] font-display tracking-[0.25em] text-brand-text mb-2 uppercase font-bold">MUA NGAY</h1>
                <div class="w-12 h-0.5 bg-brand-accent mx-auto"></div>
            </div>

            <div class="flex flex-col md:flex-row gap-10">
                <aside class="w-full md:w-64 shrink-0">
                    <form action="${pageContext.request.contextPath}/shop" method="GET" class="space-y-8 sticky top-24">
                        <input type="hidden" name="sort" value="${filterSort}" />

                        <!-- Bổ sung ô tìm kiếm khớp với tham số 'search' ở Backend -->
                        <div>
                            <h4 class="text-[10px] tracking-[0.2em] uppercase font-bold font-body text-brand-text mb-4 border-b border-brand-border pb-2">Tìm kiếm</h4>
                            <input type="text" name="search" value="${searchKeyword}" 
                                   placeholder="Tên túi xách..."
                                   class="w-full bg-white border border-brand-border px-4 py-3 text-[12px] focus:outline-none focus:border-brand-accent transition-all">
                        </div>

                        <div>
                            <h4 class="text-[10px] tracking-[0.2em] uppercase font-bold font-body text-brand-text mb-4 border-b border-brand-border pb-2">Danh mục</h4>
                            <div class="flex flex-col gap-3">
                                <c:forEach var="cat" items="${categories}">
                                    <label class="flex items-center gap-3 cursor-pointer group">
                                        <input type="checkbox" name="category" value="${cat.name}" 
                                               class="w-4 h-4 accent-brand-accent cursor-pointer"
                                               <c:forEach var="v" items="${paramValues.category}">
                                                   <c:if test="${v == cat.name}">checked</c:if>
                                               </c:forEach> />
                                        <span class="text-[12px] font-medium font-body text-brand-muted group-hover:text-brand-text uppercase transition-colors">
                                            ${cat.name}
                                        </span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>

                        <div>
                            <h4 class="text-[10px] tracking-[0.2em] uppercase font-bold font-body text-brand-text mb-4 border-b border-brand-border pb-2">Màu sắc</h4>
                            <div class="grid grid-cols-2 gap-2">
                                <c:forEach var="color" items="${colors}">
                                    <label class="cursor-pointer">
                                        <input type="checkbox" name="color" value="${color}" class="hidden peer"
                                               <c:forEach var="v" items="${paramValues.color}">
                                                   <c:if test="${v == color}">checked</c:if>
                                               </c:forEach> />
                                        <span class="block text-center text-[10px] font-bold font-body px-2 py-2 border border-brand-border text-brand-muted uppercase transition-all peer-checked:bg-brand-accent peer-checked:text-white peer-checked:border-brand-accent hover:border-brand-text">
                                            ${color}
                                        </span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>

                        <div>
                            <h4 class="text-[10px] tracking-[0.2em] uppercase font-bold font-body text-brand-text mb-4 border-b border-brand-border pb-2">Chất liệu</h4>
                            <div class="flex flex-col gap-3">
                                <c:forEach var="mat" items="${materials}">
                                    <label class="flex items-center gap-3 cursor-pointer group">
                                        <input type="checkbox" name="material" value="${mat}" 
                                               class="w-4 h-4 accent-brand-accent cursor-pointer"
                                               <c:forEach var="v" items="${paramValues.material}">
                                                   <c:if test="${v == mat}">checked</c:if>
                                               </c:forEach> />
                                        <span class="text-[12px] font-medium font-body text-brand-muted group-hover:text-brand-text uppercase">
                                            ${mat}
                                        </span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="pt-6 space-y-3">
                            <button type="submit" class="w-full bg-brand-text text-white py-3 text-[11px] font-bold uppercase tracking-[0.2em] hover:bg-brand-accent transition-colors shadow-sm">
                                Áp dụng bộ lọc
                            </button>
                            <div class="text-center">
                                <a href="${pageContext.request.contextPath}/shop" 
                                   class="inline-block text-[10px] font-bold text-brand-muted hover:text-brand-accent transition-colors uppercase tracking-[0.15em] underline underline-offset-4">
                                    XÓA TẤT CẢ
                                </a>
                            </div>
                        </div>
                    </form>
                </aside>

                <div class="flex-1">
                    <div class="flex items-center justify-between mb-8 pb-4 border-b border-brand-border/50">
                        <p class="text-[12px] font-bold font-body text-brand-muted uppercase tracking-widest">
                            Hiển thị <span class="text-brand-text">${totalProducts}</span> sản phẩm
                            <c:if test="${not empty searchKeyword}"> cho "<span class="italic text-brand-text">${searchKeyword}</span>"</c:if>
                        </p>
                        <form action="${pageContext.request.contextPath}/shop" method="GET" class="flex items-center gap-2">
                            <!-- Giữ tham số tìm kiếm khi sort -->
                            <input type="hidden" name="search" value="${searchKeyword}">
                            <c:forEach var="c" items="${paramValues.category}"><input type="hidden" name="category" value="${c}"></c:forEach>
                            <c:forEach var="co" items="${paramValues.color}"><input type="hidden" name="color" value="${co}"></c:forEach>
                            <c:forEach var="m" items="${paramValues.material}"><input type="hidden" name="material" value="${m}"></c:forEach>

                            <select name="sort" onchange="this.form.submit()" class="bg-white border border-brand-border text-[11px] font-bold font-body px-4 py-2 focus:outline-none focus:border-brand-accent cursor-pointer uppercase">
                                <option value="newest" ${filterSort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                                <option value="price-asc" ${filterSort == 'price-asc' ? 'selected' : ''}>Giá tăng dần</option>
                                <option value="price-desc" ${filterSort == 'price-desc' ? 'selected' : ''}>Giá giảm dần</option>
                            </select>
                        </form>
                    </div>

                    <div class="grid grid-cols-2 lg:grid-cols-3 gap-8">
                        <c:forEach var="product" items="${products}">
                            <div class="product-card transition-all duration-300">
                                <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="block group">
                                    <div class="aspect-[3/4] bg-white border border-brand-border overflow-hidden mb-4 relative shadow-sm">
                                        <c:set var="img" value="${product.image}" />
                                        <c:set var="displayImg" value="${img.startsWith('http') ? img : pageContext.request.contextPath.concat('/assets/images/products/').concat(img)}" />
                                        <img src="${displayImg}" alt="${product.name}" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" />
                                        <c:if test="${product.discountPercent > 0}">
                                            <span class="absolute top-4 right-4 text-[9px] font-bold bg-red-600 text-white px-2 py-1 shadow-md">-${product.discountPercent}%</span>
                                        </c:if>
                                    </div>
                                    <h3 class="text-[13px] font-bold tracking-widest text-brand-text mb-1 uppercase group-hover:text-brand-accent transition-colors">${product.name}</h3>
                                    <c:choose>
                                        <c:when test="${product.discountPercent > 0}">
                                            <div class="flex items-center gap-2 mb-2">
                                                <p class="text-[14px] font-bold text-[#8B5E3C]">${product.formattedSalePrice}</p>
                                                <p class="text-[11px] text-brand-muted line-through opacity-60">${product.formattedPrice}</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-[14px] font-bold text-[#8B5E3C] mb-2">${product.formattedPrice}</p>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="flex items-center justify-between opacity-80">
                                        <p class="text-[9px] font-bold text-brand-muted uppercase">Đã bán: ${product.sold}</p>
                                        <p class="text-[9px] font-bold text-yellow-700">⭐ ${product.rating}</p>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>

                    <c:if test="${totalPages > 1}">
                        <div class="flex items-center justify-center gap-3 mt-16">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:url var="pageUrl" value="/shop">
                                    <c:param name="page" value="${i}" />
                                    <c:param name="search" value="${searchKeyword}" />
                                    <c:param name="sort" value="${filterSort}" />
                                    <c:forEach var="c" items="${paramValues.category}"><c:param name="category" value="${c}" /></c:forEach>
                                    <c:forEach var="co" items="${paramValues.color}"><c:param name="color" value="${co}" /></c:forEach>
                                    <c:forEach var="m" items="${paramValues.material}"><c:param name="material" value="${m}" /></c:forEach>
                                </c:url>
                                <a href="${pageUrl}" class="w-10 h-10 text-[11px] font-bold border flex items-center justify-center transition-all ${i == currentPage ? 'border-brand-accent bg-brand-accent text-white shadow-md' : 'border-brand-border bg-white text-brand-muted hover:border-brand-accent'}">${i}</a>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>
    </body>
</html>