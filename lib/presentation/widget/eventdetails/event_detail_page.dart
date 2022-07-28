import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_ahead/core/common/extensions/text_style_reducer.dart';
import 'package:search_ahead/core/coordinator/coordinator.dart';
import 'package:search_ahead/core/di/service_locator.dart';
import 'package:search_ahead/presentation/bloc/favourite/favourite_cubit.dart';
import 'package:search_ahead/presentation/bloc/favourite/favourite_state.dart';
import 'package:search_ahead/presentation/widget/common/search_ahead_cached_image_widget.dart';

class EventDetailPage extends StatefulWidget with AutoRouteWrapper {
  final String imgUrl;
  final String title;
  final String dateTime;
  final String location;
  final bool isFavourite;
  final String id;

  const EventDetailPage(this.imgUrl, this.title, this.dateTime, this.location,
      this.isFavourite, this.id,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventDetailPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<FavouriteCubit>(),
      child: this,
    );
  }
}

class _EventDetailPageState extends State<EventDetailPage> {
  late FavouriteCubit _favouriteCubit;

  late bool currentFavState;

  @override
  void initState() {
    super.initState();
    _favouriteCubit = BlocProvider.of<FavouriteCubit>(context);
    currentFavState = widget.isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => sl.get<Coordinator>().pop(
                  context,
                  currentFavState,
                ),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(widget.title),
        actions: [
          BlocBuilder<FavouriteCubit, FavouriteState>(
              bloc: _favouriteCubit,
              builder: (context, state) {
                if (state is InitialFavouriteState) {
                  currentFavState = widget.isFavourite;
                }
                if (state is ChangeFavouriteState) {
                  currentFavState = state.isFavourite;
                }
                return _buildIconButton(currentFavState);
              }),
        ],
      ),
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: SearchAheadCachedImage(
              widget.imgUrl,
              width: MediaQuery.of(context).size.width - 16,
              height: MediaQuery.of(context).size.height / 2,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.dateTime,
            style: black24w700,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.location,
            style: black20w400.copyWith(color: Colors.black54),
          )
        ],
      ),
    );
  }

  Widget _buildIconButton(bool isFavourite) {
    return IconButton(
      onPressed: () => _favouriteCubit.changeFavouriteStatus(widget.id),
      icon: !isFavourite
          ? const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 28,
            )
          : const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 28,
            ),
    );
  }
}
