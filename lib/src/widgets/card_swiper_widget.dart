import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pelicula_application_3/src/models/pelicula_model.dart';

// ignore: use_key_in_widget_constructors
class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  const CardSwiper({Key? key, required this.peliculas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: //Text(peliculas[index].toString()),
                    GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'detalle',
                        arguments: peliculas[index]);
                  },
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(peliculas[index].getPosterImg()),
                    fit: BoxFit.cover,
                  ),
                )),
          );
        },
        itemCount: peliculas.length,
        //pagination: const SwiperPagination(),
        //control: const SwiperControl(),
      ),
    );
  }
}
