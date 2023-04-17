import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import '../provider/flags_provider.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.postObj});
  PostModel? postObj;

  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final avatar =
        CircleAvatar(backgroundImage: AssetImage('assets/itc_esc.jpg'));

    final txtUser = Text('Jorge Silis');
    final txtDate = Text('06/03/2023');
    final postImage =
        Image(height: 100, image: AssetImage('assets/logo_itc.png'));
    final txtDesc = Text('Este es el contenido del post');
    final iconRate = Icon(Icons.rate_review);

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Container(
      margin: EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blue),
      child: Column(
        children: [
          Row(
            children: [avatar, txtUser, txtDate],
          ),
          Row(
            children: [postImage, txtDesc],
          ),
          Row(
            children: [
              iconRate,
              Expanded(child: Container()),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add', arguments: postObj);
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('confirmar borrado'),
                              content: const Text('¿Deseas borrar el post?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      database
                                          .DELETE('tblPost', postObj!.idPost!)
                                          .then(
                                            (value) => flag.setFlag_postList(),
                                          );
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Sí')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No'))
                              ],
                            ));
                  },
                  icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
