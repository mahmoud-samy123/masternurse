import 'package:flutter/material.dart';


import '../../../app/style/custom_icon.dart';
import '../../../const/colors.dart';

class RowReusable extends StatelessWidget {
  const RowReusable({
    super.key,
    this.onTap,
    required this.leadingIcon,
    this.leadingIconColor,
    this.leadingIconSize,
    this.title,
    this.trailing,
  });
  final void Function()? onTap;
  final IconData leadingIcon;
  final Color? leadingIconColor;
  final double? leadingIconSize;
  final Widget? title;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 3,
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.kGrey3,
                child: CustomIcon(
                  icon: leadingIcon,
                  color: leadingIconColor,
                  size: leadingIconSize,
                ),
              ),
              trailing: trailing,
              title: title,
            ),
          ),
          Container(
            //width: MediaQuery.of(context).size.width / 1.2,
            height: 1.1,
            decoration: const BoxDecoration(
              color: AppColor.kGrey3,
            ),
          ),
        ],
      ),
    );
  }
}
