    
class UserResponse{
  final String username;
  final String gioiTinh;
  final String hoTen;
  final String soDienThoai;
  final String email;
  final String ngaySinh;
  final String matKhau;
  final String userType;

  UserResponse(
    this.gioiTinh,
    this.username,
    this.hoTen,
    this.soDienThoai,
    this.email,
    this.ngaySinh,
    this.matKhau,
    this.userType
  );

  UserResponse.fromJson(Map<String, dynamic> json ):
    gioiTinh = json['gioiTinh'],
    username = json['username'],
    hoTen = json['hoTen'],
    soDienThoai = json['soDienThoai'],
    email = json['email'],
    ngaySinh = json['ngaySinh'],
    matKhau = json['matKhau'],
    userType = json['userType'];
}

