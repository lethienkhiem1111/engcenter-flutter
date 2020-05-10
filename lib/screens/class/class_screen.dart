import 'package:englcenterapp/models/class.dart';
import 'package:englcenterapp/models/class_response.dart';
import 'package:englcenterapp/widgets/ClassScreenArgument.dart';
import 'package:englcenterapp/widgets/ItemClassList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/class_provider.dart';

class ClassScreen extends StatefulWidget {
  static const routeName = '/class_screen';
  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {

  @override
  Widget build(BuildContext context) {
    ClassScreenArgument args = ModalRoute.of(context).settings.arguments;
    final classProvider = Provider.of<ClassProvider>(context);
    classProvider.getAllClassesByCourseId(args.idKhoa);
    // TODO: implement build
    return Scaffold(
      
      appBar: AppBar(
        title: Text(args.tenKhoa),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
            decoration: BoxDecoration(
              color: Colors.white            
              ),
            child: StreamBuilder<ClassResponse>(
            stream: classProvider.subject.stream,
            builder: (context, AsyncSnapshot<ClassResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildWithError(snapshot.data.error);
                }
                return _buildItem(snapshot.data.classes);
              } else if (snapshot.hasError) {
                return _buildWithError(snapshot.error);
              } else {
                return _buildLoading();
              }
            },
          )),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildItem(List<Class> classes) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: classes.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (conext, index) {
          return ItemClassList('assets/images/image1.png',
              classes[index]);
        }

        );
  }

  Widget _buildWithError(String error) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text("Error occured: $error")),
      ],
    ));
  }
}