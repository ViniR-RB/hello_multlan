import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/widgets/custom_loader.dart';
import 'package:signals_flutter/signals_flutter.dart';

final class Loader {
  // ignore: avoid_init_to_null
  static OverlayEntry? _overlayEntry = null;

  // ignore: prefer_final_fields
  static bool _isShowing = false;

  static void showLoader(bool? showOrRemoveLoader, BuildContext context) {
    final overlay = Overlay.of(context);

    switch (showOrRemoveLoader) {
      case true:
        if (!_isShowing) {
          _overlayEntry = OverlayEntry(
            builder: (_) => const CustomLoader(),
            maintainState: false,
          );
          overlay.insert(_overlayEntry!);
          _isShowing = true;
        }

      case false:
        if (_isShowing) {
          _overlayEntry?.remove();
          _isShowing = false;
        }
      case null:
        null;
    }
  }
}

mixin LoaderControllerMixin {
  final Signal<bool?> _showLoader = signal(null);
  bool? get showLoader => _showLoader();

  _clearLoader() => _showLoader.set(null);

  void loader(bool showLoader) {
    _clearLoader();
    _showLoader.set(showLoader);
  }
}

mixin LoaderViewMixin<T extends StatefulWidget> on State<T> {
  void loaderListerner(LoaderControllerMixin state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        effect(() => {
              switch (state) {
                LoaderControllerMixin(:final showLoader?) =>
                  mounted ? Loader.showLoader(showLoader, context) : null,
                _ => null,
              }
            });
      }
    });
  }
}
