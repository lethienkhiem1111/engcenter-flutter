
import 'package:englcenterapp/models/news.dart';

class NewsResponse {
  final String error;
  // final String result;
  final List<News> news;

  NewsResponse({this.news, this.error});

  factory NewsResponse.fromJson(Map<String, dynamic> jsonNewsResponse) {
    if((jsonNewsResponse['data'] as List).isEmpty) {
      return NewsResponse(
      news: [],
      error: 'Tin tức chưa cập nhập'
    );
    }
    return NewsResponse(
      news: (jsonNewsResponse['data'] as List).map((i) => News.fromJson(i)).toList(),
      error: ''
    );
  }

  factory NewsResponse.withError(String error) {
    return NewsResponse(
      news: [],
      error: error
    );
  }
}
// {
//     "result": "success",
//     "data": [
//         {
//             "loaiTinTuc": "1",
//             "trangThaiTinTuc": "Đã duyệt",
//             "noiDung": "Tất cả học viên thuộc các chương trình tiếng Anh trẻ em, thiếu niên, người lớn đăng ký khoá học mới (trừ khoá Flexi-time Membership và IELTS Đảm bảo)\n- Mỗi học viên có thể nhận mức ưu đãi học phí tối đa 2 khoá học liên tiếp (đến tháng 12/2020)\n- Chỉ áp dụng khi hoàn thành học phí trong tháng 5/2020\n- KHÔNG áp dụng chế độ rút học phí khi hưởng ưu đãi này\n- KHÔNG có quyền bảo lưu (trừ các lý do khách quan từ Trung tâm)\n---------------------------------------------\nCần giải đáp thắc mắc hoặc biết thêm chi tiết, học viên có thể #inbox fanpage Gia Việt hoặc liên hệ trực tiếp qua:",
//             "ngayDang": "27/04/2020 16:51:10",
//             "tieuDe": "TIẾNG ANH MÙA \"CÔ VI\", HỌC PHÍ RẺ QUÁ ĐI!",
//             "anhDaiDien": "http://mekosoft.vn:4088/image/journal/article?img_id=134221&t=1587981070067",
//             "tenLoaiTinTuc": "Tin tức sự kiện",
//             "tomTat": "San sẻ khó khăn mùa Covid",
//             "idTrangThaiTinTuc": "0",
//             "idTinTuc": "134184"
//         },
//         {
//             "loaiTinTuc": "1",
//             "trangThaiTinTuc": "Đã duyệt",
//             "noiDung": "Tất cả học viên thuộc các chương trình tiếng Anh trẻ em, thiếu niên, người lớn đăng ký khoá học mới (trừ khoá Flexi-time Membership và IELTS Đảm bảo)\n- Mỗi học viên có thể nhận mức ưu đãi học phí tối đa 2 khoá học liên tiếp (đến tháng 12/2020)\n- Chỉ áp dụng khi hoàn thành học phí trong tháng 5/2020\n- KHÔNG áp dụng chế độ rút học phí khi hưởng ưu đãi này\n- KHÔNG có quyền bảo lưu (trừ các lý do khách quan từ Trung tâm)\n---------------------------------------------\nCần giải đáp thắc mắc hoặc biết thêm chi tiết, học viên có thể #inbox fanpage Gia Việt hoặc liên hệ trực tiếp qua:",
//             "ngayDang": "27/04/2020 17:01:28",
//             "tieuDe": "SAN SẺ KHÓ KHĂN MÙA COVID",
//             "anhDaiDien": "http://mekosoft.vn:4088/image/journal/article?img_id=134268&t=1587981687798",
//             "tenLoaiTinTuc": "Tin tức sự kiện",
//             "tomTat": "San sẻ khó khăn mùa Covid",
//             "idTrangThaiTinTuc": "0",
//             "idTinTuc": "134207"
//         },
//         {
//             "loaiTinTuc": "1",
//             "trangThaiTinTuc": "Đã duyệt",
//             "noiDung": "Chắc các bạn còn nhớ chuỗi hoạt động Online về DU HỌC được Gia Việt chia sẻ trước đây phải không? Tối hôm nay là hoạt động Kỳ 3 nè.\nChương trình Kỳ 3 sẽ nói về HỌC BỔNG TRUNG HỌC NEW ZEALAND.\nMọi người xem thêm thông tin trong bài viết để được hướng dẫn cách thức tham gia buổi chia sẻ nhé.\nSee you there!",
//             "ngayDang": "27/04/2020 16:53:22",
//             "tieuDe": "HỌC BỔNG TRUNG HỌC NEW ZEALAND",
//             "anhDaiDien": "http://mekosoft.vn:4088/image/journal/article?img_id=134238&t=1587981201750",
//             "tenLoaiTinTuc": "Tin tức sự kiện",
//             "tomTat": "Chắc các bạn còn nhớ chuỗi hoạt động Online về DU HỌC được Gia Việt chia sẻ trước đây phải không? Tối hôm nay là hoạt động Kỳ 3 nè.\nChương trình Kỳ 3 sẽ nói về HỌC BỔNG TRUNG HỌC NEW ZEALAND.\nMọi người xem thêm thông tin trong bài viết để được hướng dẫn cách thức tham gia buổi chia sẻ nhé.\nSee you there!",
//             "idTrangThaiTinTuc": "0",
//             "idTinTuc": "134235"
//         },
//         {
//             "loaiTinTuc": "1",
//             "trangThaiTinTuc": "Đã duyệt",
//             "noiDung": "Nhằm mục đích đáp ứng nhu cầu ôn thi IELTS của học viên giữa mùa dịch, Gia Việt tổ chức khoá IELTS INTENSIVE ONLINE, học tương tác hoàn toàn bằng phần mềm Zoom trực tuyến\nVới phương pháp triển khai phù hợp và khoa học, các bạn có thể yên tâm khi học tập hiệu quả mà vẫn đảm bảo an toàn sức khoẻ trong thời điểm hiện nay.\nĐối tượng: Học viên có mục tiêu đạt kết quả IELTS từ 4.5 trở lên\nThời lượng: 10 tuần, 4 buổi/tuần. Mỗi buổi học kéo dài 2 giờ, riêng lớp Nói/Phát âm kéo dài 1 giờ (xem lịch học cụ thể đính kèm)",
//             "ngayDang": "27/04/2020 17:00:17",
//             "tieuDe": "HỌC TIẾNG ANH MÙA DỊCH COVID-19",
//             "anhDaiDien": "http://mekosoft.vn:4088/image/journal/article?img_id=134263&t=1587981616587",
//             "tenLoaiTinTuc": "Tin tức sự kiện",
//             "tomTat": "Nhằm mục đích đáp ứng nhu cầu ôn thi IELTS của học viên giữa mùa dịch, Gia Việt tổ chức khoá IELTS INTENSIVE ONLINE, học tương tác hoàn toàn bằng phần mềm Zoom trực tuyến Với phương pháp triển khai phù hợp và khoa học, các bạn có thể yên tâm khi học tập hiệu quả mà vẫn đảm bảo an toàn sức khoẻ trong thời điểm hiện nay. Đối tượng: Học viên có mục tiêu đạt kết quả IELTS từ 4.5 trở lên Thời lượng: 10 tuần, 4 buổi/tuần. Mỗi buổi học kéo dài 2 giờ, riêng lớp Nói/Phát âm kéo dài 1 giờ (xem lịch học cụ thể đính kèm)",
//             "idTrangThaiTinTuc": "0",
//             "idTinTuc": "134251"
//         },
//         {
//             "loaiTinTuc": "1",
//             "trangThaiTinTuc": "Đã duyệt",
//             "noiDung": "Hẹn gặp tất cả các bạn học viên sau lễ 30/4 - 1/5",
//             "ngayDang": "28/04/2020 11:36:50",
//             "tieuDe": "HẸN GẶP LẠI TẤT CẢ CÁC BẠN HỌC VIỆN",
//             "anhDaiDien": "http://mekosoft.vn:4088/image/journal/article?img_id=134418&t=1588048610094",
//             "tenLoaiTinTuc": "Tin tức sự kiện",
//             "tomTat": "Hẹn gặp tất cả các bạn học viên sau lễ 30/4 - 1/5",
//             "idTrangThaiTinTuc": "0",
//             "idTinTuc": "134406"
//         }
//     ]
// }