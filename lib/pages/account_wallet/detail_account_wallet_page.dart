import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/color.dart';
class DetailAccountWalletPage extends StatefulWidget {
  const DetailAccountWalletPage({
    super.key,
    required this.accountWalletData,
  });
  final Map<String,dynamic> accountWalletData;
  @override
  State<DetailAccountWalletPage> createState() => _DetailAccountWalletPageState();
}

class _DetailAccountWalletPageState extends State<DetailAccountWalletPage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          toolbarHeight: 52,
          leading: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              'assets/svg/history.svg',
              fit: BoxFit.fitWidth,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          title: Text(widget.accountWalletData['name']),
          centerTitle: true,
        ),
      ),
    );
  }
}
