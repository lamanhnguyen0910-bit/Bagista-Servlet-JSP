-- ============================================================
-- BAGISTA Database Schema — SQL Server
-- ============================================================

-- Tạo Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'BagistaDB')
    CREATE DATABASE BagistaDB;
GO

USE BagistaDB;
GO

-- ============================================================
-- 1. BẢNG USERS (Tài khoản người dùng)
-- ============================================================
CREATE TABLE Users (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    username    NVARCHAR(50)  NOT NULL UNIQUE, -- Luôn bắt buộc và duy nhất
    password    NVARCHAR(255) NOT NULL,        -- Đủ độ dài cho BCrypt
    fullName    NVARCHAR(100),                 -- Cho phép NULL
    email       NVARCHAR(100),                 -- Không để UNIQUE ở đây
    phone       NVARCHAR(20),                  -- Không để UNIQUE ở đây
    birthday    DATE,
    address     NVARCHAR(255),
    role        NVARCHAR(20)  NOT NULL DEFAULT 'user',
    isActive    BIT           NOT NULL DEFAULT 1,
    createdAt   DATETIME      NOT NULL DEFAULT GETDATE()
);
GO
-- Tạo Filtered Index để cho phép nhiều người cùng NULL Email/Phone 
-- nhưng nếu đã nhập thì không được trùng.
CREATE UNIQUE INDEX UIX_Users_Email 
ON Users(email) WHERE email IS NOT NULL;

CREATE UNIQUE INDEX UIX_Users_Phone 
ON Users(phone) WHERE phone IS NOT NULL;
GO

-- ============================================================
-- 2. BẢNG CATEGORIES (Danh mục sản phẩm)
-- ============================================================
CREATE TABLE Categories (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    name        NVARCHAR(100) NOT NULL UNIQUE,
    description NVARCHAR(255)
);
GO

