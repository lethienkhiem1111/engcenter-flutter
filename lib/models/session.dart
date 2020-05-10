
class Session {
  final String coSo;
  final String lop;
  final int idSuKien;
  final String caDay;
  final String khoa;
  final String ketThuc;
  final String batDau;
  final String thu;
  final String ngay;
  final String giaoVien;
  final String phong;
  final String moTa;

  Session({this.coSo, this.lop, this.idSuKien, this.caDay, this.khoa, this.ketThuc, this.batDau,
  this.thu, this.ngay, this.giaoVien, this.phong, this.moTa});

  factory Session.fromJson(Map<String, dynamic> jsonSession){
    return Session(
      coSo: jsonSession['coSo'],
      idSuKien: jsonSession['idSuKien'],
      caDay: jsonSession['caDay'],
      ketThuc: jsonSession['ketThuc'],
      batDau: jsonSession['batDau'],
      phong: jsonSession['phong'],
      lop: jsonSession['lop'],
      thu: jsonSession['thu'],
      khoa: jsonSession['khoa'],
      giaoVien: jsonSession['giaoVien'],
      ngay: jsonSession['ngay'],
      moTa: jsonSession['moTa'],
    );
  }

}
