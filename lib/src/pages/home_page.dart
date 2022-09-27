import 'package:flutter/material.dart';
import 'package:pelicula_application_3/src/providers/peliculas_provider.dart';
import 'package:pelicula_application_3/src/search/search_delegate.dart';
import 'package:pelicula_application_3/src/widgets/card_swiper_widget.dart';
import 'package:pelicula_application_3/src/widgets/movie_horizontal.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Peliculas'),
        backgroundColor: const Color.fromARGB(255, 19, 4, 83),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          )
        ],
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [_swiperTarjetas(), _footer(context)],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          // ignore: sized_box_for_whitespace
          return Container(
              height: 400.0,
              child: const Center(child: CircularProgressIndicator()));
        }
      },
    );

    //   peliculasProvider.getEnCines();
    //
  }

  Widget _footer(context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle1,
            )),

        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder(
          stream: peliculasProvider.popularesStream,
          // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return MovieHorizontal(
                peliculas: snapshot.data,
                siguientePagina: peliculasProvider.getPopulares,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
            //return Container();
          },
        ),
        // Text('Populares',style: Theme.of(context).textTheme.headline6 ,),
      ]),
    );
  }
}
