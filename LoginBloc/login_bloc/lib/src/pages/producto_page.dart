import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/models/producto_model.dart';
import 'package:login_bloc/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  //La propiedad formkey almacena un global key de tipo FormState
  //Flutter de esta manera reconoce que es un formulario y tiene las acciones propias para validarlo
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductosBloc productosBloc;
  ProductoModel producto = ProductoModel();
  bool _guardando = false;

  //File que tendra el path de la foto
  File foto;

  @override
  Widget build(BuildContext context) {
    //Al ser una propiedad ya inicializada tengo acceso a ellas en todos los
    //lugares de la aplicacion
    productosBloc = Provider.productoBloc(context);

    //Manera en que este page recibe el argumento que se envia a traves de pushNamed
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: _tomarFoto)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              //Identificar unico del formulario
              key: formKey,
              child: Column(
                children: <Widget>[
                  _mostrarFoto(),
                  _crearNombre(),
                  _crearPrecio(),
                  _crearDisponible(),
                  _crearBoton()
                ],
              )),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      //Metodo que asigna el valor del value
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingresar el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    //TextFormField requere que se use un Stateful Widget
    return TextFormField(
      //Valor inicial
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Precio'),
      //Como el value aca es double, la validacion solo pasa si el numero es parseable
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
      title: Text('Disponible'),
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPrimary: Colors.white,
        primary: Colors.deepPurple,
      ),
      //Esta verificacion evita que se el boton de guardar se siga presionando multiples veces
      onPressed: (_guardando) ? null : _submit,
    );
  }

  //Se dispara cuando se presione el boton save
  void _submit() async {
    //Valida el estado actual del formulario y regresa un booleano
    //Es true si el formulario es valido y false si no es valido
    if (!formKey.currentState.validate()) return;
    //Todo lo que sucede aca confirma que el formulario es valido\

    //Activa todos los save que tenga el form
    formKey.currentState.save();
    //Cambia el valor de _guardando que indica el estado del boton guardar
    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      //La creacion de un nuevo atributo en firebase
      producto.fotoURl = await productosBloc.subirFoto(foto);

      CircularProgressIndicator();
    }

    if (producto.id == null) {
      productosBloc.agregarProductos(producto);
    } else {
      productosBloc.editarProductos(producto);
    }
    mostrarSnackBar('Registro guardado');

    Navigator.pushReplacementNamed(context, 'home');
  }

  void mostrarSnackBar(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  Widget _mostrarFoto() {
    if (producto.fotoURl != null) {
      return FadeInImage(
        image: NetworkImage(producto.fotoURl),
        placeholder: AssetImage('assets/img/loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  void _seleccionarFoto() async {
    // final _picker = ImagePicker();
    _procesarFoto(ImageSource.gallery);
  }

  void _tomarFoto() async {
    // final _picker = ImagePicker();
    _procesarFoto(ImageSource.camera);
  }

  _procesarFoto(ImageSource origen) async {
    final pickedFile = await ImagePicker.pickImage(source: origen);
    foto = File(pickedFile.path);

    if (foto != null) {
      producto.fotoURl = null;
    }
    //Cambia el estado actual con la nueva foto
    setState(() {});
  }
}
