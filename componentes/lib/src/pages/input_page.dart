import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  InputPage({Key key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _nombre = '';
  String _mail = '';
  String _fecha = '';
  String _opcionSelec = 'Volar';

  List<String> _poderes = ['Volar', 'Rayos X', 'Super aliento', 'Super Fuerza'];

  //Propiedad que se crea para hacer referencia a la caja de texto
  //dentro de _crearFecha
  TextEditingController _inputFieldDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs de texto'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearInput(),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearDropdown(),
          Divider(),
          _crearPersona(),
        ],
      ),
    );
  }

  //Metodo para crear un input usando TextField
  Widget _crearInput() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        counter: Text('Letras ${_nombre.length}'),
        hintText: 'Nombre de la persona',
        labelText: 'Nombre',
        helperText: 'Solo es el nombre',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle),
      ),
      onChanged: (valor) {
        //Es necesario que se guarde la igualdad de nombre con valor dentro de
        //set state por que cada vez que se redibuja el widget cambia de forma inmediata
        //Si estuviese afuera, tendria que hacer hot reload cada vez que escriba el nombre
        setState(() {
          _nombre = valor;
          print(_nombre);
        });
      },
      //por defecto cuando entra a input se abre el teclado
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget _crearPersona() {
    return ListTile(
      title: Text('Nombre es: $_nombre'),
      subtitle: Text('El email de la persona es: $_mail'),
      trailing: Text(_opcionSelec),
    );
  }

  Widget _crearEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        // counter: Text('Letras ${_mail.length}'),
        hintText: 'Email de la persona',
        labelText: 'Email',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email),
      ),
      onChanged: (valor) => setState(() {
        _mail = valor;
        print(_nombre);
      }),
    );
  }

  Widget _crearPassword() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        // counter: Text('Letras ${_mail.length}'),
        hintText: 'Password de la persona',
        labelText: 'Password',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(Icons.lock),
      ),
      onChanged: (valor) => setState(() {
        _mail = valor;
        print(_nombre);
      }),
    );
  }

  Widget _crearFecha(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      //Asginacion del controlador a la caja de texto
      controller: _inputFieldDate,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        // counter: Text('Letras ${_mail.length}'),
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha',
        suffixIcon: Icon(Icons.calendar_today),
        icon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context);
      },
    );
  }

  //Funcion que permite seleccionar la fecha a traves de un
  //cuadro de fecha(tipico cuadro android)
  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2050),
        locale: Locale('es', 'ES'));
    //Validacion para asignar el valor de la fecha a la caja de texto
    //Redibujando el valor que se quiere asignar
    if (picked != null) {
      setState(() {
        _fecha = picked.toString();
        _inputFieldDate.text = _fecha;
      });
    }
  }

  // Creacion de lista de elementos que maneja un string
  // a nivel interno
  //contiene un metodo que selecciona las opciones de la lista
  //_poderes
  List<DropdownMenuItem<String>> getOpciones() {
    List<DropdownMenuItem<String>> lista = List();

    _poderes.forEach((poder) {
      //agrega a la lista temporal los poderes
      //como si fueran de tipo dropdownmenu
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });

    //retorna la lista cargada con los poderes

    return lista;
  }

  //Creacion wicget dropdown
  Widget _crearDropdown() {
    return Row(
      children: [
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        DropdownButton(
            //tipo de valor por defecto que va a tener la lista del menu
            value: _opcionSelec,
            //Lista de objetos que va a contener el menu
            items: getOpciones(),
            //opt es necesario por que el metodo requiere un tipo especifico
            onChanged: (opt) {
              setState(() {
                _opcionSelec = opt;
              });
              print(opt);
            })
      ],
    );
  }
}
