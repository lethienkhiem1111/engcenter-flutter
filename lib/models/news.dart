
class News {
  final String loaiTinTuc;
  final String trangThaiTinTuc;
  final String noiDung;
  final String ngayDang;
  final String tieuDe;
  final String anhDaiDien;
  final String tenLoaiTinTuc;
  final String tomTat;
  final String idTrangThaiTinTuc;
  final String idTinTuc;

  News(
    this.loaiTinTuc,
    this.trangThaiTinTuc,
    this.noiDung,
    this.ngayDang,
    this.tieuDe,
    this.anhDaiDien,
    this.tenLoaiTinTuc,
    this.tomTat,
    this.idTrangThaiTinTuc,
    this.idTinTuc,
  );

  News.fromJson(Map<String, dynamic> json):
    loaiTinTuc = json['loaiTinTuc'],
    trangThaiTinTuc = json['trangThaiTinTuc'],
    noiDung = json['noiDung'],
    ngayDang = json['ngayDang'],
    tieuDe = json['tieuDe'],
    anhDaiDien = json['anhDaiDien'],
    tenLoaiTinTuc = json['tenLoaiTinTuc'],
    tomTat = json['tomTat'],
    idTrangThaiTinTuc = json['idTrangThaiTinTuc'],
    idTinTuc = json['idTinTuc'];
}
