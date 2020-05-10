import 'package:englcenterapp/models/score.dart';
import 'package:englcenterapp/models/score_response.dart';
import 'package:englcenterapp/providers/score_provider.dart';
import 'package:englcenterapp/widgets/ClassScreenArgument.dart';
import 'package:englcenterapp/widgets/item_score.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScoreScreen extends StatefulWidget {
  static const routeName = '/score_screen';
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  ClassScreenArgument args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    final scores = Provider.of<ScoreProvider>(context);
    scores.getScoreOfClass(args.idHocVien, args.idLop);
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem điểm'),
      ),
      body: Container(
          child: StreamBuilder<ScoreResponse>(
      stream: scores.subject.stream,
      builder: (context, AsyncSnapshot<ScoreResponse> snapshot) {
        List<Score> _temScores = [];
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _scoresIsEmpty(snapshot.data.error);
          }
          try {
            _temScores = snapshot.data.scores;
            if(_temScores.isEmpty) {
              return _scoresIsEmpty(snapshot.data.error);
            }
                
          } catch (error) {
            return _scoresIsEmpty(error);
          }
          return _buildScores(_temScores);
        } else if (snapshot.hasError) {
          return _scoresIsEmpty(snapshot.error);
        } else {
          return _buildLoading();
        }
      },
    )
      ),
    );
  }
}
Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }
Widget _scoresIsEmpty(String message) {
    return Center(child: Text(message));
  }

  Widget _buildScores(List<Score> scores) {
    return 
    Align(
        alignment: Alignment.center,
        child: Column(children: scores.map((score) 
        => ItemScore(Color(0xFF2D8A7F), score.tenDiem, score.giaTri.toString())).toList()),
      );

  }
  // ItemScore(Color(0xFFFFA432), 'Listening', '8'),
  //         ItemScore(Color(0xFF2D8A7F), 'Speaking', '7'),
  //         ItemScore(Color(0xFFE24959), 'Reading', '9'),
  //         ItemScore(Color(0xFF3399FF), 'Write', '9'),