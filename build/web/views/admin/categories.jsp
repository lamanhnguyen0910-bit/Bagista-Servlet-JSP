<%-- 
    Document   : categories
    Created on : Mar 5, 2026, 9:09:00 PM
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
        <title>Danh mục — BAGISTA Admin</title>
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
            .tab-link.active {
                border-color: #7A5C3E;
                color: #3D3228;
            }
            .modal-overlay {
                display: none;
                position: fixed;
                inset: 0;
                z-index: 50;
                background: rgba(61,50,40,0.3);
                backdrop-filter: blur(4px);
                justify-content: center;
                align-items: center;
            }
            .modal-overlay.show {
                display: flex;
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
                    <a href="${pageContext.request.contextPath}/adminproduct" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Sản phẩm</a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Đơn hàng</a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="sidebar-link active flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground">Danh mục</a>
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
                <main class="flex-1 p-6 overflow-auto">
                    <div class="flex items-center justify-between mb-6">
                        <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground uppercase">Danh mục & Thuộc tính</h1>
                        <button onclick="document.getElementById('addModal').classList.add('show')" class="flex items-center gap-2 bg-accent text-accent-foreground px-4 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-accent/90 transition-colors">
                            + Thêm mới
                        </button>
                    </div>

                    <div class="flex gap-1 mb-6 border-b border-border">
                        <a href="${pageContext.request.contextPath}/admincategory?tab=category" class="tab-link px-4 py-2.5 text-[11px] tracking-[0.1em] uppercase font-body transition-colors border-b-2 -mb-px ${activeTab == 'category' || activeTab == null ? 'active border-accent text-foreground' : 'border-transparent text-muted-foreground hover:text-foreground'}">Danh mục</a>
                        <a href="${pageContext.request.contextPath}/admincategory?tab=color" class="tab-link px-4 py-2.5 text-[11px] tracking-[0.1em] uppercase font-body transition-colors border-b-2 -mb-px ${activeTab == 'color' ? 'active border-accent text-foreground' : 'border-transparent text-muted-foreground hover:text-foreground'}">Màu sắc</a>
                        <a href="${pageContext.request.contextPath}/admincategory?tab=size" class="tab-link px-4 py-2.5 text-[11px] tracking-[0.1em] uppercase font-body transition-colors border-b-2 -mb-px ${activeTab == 'size' ? 'active border-accent text-foreground' : 'border-transparent text-muted-foreground hover:text-foreground'}">Kích thước</a>
                        <a href="${pageContext.request.contextPath}/admincategory?tab=material" class="tab-link px-4 py-2.5 text-[11px] tracking-[0.1em] uppercase font-body transition-colors border-b-2 -mb-px ${activeTab == 'material' ? 'active border-accent text-foreground' : 'border-transparent text-muted-foreground hover:text-foreground'}">Chất liệu</a>
                    </div>

                    <div class="border border-border">
                        <table class="w-full text-[13px] font-body">
                            <thead>
                                <tr class="border-b border-border bg-secondary/30 text-left text-muted-foreground">
                                    <th class="p-3 w-16">#</th>
                                    <th class="p-3">Tên</th>
                                        <c:if test="${activeTab == 'category' || activeTab == null}">
                                        <th class="p-3">Mô tả</th>
                                        </c:if>
                                    <th class="p-3 w-24">Sản phẩm</th>
                                    <th class="p-3 w-32 text-center">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="listItems" value="${categories}" />
                                <c:if test="${activeTab == 'color'}"><c:set var="listItems" value="${colors}" /></c:if>
                                <c:if test="${activeTab == 'size'}"><c:set var="listItems" value="${sizes}" /></c:if>
                                <c:if test="${activeTab == 'material'}"><c:set var="listItems" value="${materials}" /></c:if>

                                <c:forEach var="item" items="${listItems}" varStatus="i">
                                    <tr class="border-b border-border/50 hover:bg-secondary/10 transition-colors">
                                        <td class="p-3 text-muted-foreground">${i.index + 1}</td>

                                        <td class="p-3 text-foreground capitalize">
                                            <c:choose>
                                                <c:when test="${activeTab == 'category' || activeTab == null}">${item.getName()}</c:when>
                                                <c:otherwise>${item}</c:otherwise>
                                            </c:choose>
                                        </td>

                                        <c:if test="${activeTab == 'category' || activeTab == null}">
                                            <td class="p-3 text-[12px] text-muted-foreground">${item.getDescription()}</td>
                                        </c:if>

                                        <td class="p-3 text-foreground">
                                            <c:if test="${activeTab == 'category' || activeTab == null}">${item.getProductCount()}</c:if>
                                            </td>

                                            <td class="p-3">
                                                <div class="flex items-center justify-center gap-3">
                                                <c:choose>
                                                    <c:when test="${activeTab == 'category' || activeTab == null}">
                                                        <button onclick="openEditModal('${item.getId()}', '${item.getName()}', '${item.getDescription()}')" class="text-muted-foreground hover:text-foreground transition-colors">
                                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 00-2 2v14a2 2 0 002 2h14a2 2 0 002-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 013 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                                                        </button>
                                                        <button onclick="confirmDelete('${item.getId()}', '${item.getName()}', ${item.getProductCount()})" class="text-muted-foreground hover:text-red-600 transition-colors">
                                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6m3 0V4a2 2 0 012-2h4a2 2 0 012 2v2"/></svg>
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <%-- Đối với Color/Size/Material (String), ID và Name dùng chung giá trị String --%>
                                                        <button onclick="openEditModal('${item}', '${item}', '')" class="text-muted-foreground hover:text-foreground transition-colors">
                                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 00-2 2v14a2 2 0 002 2h14a2 2 0 002-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 013 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                                                        </button>
                                                        <button onclick="confirmDelete('${item}', '${item}', 0)" class="text-muted-foreground hover:text-red-600 transition-colors">
                                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6m3 0V4a2 2 0 012-2h4a2 2 0 012 2v2"/></svg>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div id="addModal" class="modal-overlay" onclick="this.classList.remove('show')">
                        <div class="bg-background border border-border p-8 max-w-md w-full mx-4" onclick="event.stopPropagation()">
                            <h3 class="text-[16px] font-display tracking-[0.15em] text-foreground uppercase mb-6">Thêm mới</h3>
                            <form action="${pageContext.request.contextPath}/adminaddcategory" method="POST" class="space-y-4">
                                <input type="hidden" name="tab" value="${activeTab}" />
                                <div>
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1">Tên</label>
                                    <input type="text" name="name" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                </div>
                                <c:if test="${activeTab == 'category' || activeTab == null}">
                                    <div>
                                        <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1">Mô tả</label>
                                        <input type="text" name="description" class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                    </div>
                                </c:if>
                                <div class="flex gap-3 pt-2">
                                    <button type="submit" class="bg-accent text-accent-foreground px-6 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-accent/90">Thêm</button>
                                    <button type="button" onclick="document.getElementById('addModal').classList.remove('show')" class="border border-border text-foreground px-6 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-secondary/50">Huỷ</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div id="editModal" class="modal-overlay" onclick="this.classList.remove('show')">
                        <div class="bg-background border border-border p-8 max-w-md w-full mx-4" onclick="event.stopPropagation()">
                            <h3 class="text-[16px] font-display tracking-[0.15em] text-foreground uppercase mb-6">Chỉnh sửa</h3>
                            <form action="${pageContext.request.contextPath}/adminupdatecategory" method="POST" class="space-y-4">
                                <input type="hidden" name="tab" value="${activeTab}" />
                                <input type="hidden" name="editItemId" id="editItemId" />
                                <div>
                                    <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1">Tên mới</label>
                                    <input type="text" name="editName" id="editName" required class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                </div>
                                <c:if test="${activeTab == 'category' || activeTab == null}">
                                    <div>
                                        <label class="text-[10px] tracking-[0.15em] uppercase text-muted-foreground font-body block mb-1">Mô tả</label>
                                        <input type="text" name="editDesc" id="editDesc" class="w-full bg-transparent border border-border px-3 py-2 text-[13px] font-body text-foreground focus:outline-none focus:border-accent" />
                                    </div>
                                </c:if>
                                <div class="flex gap-3 pt-2">
                                    <button type="submit" class="bg-accent text-accent-foreground px-6 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-accent/90">Lưu thay đổi</button>
                                    <button type="button" onclick="document.getElementById('editModal').classList.remove('show')" class="border border-border text-foreground px-6 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-secondary/50">Huỷ</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div id="deleteModal" class="modal-overlay" onclick="this.classList.remove('show')">
                        <div class="bg-background border border-border p-8 max-w-md w-full mx-4" onclick="event.stopPropagation()">
                            <div class="flex items-start gap-3 mb-4">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#B91C1C" stroke-width="2" class="shrink-0 mt-0.5"><path d="M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
                                <div>
                                    <h3 class="text-[14px] font-body text-foreground font-medium mb-1">Xoá mục "<span id="deleteCatName"></span>"?</h3>
                                    <p class="text-[12px] font-body text-muted-foreground">Mục này có <strong class="text-foreground" id="deleteProdCount"></strong> sản phẩm liên kết.</p>
                                </div>
                            </div>
                            <div class="flex flex-wrap gap-2">
                                <form action="${pageContext.request.contextPath}/admindeletecategory" method="POST" class="inline">
                                    <input type="hidden" name="itemId" id="deleteItemId" />
                                    <input type="hidden" name="tab" value="${activeTab}" />
                                    <input type="hidden" name="deleteProducts" value="true" />
                                    <button type="submit" class="bg-destructive text-white px-4 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-destructive/90 transition-colors">Xoá kèm sản phẩm</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admindeletecategory" method="POST" class="inline">
                                    <input type="hidden" name="itemId" id="deleteItemIdOnly" />
                                    <input type="hidden" name="tab" value="${activeTab}" />
                                    <input type="hidden" name="deleteProducts" value="false" />
                                    <button type="submit" class="bg-accent text-accent-foreground px-4 py-2 text-[11px] tracking-[0.1em] uppercase font-body hover:bg-accent/90 transition-colors">Chỉ gỡ liên kết</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script>
            function openEditModal(id, name, desc) {
                document.getElementById('editItemId').value = id;
                document.getElementById('editName').value = name;
                var descInput = document.getElementById('editDesc');
                if (descInput)
                    descInput.value = desc || '';
                document.getElementById('editModal').classList.add('show');
            }

            function confirmDelete(id, name, productCount) {
                var tab = '${activeTab}' || 'category';
                if (productCount > 0) {
                    document.getElementById('deleteCatName').textContent = name;
                    document.getElementById('deleteProdCount').textContent = productCount;
                    document.getElementById('deleteItemId').value = id;
                    document.getElementById('deleteItemIdOnly').value = id;
                    document.getElementById('deleteModal').classList.add('show');
                } else {
                    if (confirm('Bạn chắc chắn muốn xoá mục này?')) {
                        var form = document.createElement('form');
                        form.method = 'POST';
                        form.action = '${pageContext.request.contextPath}/admindeletecategory';
                        form.innerHTML = '<input type="hidden" name="itemId" value="' + id + '">'
                                + '<input type="hidden" name="tab" value="' + tab + '">'
                                + '<input type="hidden" name="deleteProducts" value="false">';
                        document.body.appendChild(form);
                        form.submit();
                    }
                }
            }
        </script>
    </body>
</html>