

import 'package:englcenterapp/models/contact.dart';

class ContactResponse {
  final String error;
  // final String result;
  final List<Contact> contacts;

  ContactResponse({this.contacts, this.error});

  factory ContactResponse.fromJson(Map<String, dynamic> jsonScheduleResponse) {
    if((jsonScheduleResponse['data'][0]['soLienLac'] as List).isEmpty) {
      return ContactResponse(
      contacts: [],
      error: 'Sổ liên lạc chưa cập nhập'
    );
    }
    return ContactResponse(
      contacts: (jsonScheduleResponse['data'][0]['soLienLac'] as List).map((i) => Contact.fromJson(i)).toList(),
      error: ''
    );
  }

  factory ContactResponse.withError(String error) {
    return ContactResponse(
      contacts: [],
      error: error
    );
  }
}

// {
//     "result": "success",
//     "data": [
//         {
//             "soLienLac": [
//                 {
//                     "tenGiaoVien": "Lê Thị Thúy Hằng",
//                     "idDotNhanXet": 1,
//                     "tenTrangThai": "Đã phản hồi",
//                     "idTrangThai": 5,
//                     "phanHoiPhuHuynh": "Thank you",
//                     "nhanXetGiaoVien": "Tuần học: 5-8\nNội dung bài: Unit 9 - 10 \nVề tinh thần học: Bé ngoan và cũng có cố gắng khi giáo viên động viên. Bé nên tích cực chủ động và sử dụng tiếng anh để giao tiếp khi làm việc nhóm. \nVề kết quả học tập: Bé nắm khá từ vựng chủ đề trong bài 9 và bài 10. Tuy nhiên phần ngữ pháp áp dụng chưa được vững. Bé nên ôn lại phần ngữ pháp bài 9 và 10. \nNhờ phụ huynh động viên em ôn bài để chuẩn bị cho kì thi cuối khóa sắp đến. \nNgày thi cuối khóa: 21 - 22/12/2019 \nCảm ơn Phụ huynh đã xem tin!\n",
//                     "idGiaoVien": 20,
//                     "idSoLienLac": 13238
//                 },
//                 {
//                     "tenGiaoVien": "Lê Thị Thúy Hằng",
//                     "idDotNhanXet": 2,
//                     "tenTrangThai": "Đã phản hồi",
//                     "idTrangThai": 5,
//                     "phanHoiPhuHuynh": "Vui lòng nhập sổ liên lạc",
//                     "nhanXetGiaoVien": "Tuần học: 9-10\nNội dung bài: Unit 9 - 10 \nVề tinh thần học: Bé ngoan và cũng có cố gắng khi giáo viên động viên. Bé nên tích cực chủ động và sử dụng tiếng anh để giao tiếp khi làm việc nhóm. \nVề kết quả học tập: Bé nắm khá từ vựng chủ đề trong bài 9 và bài 10. Tuy nhiên phần ngữ pháp áp dụng chưa được vững. Bé nên ôn lại phần ngữ pháp bài 9 và 10. \nNhờ phụ huynh động viên em ôn bài để chuẩn bị cho kì thi cuối khóa sắp đến. \nNgày thi cuối khóa: 21 - 22/12/2019 \nCảm ơn Phụ huynh đã xem tin!",
//                     "idGiaoVien": 20,
//                     "idSoLienLac": 13255
//                 },
//                 {
//                     "tenGiaoVien": "Lê Thị Thúy Hằng",
//                     "idDotNhanXet": 3,
//                     "tenTrangThai": "Đã phản hồi",
//                     "idTrangThai": 5,
//                     "phanHoiPhuHuynh": "vhgng",
//                     "nhanXetGiaoVien": "Tuần học: 9-10\nNội dung bài: Unit 9 - 10 \nVề tinh thần học: Bé ngoan và cũng có cố gắng khi giáo viên động viên. Bé nên tích cực chủ động và sử dụng tiếng anh để giao tiếp khi làm việc nhóm. \nVề kết quả học tập: Bé nắm khá từ vựng chủ đề trong bài 9 và bài 10. Tuy nhiên phần ngữ pháp áp dụng chưa được vững. Bé nên ôn lại phần ngữ pháp bài 9 và 10. \nNhờ phụ huynh động viên em ôn bài để chuẩn bị cho kì thi cuối khóa sắp đến. \nNgày thi cuối khóa: 21 - 22/12/2019 \nCảm ơn Phụ huynh đã xem tin!",
//                     "idGiaoVien": 20,
//                     "idSoLienLac": 13317
//                 }
//             ],
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