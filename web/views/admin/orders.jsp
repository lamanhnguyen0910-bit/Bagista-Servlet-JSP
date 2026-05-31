<%-- 
    Document   : orders
    Created on : Mar 5, 2026, 9:08:41 PM
    Author     : laman
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đơn hàng — BAGISTA Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Inter:wght@300;400;500&display=swap" rel="stylesheet" />
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {display: ['"Cormorant Garamond"', 'serif'], body: ['Inter', 'sans-serif']},
                        colors: {border: '#C4B9A8', background: '#FAF7F2', foreground: '#3D3228', card: '#FAF7F2', muted: '#EDE8DF', 'muted-foreground': '#8B7E6A', accent: '#7A5C3E', 'accent-foreground': '#FAF7F2', secondary: '#EDE8DF', destructive: '#B91C1C'}
                    }
                }
            }
        </script>
        <style>
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
            .status-delivered {
                color: #15803D;
                background: #DCFCE7;
            }
            .status-shipping {
                color: #A16207;
                background: #FEF9C3;
            }
            .status-pending {
                color: #1D4ED8;
                background: #DBEAFE;
            }
            .status-cancelled {
                color: #B91C1C;
                background: #FEE2E2;
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
                    <a href="${pageContext.request.contextPath}/admindashboard" class="text-[18px] tracking-[0.2em] font-display text-foreground uppercase">BAGISTA</a>
                </div>
                <nav class="flex-1 py-4">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground"><i data-lucide="layout-dashboard" class="w-4 h-4"></i> Dashboard</a>
                    <a href="${pageContext.request.contextPath}/adminproduct" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground"><i data-lucide="package" class="w-4 h-4"></i> Sản phẩm</a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="sidebar-link active flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground"><i data-lucide="shopping-cart" class="w-4 h-4"></i> Đơn hàng</a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground"><i data-lucide="tag" class="w-4 h-4"></i> Danh mục</a>
                    <a href="${pageContext.request.contextPath}/admincustomer" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground"><i data-lucide="users" class="w-4 h-4"></i> Khách hàng</a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground"><i data-lucide="star" class="w-4 h-4"></i> Đánh giá</a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground"><i data-lucide="percent" class="w-4 h-4"></i> Giảm giá</a>
                </nav>
            </aside>

            <div class="flex-1 md:ml-56 flex flex-col min-w-0">
                <main class="flex-1 p-6 overflow-auto">
                    <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground mb-6 uppercase font-bold">Đơn hàng</h1>

                    <div class="flex gap-2 mb-6 flex-wrap">
                        <a href="${pageContext.request.contextPath}/adminorder" class="text-[11px] font-body px-3 py-1.5 border transition-colors ${empty filterStatus ? 'border-accent bg-accent text-accent-foreground' : 'border-border text-muted-foreground hover:text-foreground'}">Tất cả</a>
                        <%-- FIX LỖI: Dùng hàm split để tạo mảng --%>
                        <c:forEach var="st" items="${fn:split('Chờ xử lý,Đang giao,Đã giao,Đã huỷ', ',')}">
                            <a href="${pageContext.request.contextPath}/adminorder?status=${st}" class="text-[11px] font-body px-3 py-1.5 border transition-colors ${filterStatus == st ? 'border-accent bg-accent text-accent-foreground' : 'border-border text-muted-foreground hover:text-foreground'}">${st}</a>
                        </c:forEach>
                    </div>

                    <div class="border border-border overflow-x-auto bg-white/40 shadow-sm">
                        <table class="w-full text-[12px] font-body">
                            <thead>
                                <tr class="border-b border-border bg-secondary/30 text-left text-muted-foreground uppercase tracking-widest">
                                    <th class="p-3">Mã đơn</th>
                                    <th class="p-3">Người nhận</th>
                                    <th class="p-3">SĐT</th>
                                    <th class="p-3">Tài khoản</th>
                                    <th class="p-3">Thời gian đặt</th>
                                    <th class="p-3">Thanh toán</th>
                                    <th class="p-3">Tổng</th>
                                    <th class="p-3">Trạng thái</th>
                                    <th class="p-3 text-center">Chi tiết</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="o" items="${orders}">
                                    <tr class="border-b border-border/50 hover:bg-secondary/10 transition-colors">
                                        <td class="p-3 text-foreground font-medium">#${o.id}</td>
                                        <td class="p-3 text-foreground">${o.recipientName}</td>
                                        <td class="p-3 text-muted-foreground">${o.recipientPhone}</td>
                                        <td class="p-3 text-muted-foreground">${o.accountUsername}</td>
                                        <td class="p-3 text-muted-foreground">${o.datetime}</td>
                                        <td class="p-3 text-muted-foreground capitalize">${o.payment}</td>
                                        <td class="p-3 text-foreground font-bold">${o.getFormattedTotal()}</td>
                                        <td class="p-3">
                                            <form action="${pageContext.request.contextPath}/adminupdateorderstatus" method="POST" class="inline">
                                                <input type="hidden" name="orderId" value="${o.id}" />
                                                <%-- CẬP NHẬT: Disable nếu khách đã hủy (N'Đã huỷ' khớp với Database) --%>
                                                <select name="status" onchange="this.form.submit()" ${o.status == 'Đã huỷ' ? 'disabled' : ''} class="text-[10px] px-2 py-0.5 rounded border-none cursor-pointer font-bold
                                                        ${o.status == 'Đã giao' ? 'status-delivered' : ''} ${o.status == 'Đang giao' ? 'status-shipping' : ''}
                                                        ${o.status == 'Chờ xử lý' ? 'status-pending' : ''} ${o.status == 'Đã huỷ' ? 'status-cancelled' : ''}">
                                                    <option value="Chờ xử lý" ${o.status == 'Chờ xử lý' ? 'selected' : ''}>Chờ xử lý</option>
                                                    <option value="Đang giao" ${o.status == 'Đang giao' ? 'selected' : ''}>Đang giao</option>
                                                    <option value="Đã giao" ${o.status == 'Đã giao' ? 'selected' : ''}>Đã giao</option>
                                                    <option value="Đã huỷ" ${o.status == 'Đã huỷ' ? 'selected' : ''}>Đã huỷ</option>
                                                </select>
                                            </form>
                                        </td>
                                        <td class="p-3 text-center">
                                            <button onclick="openOrderDetail('${o.id}')" class="text-muted-foreground hover:text-accent transition-colors">
                                                <i data-lucide="eye" class="w-4 h-4"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div id="orderModal" class="modal-overlay" onclick="closeOrderDetail()">
                        <div class="bg-background border border-border p-8 max-w-lg w-full mx-4 max-h-[85vh] overflow-y-auto shadow-2xl" onclick="event.stopPropagation()">
                            <div class="flex items-center justify-between mb-6 border-b border-border pb-4">
                                <h3 class="text-[18px] font-display tracking-[0.15em] text-foreground uppercase" id="modalOrderId"></h3>
                                <button onclick="closeOrderDetail()" class="text-muted-foreground hover:text-foreground"><i data-lucide="x" class="w-5 h-5"></i></button>
                            </div>
                            <div id="modalContent" class="space-y-4 text-[13px] font-body"></div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script>
            lucide.createIcons();
            function openOrderDetail(orderId) {
                const modal = document.getElementById('orderModal');
                const content = document.getElementById('modalContent');
                document.getElementById('modalOrderId').textContent = 'ĐƠN HÀNG #' + orderId;
                modal.classList.add('show');
                content.innerHTML = '<div class="py-10 text-center text-muted-foreground">Đang tải chi tiết...</div>';

                fetch('${pageContext.request.contextPath}/adminorderdetail?id=' + orderId)
                        .then(res => res.json())
                        .then(data => {
                            let html = `<div class="grid grid-cols-2 gap-4 border-b border-border pb-4">
                            <div><p class="text-[10px] uppercase text-muted-foreground">Người nhận</p><p class="font-medium">` + data.recipientName + `</p></div>
                            <div><p class="text-[10px] uppercase text-muted-foreground">SĐT</p><p class="font-medium">` + data.recipientPhone + `</p></div>
                            <div class="col-span-2"><p class="text-[10px] uppercase text-muted-foreground">Địa chỉ</p><p class="font-medium">` + data.recipientAddress + `</p></div>
                        </div>
                        <div class="mt-4"><p class="text-[10px] uppercase text-muted-foreground mb-3">Sản phẩm đã đặt</p><div class="space-y-3">`;

                            data.items.forEach(item => {
                                html += `<div class="flex justify-between items-center border-b border-border/30 pb-2">
                                <div>
                                    <p class="font-medium text-foreground uppercase">` + item.name + `</p>
                                    <p class="text-[11px] text-muted-foreground capitalize">
                                        ` + (item.color && item.color !== 'null' ? 'Màu: ' + item.color : '') + (item.color && item.color !== 'null' && item.size && item.size !== 'null' ? ' • ' : '') + (item.size && item.size !== 'null' ? 'Size: ' + item.size : '') + `
                                    </p>
                                    <p class="text-[11px]">SL: ` + item.qty + ` x ` + item.price + `</p>
                                </div>
                            </div>`;
                            });

                            html += `</div></div><div class="flex justify-between items-center pt-4 mt-2">
                            <span class="text-[11px] uppercase tracking-widest text-muted-foreground">Tổng thanh toán</span>
                            <span class="text-[20px] font-display text-accent font-bold">` + data.total + `</span>
                        </div>`;
                            content.innerHTML = html;
                        })
                        .catch(err => {
                            content.innerHTML = '<p class="text-red-600 text-center">Lỗi tải dữ liệu.</p>';
                        });
            }

            function closeOrderDetail() {
                document.getElementById('orderModal').classList.remove('show');
            }
        </script>
    </body>
</html>