<%-- 
    Document   : product-detail
    Created on : Mar 5, 2026, 9:05:20 PM
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
        <title>BAGISTA — ${product.name}</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet" />
        <script>
            tailwind.config = {theme: {extend: {
                        fontFamily: {display: ['"Playfair Display"', 'serif'], body: ['"Inter"', 'sans-serif']},
                        colors: {brand: {bg: '#FAF6F1', card: '#FFFFFF', border: '#E8DFD4', text: '#3D2E22', muted: '#8C7B6B', accent: '#6B4C3B', 'accent-fg': '#FAF6F1', secondary: '#F0E9E0', destructive: '#DC2626'}}
                    }}}
        </script>
        <style>
            body {
                background:#FAF6F1;
                color:#3D2E22;
                font-family:'Inter',sans-serif;
            }
            h1,h2,h3 {
                font-family:'Playfair Display',serif;
            }
            .option-btn {
                border:1px solid #E8DFD4;
                padding:8px 16px;
                font-size:12px;
                cursor:pointer;
                text-transform:capitalize;
                transition:all 0.2s;
                background:white;
            }
            .option-btn:hover {
                border-color:#6B4C3B;
            }
            .option-btn.selected {
                background:#6B4C3B;
                color:#FAF6F1;
                border-color:#6B4C3B;
            }
            .thumb-btn {
                border:1px solid #E8DFD4;
                cursor:pointer;
                transition:border-color 0.2s;
                background:white;
            }
            .thumb-btn.active {
                border-color:#6B4C3B;
            }
        </style>
    </head>
    <body class="min-h-screen">

        <c:set var="activePage" value="shop" scope="request" />
        <%@ include file="/views/includes/header.jsp" %>

        <section class="max-w-6xl mx-auto px-6 py-12">
            <a href="${pageContext.request.contextPath}/shop" class="inline-flex items-center gap-2 text-[12px] font-bold font-body text-brand-muted hover:text-brand-text mb-8 uppercase tracking-widest transition-colors">
                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
                Quay lại cửa hàng
            </a>

            <div class="grid md:grid-cols-2 gap-12">
                <%-- TRÁI: HÌNH ẢNH --%>
                <div>
                    <div class="aspect-[3/4] bg-white border border-brand-border overflow-hidden mb-3 shadow-sm" id="mainImageContainer">
                        <c:set var="img" value="${product.image}" />
                        <c:set var="displayImg" value="${img.startsWith('http') ? img : pageContext.request.contextPath.concat('/assets/images/products/').concat(img)}" />
                        <img id="mainImage" src="${displayImg}" alt="${product.name}" class="w-full h-full object-cover transition-opacity duration-300" />
                    </div>

                    <c:if test="${not empty product.images}">
                        <div class="grid grid-cols-5 gap-2" id="thumbnails">
                            <c:forEach var="tImg" items="${product.images}" varStatus="i">
                                <c:set var="tDisplay" value="${tImg.startsWith('http') ? tImg : pageContext.request.contextPath.concat('/assets/images/products/').concat(tImg)}" />
                                <button type="button" onclick="selectImage(this, '${tDisplay}')" class="thumb-btn aspect-square overflow-hidden ${i.index == 0 ? 'active' : ''}">
                                    <img src="${tDisplay}" class="w-full h-full object-cover" />
                                </button>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>

                <%-- PHẢI: THÔNG TIN CHI TIẾT --%>
                <div class="flex flex-col">
                    <c:if test="${product.discountPercent > 0}">
                        <span class="text-[9px] tracking-[0.2em] uppercase font-bold bg-red-600 text-white px-3 py-1 self-start mb-4 shadow-sm">Ưu đãi -${product.discountPercent}%</span>
                    </c:if>

                    <h1 class="text-[32px] font-display tracking-[0.1em] text-brand-text mb-2 uppercase font-bold">${product.name}</h1>

                    <div class="flex items-center gap-1 mb-6 text-[#8B5E3C] font-bold text-[13px] tracking-wide">
                        ⭐ ${avgRating}/5 (${reviewCount} đánh giá)
                    </div>

                    <div class="mb-8">
                        <c:choose>
                            <c:when test="${product.discountPercent > 0}">
                                <div class="flex items-baseline gap-4">
                                    <span class="text-[28px] font-display text-[#8B5E3C] font-bold">${product.formattedSalePrice}</span>
                                    <span class="text-[18px] font-body text-brand-muted line-through opacity-60">${product.formattedPrice}</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <span class="text-[28px] font-display text-[#8B5E3C] font-bold">${product.formattedPrice}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="space-y-4 mb-10 border-t border-brand-border pt-6">
                        <div class="flex gap-3"><span class="text-[10px] tracking-[0.15em] uppercase font-bold text-brand-muted w-24">Danh mục:</span><span class="text-[13px] font-semibold text-brand-text uppercase">${product.categoryName}</span></div>
                        <div class="flex gap-3"><span class="text-[10px] tracking-[0.15em] uppercase font-bold text-brand-muted w-24">Chất liệu:</span><span class="text-[13px] font-semibold text-brand-text uppercase">${product.materialName}</span></div>
                        <div class="flex gap-3">
                            <span class="text-[10px] tracking-[0.15em] uppercase font-bold text-brand-muted w-24">Tình trạng:</span>
                            <%-- ID stock-display để JS cập nhật --%>
                            <span id="stock-display" class="text-[13px] font-semibold ${product.stock > 0 ? 'text-green-600' : 'text-red-600'}">
                                ${product.stock > 0 ? 'Còn hàng' : 'Hết hàng'} (${product.stock})
                            </span>
                        </div>
                    </div>

                    <%-- Form giỏ hàng --%>
                    <form action="${pageContext.request.contextPath}/cart" method="POST" onsubmit="return validateSelection()">
                        <input type="hidden" name="action" value="add" />
                        <input type="hidden" name="productId" value="${product.id}" />
                        <input type="hidden" name="variantId" id="selectedVariantId" value="" /> <%-- THÊM VariantId --%>
                        <input type="hidden" name="color" id="selectedColor" value="" />
                        <input type="hidden" name="size" id="selectedSize" value="" />

                        <c:if test="${not empty product.colors}">
                            <div class="mb-6">
                                <span class="text-[10px] tracking-[0.15em] uppercase font-bold text-brand-muted block mb-3">Màu sắc <span class="text-brand-destructive">*</span></span>
                                <div class="flex flex-wrap gap-3" id="colorOptions">
                                    <c:forEach var="c" items="${product.colors}">
                                        <button type="button" class="option-btn font-bold" onclick="selectColor(this, '${c}')">${c}</button>
                                    </c:forEach>
                                </div>
                                <p class="text-[11px] font-bold text-brand-destructive mt-2 hidden" id="colorError">! Vui lòng chọn màu sắc</p>
                            </div>
                        </c:if>

                        <c:if test="${not empty product.sizes}">
                            <div class="mb-8">
                                <span class="text-[10px] tracking-[0.15em] uppercase font-bold text-brand-muted block mb-3">Kích cỡ <span class="text-brand-destructive">*</span></span>
                                <div class="flex flex-wrap gap-3" id="sizeOptions">
                                    <c:forEach var="s" items="${product.sizes}">
                                        <button type="button" class="option-btn font-bold" onclick="selectSize(this, '${s}')">${s}</button>
                                    </c:forEach>
                                </div>
                                <p class="text-[11px] font-bold text-brand-destructive mt-2 hidden" id="sizeError">! Vui lòng chọn kích cỡ</p>
                            </div>
                        </c:if>

                        <div class="flex items-center gap-6 mb-8">
                            <span class="text-[10px] tracking-[0.15em] uppercase font-bold text-brand-muted">Số lượng:</span>
                            <div class="flex items-center border border-brand-border bg-white shadow-sm">
                                <button type="button" onclick="changeQty(-1)" class="px-4 py-2 text-brand-text hover:bg-neutral-100 font-bold">−</button>
                                <input type="number" name="quantity" id="qtyInput" value="1" min="1" max="${product.stock}" class="w-12 text-center text-[13px] font-bold text-brand-text bg-transparent border-none focus:outline-none" />
                                <button type="button" onclick="changeQty(1)" class="px-4 py-2 text-brand-text hover:bg-neutral-100 font-bold">+</button>
                            </div>
                        </div>

                        <button id="addToCartBtn" type="submit" ${product.stock <= 0 ? 'disabled' : ''} class="w-full flex items-center justify-center gap-4 bg-[#8B5E3C] text-white py-5 text-[12px] tracking-[0.3em] uppercase font-bold hover:bg-[#704A30] transition-all disabled:bg-gray-400 shadow-md">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 01-8 0"/></svg>
                            <span id="btnText">${product.stock > 0 ? 'Thêm vào giỏ hàng' : 'Hết hàng'}</span>
                        </button>
                    </form>
                </div>
            </div>

            <%-- PHẦN ĐÁNH GIÁ (GIỮ NGUYÊN) --%>
            <div class="mt-24 border-t border-brand-border pt-16">
                <h2 class="text-[20px] font-display tracking-[0.2em] text-brand-text mb-12 uppercase font-bold border-b border-brand-border pb-4 inline-block">Đánh giá khách hàng</h2>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <form action="${pageContext.request.contextPath}/review" method="POST" class="bg-white border border-brand-border p-10 mb-16 shadow-sm">
                            <input type="hidden" name="productId" value="${product.id}" />
                            <p class="text-[11px] font-bold uppercase tracking-widest text-brand-muted mb-6">Viết đánh giá của bạn</p>
                            <div class="flex flex-col gap-8">
                                <div class="flex items-center gap-6">
                                    <span class="text-[11px] font-bold uppercase text-brand-text">Xếp hạng:</span>
                                    <select name="rating" class="text-[13px] font-bold border border-brand-border px-4 py-2 bg-brand-bg outline-none focus:border-[#8B5E3C]">
                                        <option value="5">⭐⭐⭐⭐⭐ 5/5 Tuyệt vời</option>
                                        <option value="4">⭐⭐⭐⭐ 4/5 Hài lòng</option>
                                        <option value="3">⭐⭐⭐ 3/5 Bình thường</option>
                                        <option value="2">⭐⭐ 2/5 Tạm được</option>
                                        <option value="1">⭐ 1/5 Không tốt</option>
                                    </select>
                                </div>
                                <div class="flex flex-col md:flex-row gap-4">
                                    <input type="text" name="comment" placeholder="Chia sẻ cảm nhận của bạn về chiếc túi này..." class="flex-1 bg-transparent border-b border-brand-border py-3 text-[14px] font-medium text-brand-text focus:border-[#8B5E3C] focus:outline-none" required />
                                    <button type="submit" class="bg-brand-text text-white px-10 py-3 text-[11px] font-bold uppercase tracking-[0.2em] hover:bg-brand-accent transition-colors">Gửi</button>
                                </div>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="bg-white border border-dashed border-brand-border p-10 mb-16 text-center shadow-sm">
                            <p class="text-[14px] font-medium text-brand-muted mb-6">Vui lòng đăng nhập để chia sẻ trải nghiệm về sản phẩm.</p>
                            <a href="${pageContext.request.contextPath}/login" class="inline-block bg-brand-text text-white px-10 py-3 text-[11px] font-bold uppercase tracking-[0.2em] hover:bg-brand-accent transition-all shadow-md">Đăng nhập ngay</a>
                        </div>
                    </c:otherwise>
                </c:choose>

                <%-- DANH SÁCH REVIEW (GIỮ NGUYÊN) --%>
                <div class="space-y-10">
                    <c:choose>
                        <c:when test="${empty reviews}"><div class="text-center py-16"><p class="text-[14px] italic text-brand-muted">Sản phẩm chưa có đánh giá. Hãy là người đầu tiên!</p></div></c:when>
                        <c:otherwise>
                            <c:forEach var="review" items="${reviews}">
                                <div class="bg-white p-8 border border-brand-border/40 shadow-sm hover:shadow-md transition-shadow">
                                    <div class="flex items-center justify-between mb-6">
                                        <div class="flex items-center gap-5">
                                            <div class="w-12 h-12 rounded-full bg-[#8B5E3C] flex items-center justify-center text-white font-bold text-[16px] shadow-sm uppercase">${review.username.substring(0,1)}</div>
                                            <div>
                                                <p class="text-[14px] font-bold text-brand-text uppercase tracking-wider">${review.username}</p>
                                                <div class="text-[12px] text-yellow-600 font-bold mt-1"><c:forEach begin="1" end="${review.rating}">⭐</c:forEach> <span class="text-brand-muted ml-2">${review.rating}/5</span></div>
                                                </div>
                                            </div>
                                            <span class="text-[10px] font-bold text-brand-muted uppercase tracking-widest">${review.date}</span>
                                    </div>
                                    <p class="text-[15px] font-medium text-brand-text/90 leading-relaxed pl-16 italic border-l-2 border-brand-secondary">"${review.comment}"</p>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>

        <%@ include file="/views/includes/footer.jsp" %>

        <script>
            // HỢP NHẤT DỮ LIỆU BIẾN THỂ VÀO JS
            const variants = [
            <c:forEach var="v" items="${product.variants}" varStatus="status">
            { id: ${v.id}, color: "${v.colorName}", size: "${v.sizeName}", stock: ${v.stock} }${!status.last ? ',' : ''}
            </c:forEach>
            ];

            function updateStockInfo() {
                const color = document.getElementById('selectedColor').value;
                const size = document.getElementById('selectedSize').value;
                const stockDisplay = document.getElementById('stock-display');
                const qtyInput = document.getElementById('qtyInput');
                const variantIdInput = document.getElementById('selectedVariantId');
                const btn = document.getElementById('addToCartBtn');
                const btnText = document.getElementById('btnText');

                if (color && size) {
                    const match = variants.find(v => v.color === color && v.size === size);
                    if (match) {
                        variantIdInput.value = match.id;
                        qtyInput.max = match.stock;
                        if (match.stock > 0) {
                            stockDisplay.innerText = "Còn hàng (" + match.stock + ")";
                            stockDisplay.className = "text-[13px] font-semibold text-green-600 uppercase";
                            btn.disabled = false;
                            btnText.innerText = "Thêm vào giỏ hàng";
                        } else {
                            stockDisplay.innerText = "Hết hàng";
                            stockDisplay.className = "text-[13px] font-semibold text-red-600 uppercase";
                            btn.disabled = true;
                            btnText.innerText = "Hết hàng";
                        }
                    } else {
                        stockDisplay.innerText = "Không có sẵn";
                        btn.disabled = true;
                    }
                }
            }

            function changeQty(delta) {
                var input = document.getElementById('qtyInput');
                var val = parseInt(input.value) + delta;
                var max = parseInt(input.max);
                if (val < 1)
                    val = 1;
                if (val > max)
                    val = max;
                input.value = val;
            }

            function selectColor(btn, color) {
                document.getElementById('selectedColor').value = color;
                document.getElementById('colorError').classList.add('hidden');
                document.querySelectorAll('#colorOptions .option-btn').forEach(b => b.classList.remove('selected'));
                btn.classList.add('selected');
                updateStockInfo(); // Cập nhật kho
            }

            function selectSize(btn, size) {
                document.getElementById('selectedSize').value = size;
                document.getElementById('sizeError').classList.add('hidden');
                document.querySelectorAll('#sizeOptions .option-btn').forEach(b => b.classList.remove('selected'));
                btn.classList.add('selected');
                updateStockInfo(); // Cập nhật kho
            }

            function selectImage(btn, fullPath) {
                document.getElementById('mainImage').src = fullPath;
                document.querySelectorAll('#thumbnails .thumb-btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
            }

            function validateSelection() {
                var valid = true;
                if (document.getElementById('colorOptions') && !document.getElementById('selectedColor').value) {
                    document.getElementById('colorError').classList.remove('hidden');
                    valid = false;
                }
                if (document.getElementById('sizeOptions') && !document.getElementById('selectedSize').value) {
                    document.getElementById('sizeError').classList.remove('hidden');
                    valid = false;
                }
                return valid;
            }
        </script>
    </body>
</html>