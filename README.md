# 🛒 HỆ THỐNG QUẢN LÍ BÁN HÀNG (SALES MANAGEMENT SYSTEM)

## 📌🌐 Giới thiệu dự án
Dự án tập trung vào việc thiết kế, triển khai và truy vấn cơ sở dữ liệu cho một hệ thống bán hàng thực tế.
Hệ thống quản lý toàn diện từ thông tin Khách hàng, Nhân viên đến các danh mục Sản phẩm và lịch sử giao dịch Hóa đơn.
Dự án có file docx hướng dẫn chi tiết các bước thực hiện và code.

## 📌🌐 Mục tiêu
Tìm hiểu và nắm bắt thêm kiến thức về cơ sở dữ liệu.
Truy vấn cơ sở dữ liệu và học cách tạo Diagrams.
Nhập liệu bằng 2 cách: 
+ Nhập liệu bằng lệnh.
+ Nhập liệu bằng excel.

## 🗂 Cấu trúc thư mục
Đồ án được tổ chức khoa học với các file chuyên biệt:
* 📄 **`1_DANH_CAULENH_QLBANHANG.sql`**: Chứa mã nguồn tạo cấu trúc (DDL), các ràng buộc toàn vẹn (Constraints), cập nhật dữ liệu và 40 câu truy vấn nghiệp vụ.
* 📄 **`1_DANH_DULIEU_QLBANHANG.sql`**: Chứa các lệnh `INSERT` nạp dữ liệu mẫu vào hệ thống.
* 📊 **`1_DANH_EXCEL_QLBANHANG.xls`**: File dữ liệu nguồn dùng để Import data, tạo bảng mà không cần nhập liệu.
* 📑 **`1_DANH.docx` / `BAITAPLON_CSDL.pdf`**: Báo cáo chi tiết về thiết kế thực thể, sơ đồ ER và giải thích các câu lệnh, đồng thời có comment chi tiết.

## 🏗 Thiết kế cơ sở dữ liệu
Hệ thống bao gồm 5 bảng chính được liên kết chặt chẽ:
1. **KHACHHANG**: Quản lý thông tin định danh và phân loại khách hàng. Khách hàng thành viên và khách hàng không phải thành viên.
2. **NHANVIEN**: Quản lý nhân sự bán hàng. 
3. **SANPHAM**: Danh mục hàng hóa, đơn vị tính và giá cả.
4. **HOADON**: Thông tin tổng quát về đơn hàng, các sản phẩm bán ra trong ngày, trong tháng.
5. **CTHD**: Chi tiết từng mặt hàng trong đơn hàng (Mối quan hệ n-n).



## 🚀 Hướng dẫn cài đặt & Thực thi
Để đảm bảo hệ thống chạy đúng, vui lòng thực hiện theo thứ tự sau:

1. **Khởi tạo**: Chạy phần đầu file `1_DANH_DULIEU_QLBANHANG.sql` để tạo Database và các Bảng.
2. **Nạp dữ liệu**: Chạy toàn bộ file `1_DANH_CAULENH_QLBANHANG.sql` để nạp dữ liệu ` INSERT ten_bang VALUES `.
3. **Cấu hình & Truy vấn**: Chạy các phần còn lại trong file `1_DANH_CAULENH_QLBANHANG.sql` bao gồm `ALTER TABLE`, `UPDATE` và các câu `SELECT`.
4. **Nạp dữ liệu bằng EXCEL**: Mở file EXCEL và vào SQL SERVER để import data. Dữ liệu nhanh chóng sẽ được nạp vào.

## 🛠 Các tính năng nổi bật
* ✅ **Ràng buộc logic**: Kiểm tra đơn vị tính, giá bán (>500đ) và ngày đăng ký thành viên.
* ✅ **Phân loại tự động**: Tự động nâng hạng **Vip** cho khách hàng dựa trên doanh số và thời gian gắn bó.
* ✅ **Hệ thống truy vấn**: Đáp ứng 40 yêu cầu báo cáo từ cơ bản đến phức tạp (Thống kê doanh thu, tìm sản phẩm bán chạy, khách hàng tiềm năng...).

## 👤 Thông tin tác giả
* **Sinh viên thực hiện**: Lê Thanh Danh
* **Mã số sinh viên**: 2451050005
* **Lớp**: DH24IT02
* **Giảng viên hướng dẫn**: Không có

---
⭐ *Lưu ý: dự án Sinh Viên tự thực hiện (không có giảng viên hướng dẫn) chỉ phục vụ cho việc học tập*

---
⭐ *Nếu bạn thấy dự án này hữu ích, hãy tặng mình 1 sao (Star) trên GitHub nhé!*
