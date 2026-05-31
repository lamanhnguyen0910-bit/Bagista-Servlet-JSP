<%-- 
    Document   : login
    Created on : Mar 5, 2026, 8:55:29 PM
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
        <title>BAGISTA — Đăng nhập</title>
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
            h1,h2,h3,h4,h5,h6 {
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
            .tab-active {
                color:#3D2E22;
            }
            .tab-active::after {
                content:'';
                position:absolute;
                bottom:0;
                left:0;
                right:0;
                height:1.5px;
                background:#6B4C3B;
            }
            .tab-inactive {
                color:#8C7B6B;
            }
            .form-section {
                display:none;
            }
            .form-section.active {
                display:block;
            }
        </style>
    </head>
    <body>
        <div class="flex min-h-screen">
            <div class="hidden lg:flex lg:w-1/2 relative overflow-hidden">
                <img src="${pageContext.request.contextPath}/assets/images/products/bagista-hero.jpg" alt="BAGISTA" class="absolute inset-0 w-full h-full object-cover" />
            </div>

            <div class="flex w-full lg:w-1/2 items-center justify-center px-10 py-12 bg-brand-bg">
                <div class="w-full max-w-[360px]">
                    <p class="text-center text-[13px] italic text-brand-accent leading-[1.7] mb-6 font-display">
                        "Phong cách không chỉ là thứ bạn mặc —<br/>mà còn là cách bạn mang nó."
                    </p>

                    <div class="text-center mb-8">
                        <a href="${pageContext.request.contextPath}/home" class="text-[42px] font-normal tracking-[0.28em] text-brand-text font-display hover:opacity-80 transition-opacity">BAGISTA</a>
                    </div>

                    <div class="flex items-center gap-3 mb-8">
                        <div class="flex-1 h-px bg-brand-border"></div>
                        <span id="formTitle" class="text-[10px] tracking-[0.2em] uppercase text-brand-muted font-body font-bold">Đăng nhập</span>
                        <div class="flex-1 h-px bg-brand-border"></div>
                    </div>

                    <%-- HIỂN THỊ LỖI TỪ SERVLET --%>
                    <c:if test="${not empty errorMessage}">
                        <div class="mb-6 p-3 border-l-2 border-brand-destructive bg-red-50 text-brand-destructive text-[12px] font-medium tracking-wide">
                            ${errorMessage}
                        </div>
                    </c:if>

                    <div id="loginForm" class="form-section active">
                        <div class="flex items-center justify-center border-b border-brand-border mb-7">
                            <button type="button" onclick="switchLoginMethod('username')" id="tabUsername" class="relative px-4 pb-2.5 text-[11px] tracking-[0.1em] uppercase font-body tab-active">
                                Username
                                <span id="tabUsernameLine" class="absolute bottom-0 left-0 right-0 h-[1.5px] bg-brand-accent"></span>
                            </button>
                            <button type="button" onclick="switchLoginMethod('email')" id="tabEmail" class="relative px-4 pb-2.5 text-[11px] tracking-[0.1em] uppercase font-body tab-inactive">
                                Email
                                <span id="tabEmailLine" class="absolute bottom-0 left-0 right-0 h-[1.5px] bg-brand-accent hidden"></span>
                            </button>
                            <button type="button" onclick="switchLoginMethod('phone')" id="tabPhone" class="relative px-4 pb-2.5 text-[11px] tracking-[0.1em] uppercase font-body tab-inactive">
                                Số điện thoại
                                <span id="tabPhoneLine" class="absolute bottom-0 left-0 right-0 h-[1.5px] bg-brand-accent hidden"></span>
                            </button>
                        </div>

                        <form action="${pageContext.request.contextPath}/login" method="POST" class="space-y-5">
                            <div>
                                <label class="text-[10px] tracking-[0.18em] uppercase text-brand-muted font-body block mb-1">
                                    <span id="loginLabel">Username</span> <span class="text-brand-destructive">*</span>
                                </label>
                                <input type="text" name="identifier" id="loginIdentifier" placeholder="tên đăng nhập" class="input-underline" required />
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.18em] uppercase text-brand-muted font-body block mb-1">Mật khẩu <span class="text-brand-destructive">*</span></label>
                                <div class="relative">
                                    <input type="password" name="password" id="loginPassword" placeholder="••••••••" class="input-underline pr-10" required />
                                    <button type="button" onclick="togglePassword('loginPassword', this)" class="absolute right-0 top-1/2 -translate-y-1/2 text-brand-muted hover:text-brand-text">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                    </button>
                                </div>
                            </div>
                            <input type="hidden" name="loginMethod" id="loginMethodField" value="username" />

                            <div class="text-right pt-0.5">
                                <a href="${pageContext.request.contextPath}/forgotpassword" class="text-[11px] tracking-wide text-brand-muted hover:text-brand-accent font-body">Quên mật khẩu?</a>
                            </div>
                            <button type="submit" class="w-full bg-brand-accent text-brand-accent-fg py-3.5 text-[11px] tracking-[0.25em] uppercase font-bold hover:opacity-90 transition-opacity mt-2">
                                Đăng nhập
                            </button>
                        </form>
                    </div>

                    <%-- Signup Form: Đã cập nhật khớp Servlet --%>
                    <div id="signupForm" class="form-section">
                        <form action="${pageContext.request.contextPath}/register" method="POST" class="space-y-4">
                            <div>
                                <label class="text-[10px] tracking-[0.18em] uppercase text-brand-muted font-body block mb-1">Username <span class="text-brand-destructive">*</span></label>
                                <input type="text" name="username" placeholder="tên đăng nhập mới" class="input-underline" required />
                            </div>
                            <div>
                                <div class="flex items-center gap-4 mb-2">
                                    <button type="button" onclick="switchContactMethod('email')" id="contactEmail" class="text-[10px] tracking-[0.15em] uppercase font-body text-brand-text border-b border-brand-accent pb-0.5">Email <span class="text-brand-destructive">*</span></button>
                                    <button type="button" onclick="switchContactMethod('phone')" id="contactPhone" class="text-[10px] tracking-[0.15em] uppercase font-body text-brand-muted">Số điện thoại <span class="text-brand-destructive">*</span></button>
                                </div>
                                <%-- Cập nhật: name="contact" để khớp RegisterServlet --%>
                                <input type="text" name="contact" id="contactInput" placeholder="you@example.com" class="input-underline" required />
                                <%-- Cập nhật: name="contactMethod" để khớp RegisterServlet --%>
                                <input type="hidden" name="contactMethod" id="contactMethodField" value="email" />
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.18em] uppercase text-brand-muted font-body block mb-1">Mật khẩu <span class="text-brand-destructive">*</span></label>
                                <div class="relative">
                                    <input type="password" name="password" id="signupPassword" placeholder="tối thiểu 6 ký tự" class="input-underline pr-10" required />
                                    <button type="button" onclick="togglePassword('signupPassword', this)" class="absolute right-0 top-1/2 -translate-y-1/2 text-brand-muted hover:text-brand-text">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                    </button>
                                </div>
                            </div>
                            <div>
                                <label class="text-[10px] tracking-[0.18em] uppercase text-brand-muted font-body block mb-1">Nhập lại mật khẩu <span class="text-brand-destructive">*</span></label>
                                <div class="relative">
                                    <input type="password" name="confirmPassword" id="confirmPassword" placeholder="xác nhận mật khẩu" class="input-underline pr-10" required />
                                    <button type="button" onclick="togglePassword('confirmPassword', this)" class="absolute right-0 top-1/2 -translate-y-1/2 text-brand-muted hover:text-brand-text">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                    </button>
                                </div>
                            </div>
                            <button type="submit" class="w-full bg-brand-accent text-brand-accent-fg py-3.5 text-[11px] tracking-[0.25em] uppercase font-bold hover:opacity-90 transition-opacity mt-2">
                                Tạo tài khoản
                            </button>
                        </form>
                    </div>

                    <p class="text-center text-[12px] text-brand-muted tracking-wide mt-8 font-body">
                        <span id="toggleText">Chưa có tài khoản?</span>
                        <button type="button" onclick="toggleForm()" class="text-brand-text hover:text-brand-accent font-bold tracking-wider ml-1" id="toggleBtn">Đăng ký ngay</button>
                    </p>
                    <br/>
                    <div class="flex justify-center mb-8">
                        <a href="${pageContext.request.contextPath}/home" class="inline-flex items-center gap-2 text-[10px] font-bold uppercase tracking-[0.2em] text-brand-muted hover:text-brand-text transition-all group">
                            <svg class="w-3 h-3 transition-transform group-hover:-translate-x-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
                            Quay về trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let isSignUp = false;

            function toggleForm() {
                isSignUp = !isSignUp;
                document.getElementById('loginForm').classList.toggle('active', !isSignUp);
                document.getElementById('signupForm').classList.toggle('active', isSignUp);
                document.getElementById('formTitle').textContent = isSignUp ? 'Tạo tài khoản' : 'Đăng nhập';
                document.getElementById('toggleText').textContent = isSignUp ? 'Đã có tài khoản?' : 'Chưa có tài khoản?';
                document.getElementById('toggleBtn').textContent = isSignUp ? 'Đăng nhập' : 'Đăng ký ngay';
            }

            function switchLoginMethod(method) {
                const methods = ['email', 'phone', 'username'];
                const labels = {email: 'Email', phone: 'Số điện thoại', username: 'Username'};
                const placeholders = {email: 'you@example.com', phone: '0912 345 678', username: 'tên đăng nhập'};
                const types = {email: 'email', phone: 'tel', username: 'text'};

                methods.forEach(m => {
                    const tabBtn = document.getElementById('tab' + m.charAt(0).toUpperCase() + m.slice(1));
                    const line = document.getElementById('tab' + m.charAt(0).toUpperCase() + m.slice(1) + 'Line');

                    if (m === method) {
                        tabBtn.className = 'relative px-4 pb-2.5 text-[11px] tracking-[0.1em] uppercase font-body tab-active';
                        if (line)
                            line.classList.remove('hidden');
                    } else {
                        tabBtn.className = 'relative px-4 pb-2.5 text-[11px] tracking-[0.1em] uppercase font-body tab-inactive';
                        if (line)
                            line.classList.add('hidden');
                    }
                });

                document.getElementById('loginLabel').textContent = labels[method];
                document.getElementById('loginIdentifier').placeholder = placeholders[method];
                document.getElementById('loginIdentifier').type = types[method];
                document.getElementById('loginMethodField').value = method;
            }

            function switchContactMethod(method) {
                document.getElementById('contactEmail').className = 'text-[10px] tracking-[0.15em] uppercase font-body ' + (method === 'email' ? 'text-brand-text border-b border-brand-accent pb-0.5' : 'text-brand-muted');
                document.getElementById('contactPhone').className = 'text-[10px] tracking-[0.15em] uppercase font-body ' + (method === 'phone' ? 'text-brand-text border-b border-brand-accent pb-0.5' : 'text-brand-muted');
                document.getElementById('contactInput').placeholder = method === 'email' ? 'you@example.com' : '0912 345 678';
                document.getElementById('contactInput').type = method === 'email' ? 'email' : 'tel';
                document.getElementById('contactMethodField').value = method;
            }

            function togglePassword(inputId, btn) {
                const input = document.getElementById(inputId);
                input.type = input.type === 'password' ? 'text' : 'password';
            }
        </script>
    </body>
</html>