USE BagistaDB;
GO
------------------------------------------------
-- 1. CHUẨN BỊ BẢNG TẠM (Chỉ gồm các cột trong CSV)
------------------------------------------------
IF OBJECT_ID('TempImport', 'U') IS NOT NULL DROP TABLE TempImport;

CREATE TABLE TempImport (
    name NVARCHAR(255),
    price INT,
    stock INT,
    categoryName NVARCHAR(255),
    materialName NVARCHAR(255),
    tag NVARCHAR(100),
    description NVARCHAR(MAX),
    colors NVARCHAR(500),
    sizes NVARCHAR(255),
    variantStocks NVARCHAR(MAX),
    image1 NVARCHAR(MAX),
    image2 NVARCHAR(MAX),
    image3 NVARCHAR(MAX),
    image4 NVARCHAR(MAX),
    image5 NVARCHAR(MAX)
);

------------------------------------------------
-- 2. BULK INSERT (Khớp 100% số cột)
------------------------------------------------
BULK INSERT TempImport
FROM 'D:\BAGISTA\Bagista\ProductData02.csv' -- Kiểm tra kỹ đường dẫn này nhé Lâm
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'
);

-- SAU KHI NẠP XONG, THÊM CỘT PRODUCTID ĐỂ XỬ LÝ TIẾP
ALTER TABLE TempImport ADD productId INT NULL;
GO

------------------------------------------------
-- 3. XỬ LÝ SẢN PHẨM (INSERT/UPDATE)
------------------------------------------------
-- Đánh dấu sản phẩm nếu đã tồn tại 
UPDATE t
SET productId = p.id
FROM TempImport t
JOIN Products p ON p.name = t.name;

-- Cập nhật sản phẩm cũ (nếu có)
UPDATE p
SET
    p.price = t.price,
    p.categoryId = ISNULL(c.id, p.categoryId),
    p.materialId = ISNULL(m.id, p.materialId),
    p.tag = NULLIF(LTRIM(RTRIM(t.tag)),''),
    p.description = ISNULL(t.description, p.description)
FROM Products p
JOIN TempImport t ON p.id = t.productId
LEFT JOIN Categories c ON c.name = LTRIM(RTRIM(t.categoryName))
LEFT JOIN Materials m ON m.name = LTRIM(RTRIM(t.materialName))
WHERE t.productId IS NOT NULL;

DELETE FROM Products WHERE createdAt >= CAST(GETDATE() AS DATE); 
-- Hoặc nếu Lâm muốn chắc chắn sạch 100%, hãy dùng lại script xóa sạch/reset ID mình gửi lúc trước.
-- Thêm sản phẩm mới
INSERT INTO Products (name, price, stock, sold, rating, categoryId, materialId, tag, description, isActive)
SELECT 
    t.name, 
    t.price, 
    0, 0, 0, 
    c.id, 
    m.id, 
    NULLIF(LTRIM(RTRIM(t.tag)),''), 
    t.description, 
    1
FROM TempImport t
LEFT JOIN Categories c ON c.name = LTRIM(RTRIM(t.categoryName))
LEFT JOIN Materials m ON m.name = LTRIM(RTRIM(t.materialName))
WHERE t.productId IS NULL 
  AND t.name IS NOT NULL -- QUAN TRỌNG: Chặn dòng trống từ CSV
  AND LTRIM(RTRIM(t.name)) <> ''; -- Chặn dòng chỉ có dấu cách

------------------------------------------------
-- 4. DỌN RÁC TRONG BẢNG TẠM (Để tránh lỗi Join)
------------------------------------------------
DELETE FROM TempImport WHERE name IS NULL OR LTRIM(RTRIM(name)) = '';

------------------------------------------------
-- 5. CẬP NHẬT productId (Lệnh này của Lâm giữ nguyên - Rất tốt)
------------------------------------------------
UPDATE t
SET productId = p.id
FROM TempImport t
JOIN Products p ON p.name = t.name
WHERE t.productId IS NULL;

------------------------------------------------
-- 6. XỬ LÝ BIẾN THỂ (ProductVariants)
------------------------------------------------
-- Chỉ xóa biến thể của những sản phẩm có productId hợp lệ
DELETE FROM ProductVariants 
WHERE productId IN (SELECT productId FROM TempImport WHERE productId IS NOT NULL);

-- Bóc tách và Insert
INSERT INTO ProductVariants (productId, colorId, sizeId, stock)
SELECT 
    t.productId,
    c.id,
    s2.id,
    CAST(LTRIM(RTRIM(SUBSTRING(val.v, CHARINDEX(':', val.v) + 1, LEN(val.v)))) AS INT)
