--I: Ngôn ngữ định nghĩa dữ liệu (Data Definition Language)
--2. Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM.
ALTER TABLE SANPHAM_1_DANH 
ADD GHICHU_1_DANH VARCHAR(20)

--3. Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG.
ALTER TABLE KHACHHANG_1_DANH
ADD LOAIKH_1_DANH TINYINT

--4. Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100).
ALTER TABLE SANPHAM_1_DANH
ALTER COLUMN GHICHU_1_DANH VARCHAR(100)

--5. Xóa thuộc tính GHICHU trong quan hệ SANPHAM.
ALTER TABLE SANPHAM_1_DANH 
DROP COLUMN GHICHU_1_DANH

--6. Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trịlà: “Vang ai”, “Thuong xuyen”, “Vip”, …
ALTER TABLE KHACHHANG_1_DANH 
ALTER COLUMN LOAIKH_1_DANH VARCHAR(20)

ALTER TABLE KHACHHANG_1_DANH
ADD CONSTRAINT CHK_LOAIKH_1_DANH 
CHECK (LOAIKH_1_DANH IN ('Vang ai', 'Thuong xuyen', 'Vip'))

--7. Đơn vị tính của sản phẩm chỉ có thể là (“cây”,”hộp”,”cái”,”quyển”,”chục”)
ALTER TABLE SANPHAM_1_DANH 
--'Chữa cháy' khi bảng có dữ liệu rác không muốn xóa
WITH NOCHECK
ADD CONSTRAINT CHK_DVT_1_DANH
CHECK (DVT_1_DANH IN (N'cây',N'hộp',N'cái',N'quyển',N'chục'))

--Kiem tra 7
INSERT SANPHAM_1_DANH VALUES ('123', 'San Pham Loi', N'thùng', 'Viet Nam', 1000)

--8. Giá bán của sản phẩm từ 500 đồng trở lên.
ALTER TABLE SANPHAM_1_DANH
ADD CONSTRAINT CHK_GIA_1_DANH
CHECK (GIA_1_DANH >= 500)
--Kiem tra
INSERT SANPHAM_1_DANH VALUES ('123', 'none', 'none', 'none', 400)

--9. Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.
ALTER TABLE CTHD_1_DANH
ADD CONSTRAINT CHK_SL_1_DANH
CHECK (SL_1_DANH >= 1)

--Kiểm tra
INSERT CTHD_1_DANH VALUES('1001', 'BB01', 2)

--10. Ngày gia nhập của khách hàng thành viên phải lớn hơn ngày sinh của người đó.
ALTER TABLE KHACHHANG_1_DANH
ADD CONSTRAINT CHK_NGDK_1_DANH
CHECK (NGDK_1_DANH > NGSINH_1_DANH)

--Kiem tra
INSERT KHACHHANG_1_DANH VALUES('123', '123', '123', '123', '2006-12-27', 56000, '2007-12-27', 'Vang ai')


--II. Ngôn ngữ thao tác dữ liệu (Data Manipulation Language):
--2. Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất.
UPDATE SANPHAM_1_DANH
SET GIA_1_DANH = GIA_1_DANH * 1.05
WHERE NUOCSX_1_DANH = 'Thai Lan'

--3. Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống.
UPDATE SANPHAM_1_DANH
SET GIA_1_DANH = GIA_1_DANH * 0.95
WHERE NUOCSX_1_DANH = 'Trung Quoc' AND GIA_1_DANH <= 10000


--4. Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày 1/1/2007 có doanh số từ 10.000.000
--trở lên hoặc khách hàng đĕng ký thành viên từ 1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên.
UPDATE KHACHHANG_1_DANH
SET LOAIKH_1_DANH = 'Vip'
WHERE (NGDK_1_DANH < '2007-01-01' AND DOANHSO_1_DANH >= 10000000) OR (NGDK_1_DANH >= '2007-01-01' AND DOANHSO_1_DANH >= 2000000)

