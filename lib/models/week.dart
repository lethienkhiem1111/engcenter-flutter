
class Week {
  final String ngayBatDau;
  final String ngayKetThuc;
  final int tuanLich;
  final int tuanHoc;

  Week(this.ngayBatDau, this.ngayKetThuc, this.tuanHoc, this.tuanLich);

  Week.fromJson(Map<String, dynamic> jsonSession):
    ngayBatDau = jsonSession['ngayKetThuc'],
    ngayKetThuc = jsonSession['ngayKetThuc'],
    tuanLich = jsonSession['tuanLich'],
    tuanHoc = jsonSession['tuanHoc'];

}