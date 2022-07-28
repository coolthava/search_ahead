import 'package:flutter/material.dart';

class SearchScaffold extends StatelessWidget {
  final Widget scaffoldBody;
  final AppBar appBar;
  final Widget whiteBoxWidget;
  final bool isFocusedState;
  final double boxHeight;

  const SearchScaffold(this.appBar, this.scaffoldBody, this.whiteBoxWidget,
      {this.isFocusedState = false, this.boxHeight = 56, Key? key})
      : super(key: key);

  final double kMinBoxHeight = 56;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(80 +
                    ((boxHeight >= kMinBoxHeight ? boxHeight : kMinBoxHeight) -
                            kMinBoxHeight) /
                        2),
                child: appBar,
              ),
              body: scaffoldBody),
        ),
        Positioned(
          top: 52 + MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,
          child: Card(
            elevation: 0.0,
            margin: const EdgeInsets.symmetric(horizontal: 0),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                side: BorderSide(
                    color: isFocusedState ? Colors.blueAccent : Colors.black)),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 4),
                    spreadRadius: 0.0,
                    blurRadius: 8,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              width: double.infinity,
              height: boxHeight >= kMinBoxHeight ? boxHeight : kMinBoxHeight,
              child: whiteBoxWidget,
            ),
          ),
        ),
      ],
    );
  }
}
