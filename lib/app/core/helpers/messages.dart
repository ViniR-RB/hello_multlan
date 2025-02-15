import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

final class Messages {
  static void showError(String message, BuildContext context) {
    showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message: message),
        persistent: false, displayDuration: const Duration(milliseconds: 1000));
  }

  static void showInfo(String message, BuildContext context) {
    showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message: message),
        persistent: false, displayDuration: const Duration(milliseconds: 1000));
  }

  static void showSuccess(String message, BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
        ),
        displayDuration: const Duration(milliseconds: 1000),
        persistent: false);
  }
}

mixin MessageStateMixin {
  final Signal<String?> _errorMessage = signal(null);
  String? get errorMessage => _errorMessage();

  final Signal<String?> _infoMessage = signal(null);
  String? get infoMessage => _infoMessage();

  final Signal<String?> _successMessage = signal(null);
  String? get successMessage => _successMessage();

  void clearError() => _errorMessage.value = null;
  void clearInfo() => _infoMessage.value = null;
  void clearSuccess() => _successMessage.value = null;

  void showError(String message) {
    untracked(() => clearError());
    _errorMessage.value = message;
  }

  void showInfo(String message) {
    untracked(() => clearInfo());
    _infoMessage.value = message;
  }

  void showSuccess(String message) {
    untracked(() => clearSuccess());
    _successMessage.value = message;
  }

  void clearAllMessages() {
    untracked(() {
      clearError();
      clearInfo();
      clearSuccess();
    });
  }

  void disposeMessages() {
    _errorMessage.dispose();
    _infoMessage.dispose();
    _successMessage.dispose();
  }
}

mixin MessageViewMixin<T extends StatefulWidget> on State<T> {
  void messageListener(MessageStateMixin state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mounted
          ? effect(
              () {
                switch (state) {
                  case MessageStateMixin(:final errorMessage?):
                    Messages.showError(errorMessage, context);
                  case MessageStateMixin(:final infoMessage?):
                    Messages.showInfo(infoMessage, context);
                  case MessageStateMixin(:final successMessage?):
                    Messages.showSuccess(successMessage, context);
                }
              },
            )
          : null;
    });
  }
}
