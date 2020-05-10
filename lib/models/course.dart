
class Course{
  final int maKhoa;
  final int idKhoa;
  final String tenTrangThai;
  final String tenChungChi;
  final String tenKhoa;
  final String ngayKT;
  final String ngayBD;

  Course(
    this.maKhoa, 
    this.idKhoa, 
    this.tenTrangThai, 
    this.tenChungChi, 
    this.tenKhoa, 
    this.ngayBD,
    this.ngayKT
    );

  Course.fromJson(Map<String, dynamic> json ):
    maKhoa = json['maKhoa'],
    idKhoa = json['idKhoa'],
    tenTrangThai = json['tenTrangThai'],
    tenChungChi = json['tenChungChi'],
    tenKhoa = json['tenKhoa'],
    ngayBD = json['ngayBD'],
    ngayKT = json['ngayKT'];
}

