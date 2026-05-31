<%-- 
    Document   : home
    Created on : Mar 5, 2026, 9:04:56 PM
    Author     : laman
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>BAGISTA — Trang chủ</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet" />
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {
                            display: ['"Playfair Display"', 'serif'],
                            body: ['"Inter"', 'sans-serif']
                        },
                        colors: {
                            brand: {
                                bg: '#FAF6F1',
                                card: '#FFFFFF',
                                border: '#E8DFD4',
                                text: '#3D2E22',
                                muted: '#8C7B6B',
                                accent: '#6B4C3B',
                                'accent-fg': '#FAF6F1',
                                secondary: '#F0E9E0'
                            }
                        }
                    }
                }
            }
        </script>
        <style>
            body {
                background:#FAF6F1;
                color:#3D2E22;
                font-family:'Inter',sans-serif;
            }
            h1,h2,h3,h4,h5,h6 {
                font-family:'Playfair Display',serif;
                font-weight: 400;
            } /* Làm mỏng tiêu đề theo gu của Lâm */
            .mobile-menu {
                max-height:0;
                overflow:hidden;
                transition:max-height 0.3s ease, opacity 0.3s ease;
                opacity:0;
            }
            .mobile-menu.open {
                max-height:400px;
                opacity:1;
            }
            .product-card:hover {
                transform:translateY(-4px);
            }
            .product-card img:hover {
                transform:scale(1.05);
            }
            .user-dropdown {
                display:none;
            }
            .user-dropdown.open {
                display:block;
            }
        </style>
    </head>
    <body class="min-h-screen">

        <c:set var="activePage" value="home" scope="request" />
        <%@ include file="/views/includes/header.jsp" %>

        <section class="relative h-[70vh] overflow-hidden">
            <img src="${pageContext.request.contextPath}/assets/images/products/bagista-hero.jpg" alt="BAGISTA collection" class="absolute inset-0 w-full h-full object-cover" />
            <div class="absolute inset-0 bg-black/30"></div>
            <div class="absolute inset-0 flex items-center justify-center text-center">
                <div class="animate-fadeIn">
                    <h1 class="text-[48px] md:text-[64px] font-display tracking-[0.3em] text-white mb-4 uppercase">BAGISTA</h1>
                    <p class="text-[13px] tracking-[0.3em] uppercase font-body text-white/80">Mang phong cách theo cách của bạn</p>
                    <div class="mt-8">
                        <a href="${pageContext.request.contextPath}/shop" class="inline-block border border-white text-white px-8 py-3 text-[11px] uppercase tracking-widest hover:bg-white hover:text-brand-text transition-all">Mua sắm ngay</a>
                    </div>
                </div>
            </div>
        </section>

        <section class="max-w-7xl mx-auto px-6 py-16">
            <div class="flex items-center gap-4 mb-10">
                <div class="flex-1 h-px bg-brand-border"></div>
                <h2 class="text-[14px] tracking-[0.25em] uppercase font-display text-brand-text font-bold">Sản phẩm mới</h2>
                <div class="flex-1 h-px bg-brand-border"></div>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                <c:forEach var="product" items="${newProducts}">
                    <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="product-card transition-transform duration-300 group">
                        <div class="aspect-[3/4] bg-white border border-brand-border overflow-hidden mb-4 relative shadow-sm">
                            <c:set var="img" value="${product.image}" />
                            <c:set var="displayImg" value="${img.startsWith('http') ? img : pageContext.request.contextPath.concat('/assets/images/products/').concat(img)}" />
                            <img src="${displayImg}" alt="${product.name}" class="w-full h-full object-cover transition-transform duration-500" />

                            <span class="absolute top-3 left-3 text-[9px] tracking-[0.2em] uppercase font-bold bg-brand-accent text-white px-3 py-1 shadow-md">Mới</span>

                            <c:if test="${product.discountPercent > 0}">
                                <span class="absolute top-3 right-3 text-[9px] font-bold bg-red-600 text-white px-2 py-0.5 rounded shadow-sm">-${product.discountPercent}%</span>
                            </c:if>
                        </div>
                        <h3 class="text-[13px] font-body tracking-wide text-brand-text mb-1 group-hover:text-brand-accent transition-colors">${product.name}</h3>

                        <c:choose>
                            <c:when test="${product.discountPercent > 0}">
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="text-[13px] font-bold text-red-600">${product.formattedSalePrice}</span>
                                    <span class="text-[11px] text-brand-muted line-through opacity-60">${product.formattedPrice}</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-[13px] font-bold text-brand-accent mb-1">${product.formattedPrice}</p>
                            </c:otherwise>
                        </c:choose>
                        <p class="text-[10px] font-body text-brand-muted">Đã bán: ${product.sold} · Kho: ${product.stock}</p>
                    </a>
                </c:forEach>
            </div>
        </section>

        <section class="max-w-7xl mx-auto px-6 py-16">
            <div class="flex items-center gap-4 mb-10">
                <div class="flex-1 h-px bg-brand-border"></div>
                <h2 class="text-[14px] tracking-[0.25em] uppercase font-display text-brand-text font-bold">Sản phẩm nổi bật</h2>
                <div class="flex-1 h-px bg-brand-border"></div>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                <c:forEach var="product" items="${hotProducts}">
                    <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="product-card transition-transform duration-300 group">
                        <div class="aspect-[3/4] bg-white border border-brand-border overflow-hidden mb-4 relative shadow-sm">
                            <c:set var="img" value="${product.image}" />
                            <c:set var="displayImg" value="${img.startsWith('http') ? img : pageContext.request.contextPath.concat('/assets/images/products/').concat(img)}" />
                            <img src="${displayImg}" alt="${product.name}" class="w-full h-full object-cover transition-transform duration-500" />

                            <span class="absolute top-3 left-3 text-[9px] tracking-[0.2em] uppercase font-bold bg-[#3F2A1D] text-white px-3 py-1 shadow-md">Hot</span>
                        </div>
                        <h3 class="text-[13px] font-body tracking-wide text-brand-text mb-1 group-hover:text-brand-accent transition-colors">${product.name}</h3>
                        <p class="text-[13px] font-bold text-brand-accent mb-1">${product.formattedPrice}</p>
                    </a>
                </c:forEach>
            </div>
        </section>

        <section class="max-w-7xl mx-auto px-6 py-16 mb-12">
            <div class="flex items-center gap-4 mb-10">
                <div class="flex-1 h-px bg-brand-border"></div>
                <h2 class="text-[14px] tracking-[0.25em] uppercase font-display text-brand-text font-bold">Bán chạy nhất</h2>
                <div class="flex-1 h-px bg-brand-border"></div>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                <c:forEach var="product" items="${bestsellerProducts}">
                    <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="product-card transition-transform duration-300 group">
                        <div class="aspect-[3/4] bg-white border border-brand-border overflow-hidden mb-4 relative shadow-sm">
                            <c:set var="img" value="${product.image}" />
                            <c:set var="displayImg" value="${img.startsWith('http') ? img : pageContext.request.contextPath.concat('/assets/images/products/').concat(img)}" />
                            <img src="${displayImg}" alt="${product.name}" class="w-full h-full object-cover transition-transform duration-500" />
                            <span class="absolute top-3 left-3 text-[9px] tracking-[0.2em] uppercase font-bold bg-brand-secondary text-brand-text px-3 py-1 shadow-md">Bestseller</span>
                        </div>
                        <h3 class="text-[13px] font-body tracking-wide text-brand-text mb-1 group-hover:text-brand-accent transition-colors">${product.name}</h3>
                        <p class="text-[13px] font-bold text-brand-accent mb-1">${product.formattedPrice}</p>
                        <p class="text-[10px] font-body text-brand-muted uppercase">Đã bán: ${product.sold}</p>
                    </a>
                </c:forEach>
            </div>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>

        <script>
            function toggleMobileMenu() {
                document.getElementById('mobileMenu').classList.toggle('open');
                document.getElementById('menuOpenIcon').classList.toggle('hidden');
                document.getElementById('menuCloseIcon').classList.toggle('hidden');
            }
            function toggleUserMenu() {
                const dropdown = document.getElementById('userDropdown');
                if (dropdown)
                    dropdown.classList.toggle('open');
            }
            document.addEventListener('click', function (e) {
                const dropdown = document.getElementById('userDropdown');
                if (dropdown && !e.target.closest('.relative'))
                    dropdown.classList.remove('open');
            });
        </script>
    </body>
</html>