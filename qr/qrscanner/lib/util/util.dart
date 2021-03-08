import 'package:flutter/material.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchUrl(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
  //Verificacion de que el scan sea de tipo http
  if (scan.tipo == 'http') {
    //Abri el sitio web
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
