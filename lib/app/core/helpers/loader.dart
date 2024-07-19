import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/widgets/custom_loader.dart';
import 'package:signals_flutter/signals_flutter.dart';

final class Loader {
  static final OverlayEntry _overlayEntry = OverlayEntry(
    builder: (context) => const CustomLoader(),
  );
  static void showLoader(bool? showOrRemoveLoader, BuildContext context) {
    final overlay = Overlay.of(context);
    switch (showOrRemoveLoader) {
      case true:
        overlay.insert(_overlayEntry);
      case false:
        _overlayEntry.remove();
      case null:
        null;
    }
  }
}

mixin LoaderControllerMixin {
  final Signal<bool?> _showLoader = signal(null);
  bool? get showLoader => _showLoader();

  void loader(bool showLoader) {
    _showLoader.value = showLoader;
  }
}

mixin LoaderViewMixin<T extends StatefulWidget> on State<T> {
  void loaderListerner(LoaderControllerMixin state) {
    effect(() => {
          switch (state) {
            LoaderControllerMixin(:final showLoader?) =>
              Loader.showLoader(showLoader, context),
            _ => null,
          }
        });
  }
}
