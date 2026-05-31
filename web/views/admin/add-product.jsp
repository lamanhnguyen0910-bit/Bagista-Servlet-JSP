<%-- 
    Document   : add-products
    Created on : Mar 5, 2026, 9:08:14 PM
    Author     : laman
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Thêm sản phẩm — BAGISTA Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Inter:wght@300;400;500&display=swap" rel="stylesheet" />
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {display: ['"Cormorant Garamond"', 'serif'], body: ['Inter', 'sans-serif']},
                        colors: {
                            border: '#C4B9A8', background: '#FAF7F2', foreground: '#3D3228',
                            card: '#FAF7F2', muted: '#EDE8DF', 'muted-foreground': '#8B7E6A',
                            accent: '#7A5C3E', 'accent-foreground': '#FAF7F2',
                            secondary: '#EDE8DF', destructive: '#B91C1C',
                        }
                    }
                }
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
            <aside class="hidden md:flex flex-col w-56 border-r border-border bg-card shrink-0 fixed inset-y-0 left-0 z-30">
                <div class="h-16 flex items-center px-6 border-b border-border">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="text-[18px] tracking-[0.2em] font-display text-foreground">BAGISTA</a>
                    <span class="ml-2 text-[9px] tracking-[0.15em] uppercase font-body text-accent bg-accent/10 px-2 py-0.5">Admin</span>
                </div>
                <nav class="flex-1 py-4">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/adminproduct" class="sidebar-link active flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Sản phẩm</a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Đơn hàng</a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Danh mục</a>
                    <a href="${pageContext.request.contextPath}/admincustomer" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Khách hàng</a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Đánh giá</a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Giảm giá</a>
                </nav>
                <div class="border-t border-border p-4">
                    <a href="${pageContext.request.contextPath}/adminprofile" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground px-2 py-2">Hồ sơ Admin</a>
                    <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground px-2 py-2">Về trang chủ</a>
                </div>
            </aside>

            <div class="flex-1 md:ml-56 flex flex-col min-w-0">
                <header class="md:hidden h-14 flex items-center justify-between px-4 border-b border-border bg-card">
                    <div class="flex items-center gap-2">
                        <span class="text-[16px] tracking-[0.15em] font-display text-foreground">BAGISTA</span>
                        <span class="text-[8px] tracking-[0.1em] uppercase font-body text-accent bg-accent/10 px-1.5 py-0.5">Admin</span>
                    </div>
                    <button onclick="toggleMobileSidebar()" class="text-foreground">
                        <svg id="menuIcon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
                        <svg id="closeIcon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="hidden"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                    </button>
                </header>
                <div id="mobileSidebar" class="md:hidden hidden border-b border-border bg-card">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/adminproduct" class="flex items-center gap-3 px-6 py-3 text-[12px] font-body text-foreground bg-secondary/50">Sản phẩm</a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground">Đơn hàng</a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground">Danh mục</a>
                    <a href="${pageContext.request.contextPath}/admincustomer" class="flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground">Khách hàng</a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground">Đánh giá</a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground">Giảm giá</a>
                </div>

                <main class="flex-1 p-6 overflow-auto">
                    <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground mb-6 uppercase">Thêm sản phẩm mới</h1>

                    <form action="${pageContext.request.contextPath}/adminaddproduct" method="POST" enctype="multipart/form-data" class="max-w-2xl space-y-5">
                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5">Tên sản phẩm <span class="text-red-600">*</span></label>
                            <input type="text" name="name" required class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5">Giá (VNĐ) <span class="text-red-600">*</span></label>
                                <input type="number" name="price" required class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5">Số lượng tồn kho</label>
                                <input type="number" name="stock" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                            </div>
                        </div>

                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5">Danh mục</label>
                            <select name="category" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent capitalize">
                                <option value="">Chọn danh mục</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.getName()}">${cat.getName()}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5">Màu sắc (chọn nhiều)</label>
                            <div class="flex flex-wrap gap-2" id="colorGroup">
                                <c:forEach var="color" items="${colors}">
                                    <button type="button" onclick="toggleMultiSelect(this, 'colors')" data-value="${color}"
                                            class="color-btn text-[11px] font-body px-3 py-1.5 border border-border text-muted-foreground capitalize hover:text-foreground transition-colors">${color}</button>
                                </c:forEach>
                            </div>
                            <input type="hidden" name="colors" id="colorsInput" />
                        </div>

                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5">Kích cỡ (chọn nhiều)</label>
                            <div class="flex flex-wrap gap-2" id="sizeGroup">
                                <c:forEach var="size" items="${sizes}">
                                    <button type="button" onclick="toggleMultiSelect(this, 'sizes')" data-value="${size}"
                                            class="size-btn text-[11px] font-body px-3 py-1.5 border border-border text-muted-foreground capitalize hover:text-foreground transition-colors">${size}</button>
                                </c:forEach>
                            </div>
                            <input type="hidden" name="sizes" id="sizesInput" />
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5">Chất liệu</label>
                                <select name="material" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent capitalize">
                                    <option value="">Chọn chất liệu</option>
                                    <c:forEach var="mat" items="${materials}">
                                        <option value="${mat}">${mat}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5">Nhãn</label>
                                <select name="tag" class="w-full bg-transparent border border-border px-3 py-2.5 text-[13px] font-body text-foreground focus:outline-none focus:border-accent">
                                    <option value="">Không có</option>
                                    <option value="new">Mới</option>
                                    <option value="hot">Nổi bật</option>
                                    <option value="bestseller">Bán chạy</option>
                                </select>
                            </div>
                        </div>

                        <div>
                            <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1.5">Hình ảnh sản phẩm (tối đa 5 ảnh)</label>
                            <div class="grid grid-cols-5 gap-3 mb-3" id="imagePreview"></div>
                            <label class="inline-flex items-center gap-2 border border-dashed border-border px-4 py-3 cursor-pointer hover:border-accent transition-colors">
                                <span class="text-[11px] font-body text-muted-foreground">+ Thêm ảnh</span>
                                <input type="file" name="images" accept="image/*" multiple onchange="previewImages(this)" class="hidden" />
                            </label>
                            <p class="text-[11px] font-body text-muted-foreground mt-2" id="imageCount">0/5 ảnh</p>
                        </div>

                        <div class="flex gap-3 pt-2">
                            <button type="submit" class="bg-accent text-accent-foreground px-8 py-2.5 text-[11px] tracking-[0.15em] uppercase font-body hover:bg-accent/90 transition-colors">Thêm sản phẩm</button>
                            <a href="${pageContext.request.contextPath}/adminproduct" class="border border-border text-foreground px-8 py-2.5 text-[11px] tracking-[0.15em] uppercase font-body hover:bg-secondary/50 transition-colors inline-block text-center">Huỷ</a>
                        </div>
                    </form>
                </main>
            </div>
        </div>

        <script>
            function toggleMobileSidebar() {
                document.getElementById('mobileSidebar').classList.toggle('hidden');
                document.getElementById('menuIcon').classList.toggle('hidden');
                document.getElementById('closeIcon').classList.toggle('hidden');
            }

            function toggleMultiSelect(btn, inputId) {
                btn.classList.toggle('selected');
                var btns = btn.parentElement.querySelectorAll('.selected');
                var values = Array.from(btns).map(function (b) {
                    return b.dataset.value;
                });
                document.getElementById(inputId + 'Input').value = values.join(',');
            }

            function previewImages(input) {
                var preview = document.getElementById('imagePreview');
                preview.innerHTML = '';
                var files = Array.from(input.files).slice(0, 5);
                files.forEach(function (file, i) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var div = document.createElement('div');
                        div.className = 'relative aspect-square border border-border overflow-hidden';
                        div.innerHTML = '<img src="' + e.target.result + '" class="w-full h-full object-cover" />';
                        preview.appendChild(div);
                    };
                    reader.readAsDataURL(file);
                });
                document.getElementById('imageCount').textContent = files.length + '/5 ảnh';
            }
        </script>
    </body>
</html>