-- ============================================================
-- 3. BẢNG COLORS
-- ============================================================
CREATE TABLE Colors (
    id   INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- ============================================================
-- 4. BẢNG SIZES
-- ============================================================
CREATE TABLE Sizes (
    id   INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- ============================================================
-- 5. BẢNG MATERIALS
-- ============================================================
CREATE TABLE Materials (
    id   INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- ============================================================
-- 6. BẢNG PRODUCTS (Sản phẩm)
-- ============================================================
CREATE TABLE Products (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    name        NVARCHAR(200) NOT NULL,
    price       DECIMAL(18,0) NOT NULL,
    stock       INT           NOT NULL DEFAULT 0, -- Tổng kho (tự động cập nhật)
    sold        INT           NOT NULL DEFAULT 0,
    rating      DECIMAL(2,1)  DEFAULT 0,
    categoryId  INT           FOREIGN KEY REFERENCES Categories(id),
    materialId  INT           FOREIGN KEY REFERENCES Materials(id),
    tag         NVARCHAR(20),   -- 'new', 'hot', 'bestseller'
    description NVARCHAR(MAX),
    isActive    BIT           NOT NULL DEFAULT 1,
    createdAt   DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ============================================================
-- 7. BẢNG PRODUCT_IMAGES (Ảnh sản phẩm — tối đa 5)
-- ============================================================
CREATE TABLE ProductImages (
    id        INT IDENTITY(1,1) PRIMARY KEY,
    productId INT NOT NULL FOREIGN KEY REFERENCES Products(id) ON DELETE CASCADE,
    imagePath NVARCHAR(255) NOT NULL,
    sortOrder INT DEFAULT 0
);
GO

-- ============================================================
-- 8. BẢNG PRODUCT_VARIANTS (MỚI: Quản lý chi tiết từng Màu - Size)
-- ============================================================
CREATE TABLE ProductVariants (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    productId   INT NOT NULL FOREIGN KEY REFERENCES Products(id) ON DELETE CASCADE,
    colorId     INT NOT NULL FOREIGN KEY REFERENCES Colors(id),
    sizeId      INT NOT NULL FOREIGN KEY REFERENCES Sizes(id),
    stock       INT NOT NULL DEFAULT 0, -- Số lượng thực tế của đúng cặp Màu-Size này
    UNIQUE (productId, colorId, sizeId)
);

-- ============================================================
-- 9. BẢNG ORDERS (Đơn hàng)
-- ============================================================
CREATE TABLE Orders (
    id             INT IDENTITY(1,1) PRIMARY KEY,
    userId         INT           FOREIGN KEY REFERENCES Users(id),
    recipientName  NVARCHAR(100) NOT NULL,
    recipientPhone NVARCHAR(20)  NOT NULL,
    recipientAddress NVARCHAR(255) NOT NULL,
    payment        NVARCHAR(20)  NOT NULL DEFAULT 'cod', -- 'cod', 'bank'
    note           NVARCHAR(500),
    total          DECIMAL(18,0) NOT NULL DEFAULT 0,
    status         NVARCHAR(20)  NOT NULL DEFAULT N'Chờ xử lý',
    createdAt      DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ============================================================
-- 10. BẢNG ORDER_DETAILS (Chi tiết đơn hàng)
-- ============================================================
CREATE TABLE OrderDetails (
    id        INT IDENTITY(1,1) PRIMARY KEY,
    orderId   INT           NOT NULL FOREIGN KEY REFERENCES Orders(id) ON DELETE CASCADE,
    productId INT           NOT NULL FOREIGN KEY REFERENCES Products(id),
    quantity  INT           NOT NULL DEFAULT 1,
    price     DECIMAL(18,0) NOT NULL,  -- Giá tại thời điểm mua
    color     NVARCHAR(50)  NULL,      -- Màu sắc đã chọn
    size      NVARCHAR(50)  NULL       -- Kích cỡ đã chọn
);
GO

-- 1. Thêm cột variantId
ALTER TABLE OrderDetails ADD variantId INT;
GO
-- 2. Thêm khóa ngoại liên kết sang bảng ProductVariants
ALTER TABLE OrderDetails 
ADD CONSTRAINT FK_OrderDetails_ProductVariants 
FOREIGN KEY (variantId) REFERENCES ProductVariants(id);
GO
-- Sau này khi Insert đơn hàng, nhớ lưu cả variantId vào đây nhé Lâm!

-- ============================================================
-- 11. BẢNG REVIEWS (Đánh giá sản phẩm)
-- ============================================================
CREATE TABLE Reviews (
    id        INT IDENTITY(1,1) PRIMARY KEY,
    productId INT NOT NULL FOREIGN KEY REFERENCES Products(id) ON DELETE CASCADE,
    userId    INT NOT NULL FOREIGN KEY REFERENCES Users(id),
    rating    INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment   NVARCHAR(500),
    createdAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- ============================================================
-- 12. BẢNG DISCOUNTS (Giảm giá theo thời gian)
-- ============================================================
CREATE TABLE Discounts (
    id        INT IDENTITY(1,1) PRIMARY KEY,
    productId INT NOT NULL,
    [percent] INT NOT NULL CHECK ([percent] BETWEEN 1 AND 99), -- Dùng [ ] để tránh lỗi từ khóa
    startDate DATE NOT NULL,
    endDate   DATE NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT GETDATE(),
    
    -- Khai báo Foreign Key riêng để dễ quản lý hoặc đặt tên Constraint
    CONSTRAINT FK_Discounts_Products FOREIGN KEY (productId) 
        REFERENCES Products(id) ON DELETE CASCADE,
        
    -- Ràng buộc logic: Ngày bắt đầu không được lớn hơn ngày kết thúc
    CONSTRAINT CHK_DiscountDates CHECK (startDate <= endDate)
);
GO

-- Index cho tìm kiếm discount theo sản phẩm và thời gian
-- Tối ưu hóa việc truy vấn "Sản phẩm này hiện có đang giảm giá không?"
CREATE INDEX IX_Discounts_Product ON Discounts(productId);
CREATE INDEX IX_Discounts_Dates ON Discounts(startDate, endDate);
GO

-- ============================================================
-- 13. BẢNG PASSWORD RESET TOKENS (Token đặt lại mật khẩu)
-- ============================================================
CREATE TABLE PasswordResetTokens (
    id        INT IDENTITY(1,1) PRIMARY KEY,
    userId    INT           NOT NULL REFERENCES Users(id) ON DELETE CASCADE,
    token     NVARCHAR(255) NOT NULL UNIQUE,
    expiresAt DATETIME      NOT NULL,
    createdAt DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- Index cho tìm kiếm token nhanh
CREATE INDEX IX_PasswordResetTokens_Token ON PasswordResetTokens(token);
CREATE INDEX IX_PasswordResetTokens_Expires ON PasswordResetTokens(expiresAt);
GO

CREATE TRIGGER trg_UpdateProductStock
ON ProductVariants
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Products
    SET stock = (SELECT ISNULL(SUM(stock), 0) 
                 FROM ProductVariants 
                 WHERE ProductVariants.productId = Products.id)
    WHERE id IN (SELECT productId FROM inserted UNION SELECT productId FROM deleted);
END;
GO

PRINT N'Database BagistaDB đã được tạo thành công!';
GO

-- ============================================================
-- 13. DỮ LIỆU CƠ BẢN (Bắt buộc)
-- ============================================================

-- Admin mặc định (password: admin123 — BCrypt hash)
INSERT INTO Users (username, password, fullName, email, role)
VALUES ('admin', '$2a$10$uE4YyH5g0Ms5eCRSrsfv5uHZYjVN.s.OqtQcHSbHOj8kBdD8ozI5S', N'Quản trị viên', 'admin@bagista.vn', 'admin');


INSERT INTO Categories (name, description) VALUES
(N'Túi Tote', N'Túi bản lớn, dáng vuông hoặc chữ nhật, đựng được nhiều đồ và rất đa năng.'),
(N'Túi Xách Tay', N'Phụ kiện có quai cầm tay, phù hợp cho môi trường công sở hoặc các sự kiện trang trọng.'),
(N'Túi Đeo Chéo', N'Kiểu túi có dây dài đeo qua người, tạo sự năng động và thoải mái khi di chuyển.'),
(N'Túi Đeo Vai', N'Thiết kế có dây vừa đủ để đeo dưới nách, mang lại vẻ thanh lịch và tiện dụng.'),
(N'Túi Clutch', N'Dạng túi cầm tay nhỏ gọn, không quai, là điểm nhấn sang trọng cho các buổi tiệc.'),
(N'Túi Hobo', N'Mang phong cách du mục với họa tiết thổ cẩm, tua rua và vẻ đẹp tự do, phóng khoáng.'),
(N'Túi Nhỏ', N'Phụ kiện kích thước mini dùng để đựng các vật dụng thiết yếu như son, chìa khóa.'),
(N'Ba lô', N'Túi có hai quai đeo trên lưng, giúp phân bổ trọng lượng và tối ưu không gian lưu trữ.');

-- Màu sắc (1=Đen, 2=Trắng, 3=Be, 4=Kem, 5=Nâu, 6=Xanh Navy, 7=Xanh Rêu, 8=Đỏ, 9=Hồng, 10=Vàng, 11=Cam, 12=Tím)
INSERT INTO Colors (name) VALUES
(N'Đen'), (N'Trắng'), (N'Be'), (N'Kem'), (N'Nâu'), (N'Xanh Navy'), (N'Xanh Rêu'), (N'Đỏ'), (N'Hồng'), (N'Vàng'), (N'Cam'), (N'Tím'), (N'Xám'), (N'Xanh Dương'), (N'Xanh Lá');

-- Kích thước (1=XS, 2=S, 3=M, 4=L, 5=XL)
INSERT INTO Sizes (name) VALUES
(N'XS'), (N'S'), (N'M'), (N'L'), (N'XL');

-- Chất liệu (1=Da thật, 2=Da nhân tạo, 3=Nhung)
INSERT INTO Materials (name) VALUES
(N'Da thật'), (N'Da nhân tạo'), (N'Nhung');

SELECT * FROM Users
SELECT * FROM Categories
SELECT * FROM Materials
SELECT * FROM Sizes
SELECT * FROM Colors

