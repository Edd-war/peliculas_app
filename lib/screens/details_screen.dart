import 'package:flutter/material.dart';
import 'package:peliculas_app/widgets/casting_cards.dart';
class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // TODO: Cambiar luego por una isntancia de movie
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'No movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              CastingCards(),
            ]),
            
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 5),
          color: Colors.black12,
          alignment: Alignment.bottomCenter,
          child: Text(
            'movie.title',
            style: TextStyle(fontSize: 16),
          )
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,

        ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
              Text('movie.originalTitle', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  SizedBox(width: 5,),
                  Text('movie.voteAverage', style: textTheme.caption,)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),

    );
  }
}

