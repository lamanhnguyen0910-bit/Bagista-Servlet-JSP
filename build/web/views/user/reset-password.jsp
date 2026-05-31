<%-- 
    Document   : reset-password
    Created on : Mar 5, 2026, 9:06:33 PM
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
        <title>BAGISTA — Đặt lại mật khẩu</title>
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
            <div class="hidden lg:flex lg:w-1/2 relative overflow-hidden">
                <%-- CẬP NHẬT: Đường dẫn ảnh tuyệt đối --%>
                <img src="${pageContext.request.contextPath}/assets/images/products/bagista-hero.jpg" alt="BAGISTA" class="absolute inset-0 w-full h-full object-cover" />
            </div>

            <div class="flex w-full lg:w-1/2 items-center justify-center px-10 py-12 bg-brand-bg">
                <div class="w-full max-w-[360px]">
                    <div class="text-center mb-6">
                        <%-- CẬP NHẬT: Link về Home --%>
                        <a href="${pageContext.request.contextPath}/home" class="text-[42px] font-normal tracking-[0.28em] text-brand-text font-display hover:opacity-80 transition-opacity">BAGISTA</a>
                    </div>

                    <div class="flex items-center gap-3 mb-8">
                        <div class="flex-1 h-px bg-brand-border"></div>
                        <span class="text-[10px] tracking-[0.2em] uppercase text-brand-muted font-body">Đặt lại mật khẩu</span>
                        <div class="flex-1 h-px bg-brand-border"></div>
                    </div>

                    <c:if test="${resetSuccess}">
                        <div class="mb-6 p-4 border border-green-300 bg-green-50 text-green-700 text-[13px] font-body leading-relaxed">
                            ${successMessage}
                            <div class="mt-4">
                                <%-- CẬP NHẬT: Link đăng nhập --%>
                                <a href="${pageContext.request.contextPath}/login" class="inline-block bg-brand-accent text-brand-accent-fg py-2.5 px-6 text-[11px] tracking-[0.2em] uppercase font-body hover:opacity-90 transition-opacity">
                                    Đăng nhập ngay
                                </a>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                        <div class="mb-4 p-3 border border-red-300 bg-red-50 text-red-700 text-[12px] font-body">
                            ${errorMessage}
                        </div>
                    </c:if>

                    <c:if test="${tokenValid && !resetSuccess}">
                        <div>
                            <p class="text-[13px] text-brand-muted font-body leading-relaxed mb-6">
                                Nhập mật khẩu mới cho tài khoản của bạn.
                            </p>

                            <%-- CẬP NHẬT: Form action --%>
                            <form action="${pageContext.request.contextPath}/resetpassword" method="POST" class="space-y-5" onsubmit="return validateResetForm()">
                                <input type="hidden" name="token" value="${token}" />

                                <div>
                                    <label class="text-[10px] tracking-[0.18em] uppercase text-brand-muted font-body block mb-1">
                                        Mật khẩu mới <span class="text-brand-destructive">*</span>
                                    </label>
                                    <div class="relative">
                                        <input type="password" name="newPassword" id="newPassword" placeholder="••••••••" class="input-underline pr-10" required minlength="6" />
                                        <button type="button" onclick="togglePassword('newPassword')" class="absolute right-0 top-1/2 -translate-y-1/2 text-brand-muted hover:text-brand-text">
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                        </button>
                                    </div>
                                </div>

                                <div>
                                    <label class="text-[10px] tracking-[0.18em] uppercase text-brand-muted font-body block mb-1">
                                        Xác nhận mật khẩu <span class="text-brand-destructive">*</span>
                                    </label>
                                    <div class="relative">
                                        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="••••••••" class="input-underline pr-10" required minlength="6" />
                                        <button type="button" onclick="togglePassword('confirmPassword')" class="absolute right-0 top-1/2 -translate-y-1/2 text-brand-muted hover:text-brand-text">
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                        </button>
                                    </div>
                                </div>

                                <div id="resetError" class="hidden text-brand-destructive text-[12px] font-body"></div>

                                <button type="submit" class="w-full bg-brand-accent text-brand-accent-fg py-3.5 text-[11px] tracking-[0.25em] uppercase font-body hover:opacity-90 transition-opacity">
                                    Cập nhật mật khẩu
                                </button>
                            </form>
                        </div>
                    </c:if>

                    <c:if test="${!tokenValid && !resetSuccess}">
                        <div class="text-center">
                            <p class="text-[13px] text-brand-muted font-body mb-6">Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.</p>
                            <%-- CẬP NHẬT: Link yêu cầu lại --%>
                            <a href="${pageContext.request.contextPath}/forgotpassword" class="inline-block bg-brand-accent text-brand-accent-fg py-2.5 px-6 text-[11px] tracking-[0.2em] uppercase font-body hover:opacity-90 transition-opacity">
                                Yêu cầu link mới
                            </a>
                        </div>
                    </c:if>

                    <p class="text-center text-[12px] text-brand-muted tracking-wide mt-8 font-body">
                        <%-- CẬP NHẬT: Link quay lại đăng nhập --%>
                        <a href="${pageContext.request.contextPath}/login" class="text-brand-text hover:text-brand-accent tracking-wider">
                            ← Quay lại đăng nhập
                        </a>
                    </p>
                </div>
            </div>
        </div>

        <script>
            function togglePassword(inputId) {
                const input = document.getElementById(inputId);
                input.type = input.type === 'password' ? 'text' : 'password';
            }

            function validateResetForm() {
                const pw = document.getElementById('newPassword').value;
                const confirm = document.getElementById('confirmPassword').value;
                const errorDiv = document.getElementById('resetError');

                if (pw.length < 6) {
                    errorDiv.textContent = 'Mật khẩu phải từ 6 ký tự trở lên.';
                    errorDiv.classList.remove('hidden');
                    return false;
                }
                if (pw !== confirm) {
                    errorDiv.textContent = 'Mật khẩu xác nhận không khớp.';
                    errorDiv.classList.remove('hidden');
                    return false;
                }
                errorDiv.classList.add('hidden');
                return true;
            }
        </script>
    </body>
</html>