--III. Viết các câu truy vấn:
--1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất.
--Bước 1: Đổi dữ liệu
ALTER TABLE SANPHAM_1_DANH 
ALTER COLUMN NUOCSX_1_DANH NVARCHAR(40)

--Bước 2: Đưa dữ liệu về đúng chuẩn theo đề bài
UPDATE SANPHAM_1_DANH 
SET NUOCSX_1_DANH = N'Trung Quốc' 
WHERE NUOCSX_1_DANH = 'Trung Quoc'

--Bước 3: Câu truy vấn
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH 
WHERE NUOCSX_1_DANH = N'Trung Quốc'

--2. In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “Cây”, ”quyển”.
--Bước 1: Đổi dữ liệu
ALTER TABLE SANPHAM_1_DANH 
ALTER COLUMN DVT_1_DANH NVARCHAR(20)

--Bước 2: Đưa dữ liệu về đúng chuẩn theo đề bài
UPDATE SANPHAM_1_DANH 
SET DVT_1_DANH = N'Cây'
WHERE DVT_1_DANH = 'Cay' 

UPDATE SANPHAM_1_DANH 
SET DVT_1_DANH = N'quyển' 
WHERE DVT_1_DANH = 'Quyen'

--Bước 3: Câu truy vấn
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH 
WHERE DVT_1_DANH IN (N'Cây', N'quyển')


--3. In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH
WHERE MASP_1_DANH LIKE 'B%01'


--4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 20.000 đến 30.000.
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH
WHERE NUOCSX_1_DANH LIKE N'Trung Quốc' AND (GIA_1_DANH >= 20000 AND GIA_1_DANH <= 30000)

--5. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” hoặc “Thái Lan” sản xuất có giá từ 20.000 đến 30.000.
--Bước 1: Đưa dữ liệu về dạng đúng chuẩn
UPDATE SANPHAM_1_DANH 
SET NUOCSX_1_DANH = N'Thái Lan' 
WHERE NUOCSX_1_DANH = 'Thai Lan'

--Bước 2: Câu truy vấn
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH
WHERE NUOCSX_1_DANH IN (N'Thái Lan', N'Trung Quốc') and GIA_1_DANH BETWEEN 20000 AND 30000

--6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD_1_DANH, TRIGIA_1_DANH
FROM HOADON_1_DANH
WHERE NGHD_1_DANH IN ('2007-01-01', '2007-01-02')

--7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD_1_DANH, TRIGIA_1_DANH
FROM HOADON_1_DANH
WHERE MONTH(NGHD_1_DANH) = 1 AND YEAR(NGHD_1_DANH) = 2007
ORDER BY NGHD_1_DANH ASC, TRIGIA_1_DANH DESC


--8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT KH.MAKH_1_DANH, KH.HOTEN_1_DANH
FROM KHACHHANG_1_DANH KH, HOADON_1_DANH HD
WHERE KH.MAKH_1_DANH = HD.MAKH_1_DANH AND HD.NGHD_1_DANH = '2007-01-01'

--9. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyễn Văn A” mua trong háng 10/2006.
--Bước 1: Đổi dữ liệu
ALTER TABLE KHACHHANG_1_DANH 
ALTER COLUMN HOTEN_1_DANH NVARCHAR(40)

--Bước 2: Đổi Tên ( 'Nguyen Van A' thành 'Nguyễn Văn A' )
UPDATE KHACHHANG_1_DANH 
SET HOTEN_1_DANH = N'Nguyễn Văn A' 
WHERE MAKH_1_DANH = 'KH01'

