import 'package:englcenterapp/models/session.dart';
import 'package:englcenterapp/models/week.dart';

class Schedule {
  final Week tuan;
  final List<Session> buoi;

  Schedule({this.tuan, this.buoi});

  factory Schedule.fromJson(Map<String, dynamic> jsonSchedule) {
    return Schedule(
      tuan: Week.fromJson(jsonSchedule['tuan']),
      buoi: (jsonSchedule['buois'] as List).map((i) => Session.fromJson(i)).toList()
    );
  }
  
}

// 
//   scheduleResponse[
//     schedule [
//       tuan,
//       buoi
//     ]
//   ]
// 

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
//             "tuans": [
//                 {
//                     "tuan": {
//                         "ngayBatDau": "20/04/20",
//                         "ngayKetThuc": "26/04/20",
//                         "tuanLich": 17,
//                         "tuanHoc": 11
//                     },
//                     "buois": [
//                         {
//                             "coSo": "Building 80 Mau Than",
//                          "lop": "B1 QSKILLS - 2345 - Nhóm 1",
//                             "idSuKien": 21733,
//                          "caDay": "18:30 - 20:30",
//                             "khoa": "ADU - 01.2020 (06.01)",
//                             "trangThaiGiaoViens": [
//                                 {
//                                     "tenGiaoVien": "",
//                                     "trangThaiDiemDanh": "Chưa điểm danh",
//                                     "idGiaoVien": 0,
//                                     "maTrangThaiDiemDanh": 1
//                                 }
//                             ],
//                             "ketThuc": "20/04/20",
//                           "batDau": "20/04/20",
//                           "thu": "Thứ Hai",
//                             "ngay": "20/04/20",
//                           "giaoVien": "[18:30 - 20:30] - Lê Thị Thúy Hằng - (Reading / Writing)",
//                           "phong": "102 - Building 80 Mau Than",
//                             "moTa": ""
//                         },
//                         {
//                             "coSo": "Building 80 Mau Than",
//                             "lop": "B1 QSKILLS - 2345 - Nhóm 1",
//                             "idSuKien": 21734,
//                             "caDay": "18:30 - 20:30",
//                             "khoa": "ADU - 01.2020 (06.01)",
//                             "trangThaiGiaoViens": [
//                                 {
//                                     "tenGiaoVien": "",
//                                     "trangThaiDiemDanh": "Chưa điểm danh",
//                                     "idGiaoVien": 0,
//                                     "maTrangThaiDiemDanh": 1
//                                 }
//                             ],
//                             "ketThuc": "21/04/20",
//                             "batDau": "21/04/20",
//                             "thu": "Thứ Ba",
//                             "ngay": "21/04/20",
//                             "giaoVien": "[18:30 - 20:30] - Meghan Elica Matias Sonquipal - (Speaking / Listening)",
//                             "phong": "102 - Building 80 Mau Than",
//                             "moTa": ""
//                         },
//                         {
//                             "coSo": "Building 80 Mau Than",
//                             "lop": "B1 QSKILLS - 2345 - Nhóm 1",
//                             "idSuKien": 21735,
//                             "caDay": "18:30 - 20:30",
//                             "khoa": "ADU - 01.2020 (06.01)",
//                             "trangThaiGiaoViens": [
//                                 {
//                                     "tenGiaoVien": "",
//                                     "trangThaiDiemDanh": "Chưa điểm danh",
//                                     "idGiaoVien": 0,
//                                     "maTrangThaiDiemDanh": 1
//                                 }
//                             ],
//                             "ketThuc": "22/04/20",
//                             "batDau": "22/04/20",
//                             "thu": "Thứ Tư",
//                             "ngay": "22/04/20",
//                             "giaoVien": "[18:30 - 20:30] - Lê Thị Thúy Hằng - (Reading / Writing)",
//                             "phong": "102 - Building 80 Mau Than",
//                             "moTa": ""
//                         },
//                         {
//                             "coSo": "Building 80 Mau Than",
//                             "lop": "B1 QSKILLS - 2345 - Nhóm 1",
//                             "idSuKien": 21736,
//                             "caDay": "18:30 - 20:30",
//                             "khoa": "ADU - 01.2020 (06.01)",
//                             "trangThaiGiaoViens": [
//                                 {
//                                     "tenGiaoVien": "",
//                                     "trangThaiDiemDanh": "Chưa điểm danh",
//                                     "idGiaoVien": 0,
//                                     "maTrangThaiDiemDanh": 1
//                                 }
//                             ],
//                             "ketThuc": "23/04/20",
//                             "batDau": "23/04/20",
//                             "thu": "Thứ Năm",
//                             "ngay": "23/04/20",
//                             "giaoVien": "[18:30 - 20:30] - Đặng Trần Hoàng Nguyên - (Listening / Speaking)",
//                             "phong": "102 - Building 80 Mau Than",
//                             "moTa": ""
//                         }
//                     ]
//                 },
//                 {
//                     "tuan": {
//                         "ngayBatDau": "27/04/20",
//                         "ngayKetThuc": "03/05/20",
//                         "tuanLich": 18,
//                         "tuanHoc": 12
//                     },
//                     "buois": [
//                         {
//                             "coSo": "Building 80 Mau Than",
//                             "lop": "B1 QSKILLS - 2345 - Nhóm 1",
//                             "idSuKien": 21761,
//                             "caDay": "18:30 - 20:30",
//                             "khoa": "ADU - 01.2020 (06.01)",
//                             "trangThaiGiaoViens": [
//                                 {
//                                     "tenGiaoVien": "",
//                                     "trangThaiDiemDanh": "Chưa điểm danh",
//                                     "idGiaoVien": 0,
//                                     "maTrangThaiDiemDanh": 1
//                                 }
//                             ],
//                             "ketThuc": "27/04/20",
//                             "batDau": "27/04/20",
//                             "thu": "Thứ Hai",
//                             "ngay": "27/04/20",
//                             "giaoVien": "[18:30 - 20:30] - Lê Thị Thúy Hằng - (Reading / Writing)",
//                             "phong": "102 - Building 80 Mau Than",
//                             "moTa": ""
//                         },
//                         {
//                             "coSo": "Building 80 Mau Than",
//                             "lop": "B1 QSKILLS - 2345 - Nhóm 1",
//                             "idSuKien": 21762,
//                             "caDay": "18:30 - 20:30",
//                             "khoa": "ADU - 01.2020 (06.01)",
//                             "trangThaiGiaoViens": [
//                                 {
//                                     "tenGiaoVien": "",
//                                     "trangThaiDiemDanh": "Chưa điểm danh",
//                                     "idGiaoVien": 0,
//                                     "maTrangThaiDiemDanh": 1
//                                 }
//                             ],
//                             "ketThuc": "28/04/20",
//                             "batDau": "28/04/20",
//                             "thu": "Thứ Ba",
//                             "ngay": "28/04/20",
//                             "giaoVien": "[18:30 - 20:30] - Meghan Elica Matias Sonquipal - (Speaking / Listening)",
//                             "phong": "102 - Building 80 Mau Than",
//                             "moTa": ""
//                         },
//                         {
//                             "coSo": "Building 80 Mau Than",
//                             "lop": "B1 QSKILLS - 2345 - Nhóm 1",
//                             "idSuKien": 21763,
//                             "caDay": "18:30 - 20:30",
//                             "khoa": "ADU - 01.2020 (06.01)",
//                             "trangThaiGiaoViens": [
//                                 {
//                                     "tenGiaoVien": "",
//                                     "trangThaiDiemDanh": "Chưa điểm danh",
//                                     "idGiaoVien": 0,
//                                     "maTrangThaiDiemDanh": 1
//                                 }
//                             ],
//                             "ketThuc": "29/04/20",
//                             "batDau": "29/04/20",
//                             "thu": "Thứ Tư",
//                             "ngay": "29/04/20",
//                             "giaoVien": "[18:30 - 20:30] - Lê Thị Thúy Hằng - (Reading / Writing)",
//                             "phong": "102 - Building 80 Mau Than",
//                             "moTa": ""
//                         },
//                         {
//                             "coSo": "Building 80 Mau Than",
//                             "lop": "B1 QSKILLS - 2345 - Nhóm 1",
//                             "idSuKien": 21764,
//                             "caDay": "18:30 - 20:30",
//                             "khoa": "ADU - 01.2020 (06.01)",
//                             "trangThaiGiaoViens": [
//                                 {
//                                     "tenGiaoVien": "",
//                                     "trangThaiDiemDanh": "Chưa điểm danh",
//                                     "idGiaoVien": 0,
//                                     "maTrangThaiDiemDanh": 1
//                                 }
//                             ],
//                             "ketThuc": "30/04/20",
//                             "batDau": "30/04/20",
//                             "thu": "Thứ Năm",
//                             "ngay": "30/04/20",
//                             "giaoVien": "[18:30 - 20:30] - Đặng Trần Hoàng Nguyên - (Listening / Speaking)",
//                             "phong": "102 - Building 80 Mau Than",
//                             "moTa": ""
//                         }
//                     ]
//                 }
//             ]
//         }
//     ]
// }