import 'package:flutter/material.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:news_provider/src/theme/theme.dart';

class ListaNoticias extends StatelessWidget {
  //Recibe una lista de articles que se guardan en noticias
  final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(noticia: noticias[index], index: index);
      },
    );
  }
}

//Widget que contiene las noticias

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({@required this.noticia, @required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(noticia, index),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),
        SizedBox(height: 10.0),
        Divider(),
        _TarjetaBotones()
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _RawTarjetaBotones(),
    );
  }
}

class _RawTarjetaBotones extends StatelessWidget {
  const _RawTarjetaBotones({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Icon(Icons.star_border),
        ),
        SizedBox(width: 10.0),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Icon(Icons.more),
        )
      ],
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;
  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        (noticia.description != null)
            ? noticia.description
            : 'No se encontro descripcion',
      ),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const _TarjetaImagen(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        child: Container(
            //Validar si el urlToImage tiene una imagen disponible
            margin: EdgeInsets.all(1.0),
            child: (noticia.urlToImage != null)
                ? FadeInImage(
                    placeholder: AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage(noticia.urlToImage))
                : Image(image: AssetImage('assets/img/no-image.png'))),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        noticia.title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;
  const _TarjetaTopBar(this.noticia, this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: TextStyle(color: myTheme.accentColor),
          ),
          Text(
            '${noticia.source.name}. ',
          ),
        ],
      ),
    );
  }
}
