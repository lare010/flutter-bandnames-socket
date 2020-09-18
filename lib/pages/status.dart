import 'package:band_names/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    // socketService.socket.

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('ServerStatus ${socketService.serverStatus}')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          // emitir: emitir-mensaje
          // {nombre:'flutter ',mensaje:'hola desde flutter'}
          socketService.socket.emit('emitir-mensaje',
              {'nombre': 'flutter', 'mensaje': 'hola desde flutter'});
        },
      ),
    );
  }
}
