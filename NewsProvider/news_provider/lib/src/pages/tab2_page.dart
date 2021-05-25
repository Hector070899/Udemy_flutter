import 'package:flutter/material.dart';
import 'package:news_provider/src/models/category_models.dart';
import 'package:news_provider/src/services/news_service.dart';
import 'package:news_provider/src/theme/theme.dart';
import 'package:news_provider/src/widgets/lista_news.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),
            //Utiliza el mismo widget que el tab1, lo unico que cambia es que recibe la categoria seleccionada
            Expanded(
              child:
                  ListaNoticias(newsService.getArticulosCategoriaSeleccionada),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Instancia de NewsService con la cual obtenemos las categorias
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80.0,
      child: _ListViewerCategorias(categories: categories),
    );
  }
}

class _ListViewerCategorias extends StatelessWidget {
  const _ListViewerCategorias({
    Key key,
    @required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final name = categories[index].name;
        return Padding(
          padding: EdgeInsets.all(8.00),
          child: Column(
            children: <Widget>[
              _CategoryButton(categories[index]),
              SizedBox(
                height: 5.0,
              ),
              //Primera letra de las categorias en mayuscula
              Text('${name[0].toUpperCase()}${name.substring(1)}')
            ],
          ),
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(
    this.categoria,
  );

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        //En un evento onTap no se tiene que redibujar el elemento
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
          width: 40.0,
          height: 40.0,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: (newsService.selectedCategory == categoria.name)
              ? Icon(categoria.icon, color: myTheme.accentColor)
              : Icon(categoria.icon, color: Colors.black54)),
    );
  }
}
