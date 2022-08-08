import 'package:flutter/material.dart';

class DisplayData {
  String? mensaje = '';
  String? estado = '';
  DisplayData(this.mensaje, this.estado);

  DisplayData.fromJson(var value) {
    mensaje = value['mensaje'];
    estado = value['estado'];
  }
}
