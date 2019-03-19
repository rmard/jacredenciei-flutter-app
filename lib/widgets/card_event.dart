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
                    builder: (context) => (EventDetails(event)),
                  ))
            },
        child: Card(
          color: Colors.grey[300],
          child: Column(
            children: [
              Image(
                image: NetworkImage(imgUrl),
              ),
              Padding(
                padding: EdgeInsets.all(6),
              ),
              Text('EVENTO', style: TextStyle(fontSize: 12, color: Colors.indigo[600], fontWeight: FontWeight.bold),),
              Text(
                event['nome'],
                style: TextStyle(
                    color: Colors.grey[700], fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.all(6),
              ),
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          margin: EdgeInsets.only(bottom: 20),
        ));
  }
}
