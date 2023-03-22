import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/models/post_model.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  DatabaseHelper database = DatabaseHelper();
  PostModel? objPostModel;
  @override
  Widget build(BuildContext context) {
    objPostModel = ModalRoute.of(context)!.settings.arguments as PostModel;
    final txtConPost = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          height: 350,
          decoration: BoxDecoration(
              color: Colors.green[600],
              border: Border.all(color: Colors.black)),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              objPostModel == null
                  ? const Text('Add post :D')
                  : const Text('Update post :D'),
              TextFormField(
                controller: txtConPost,
                maxLines: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (objPostModel == null) {
                      database.INSERT('tblPost', {
                        'descPost': txtConPost.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msg = value > 0
                            ? 'Registro insertado'
                            : 'Ocurrio un error';

                        var snackBar = SnackBar(content: Text(msg));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    } else {
                      database.INSERT('tblPost', {
                        'descPost': txtConPost.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msg = value > 0
                            ? 'Registro insertado'
                            : 'Ocurrio un error';

                        var snackBar = SnackBar(content: Text(msg));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                  },
                  child: Text('Save post'))
            ],
          ),
        ),
      ),
    );
  }
}
