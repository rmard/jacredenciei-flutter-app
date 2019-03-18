import 'package:flutter/material.dart';
import '../pages/event_details.dart';

class CardEvent extends StatelessWidget {
  final event;

  CardEvent(this.event);

  @override
  Widget build(BuildContext context) {
    var imgUrl =
        'https://jacredenciei.com.br/' + event['imagem_dir'] + event['imagem'];
    return GestureDetector(
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (EventDetails(event)),))
            },
        child: Card(
          child: Column(
            children: [
              Image(
                image: NetworkImage(imgUrl),
              ),
              Text(event['nome']),
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          margin: EdgeInsets.only(bottom: 25),
        ));
  }
}