--Bước 3: Câu truy vấn
SELECT DISTINCT SP.MASP_1_DANH, SP.TENSP_1_DANH
FROM KHACHHANG_1_DANH KH, HOADON_1_DANH HD, SANPHAM_1_DANH SP, CTHD_1_DANH CTHD
WHERE KH.MAKH_1_DANH = HD.MAKH_1_DANH 
	AND CTHD.SOHD_1_DANH = HD.SOHD_1_DANH
	AND CTHD.MASP_1_DANH = SP.MASP_1_DANH 
	AND KH.HOTEN_1_DANH = N'Nguyễn Văn A' 
	AND HD.NGHD_1_DANH BETWEEN '2006-10-01' AND '2006-10-31'


--10. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyễn Văn B” lập trong ngày 10/10/2006.
--Bước 1: Đổi dữ liệu
ALTER TABLE NHANVIEN_1_DANH 
ALTER COLUMN HOTEN_1_DANH NVARCHAR(40)

--Bước 2: Đổi tên ( 'Nguyen Van B' thành 'Nguyễn Văn B' )
UPDATE NHANVIEN_1_DANH 
SET HOTEN_1_DANH = N'Nguyễn Văn B' 
WHERE MANV_1_DANH = 'NV03'

--Bước 3: Câu truy vấn
SELECT HD.SOHD_1_DANH, HD.TRIGIA_1_DANH
FROM HOADON_1_DANH HD, NHANVIEN_1_DANH NV
WHERE HD.MANV_1_DANH = NV.MANV_1_DANH AND NV.HOTEN_1_DANH = N'Nguyễn Văn B' AND HD.NGHD_1_DANH = '2006-10-10'


--11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT SOHD_1_DANH
FROM CTHD_1_DANH
WHERE MASP_1_DANH LIKE 'BB01%' OR MASP_1_DANH LIKE 'BB02%'


--12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số ượng từ 10 đến 20.
SELECT SOHD_1_DANH
FROM CTHD_1_DANH
WHERE (MASP_1_DANH = 'BB01' OR MASP_1_DANH = 'BB02') AND (SL_1_DANH BETWEEN 10 AND 20)

--13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số ượng từ 10 đến 20
--DISTINCT de bo qua hoa don trung nhau
SELECT DISTINCT SOHD_1_DANH
FROM CTHD_1_DANH
--Tim ma và so luong trong khoang quy dinh
WHERE MASP_1_DANH = 'BB01' AND SL_1_DANH BETWEEN 10 AND 20 
	AND SOHD_1_DANH IN (
      SELECT SOHD_1_DANH 
      FROM CTHD_1_DANH 
	  --Tim ma và so luong trong khoang quy dinh
      WHERE MASP_1_DANH = 'BB02' AND SL_1_DANH BETWEEN 10 AND 20)

--14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT DISTINCT SP.MASP_1_DANH, SP.TENSP_1_DANH
FROM SANPHAM_1_DANH SP, CTHD_1_DANH CTHD, HOADON_1_DANH HD
WHERE (SP.MASP_1_DANH = CTHD.MASP_1_DANH AND CTHD.SOHD_1_DANH = HD.SOHD_1_DANH)
  AND (SP.NUOCSX_1_DANH = N'Trung Quốc' OR HD.NGHD_1_DANH = '2007-01-01')

--15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH
--Tim ra nhung san pham khong ban duoc
WHERE MASP_1_DANH NOT IN ( SELECT MASP_1_DANH 
							FROM CTHD_1_DANH )


--16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH
WHERE MASP_1_DANH NOT IN ( SELECT C.MASP_1_DANH
							FROM CTHD_1_DANH C, HOADON_1_DANH H
							WHERE C.SOHD_1_DANH = H.SOHD_1_DANH AND YEAR(H.NGHD_1_DANH) = 2006)

--17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất không bán được trong năm 2006.
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH
WHERE NUOCSX_1_DANH = N'Trung Quốc'
  AND MASP_1_DANH NOT IN (
      SELECT C.MASP_1_DANH
      FROM CTHD_1_DANH C, HOADON_1_DANH H
      WHERE C.SOHD_1_DANH = H.SOHD_1_DANH AND YEAR(H.NGHD_1_DANH) = 2006)


