import 'package:flutter/material.dart';

extension ContainerModifier on Container {
  Widget applyShimmerDecoration({
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(8)),
    BoxShape boxShape = BoxShape.rectangle,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(216, 216, 216, 1),
        shape: boxShape,
        borderRadius: boxShape == BoxShape.rectangle ? borderRadius : null,
      ),
      child: this,
    );
  }
}
