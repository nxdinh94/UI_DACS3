import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({Key? key}) : super(key: key);

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late bool isShow;
  final mylist = <String>['abc', 'afadf', 'asdfd', 'asdf'];

  @override
  void initState() {
    isShow = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: isShow,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: isShow ? 200 : 0, // Adjust height as needed
            child: ListView.builder(
              itemCount: mylist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(mylist[index]),
                );
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isShow = !isShow;
            });
          },
          child: Text(isShow ? 'Hide' : 'Show'),
        ),
      ],
    );
  }
}
