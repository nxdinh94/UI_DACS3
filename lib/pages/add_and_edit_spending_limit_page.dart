
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/widgets/custom_stack_three_images.dart';
import '../constant/color.dart';
import '../constant/font.dart';
import '../utils/custom_navigation_helper.dart';
class AddAndEditSpendingLimitPage extends StatefulWidget {
  const AddAndEditSpendingLimitPage({super.key});

  @override
  State<AddAndEditSpendingLimitPage> createState() => _AddAndEditSpendingLimitPageState();
}

class _AddAndEditSpendingLimitPageState extends State<AddAndEditSpendingLimitPage> {
  late final TextEditingController _moneyInputController  = TextEditingController();
  late final TextEditingController _nameSpendingLitmit    = TextEditingController();

  bool isNextPeriod = false;
  String repeat = 'Hằng tháng';
  @override
  void dispose() {
    _moneyInputController.dispose();
    _nameSpendingLitmit.dispose();
    super.dispose();
  }
  // A method that launches the SelectionScreen and awaits the result from
// Navigator.pop.

  @override
  Widget build(BuildContext context) {
    const Divider divider = Divider(height: 1, color: underLineColor,indent: 85, endIndent: 12,);
    const sidePaddingRL = EdgeInsets.only(right: 12, left: 20);
    const marginRight =  EdgeInsets.only(right: 30);
    const trailing = Icon( Icons.keyboard_arrow_right, color: iconColor, size: 33);
    String currentRoute = GoRouterState.of(context).uri.toString();
    String title = '';
    bool isAddingPage = false;
    if(currentRoute=='/addSpendingLimit'){
      title = 'Thêm hạn mức chi';
      isAddingPage = true;
    }else if(currentRoute == '/editSpendingLimit'){
      title = 'Sửa hạn mức chi';
      isAddingPage = false;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          title,
          style: const TextStyle(
              color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: const Icon(
                    Icons.keyboard_arrow_left, color: secondaryColor, size: 43
                ),
                onPressed: () {
                  CustomNavigationHelper.router.pop();
                },
              );
            }
        ),
        actions: [
          GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(
                'assets/svg/tick.svg',
                colorFilter: const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
                width: 38,
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: backgroundColor,
        height: 2000,
        child: ListView(
          children: [
            Container(
              height: 110,
              color: secondaryColor,
              padding: paddingAll12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Số tiền', style: TextStyle(
                   fontSize: textSmall,
                    color: textColor
                  )),
                  spaceColumn6,
                  TextField(
                    controller: _moneyInputController,
                    style: const TextStyle(fontSize: 35.0, height: 45/35,fontWeight: FontWeight.w500, color: primaryColor),
                    textAlign: TextAlign.end,
                    cursorColor: Colors.deepPurpleAccent,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,

                      suffixIcon: SvgPicture.asset(
                        'assets/svg/dong.svg',
                        colorFilter: const  ColorFilter.mode(textColor, BlendMode.srcIn),
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        minHeight: 32,
                        minWidth: 32
                      ),
                      hintText: '0',
                      hintStyle: const TextStyle(fontSize: 35, color: primaryColor)
                    ),
                    
                  ),
                  spaceColumn6,
                  const Divider(height: 1, color: underLineColor,indent: 72),
                ],
              ),
            ),
            spaceColumn,
            Container(
              padding: const EdgeInsets.only(top: 8),
              color: secondaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: sidePaddingRL,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Wrap the SvgPicture.asset in a SizedBox to give it a fixed size
                        Container(
                          margin: marginRight,
                          width: 35, // Adjust the width as needed
                          height: 35, // Adjust the height as needed
                          child: SvgPicture.asset(
                            'assets/svg/abc.svg',
                            colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _nameSpendingLitmit,
                            style: const TextStyle(
                              fontSize: textSize,
                              height: 25 / textSize,
                              color: textColor,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                              border: InputBorder.none,
                              hintText: 'Tên hạn mức',
                              hintStyle: TextStyle(color: labelColor)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  spaceColumn6,
                  divider,
                  MyStackListTile(
                    leading: StackThreeCircleImages(
                      imageOne: 'assets/sampleImage/aolen.jpg',
                      imageTwo: 'assets/sampleImage/girl1.jpg',
                      imageThree: 'assets/sampleImage/girl3.jpg'
                  ),
                    centerText: 'Tất cả hạng mục',
                    trailing: trailing,
                    onTap: (){},
                  ),
                  divider,
                  MyListTile(
                    leading: SvgPicture.asset(
                      'assets/svg/wallet.svg', height: 30,
                      colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn),
                    ),
                    centerText: 'Tất cả tài khoản',
                    trailing: trailing,
                    onTap: (){}
                  ),
                  divider,
                ],
              ),
            ),
            spaceColumn,
            Container(
              color: secondaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyListTile(
                    leading: SvgPicture.asset(
                      'assets/svg/refresh.svg',
                      width: 25,
                      colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn),
                    ),
                    centerText: repeat,
                    trailing: trailing,
                    onTap: () async {
                      final result = await CustomNavigationHelper.router.push(
                          CustomNavigationHelper.repeatCyclePath
                      );
                      if(!context.mounted) return;
                      setState(() {
                        repeat= result as String;
                      });
                    }
                  ),
                  divider,
                  MyDateListTile(
                      leading: SvgPicture.asset(
                        'assets/svg/calendar.svg',
                        width: 25,
                        colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn),
                      ),
                      title: 'Ngày bắt đầu',
                      subtitle: Text('10/12/2022'),
                      trailing: const SizedBox(height: 0),
                      onTap: (){

                      }
                  ),
                  divider,
                  MyDateListTile(
                      leading: SvgPicture.asset(
                        'assets/svg/calendar.svg',
                        width: 25,
                        colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn),
                      ),
                      title: 'Ngày kết thúc',
                      subtitle: Text('10/12/2022'),
                      trailing:  const SizedBox(height: 0),
                      onTap: (){}
                  ),
                  divider,
                  spaceColumn6,
                  Padding(
                    padding: sidePadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dồn sang kì sau', style: TextStyle(
                          fontSize: textSize, color: textColor
                        ),),
                        Switch(
                          value: isNextPeriod,
                          activeColor: switchColorButton,
                          trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),

                          thumbColor: const MaterialStatePropertyAll<Color>(secondaryColor),
                          onChanged: (bool value) {
                            setState(() {
                              isNextPeriod= value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: sidePadding,
                    child: Text(
                      'Số tiền dư hoặc bội chi sẽ được chuyển sang kì sau',
                      style: TextStyle(
                        color: labelColor,
                        fontSize: textSmall,
                      ),
                    ),
                  ),
                  spaceColumn
                ],
              ),
            ),
            spaceColumn6,
            Container(
              padding: sidePadding,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  backgroundColor: primaryColor,
                ),
                child: const Text('LƯU', style:
                  TextStyle(fontSize: textBig,color: secondaryColor)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyStackListTile extends StatelessWidget {
  const MyStackListTile({
    super.key, required this.leading, required this.centerText, required this.trailing,required this.onTap,
  });
  final Widget leading;
  final String centerText;
  final Widget trailing;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
        // dense: true,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
        horizontalTitleGap: 0,
        leading: leading,
        title: Text(
          centerText,
          style: const TextStyle(fontSize: textSize, color: textColor),
        ),
        trailing: trailing,
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key, required this.leading, required this.centerText, required this.trailing,required this.onTap,
  });
  final Widget leading;
  final String centerText;
  final Widget trailing;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    const sidePaddingRL = EdgeInsets.only(right: 2, left: 20);
    return Padding(
      padding: sidePaddingRL,
      child: ListTile(
        // dense: true,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        horizontalTitleGap: 35,
        leading: leading,
        title: Text(
          centerText,
          style: const TextStyle(fontSize: textSize, color: textColor),
        ),
        trailing: trailing,
      ),
    );
  }
}
class MyDateListTile extends StatelessWidget {
  const MyDateListTile({
    super.key, required this.leading, required this.title, required this.subtitle, required this.trailing,required this.onTap,
  });
  final Widget leading;
  final String title;
  final Widget subtitle;
  final Widget trailing;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    const sidePaddingRL = EdgeInsets.only(right: 2, left: 20);
    return Padding(
      padding: sidePaddingRL,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        horizontalTitleGap: 35,
        // dense: true,
        // isThreeLine: true,
        visualDensity:const VisualDensity(horizontal: 0, vertical: -4),
        leading: leading,
        title: Text(
          title, style: const TextStyle(fontSize: textSmall, color: labelColor),
        ),
        subtitle: subtitle,
        subtitleTextStyle: const TextStyle(fontSize: textSize, color: textColor),
        trailing: trailing,
      ),
    );
  }
}
