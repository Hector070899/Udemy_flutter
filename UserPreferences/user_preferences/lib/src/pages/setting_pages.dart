import 'package:flutter/material.dart';
import 'package:user_preferences/src/shared_prefs/preferencias_usuario.dart';
import 'package:user_preferences/src/widgets/drawer_widget.dart';

class SettingsPage extends StatefulWidget {
  //Propiedad estatica para acceder al nombre de la pagina
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _colorSecundario;
  int _genero;
  String _nombre;

  //Prop para acceder al controller del textfield
  TextEditingController _textController;

  final prefs = PreferenciasUsuario();

  //Se dispara cuando se inicializa el estado
  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = SettingsPage.routeName;
    print('${prefs.ultimaPagina}');
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _textController = TextEditingController(text: prefs.nombreUsuario);
  }

  _setSelectedRadio(int valor) {
    prefs.genero = valor;

    setState(() {
      _genero = valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.black,
      ),
      drawer: DrawerWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SwitchListTile(
            //Se asigna _colorSecundario al value
            value: _colorSecundario,
            title: Text('Color Secundario'),
            onChanged: (value) {
              setState(() {
                //Se iguala al value que recibe como argumento el onChanged
                _colorSecundario = value;
                prefs.colorSecundario = value;
                print(_colorSecundario);
              });
            },
          ),
          RadioListTile(
            value: 1,
            groupValue: _genero,
            onChanged: _setSelectedRadio,
            // onChanged: (value) {
            //   setState(() {
            //     _genero = value;
            //     print(_genero);
            //   });
            // },
            title: Text('Masculino'),
          ),
          RadioListTile(
            value: 2,
            groupValue: _genero,
            onChanged: _setSelectedRadio,
            // onChanged: (value) {
            //   setState(() {
            //     _genero = value;
            //     print(_genero);
            //   });
            // },
            title: Text('Femenino'),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              //Asignacion del valor del initState al controller
              controller: _textController,
              decoration: InputDecoration(
                  labelText: 'Nombre',
                  helperText: 'Nombre de la persona usando el telefono'),
              onChanged: (value) {
                prefs.nombreUsuario = value;
              },
            ),
          )
        ],
      ),
    );
  }
}
