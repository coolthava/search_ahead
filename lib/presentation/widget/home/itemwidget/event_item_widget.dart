import 'package:flutter/material.dart';
import 'package:search_ahead/core/common/extensions/text_style_reducer.dart';
import 'package:search_ahead/core/coordinator/coordinator.dart';
import 'package:search_ahead/core/di/service_locator.dart';
import 'package:search_ahead/core/model/home/event.dart';
import 'package:search_ahead/presentation/widget/common/search_ahead_cached_image_widget.dart';

typedef UnfocusCallback = void Function();

class EventItemWidget extends StatelessWidget {
  final Event eventItem;
  final UnfocusCallback? callback;
  final void Function(bool)? updateIsFav;

  const EventItemWidget({
    Key? key,
    required this.eventItem,
    this.callback,
    this.updateIsFav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback?.call();
        }
        _navigateToEventDetail(context, eventItem);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: [
              Container(
                padding: const EdgeInsets.only(left: 15, top: 10),
                constraints: BoxConstraints.tight(const Size(103, 98)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: SearchAheadCachedImage(
                    eventItem.performers[0].image,
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Icon(
                eventItem.isFavourite ? Icons.favorite : Icons.favorite_border,
                size: 30,
                color: Colors.red,
              )
            ]),
            const SizedBox(
              width: 16,
            ),
            Flexible(
                child: Container(
              margin: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventItem.title ?? '',
                    maxLines: 2,
                    style: black16w700,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    eventItem.venue.location,
                    style: black14w400.copyWith(color: Colors.black45),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    eventItem.dateTime,
                    style: black14w400.copyWith(color: Colors.black45),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _navigateToEventDetail(BuildContext context, Event eventItem) async {
    var isFavourite =
        await sl.get<Coordinator>().navigateToDetails(context, eventItem);
    if (isFavourite != eventItem.isFavourite) {
      updateIsFav?.call(isFavourite ?? false);
    }
  }
}
