<%-- 
    Document   : edit-product
    Created on : Mar 5, 2026, 9:08:23 PM
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
        <title>Chỉnh sửa sản phẩm — BAGISTA Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Inter:wght@300;400;500&display=swap" rel="stylesheet" />
        <script>
            tailwind.config = {
                theme: {extend: {
                        fontFamily: {display: ['"Cormorant Garamond"', 'serif'], body: ['Inter', 'sans-serif']},
                        colors: {border: '#C4B9A8', background: '#FAF7F2', foreground: '#3D3228', card: '#FAF7F2', muted: '#EDE8DF', 'muted-foreground': '#8B7E6A', accent: '#7A5C3E', 'accent-foreground': '#FAF7F2', secondary: '#EDE8DF', destructive: '#B91C1C'}
                    }}
            }
        </script>
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                font-family: 'Inter', sans-serif;
                background: #FAF7F2;
                color: #3D3228;
                margin: 0;
            }
            .sidebar-link.active {
                background: rgba(237,232,223,0.5);
                border-right: 2px solid #7A5C3E;
                color: #3D3228;
            }
            .color-btn.selected, .size-btn.selected {
                border-color: #7A5C3E;
                background: #7A5C3E;
                color: #FAF7F2;
            }
        </style>
    </head>
    <body>
        <div class="min-h-screen flex">
            <aside class="hidden md:flex flex-col w-56 border-r border-border bg-card fixed inset-y-0 left-0 z-30">
                <div class="h-16 flex items-center px-6 border-b border-border">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="text-[18px] tracking-[0.2em] font-display text-foreground uppercase">BAGISTA</a>
                </div>
                <nav class="flex-1 py-4">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="layout-dashboard" class="w-4 h-4"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/adminproduct" class="sidebar-link active flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="package" class="w-4 h-4"></i> Sản phẩm
                    </a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="shopping-cart" class="w-4 h-4"></i> Đơn hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="tag" class="w-4 h-4"></i> Danh mục
                    </a>
                    <a href="${pageContext.request.contextPath}/admincustomer" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="users" class="w-4 h-4"></i> Khách hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="star" class="w-4 h-4"></i> Đánh giá
                    </a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">
                        <i data-lucide="percent" class="w-4 h-4"></i> Giảm giá
                    </a>
                </nav>
            </aside>

            <div class="flex-1 md:ml-56 flex flex-col min-w-0">
                <main class="flex-1 p-6 overflow-auto">
                    <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground mb-6 uppercase">CHỈNH SỬA SẢN PHẨM</h1>

                    <form action="${pageContext.request.contextPath}/admineditproduct" method="POST" enctype="multipart/form-data" class="max-w-2xl space-y-5">
                        <input type="hidden" name="productId" value="${product.id}" />

                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-2 font-bold">Hình ảnh hiện tại</label>
                            <div class="grid grid-cols-5 gap-3 mb-3">
                                <c:forEach var="img" items="${product.images}">
                                    <div class="relative aspect-square border border-border overflow-hidden group bg-white">
                                        <c:choose>
                                            <c:when test="${img.contains('http')}"><img src="${img}" class="w-full h-full object-cover" /></c:when>
                                            <c:otherwise><img src="${pageContext.request.contextPath}/assets/images/products/${img}" class="w-full h-full object-cover" /></c:otherwise>
                                        </c:choose>
                                        <div class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                                            <button type="button" onclick="markImageForDelete(this, '${img}')" class="w-7 h-7 bg-white text-destructive flex items-center justify-center hover:bg-destructive hover:text-white transition-colors">✕</button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <input type="hidden" name="deletedImages" id="deletedImages" value="" />
                        </div>

                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Thêm ảnh mới</label>
                            <input type="file" name="newImages" accept="image/*" multiple class="text-[12px] font-body" />
                        </div>

                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Tên sản phẩm *</label>
                            <input type="text" name="name" value="${product.name}" required class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Giá (VNĐ) *</label>
                                <input type="number" name="price" value="${product.price}" required class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Tổng kho</label>
                                <input type="number" name="stock" value="${product.stock}" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                            </div>
                        </div>

                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Danh mục</label>
                            <select name="category" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent">
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.name}" ${product.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Màu sắc</label>
                            <div class="flex flex-wrap gap-2">
                                <c:forEach var="colorName" items="${colors}">
                                    <c:set var="isSelected" value="false" />
                                    <c:forEach var="myC" items="${product.colors}"><c:if test="${myC == colorName}"><c:set var="isSelected" value="true" /></c:if></c:forEach>
                                    <button type="button" onclick="toggleMultiSelect(this, 'colors')" data-value="${colorName}"
                                            class="color-btn text-[11px] font-body px-3 py-1.5 border border-border transition-all ${isSelected ? 'selected' : ''}">${colorName}</button>
                                </c:forEach>
                            </div>
                            <input type="hidden" name="colors" id="colorsInput" value="${product.getColorsFormatted()}" />
                        </div>

                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Kích cỡ</label>
                            <div class="flex flex-wrap gap-2">
                                <c:forEach var="sizeName" items="${sizes}">
                                    <c:set var="isSelectedS" value="false" />
                                    <c:forEach var="myS" items="${product.sizes}"><c:if test="${myS == sizeName}"><c:set var="isSelectedS" value="true" /></c:if></c:forEach>
                                    <button type="button" onclick="toggleMultiSelect(this, 'sizes')" data-value="${sizeName}"
                                            class="size-btn text-[11px] font-body px-3 py-1.5 border border-border transition-all ${isSelectedS ? 'selected' : ''}">${sizeName}</button>
                                </c:forEach>
                            </div>
                            <input type="hidden" name="sizes" id="sizesInput" value="${product.getSizesFormatted()}" />
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Chất liệu</label>
                                <select name="material" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent capitalize">
                                    <c:forEach var="matName" items="${materials}">
                                        <option value="${matName}" ${product.materialName == matName ? 'selected' : ''}>${matName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5 font-bold">Nhãn (Tag)</label>
                                <select name="tag" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent">
                                    <option value="">Không có</option>
                                    <option value="new" ${product.tag == 'new' ? 'selected' : ''}>Mới</option>
                                    <option value="hot" ${product.tag == 'hot' ? 'selected' : ''}>Nổi bật</option>
                                    <option value="bestseller" ${product.tag == 'bestseller' ? 'selected' : ''}>Bán chạy</option>
                                </select>
                            </div>
                        </div>

                        <div class="flex gap-4 pt-6 border-t border-border/30">
                            <button type="submit" class="bg-accent text-accent-foreground px-10 py-3 text-[11px] tracking-[0.2em] uppercase font-body hover:bg-accent/90 transition-colors">Cập nhật sản phẩm</button>
                            <a href="${pageContext.request.contextPath}/adminproduct" class="border border-border text-foreground px-10 py-3 text-[11px] tracking-[0.2em] uppercase font-body hover:bg-secondary/50 transition-colors inline-block text-center">Hủy</a>
                        </div>
                    </form>
                </main>
            </div>
        </div>

        <script>
            lucide.createIcons();
            function toggleMultiSelect(btn, type) {
                btn.classList.toggle('selected');
                const parent = btn.parentElement;
                const selectedBtns = parent.querySelectorAll('.selected');
                const values = Array.from(selectedBtns).map(b => b.getAttribute('data-value').trim());
                document.getElementById(type + 'Input').value = values.join(', ');
            }
            let deletedImages = [];
            function markImageForDelete(btn, imgName) {
                const container = btn.closest('.relative');
                if (!container.classList.contains('marked-deleted')) {
                    container.classList.add('marked-deleted');
                    container.style.opacity = '0.2';
                    deletedImages.push(imgName);
                } else {
                    container.classList.remove('marked-deleted');
                    container.style.opacity = '1';
                    deletedImages = deletedImages.filter(item => item !== imgName);
                }
                document.getElementById('deletedImages').value = deletedImages.join(',');
            }
        </script>
    </body>
</html>
