import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import '../provider/flags_provider.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key,this.objPostModel});

  PostModel? objPostModel;

  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    

    final avatar = CircleAvatar(
      backgroundImage: AssetImage('assets/logo_itc.png'),
    );
    final txtUser = Text('Jorge Silis');

    final datePost = Text('06/03/2023');
    final imgPost = Image(image: AssetImage('assets/itc_esc.jpg'));
    final txtDescPost = Text('Lorem ipsum lkasjdlkajdlaksdja');
    final iconRate = Icon(Icons.star);

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            children: [
              avatar,
              txtUser,
              datePost
            ],
          ),
          Row(
            children: [
              imgPost,
              txtDescPost
            ],
          ),
          Row(
            children: [
              iconRate,
              Expanded(child: Container()),
              IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/add', arguments: objPostModel);

                }, 
                icon: Icon(Icons.edit)
              ),
              IconButton(
                onPressed: (){

                  showDialog(
                    context: context, 
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar Borrado'),
                      content: const Text('Deseas borrar el post?'),
                      actions: [
                        TextButton(
                          onPressed: (){
                            database.DELETE('tblPost',objPostModel!.idPost!).then(
                              (value) => flag.setflagListPost()
                            );
                            Navigator.pop(context);
                          }, 
                          child: const Text('Si')
                        ),
                        TextButton(
                          onPressed: (){}, 
                          child: const Text('No')
                        )
                      ],
                    ),
                  );
                }, 
                icon: Icon(Icons.delete)
              )
            ],
          )
        ],
      ),
    );
  }
}