--18. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(SOHD_1_DANH) AS SoLuong_1_Danh
FROM HOADON_1_DANH
WHERE MAKH_1_DANH IS NULL

--19. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MAX(TRIGIA_1_DANH) AS CaoNhat, MIN(TRIGIA_1_DANH) AS ThapNhat
FROM HOADON_1_DANH

--20. Trị giá trung bình của tất cả các hóa đơn được bán ra trong nĕm 2006 là bao nhiêu?
SELECT AVG(TRIGIA_1_DANH) AS TriGiaTrungBinh_2006_1_Danh
FROM HOADON_1_DANH
WHERE NGHD_1_DANH BETWEEN '2006-01-01' AND '2006-12-31'

--21. Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA_1_DANH) AS TongDoanhThu_2006_1_Danh
FROM HOADON_1_DANH
WHERE YEAR(NGHD_1_DANH) = 2006

--22. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT SOHD_1_DANH
FROM HOADON_1_DANH
WHERE YEAR(NGHD_1_DANH) = 2006 AND TRIGIA_1_DANH = ( SELECT MAX(TRIGIA_1_DANH) 
      FROM HOADON_1_DANH 
      WHERE YEAR(NGHD_1_DANH) = 2006)

--23. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT K.HOTEN_1_DANH
FROM KHACHHANG_1_DANH K, HOADON_1_DANH H
WHERE K.MAKH_1_DANH = H.MAKH_1_DANH AND H.TRIGIA_1_DANH = (
      SELECT MAX(TRIGIA_1_DANH) 
      FROM HOADON_1_DANH 
      WHERE YEAR(NGHD_1_DANH) = 2006)

--24. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP 3 MAKH_1_DANH, HOTEN_1_DANH
FROM KHACHHANG_1_DANH
ORDER BY DOANHSO_1_DANH DESC

--25. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH
WHERE GIA_1_DANH IN (
    SELECT DISTINCT TOP 3 GIA_1_DANH
    FROM SANPHAM_1_DANH
    ORDER BY GIA_1_DANH DESC
)

--26. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quốc” sản xuất có giá bằng 1 trong 3 mức iá thấp nhất (của tất cả các sản phẩm).
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH
WHERE NUOCSX_1_DANH = N'Trung Quốc'
  AND GIA_1_DANH IN (
      SELECT TOP 3 GIA_1_DANH
      FROM SANPHAM_1_DANH
      -- ASC là thấp nhất
      ORDER BY GIA_1_DANH ASC )

--27. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quốc” sản xuất có giá bằng 1 trong 3 mức giá thấp nhất
--(của sản phẩm do “Trung Quốc” sản xuất).
SELECT MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH
WHERE NUOCSX_1_DANH = N'Trung Quốc'
  AND GIA_1_DANH IN (
      SELECT TOP 3 GIA_1_DANH
      FROM SANPHAM_1_DANH
      WHERE NUOCSX_1_DANH = N'Trung Quốc'
      ORDER BY GIA_1_DANH ASC)

--28. * In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP 3 MAKH_1_DANH, HOTEN_1_DANH
FROM KHACHHANG_1_DANH
ORDER BY DOANHSO_1_DANH DESC

--29. Tính tổng số sản phẩm do “Trung Quốc” sản xuất.
SELECT COUNT(*) AS TongSP_TrungQuoc_1_Danh
FROM SANPHAM_1_DANH
WHERE NUOCSX_1_DANH = N'Trung Quốc'

--30. Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX_1_DANH, COUNT(*) AS SoLuongSanPham_1_Danh
FROM SANPHAM_1_DANH
GROUP BY NUOCSX_1_DANH

--31. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NUOCSX_1_DANH, 
       MAX(GIA_1_DANH) AS GiaCaoNhat_1_Danh, 
       MIN(GIA_1_DANH) AS GiaThapNhat_1_Danh, 
       AVG(GIA_1_DANH) AS GiaTrungBinh_1_Danh
