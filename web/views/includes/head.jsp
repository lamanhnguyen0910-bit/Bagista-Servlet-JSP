<%-- 
    Document   : head
    Created on : Mar 6, 2026, 8:34:33 AM
    Author     : laman
--%>
<%--
  ============================================================
  BAGISTA ? Common Head (CSS, Fonts, Tailwind Config)
  ============================================================
  Sử dụng: <%@ include file="/includes/head.jsp" %>
  ??t trong th? <head> c?a m?i trang JSP
  ============================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
                        secondary: '#F0E9E0',
                        destructive: '#DC2626'
                    }
                }
            }
        }
    }
</script>
<style>
    body {
        background: #FAF6F1;
        color: #3D2E22;
        font-family: 'Inter', sans-serif;
    }
    h1, h2, h3, h4, h5, h6 {
        font-family: 'Playfair Display', serif;
    }
    .mobile-menu {
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.3s ease, opacity 0.3s ease;
        opacity: 0;
    }
    .mobile-menu.open {
        max-height: 400px;
        opacity: 1;
    }
    .user-dropdown {
        display: none;
    }
    .user-dropdown.open {
        display: block;
    }
    .product-card:hover {
        transform: translateY(-4px);
    }
    .product-card img:hover {
        transform: scale(1.05);
    }
    .input-underline {
        width: 100%;
        background: transparent;
        border: none;
        border-bottom: 1px solid #E8DFD4;
        padding: 10px 0;
        font-size: 14px;
        font-family: 'Inter', sans-serif;
        color: #3D2E22;
        outline: none;
        transition: border-color 0.3s;
    }
    .input-underline:focus {
        border-bottom-color: #6B4C3B;
    }
    .input-underline::placeholder {
        color: rgba(140, 123, 107, 0.4);
    }
</style>
