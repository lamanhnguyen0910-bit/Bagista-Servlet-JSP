<%-- 
    Document   : dashboard
    Created on : Mar 5, 2026, 9:07:32 PM
    Author     : laman
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Dashboard — BAGISTA Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
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
            * { box-sizing: border-box; }
            body { font-family: 'Inter', sans-serif; background: #FAF7F2; color: #3D3228; margin: 0; }
            .scroll-list { max-height: 400px; overflow-y: auto; }
            .scroll-list::-webkit-scrollbar { width: 4px; }
            .scroll-list::-webkit-scrollbar-thumb { background: #C4B9A8; }
            .sidebar-link.active { background: rgba(237,232,223,0.5); border-right: 2px solid #7A5C3E; color: #3D3228; }
            .status-delivered { color: #15803D; background: #DCFCE7; }
            .status-shipping { color: #A16207; background: #FEF9C3; }
            .status-pending { color: #1D4ED8; background: #DBEAFE; }
            .status-cancelled { color: #B91C1C; background: #FEE2E2; }
            .tab-btn.active { border-color: #7A5C3E; background: #7A5C3E; color: #FAF7F2; }
        </style>
    </head>
    <body>
        <div class="min-h-screen flex">
            <aside class="hidden md:flex flex-col w-56 border-r border-border bg-card shrink-0 fixed inset-y-0 left-0 z-30">
                <div class="h-16 flex items-center px-6 border-b border-border">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="text-[18px] tracking-[0.2em] font-display text-foreground uppercase">BAGISTA</a>
                    <span class="ml-2 text-[9px] tracking-[0.15em] uppercase font-body text-accent bg-accent/10 px-2 py-0.5">Admin</span>
                </div>
                <nav class="flex-1 py-4">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="sidebar-link active flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="layout-dashboard" class="w-4 h-4"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/adminproduct" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="package" class="w-4 h-4"></i> Sản phẩm
                    </a>
                    <a href="${pageContext.request.contextPath}/adminorder" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="shopping-cart" class="w-4 h-4"></i> Đơn hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/admincategory" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="tag" class="w-4 h-4"></i> Danh mục
                    </a>
                    <a href="${pageContext.request.contextPath}/admincustomer" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="users" class="w-4 h-4"></i> Khách hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/adminreview" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="star" class="w-4 h-4"></i> Đánh giá
                    </a>
                    <a href="${pageContext.request.contextPath}/admindiscount" class="sidebar-link flex items-center gap-3 px-6 py-3 text-[12px] font-body text-muted-foreground hover:text-foreground hover:bg-secondary/20 transition-colors">
                        <i data-lucide="percent" class="w-4 h-4"></i> Giảm giá
                    </a>
                </nav>
                <div class="border-t border-border p-4">
                    <a href="${pageContext.request.contextPath}/adminprofile" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground transition-colors px-2 py-2">
                        <i data-lucide="user" class="w-3.5 h-3.5"></i> Hồ sơ Admin
                    </a>
                    <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-2 text-[11px] font-body text-muted-foreground hover:text-foreground transition-colors px-2 py-2">
                        <i data-lucide="log-out" class="w-3.5 h-3.5"></i> Về trang chủ
                    </a>
                </div>
            </aside>

            <div class="flex-1 md:ml-56 flex flex-col min-w-0">
                <header class="md:hidden h-14 flex items-center justify-between px-4 border-b border-border bg-card">
                    <div class="flex items-center gap-2">
                        <span class="text-[16px] tracking-[0.15em] font-display text-foreground uppercase">BAGISTA</span>
                        <span class="text-[8px] tracking-[0.1em] uppercase font-body text-accent bg-accent/10 px-1.5 py-0.5">Admin</span>
                    </div>
                    <button onclick="toggleMobileSidebar()" class="text-foreground" id="menuBtn">
                        <i id="menuIcon" data-lucide="menu" class="w-5 h-5"></i>
                        <i id="closeIcon" data-lucide="x" class="w-5 h-5 hidden"></i>
                    </button>
                </header>

                <div id="mobileSidebar" class="md:hidden hidden border-b border-border bg-card">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="flex items-center gap-3 px-6 py-3 text-[12px] font-body text-foreground bg-secondary/50">Dashboard</a>
                    </div>

                <main class="flex-1 p-6 overflow-auto">
                    <h1 class="text-[22px] font-display tracking-[0.15em] text-foreground mb-6 uppercase">Dashboard</h1>

                    <div class="grid grid-cols-2 md:grid-cols-5 gap-4 mb-8">
                        <div class="border border-border p-5">
                            <div class="flex items-center gap-2 mb-2 text-green-600">
                                <i data-lucide="trending-up" class="w-4 h-4"></i>
                                <span class="text-[10px] tracking-[0.15em] uppercase font-body">Tổng doanh thu</span>
                            </div>
                            <p class="text-[20px] font-display text-foreground">${totalRevenue}</p>
                        </div>
                        <div class="border border-border p-5">
                            <div class="flex items-center gap-2 mb-2 text-accent">
                                <i data-lucide="box" class="w-4 h-4"></i>
                                <span class="text-[10px] tracking-[0.15em] uppercase font-body">Tổng sản phẩm</span>
                            </div>
                            <p class="text-[20px] font-display text-foreground">${totalProducts}</p>
                        </div>
                        <div class="border border-border p-5">
                            <div class="flex items-center gap-2 mb-2 text-blue-600">
                                <i data-lucide="shopping-cart" class="w-4 h-4"></i>
                                <span class="text-[10px] tracking-[0.15em] uppercase font-body">Tổng đơn hàng</span>
                            </div>
                            <p class="text-[20px] font-display text-foreground">${totalOrders}</p>
                        </div>
                        <div class="border border-border p-5">
                            <div class="flex items-center gap-2 mb-2 text-purple-600">
                                <i data-lucide="users" class="w-4 h-4"></i>
                                <span class="text-[10px] tracking-[0.15em] uppercase font-body">Khách hàng</span>
                            </div>
                            <p class="text-[20px] font-display text-foreground">${totalCustomers}</p>
                        </div>
                        <div class="border border-border p-5">
                            <div class="flex items-center gap-2 mb-2 text-orange-600">
                                <i data-lucide="alert-circle" class="w-4 h-4"></i>
                                <span class="text-[10px] tracking-[0.15em] uppercase font-body">Đơn chưa xử lý</span>
                            </div>
                            <p class="text-[20px] font-display text-foreground text-orange-600">${pendingOrders}</p>
                        </div>
                    </div>

                    <div class="border border-border p-6 mb-8 bg-card shadow-sm">
                        <div class="flex items-center justify-between mb-4">
                            <h2 class="text-[12px] tracking-[0.15em] uppercase font-body text-foreground font-bold">Biểu đồ doanh thu</h2>
                            <div class="flex gap-1">
                                <button onclick="updateChart('month')" class="tab-btn active text-[10px] font-body px-3 py-1 border border-border transition-colors" id="tabMonth">Theo tháng</button>
                                <button onclick="updateChart('day')" class="tab-btn text-[10px] font-body px-3 py-1 border border-border transition-colors" id="tabDay">Theo ngày</button>
                            </div>
                        </div>
                        <div class="relative h-[280px] w-full">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>

                    <div class="border border-border p-6 mb-8">
                        <h2 class="text-[12px] tracking-[0.15em] uppercase font-body text-foreground mb-4 font-bold">Sản phẩm theo danh mục</h2>
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
                            <c:forEach var="cat" items="${categoryStats}">
                                <div class="border border-border/50 p-4 text-center hover:bg-muted/20 transition-colors">
                                    <p class="text-[13px] font-body text-foreground capitalize font-medium">${cat.name}</p>
                                    <p class="text-[20px] font-display text-accent mt-1">${cat.productCount}</p>
                                    <p class="text-[10px] font-body text-muted-foreground mt-1 uppercase tracking-tighter">sản phẩm</p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="grid md:grid-cols-2 gap-6 mb-6">
                        <div class="border border-border p-5">
                            <h3 class="text-[11px] tracking-[0.15em] uppercase font-body text-foreground mb-4 flex items-center gap-2">
                                <i data-lucide="star" class="w-4 h-4 text-yellow-500 fill-yellow-500"></i> Đánh giá cao nhất
                            </h3>
                            <div class="scroll-list space-y-3 pr-1">
                                <c:forEach var="p" items="${topRated}" varStatus="i">
                                    <div class="flex items-center gap-3 group">
                                        <span class="text-[11px] font-body text-muted-foreground w-5">${i.index + 1}.</span>
                                        <div class="w-10 h-12 bg-secondary/50 overflow-hidden shrink-0 border border-border/50">
                                            <img src="${p.image}" alt="" class="w-full h-full object-cover group-hover:scale-110 transition-transform" onerror="this.src='https://placehold.co/400x500?text=BAG'"/>
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <p class="text-[12px] font-body text-foreground truncate uppercase font-medium">${p.name}</p>
                                            <p class="text-[11px] font-body text-muted-foreground italic">Rating: ${p.rating}/5.0</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="border border-border p-5">
                            <h3 class="text-[11px] tracking-[0.15em] uppercase font-body text-foreground mb-4 flex items-center gap-2 text-red-600">
                                <i data-lucide="flame" class="w-4 h-4"></i> Bán chạy nhất
                            </h3>
                            <div class="scroll-list space-y-3 pr-1">
                                <c:forEach var="p" items="${topSelling}" varStatus="i">
                                    <div class="flex items-center gap-3 group">
                                        <span class="text-[11px] font-body text-muted-foreground w-5">${i.index + 1}.</span>
                                        <div class="w-10 h-12 bg-secondary/50 overflow-hidden shrink-0 border border-border/50">
                                            <img src="${p.image}" alt="" class="w-full h-full object-cover group-hover:scale-110 transition-transform" onerror="this.src='https://placehold.co/400x500?text=BAG'"/>
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <p class="text-[12px] font-body text-foreground truncate uppercase font-medium">${p.name}</p>
                                            <p class="text-[11px] font-body text-muted-foreground">Đã bán: <strong>${p.sold}</strong> · Tồn: ${p.stock}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            lucide.createIcons();

            function toggleMobileSidebar() {
                var sidebar = document.getElementById('mobileSidebar');
                document.getElementById('menuIcon').classList.toggle('hidden');
                document.getElementById('closeIcon').classList.toggle('hidden');
                sidebar.classList.toggle('hidden');
            }

            // Dữ liệu đồng bộ với Servlet Dashboard
            const monthLabels = ['Th1', 'Th2', 'Th3', 'Th4', 'Th5', 'Th6', 'Th7', 'Th8', 'Th9', 'Th10', 'Th11', 'Th12'];
            const monthData = ${not empty monthlyRevenue ? monthlyRevenue : '[0,0,0,0,0,0,0,0,0,0,0,0]'};

            const dayLabels = ${not empty dailyRevenueLabels ? dailyRevenueLabels : "['No Data']"};
            const dayData = ${not empty dailyRevenue ? dailyRevenue : '[0]'};

            let currentChart;
            const ctx = document.getElementById('revenueChart').getContext('2d');

            function renderChart(type, labels, data) {
                if (currentChart) { currentChart.destroy(); }
                const isLine = type === 'line';

                currentChart = new Chart(ctx, {
                    type: isLine ? 'line' : 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: isLine ? 'rgba(122, 92, 62, 0.1)' : '#7A5C3E',
                            borderColor: '#7A5C3E',
                            borderWidth: 2,
                            fill: isLine,
                            tension: 0.4,
                            pointRadius: 4,
                            pointBackgroundColor: '#FAF7F2'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: { 
                                    font: { size: 10 }, 
                                    callback: v => v >= 1000000 ? (v / 1000000) + 'M' : v 
                                }
                            },
                            x: { 
                                ticks: { font: { size: 10 } }, 
                                grid: { display: false } 
                            }
                        }
                    }
                });
            }

            function switchRevenueTab(tab) {
                document.getElementById('tabMonth').classList.toggle('active', tab === 'month');
                document.getElementById('tabDay').classList.toggle('active', tab === 'day');
                if (tab === 'month') {
                    renderChart('bar', monthLabels, monthData);
                } else {
                    renderChart('line', dayLabels, dayData);
                }
            }

            // Khởi tạo mặc định
            renderChart('bar', monthLabels, monthData);
            window.updateChart = switchRevenueTab;
        </script>
    </body>
</html>