FROM SANPHAM_1_DANH
GROUP BY NUOCSX_1_DANH

--32. Tính doanh thu bán hàng mỗi ngày.
SELECT NGHD_1_DANH, SUM(TRIGIA_1_DANH) AS DoanhThuNgay_1_Danh
FROM HOADON_1_DANH
GROUP BY NGHD_1_DANH

--33. Tính tổng số lượng của từng sản phẩm bán ra trong ngày 28/10/2006.
SELECT MASP_1_DANH, SUM(SL_1_DANH) AS TongSoLuong_1_Danh
FROM CTHD_1_DANH C, HOADON_1_DANH H
WHERE C.SOHD_1_DANH = H.SOHD_1_DANH AND H.NGHD_1_DANH = '2006-10-28'
GROUP BY MASP_1_DANH

--34. Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(NGHD_1_DANH) AS Thang_1_Danh, SUM(TRIGIA_1_DANH) AS DoanhThuThang_1_Danh
FROM HOADON_1_DANH
WHERE YEAR(NGHD_1_DANH) = 2006
GROUP BY MONTH(NGHD_1_DANH)

--35. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
SELECT TOP 1 K.MAKH_1_DANH, K.HOTEN_1_DANH
FROM KHACHHANG_1_DANH K, HOADON_1_DANH H
WHERE K.MAKH_1_DANH = H.MAKH_1_DANH
GROUP BY K.MAKH_1_DANH, K.HOTEN_1_DANH
ORDER BY COUNT(H.SOHD_1_DANH) DESC

--36. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT TOP 1 S.MASP_1_DANH, S.TENSP_1_DANH
FROM SANPHAM_1_DANH S, CTHD_1_DANH C, HOADON_1_DANH H
WHERE S.MASP_1_DANH = C.MASP_1_DANH AND C.SOHD_1_DANH = H.SOHD_1_DANH AND YEAR(H.NGHD_1_DANH) = 2006
GROUP BY S.MASP_1_DANH, S.TENSP_1_DANH
ORDER BY SUM(C.SL_1_DANH) ASC

--37. Tháng mấy trong năm 2006, doanh số bán hàng thấp nhất ?
SELECT TOP 1 MONTH(NGHD_1_DANH) AS ThangThapNhat_1_Danh
FROM HOADON_1_DANH
WHERE YEAR(NGHD_1_DANH) = 2006
GROUP BY MONTH(NGHD_1_DANH)
ORDER BY SUM(TRIGIA_1_DANH) ASC

--38. Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT NUOCSX_1_DANH, MASP_1_DANH, TENSP_1_DANH
FROM SANPHAM_1_DANH S1
WHERE GIA_1_DANH = (
    SELECT MAX(GIA_1_DANH)
    FROM SANPHAM_1_DANH S2
    WHERE S1.NUOCSX_1_DANH = S2.NUOCSX_1_DANH
)

--39. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
SELECT TOP 1 K.MAKH_1_DANH, K.HOTEN_1_DANH
FROM KHACHHANG_1_DANH K, HOADON_1_DANH H
WHERE K.MAKH_1_DANH = H.MAKH_1_DANH
  AND K.MAKH_1_DANH IN (
      -- Bước 1: Xac dinh danh sach ma cua 10 nguoi doanh so cao nhat
      SELECT TOP 10 MAKH_1_DANH
      FROM KHACHHANG_1_DANH
      ORDER BY DOANHSO_1_DANH DESC
  )
GROUP BY K.MAKH_1_DANH, K.HOTEN_1_DANH
ORDER BY COUNT(H.SOHD_1_DANH) DESC

--40. *Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau
SELECT NUOCSX_1_DANH
FROM SANPHAM_1_DANH
GROUP BY NUOCSX_1_DANH
HAVING COUNT(DISTINCT GIA_1_DANH) >= 3