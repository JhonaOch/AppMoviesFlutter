import 'package:flutter/material.dart';
import 'package:pelicula_application_3/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal(
      {Key? key, required this.peliculas, required this.siguientePagina})
      : super(key: key);

  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 100) {
        //print('Dagos sigueintes');
        siguientePagina();
      }
    });

    // ignore: sized_box_for_whitespace
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
          pageSnapping: false,
          //children:_tarjetas(context),
          itemCount: peliculas.length,
          itemBuilder: (context, i) {
            return _tarjeta(context, peliculas[i]);
          },
          controller: _pageController),
    );
  }

  Widget _tarjeta(context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-poster';
    final tarjeta = Container(
      margin: const EdgeInsets.only(right: 15.0),
      //alignment: Alignment.center,
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 140.0),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
        child: tarjeta);
  }

//No se esta usando
  // ignore: unused_element
  List<Widget> _tarjetas(context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: const EdgeInsets.only(right: 15.0),
        //alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 140.0),
            ),
            const SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
