import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * .8,
          child: LoadingAnimationWidget.inkDrop(size: 40, color: Colors.blue),
        ),
      ),
    );
  }
}
