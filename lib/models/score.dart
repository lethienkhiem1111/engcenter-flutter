
class Score {
  final int idDiem;
  final int giaTri;
  final int stt;
  final String tenDiem; 

  Score({this.idDiem, this.giaTri, this.stt, this.tenDiem});

  factory Score.fromJson(Map<String, dynamic> jsonScore) {
    return Score(
      idDiem: jsonScore['idDiem'],
      giaTri: jsonScore['giaTri'],
      stt: jsonScore['stt'],
      tenDiem: jsonScore['tenDiem']
    );
  }
  
}

