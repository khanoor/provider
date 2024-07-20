import 'package:flutter/material.dart';
import 'package:provider_mvvm/resources/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPressed;

  const RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.buttonColor,
            borderRadius: BorderRadius.circular(10)),
        height: 40,
        width: 200,
        child: Center(
            child: loading
                ? const CircularProgressIndicator()
                : Text(
                    title,
                    style: const TextStyle(color: AppColor.whiteColor),
                  )),
      ),
    );
  }
}
