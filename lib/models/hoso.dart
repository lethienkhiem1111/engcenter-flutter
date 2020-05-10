class Hoso {
  String gioiTinh;
  String hoTen;
  String ngaySinh;
  int idHocVien;
  String maHocVien;

  Hoso(this.gioiTinh, this.hoTen, this.ngaySinh, this.idHocVien, this.maHocVien);

  Hoso.fromJson(Map<String, dynamic> json ):
    gioiTinh = json['gioiTinh'],
    hoTen = json['hoTen'],
    ngaySinh = json['ngaySinh'],
    idHocVien = json['idHocVien'],
    maHocVien = json['maHocVien'];
}

