CREATE DATABASE fashion_store;
USE fashion_store;

-- Bảng Danh Mục
CREATE TABLE Danh_Muc (
    danh_muc_id INT PRIMARY KEY,
    ten VARCHAR(100) NOT NULL,
    mo_ta TEXT
);

-- Bảng Sản Phẩm
CREATE TABLE San_Pham (
    san_pham_id INT PRIMARY KEY IDENTITY(1,1),
    ten VARCHAR(100) NOT NULL,
    mo_ta TEXT,
    gia DECIMAL(10, 2) NOT NULL,
    danh_muc_id INT,
    so_luong_ton INT NOT NULL,
    hinh_anh VARCHAR(255),
    ngay_tao DATETIME DEFAULT GETDATE(),
    ngay_cap_nhat DATETIME DEFAULT GETDATE(),
    trang_thai BIT DEFAULT 1,
    FOREIGN KEY (danh_muc_id) REFERENCES Danh_Muc(danh_muc_id) ON DELETE SET NULL
);

-- Bảng Người Dùng
CREATE TABLE Nguoi_Dung (
    nguoi_dung_id INT PRIMARY KEY IDENTITY(1,1),
    ten_tai_khoan VARCHAR(50) NOT NULL UNIQUE,
    mat_khau_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    ho VARCHAR(50),
    ten VARCHAR(50),
    dia_chi TEXT,
    dien_thoai VARCHAR(15),
    vai_tro VARCHAR(50) DEFAULT 'khach_hang' CHECK (vai_tro IN ('khach_hang', 'quan_tri')),
    ngay_tao DATETIME DEFAULT GETDATE(),
    ngay_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng Đơn Hàng
CREATE TABLE Don_Hang (
    don_hang_id INT PRIMARY KEY IDENTITY(1,1),
    nguoi_dung_id INT,
    ngay_dat DATETIME DEFAULT GETDATE(),
    trang_thai VARCHAR(50) DEFAULT 'cho_xu_ly' CHECK (trang_thai IN ('cho_xu_ly', 'hoan_thanh', 'da_giao', 'huy')),
    tong_tien DECIMAL(10, 2),
    dia_chi_giao_hang TEXT,
    FOREIGN KEY (nguoi_dung_id) REFERENCES Nguoi_Dung(nguoi_dung_id) ON DELETE CASCADE
);

-- Bảng Chi Tiết Đơn Hàng
CREATE TABLE Chi_Tiet_Don_Hang (
    chi_tiet_don_hang_id INT PRIMARY KEY,
    don_hang_id INT,
    san_pham_id INT,
    so_luong INT NOT NULL,
    gia DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (don_hang_id) REFERENCES Don_Hang(don_hang_id),
    FOREIGN KEY (san_pham_id) REFERENCES San_Pham(san_pham_id)
);

-- Bảng Đánh Giá
CREATE TABLE Danh_Gia (
    danh_gia_id INT PRIMARY KEY IDENTITY(1,1),
    san_pham_id INT,
    nguoi_dung_id INT,
    xep_hang INT CHECK (xep_hang >= 1 AND xep_hang <= 5),
    binh_luan TEXT,
    ngay_tao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (san_pham_id) REFERENCES San_Pham(san_pham_id),
    FOREIGN KEY (nguoi_dung_id) REFERENCES Nguoi_Dung(nguoi_dung_id)
);

-- Bảng Giỏ Hàng
CREATE TABLE Gio_Hang (
    gio_hang_id INT PRIMARY KEY IDENTITY(1,1),
    nguoi_dung_id INT,
    ngay_tao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (nguoi_dung_id) REFERENCES Nguoi_Dung(nguoi_dung_id)
);

-- Bảng Chi Tiết Giỏ Hàng
CREATE TABLE Chi_Tiet_Gio_Hang (
    chi_tiet_gio_hang_id INT PRIMARY KEY IDENTITY(1,1),
    gio_hang_id INT,
    san_pham_id INT,
    so_luong INT NOT NULL,
    FOREIGN KEY (gio_hang_id) REFERENCES Gio_Hang(gio_hang_id),
    FOREIGN KEY (san_pham_id) REFERENCES San_Pham(san_pham_id)
);

-- Bảng Thanh Toán
CREATE TABLE Thanh_Toan (
    thanh_toan_id INT PRIMARY KEY IDENTITY(1,1),
    don_hang_id INT,
    ngay_thanh_toan DATETIME DEFAULT GETDATE(),
    so_tien DECIMAL(10, 2) NOT NULL,
    phuong_thuc_thanh_toan VARCHAR(50) CHECK (phuong_thuc_thanh_toan IN ('the_tin_dung', 'paypal', 'chuyen_khoan')),
    ma_giao_dich VARCHAR(100),
    trang_thai VARCHAR(50) DEFAULT 'cho_xu_ly' CHECK (trang_thai IN ('thanh_cong', 'that_bai', 'cho_xu_ly')),
    FOREIGN KEY (don_hang_id) REFERENCES Don_Hang(don_hang_id)
);

-- Bảng Nhật Ký Giao Dịch
CREATE TABLE Nhat_Ky_Giao_Dich (
    nhat_ky_id INT PRIMARY KEY IDENTITY(1,1),
    ma_giao_dich VARCHAR(100),
    don_hang_id INT,
    nguoi_dung_id INT,
    phuong_thuc_thanh_toan VARCHAR(50) CHECK (phuong_thuc_thanh_toan IN ('the_tin_dung', 'paypal', 'chuyen_khoan')),
    so_tien DECIMAL(10, 2),
    trang_thai VARCHAR(50) DEFAULT 'cho_xu_ly' CHECK (trang_thai IN ('thanh_cong', 'that_bai', 'cho_xu_ly')),
    ngay_tao DATETIME DEFAULT GETDATE(),
    thong_diep TEXT,
    FOREIGN KEY (don_hang_id) REFERENCES Don_Hang(don_hang_id),
    FOREIGN KEY (nguoi_dung_id) REFERENCES Nguoi_Dung(nguoi_dung_id)
);