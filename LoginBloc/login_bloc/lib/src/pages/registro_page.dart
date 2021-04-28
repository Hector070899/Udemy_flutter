import 'package:login_bloc/src/providers/usuario_provider.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/utils/utils.dart';

import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  final userProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('register'),
      // ),
      body: Stack(
        children: <Widget>[
          _background(context),
          _registerCard(context),
        ],
      ),
    );
  }

  _background(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final backGradient = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColorDark,
          ],
        ),
      ),
    );

    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Theme.of(context).accentColor,
      ),
    );

    return Stack(
      children: <Widget>[
        backGradient,
        // floating circles
        Positioned(top: 90.0, left: 30.0, child: circle),
        Positioned(top: -40.0, right: -30.0, child: circle),
        // register icon and text
        Container(
          padding: EdgeInsets.only(top: 70.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.memory,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(height: 5.0, width: double.infinity),
              Text(
                'Silicon',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _registerCard(BuildContext context) {
    final bloc = Provider.of(context);

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      // controller: ,
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 200.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 30.0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Register',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                _email(context, bloc),
                SizedBox(height: 20.0),
                _password(context, bloc),
                SizedBox(height: 40.0),
                _submitButton(context, bloc),
              ],
            ),
          ),
          TextButton(
            child: Text(
              'Ya tenes una cuenta?',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              'login',
            ),
          ),
          SizedBox(height: 80.0),
        ],
      ),
    );
  }

  _email(BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Theme.of(context).primaryColor,
              ),
              // hintText: 'john@example.com',
              labelText: 'Email',
              // counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  _password(BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: Theme.of(context).primaryColor,
              ),
              labelText: 'Password',
              // counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  _submitButton(BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0,
            ),
            child: Text('Submit'),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 3.0,
            primary: Theme.of(context).primaryColorLight,
            onPrimary: Colors.black87,
          ),
          onPressed: snapshot.hasData ? () => _register(context, bloc) : null,
        );
      },
    );
  }

  _register(BuildContext context, LoginBloc bloc) async {
    Map info = await userProvider.newUser(bloc.email, bloc.password);

    if (info['ok']) {
      Navigator.pushNamed(context, 'login');
    } else {
      mostrarAlerta(context, info['message']);
    }
  }
}
