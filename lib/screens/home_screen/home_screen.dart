import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/home/home_bloc.dart';
import 'package:movie_app/bloc/home/home_event.dart';
import 'package:movie_app/bloc/home/home_state.dart';
import 'package:movie_app/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/screens/movie_detail_screen/anime_detail_screen.dart';
import '../../data/model/getTop/Anime/Data.dart';

import '../../widgets/anime_container.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/character_container_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeInitEvent());
  }

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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: AnimationLimiter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 500),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 100.0,
                          child: ScaleAnimation(
                            curve: Curves.ease,
                            child: widget,
                          ),
                        ),
                        children: [
                          if (state is HomeLoadingState) ...[
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ] else ...{
                            if (state is ResponseSuccessState) ...{
                              state.TopAnimeBanner.fold(
                                (l) => const Text("sth went wrong"),
                                (animeList) =>
                                    GetTopAnimationForBanner(animeList.data!),
                              ),
                            },
                            const TopAnimeTitle(),
                            if (state is ResponseSuccessState) ...{
                              state.TopAnime.fold(
                                (l) => const Text("sth went wrong"),
                                (anime) => GetTopAnime(anime.data!),
                              )
                            },
                            const TopCharacters(),
                            if (state is ResponseSuccessState) ...{
                              state.TopCharacters.fold(
                                (l) => const Text("sth went wrong"),
                                (anime) =>
                                    CharacterContainerBuilder(anime.data!),
                              )
                            },
                            const NowSeasonsTitle(),
                            if (state is ResponseSuccessState) ...{
                              state.SeasonNow.fold(
                                (l) => const Text("sth went wrong"),
                                (anime) => GetTopAnime(anime.data!),
                              )
                            },
                            const SizedBox(
                              height: 20,
                            )
                          }
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class TopAnimeTitle extends StatelessWidget {
  const TopAnimeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Text(
        'Top Anime',
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NowSeasonsTitle extends StatelessWidget {
  const NowSeasonsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12),
      child: Text(
        'Now Seasons',
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TopCharacters extends StatelessWidget {
  const TopCharacters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12),
      child: Text(
        'Top Characters',
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class GetTopAnimationForBanner extends StatefulWidget {
  final List<Data> _listData;
  const GetTopAnimationForBanner(
    this._listData, {
    super.key,
  });

  @override
  State<GetTopAnimationForBanner> createState() =>
      _GetTopAnimationForBannerState();
}

class _GetTopAnimationForBannerState extends State<GetTopAnimationForBanner> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 300,
          viewportFraction: 0.45,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.easeInOutCubic,
          enlargeCenterPage: true,
          enlargeFactor: 0.16,
          //onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ),
        itemCount: widget._listData.length,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
            GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) => MovieDetailBloc(),
                    child: AnimeDetailScreen(widget._listData[index]),
                  );
                },
              ),
            );
          },
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CachedImage(
                  imageUrl: widget._listData[index].images!.jpg!.largeImageUrl,
                  radious: 5,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      widget._listData[index].titleEnglish!,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      (widget._listData[index].genres![0].name!.isNotEmpty)
                          ? widget._listData[index].genres![0].name!
                          : "",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
