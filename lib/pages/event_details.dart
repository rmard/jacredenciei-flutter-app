import 'package:flutter/material.dart';

import '../api.dart';

class EventDetails extends StatelessWidget {
  final event;

  EventDetails(this.event);

  @override
  Widget build(BuildContext context) {
    var url = 'https://jacredenciei.com.br/i/'+event['hsurl'];
    var imgUrl =
        'https://jacredenciei.com.br/' + event['imagem_dir'] + event['imagem'];
    return Scaffold(
      appBar: AppBar(
        title: Text(event['nome']),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage(imgUrl),
            ),
            Text(event['hsdestaquetitulo'], style: Theme.of(context).textTheme.title),
            Text(event['hsdetaquetexto'], style: Theme.of(context).textTheme.subhead),
            Divider(),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                event['descricao'],
                textAlign: TextAlign.justify,
              ),
            ),
            RaisedButton(
              onPressed: (){API.launchURL(url);},
              child: Text('INSCREVA-SE'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

