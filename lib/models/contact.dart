

class Contact {
  final String tenGiaoVien;
  final int idDotNhanXet;
  final String tenTrangThai;
  final int idTrangThai;
  final String phanHoiPhuHuynh;
  final String nhanXetGiaoVien;
  final int idGiaoVien;
  final int idSoLienLac;

  Contact({this.tenGiaoVien, this.idDotNhanXet, this.tenTrangThai, this.idTrangThai, this.nhanXetGiaoVien,
  this.idGiaoVien, this.idSoLienLac, this.phanHoiPhuHuynh});

  factory Contact.fromJson(Map<String, dynamic> jsonContact) {
    return Contact(
      tenGiaoVien: jsonContact['tenGiaoVien'],
      idDotNhanXet: jsonContact['idDotNhanXet'],
      tenTrangThai: jsonContact['tenTrangThai'],
      idTrangThai: jsonContact['idTrangThai'],
      phanHoiPhuHuynh: jsonContact['phanHoiPhuHuynh'],
      nhanXetGiaoVien: jsonContact['nhanXetGiaoVien'],
      idGiaoVien: jsonContact['idGiaoVien'],
      idSoLienLac: jsonContact['idSoLienLac']
    );
  }
  
}

