<%-- 
    Document   : forgot-password
    Created on : Mar 5, 2026, 9:06:23 PM
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
        <title>BAGISTA — Quên mật khẩu</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet" />
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {display: ['"Playfair Display"', 'serif'], body: ['"Inter"', 'sans-serif']},
                        colors: {
                            brand: {bg: '#FAF6F1', card: '#FFFFFF', border: '#E8DFD4', text: '#3D2E22', muted: '#8C7B6B', accent: '#6B4C3B', 'accent-fg': '#FAF6F1', secondary: '#F0E9E0', destructive: '#DC2626'}
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
            h1,h2,h3 {
                font-family:'Playfair Display',serif;
            }
            .input-underline {
                width:100%;
                background:transparent;
                border:none;
                border-bottom:1px solid #E8DFD4;
                padding:10px 0;
                font-size:14px;
                font-family:'Inter',sans-serif;
                color:#3D2E22;
                outline:none;
                transition:border-color 0.3s;
            }
            .input-underline:focus {
                border-bottom-color:#6B4C3B;
            }
            .input-underline::placeholder {
                color:rgba(140,123,107,0.4);
            }
        </style>
    </head>
    <body>
        <div class="flex min-h-screen">
            <%-- Hero Image: Lưu ý đường dẫn ảnh cũng nên dùng path tuyệt đối nếu cần --%>
            <div class="hidden lg:flex lg:w-1/2 relative overflow-hidden">
                <img src="${pageContext.request.contextPath}/assets/images/products/bagista-hero.jpg" alt="BAGISTA" class="absolute inset-0 w-full h-full object-cover" />
            </div>

            <div class="flex w-full lg:w-1/2 items-center justify-center px-10 py-12 bg-brand-bg">
                <div class="w-full max-w-[360px]">
                    <div class="text-center mb-6">
                        <%-- URL TRANG CHỦ --%>
                        <a href="${pageContext.request.contextPath}/home" class="text-[42px] font-normal tracking-[0.28em] text-brand-text font-display hover:opacity-80 transition-opacity">BAGISTA</a>
                    </div>

                    <div class="flex items-center gap-3 mb-8">
                        <div class="flex-1 h-px bg-brand-border"></div>
                        <span class="text-[10px] tracking-[0.2em] uppercase text-brand-muted font-body">Quên mật khẩu</span>
                        <div class="flex-1 h-px bg-brand-border"></div>
                    </div>

                    <c:if test="${not empty successMessage}">
                        <div id="successMsg" class="mb-6 p-4 border border-green-300 bg-green-50 text-green-700 text-[13px] font-body leading-relaxed">
                            ${successMessage}
                            <div class="mt-4">
                                <%-- URL ĐĂNG NHẬP SAU THÀNH CÔNG --%>
                                <a href="${pageContext.request.contextPath}/login" class="inline-block bg-brand-accent text-brand-accent-fg py-2.5 px-6 text-[11px] tracking-[0.2em] uppercase font-body hover:opacity-90 transition-opacity">
                                    Quay lại đăng nhập
                                </a>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                        <div id="errorMsg" class="mb-4 p-3 border border-red-300 bg-red-50 text-red-700 text-[12px] font-body">
                            ${errorMessage}
                        </div>
                    </c:if>

                    <c:if test="${empty successMessage}">
                        <div>
                            <p class="text-[13px] text-brand-muted font-body leading-relaxed mb-6">
                                Nhập địa chỉ email đã đăng ký tài khoản. Chúng tôi sẽ gửi cho bạn một liên kết để đặt lại mật khẩu.
                            </p>

                            <%-- ACTION CỦA FORM --%>
                            <form action="${pageContext.request.contextPath}/forgotpassword" method="POST" class="space-y-5">
                                <div>
                                    <label class="text-[10px] tracking-[0.18em] uppercase text-brand-muted font-body block mb-1">
                                        Email <span class="text-brand-destructive">*</span>
                                    </label>
                                    <input type="email" name="email" placeholder="you@example.com" class="input-underline" required />
                                </div>

                                <button type="submit" class="w-full bg-brand-accent text-brand-accent-fg py-3.5 text-[11px] tracking-[0.25em] uppercase font-body hover:opacity-90 transition-opacity">
                                    Gửi link đặt lại
                                </button>
                            </form>
                        </div>
                    </c:if>

                    <p class="text-center text-[12px] text-brand-muted tracking-wide mt-8 font-body">
                        <%-- URL QUAY LẠI ĐĂNG NHẬP --%>
                        <a href="${pageContext.request.contextPath}/login" class="text-brand-text hover:text-brand-accent tracking-wider">
                            ← Quay lại đăng nhập
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </body>
</html>