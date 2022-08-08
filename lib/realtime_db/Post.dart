import 'package:flutter/material.dart';

class Post {
  String? mensaje = '';
  String? estado = '';
  Post(this.mensaje, this.estado);

  Post.fromJson(var value) {
    mensaje = value['mensaje'];
    estado = value['estado'];
  }
}
