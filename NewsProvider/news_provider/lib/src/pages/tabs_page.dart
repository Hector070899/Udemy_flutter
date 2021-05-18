import 'package:flutter/material.dart';
import 'package:news_provider/src/pages/tab1_page.dart';
import 'package:news_provider/src/pages/tab2_page.dart';

import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //Instancia de navegacion Model
      //en un changeNotifier
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

//clase que permite navegar entre tabs
class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Instancia de NavegacionModel
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      //currentIndex es la posicion inicial de los tabs del navigationBottomBar
      //
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Favoritos'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      //El pageController proviene _NavegacionModel
      controller: navegacionModel.pageController,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

//Cuando haga el cambio de valor se actualizan todos los widgets
class _NavegacionModel with ChangeNotifier {
  //Prop que indica la seleccion cuando la aplicacion se incialice
  //Va a cambiar su valor conforme sean seleccionados los tabs
  int _paginaActual = 0;

  PageController _pageController = PageController(initialPage: 0);

  //Getter que expone el valor de pageController para que sea visible en cualquier lugar
  PageController get pageController => _pageController;

  //Getter que expone la propiedad para que sea visible en cualquier lugar
  int get paginaActual => _paginaActual;

  set paginaActual(int valor) {
    //Aqui cambia el valor de pagina actual y permite la navegacioon
    _paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    //Notificar a todos los widgets que esten pendientes que se redibujen si es necesario
    print(paginaActual);
    notifyListeners();
  }
}
  //API KEY
// 78bca3f8936a447599d2a902bd7f305e
