class Class {
  final String ngayBatDau;
  final String tenChungChi;
  final String tenKhoa;
  final String tenChuongTrinh;
  final int idLop;
  final String lichHoc;
  final int tuanHienTai;
  final String hocPhi;
  final String loaiLop;
  final String deCuong;
  final int soTuan;
  final String phong;
  final String tenLop;

  Class(
    this.ngayBatDau,
    this.tenChungChi,
    this.tenKhoa,
    this.tenChuongTrinh,
    this.idLop,
    this.lichHoc,
    this.tuanHienTai,
    this.hocPhi,
    this.loaiLop,
    this.deCuong,
    this.soTuan,
    this.phong,
    this.tenLop
  );

  Class.fromJson(Map<String, dynamic> json):
    ngayBatDau = json['ngayBatDau'],
    tenChungChi = json['tenChungChi'],
    tenKhoa = json['tenKhoa'],
    tenChuongTrinh = json['tenChuongTrinh'],
    idLop = json['idLop'],
    lichHoc = json['lichHoc'],
    tuanHienTai = json['tuanHienTai'],
    hocPhi = json['hocPhi'],
    loaiLop = json['loaiLop'],
    deCuong = json['deCuong'],
    soTuan = json['soTuan'],
    phong = json['phong'],
    tenLop = json['tenLop'];
}
