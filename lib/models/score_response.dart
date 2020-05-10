
import 'package:englcenterapp/models/score.dart';

class ScoreResponse {
  final String error;
  // final String result;
  final List<Score> scores;

  ScoreResponse({this.scores, this.error});

  factory ScoreResponse.fromJson(Map<String, dynamic> jsonScoreResponse) {
    if((jsonScoreResponse['data'] as List).isEmpty) {
      return ScoreResponse(
      scores: [],
      error: 'Điểm chưa cập nhật'
    );
    }
    return ScoreResponse(
      scores: (jsonScoreResponse['data'][0]['diem'] as List).map((i) => Score.fromJson(i)).toList(),
      error: ''
    );
  }

  factory ScoreResponse.withError(String error) {
    return ScoreResponse(
      scores: [],
      error: error
    );
  }
}

// {
//     "result": "success",
//     "data": [
//         {
//             "lop": {
//                 "ngayBatDau": "06/01/2020",
//                 "tenChungChi": "ADU",
//                 "tenKhoa": "ADU - 01.2020 (06.01)",
//                 "tenChuongTrinh": "B QSKILLS",
//                 "idLop": 9507,
//                 "lichHoc": "[2,3,4,5] [18:30 - 20:30] ",
//                 "tuanHienTai": 12,
//                 "maLop": "060120007",
//                 "hocPhi": 2200000,
//                 "loaiLop": "Lớp học",
//                 "deCuong": "B1 QSKILLS - 2345",
//                 "soTuan": 12,
//                 "phong": "102 - Building 80 Mau Than",
//                 "tenLop": "B1 QSKILLS - 2345 - Nhóm 1"
//             },
//             "diem": [
//                 {
//                     "idDiem": 115041,
//                     "giaTri": 45,
//                     "stt": 0,
//                     "tenDiem": "S"
//                 },
//                 {
//                     "idDiem": 115042,
//                     "giaTri": 35,
//                     "stt": 1,
//                     "tenDiem": "L"
//                 },
//                 {
//                     "idDiem": 115043,
//                     "giaTri": 20,
//                     "stt": 2,
//                     "tenDiem": "R+V"
//                 },
//                 {
//                     "idDiem": 115044,
//                     "giaTri": 36,
//                     "stt": 3,
//                     "tenDiem": "G+LU"
//                 },
//                 {
//                     "idDiem": 115045,
//                     "giaTri": 18,
//                     "stt": 4,
//                     "tenDiem": "W"
//                 }
//             ],
//             "hocVien": {
//                 "gioiTinh": "Nam",
//                 "hoTen": "NGUYỄN THANH NHÃ PHƯƠNG",
//                 "ngaySinh": "2004",
//                 "idHocVien": 81634,
//                 "maHocVien": "059155"
//             }
//         }
//     ]
// }