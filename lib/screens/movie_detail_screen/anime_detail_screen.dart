import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/data/model/Anime/Data.dart';
import 'package:movie_app/widgets/cached_image.dart';

class AnimeDetailScreen extends StatefulWidget {
  final Data anime;
  const AnimeDetailScreen(this.anime, {super.key});

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff1F2722),
            Color(0xff131312),
          ],
        ),
      ),
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                stretch: true,
                toolbarHeight: 40,
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(top: 18, right: 18),
                    child: Icon(
                      Icons.menu,
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(5),
                  child: Container(
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Color(0xff1F2722),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                backgroundColor: const Color(0xff1F2722),
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CachedImage(
                          imageUrl: widget.anime.images!.jpg!.largeImageUrl,
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        child: Container(
                          width: 130,
                          height: 40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.red,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.play_arrow_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Play",
                                style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ];
          },
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff1F2722),
                  Color(0xff131312),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Text(
                    widget.anime.title!,
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Chip(
                              avatar: const Icon(Icons.movie),
                              label: Text(
                                "episode:${widget.anime.episodes.toString()}",
                                style: GoogleFonts.raleway(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Chip(
                              avatar: const Icon(Icons.timelapse),
                              label: Text(
                                "${widget.anime.duration}",
                                style: GoogleFonts.raleway(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Chip(
                              avatar: const Icon(Icons.local_movies),
                              label: Text(
                                "genre: ${widget.anime.genres![0].name}",
                                style: GoogleFonts.raleway(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Chip(
                              avatar: const Icon(Icons.rate_review),
                              label: Text(
                                "members: ${widget.anime.rating}",
                                style: GoogleFonts.raleway(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            // ignore: unrelated_type_equality_checks
                            if (widget.anime.year == Null) ...{
                              Chip(
                                avatar: const Icon(
                                    Icons.production_quantity_limits_rounded),
                                label: Text(
                                  "${widget.anime.year}",
                                  style: GoogleFonts.raleway(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            }
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.anime.broadcast!.timezone == Null &&
                      widget.anime.broadcast!.day == Null &&
                      widget.anime.broadcast!.string == Null) ...{
                    SizedBox(
                      height: 30,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Chip(
                                avatar: const Icon(Icons.flag),
                                label: Text(
                                  "${widget.anime.broadcast!.timezone}",
                                  style: GoogleFonts.raleway(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Chip(
                                avatar: const Icon(
                                    Icons.published_with_changes_rounded),
                                label: Text(
                                  "${widget.anime.broadcast!.string}",
                                  style: GoogleFonts.raleway(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  },
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}