FROM (
    SELECT productId, LTRIM(RTRIM(s.value)) as v
    FROM TempImport
    CROSS APPLY STRING_SPLIT(variantStocks, ';') s
    WHERE LTRIM(RTRIM(s.value)) <> '' AND productId IS NOT NULL -- Chặn dòng rác
) val
JOIN TempImport t ON t.productId = val.productId
JOIN Colors c ON c.name = LTRIM(RTRIM(LEFT(val.v, CHARINDEX('-', val.v) - 1)))
JOIN Sizes s2 ON s2.name = LTRIM(RTRIM(SUBSTRING(val.v, CHARINDEX('-', val.v) + 1, CHARINDEX(':', val.v) - CHARINDEX('-', val.v) - 1)))
WHERE val.v LIKE '%-%:%';

------------------------------------------------
-- 7. XỬ LÝ ẢNH (ProductImages)
------------------------------------------------
ALTER TABLE ProductImages
ALTER COLUMN imagePath NVARCHAR(MAX) NOT NULL;
-- Chỉ xóa ảnh của những sản phẩm có productId hợp lệ
DELETE pi 
FROM ProductImages pi 
JOIN TempImport t ON pi.productId = t.productId
WHERE t.productId IS NOT NULL;

INSERT INTO ProductImages(productId, imagePath, sortOrder)
SELECT productId, imagePath, ROW_NUMBER() OVER(PARTITION BY productId ORDER BY sortOrder)
FROM (
    SELECT productId, LTRIM(RTRIM(image1)) imagePath, 1 sortOrder FROM TempImport WHERE image1 <> '' AND productId IS NOT NULL
    UNION ALL SELECT productId, LTRIM(RTRIM(image2)), 2 FROM TempImport WHERE image2 <> '' AND productId IS NOT NULL
    UNION ALL SELECT productId, LTRIM(RTRIM(image3)), 3 FROM TempImport WHERE image3 <> '' AND productId IS NOT NULL
    UNION ALL SELECT productId, LTRIM(RTRIM(image4)), 4 FROM TempImport WHERE image4 <> '' AND productId IS NOT NULL
    UNION ALL SELECT productId, LTRIM(RTRIM(image5)), 5 FROM TempImport WHERE image5 <> '' AND productId IS NOT NULL
) imgs;

PRINT N'IMPORT HOÀN TẤT - TỔNG KHO SẼ TỰ ĐỘNG CẬP NHẬT QUA TRIGGER';
GO


-- TEST THỬ
SELECT * FROM Products
SELECT * FROM ProductVariants
SELECT * FROM ProductImages
SELECT * FROM Colors
SELECT * FROM Materials
SELECT * FROM Sizes
SELECT * FROM Categories

DROP TABLE TempImport

USE BagistaDB;
GO

-- 1. Xóa các ảnh cũ của sản phẩm 101
DELETE FROM ProductImages WHERE productId = 101;

-- 2. Chèn các ảnh mới
INSERT INTO ProductImages (productId, imagePath, sortOrder)
VALUES 
(101, N'https://www.charleskeith.vn/dw/image/v2/BCWJ_PRD/on/demandware.static/-/Sites-vn-products/default/dw7164294c/images/hi-res/2026-L2-CK2-40151610-73-1.jpg?sw=756&sh=1008', 1),
(101, N'https://www.charleskeith.vn/dw/image/v2/BCWJ_PRD/on/demandware.static/-/Sites-vn-products/default/dw74f32677/images/hi-res/2026-L2-CK2-40151610-73-4.jpg?sw=756&sh=1008', 2),
(101, N'https://www.charleskeith.vn/dw/image/v2/BCWJ_PRD/on/demandware.static/-/Sites-vn-products/default/dwe1c8930e/images/hi-res/2026-L2-CK2-40151610-09-1.jpg?sw=756&sh=1008', 3),
(101, N'https://www.charleskeith.vn/dw/image/v2/BCWJ_PRD/on/demandware.static/-/Sites-vn-products/default/dw4c76e10f/images/hi-res/2026-L2-CK2-40151610-09-2.jpg?sw=756&sh=1008', 4),
(101, N'https://www.charleskeith.vn/dw/image/v2/BCWJ_PRD/on/demandware.static/-/Sites-vn-products/default/dwdb8b9084/images/hi-res/2026-L2-CK2-40151610-01-1.jpg?sw=756&sh=1008', 5);
