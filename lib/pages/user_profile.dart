import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:intl/intl.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: secondaryColor,
      child: Column(
        children: [
          const _actionBar(),
          Expanded(
            child: ListView(
                children: [
                  _avatar_section(),
                  MyForm(),
                ]
            ),
          ),
        ],
      ),
    );
  }
}

class _avatar_section extends StatelessWidget {
  const _avatar_section({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children:[
            CircleAvatar(
              radius: 75,
              child: CircleAvatar(
                radius: 43,
                backgroundColor: Colors.grey.shade400,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/beach and me.jpg'),
                ),
              ),
            ),
            Positioned(
                bottom: 28,
                right: 40,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 13,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 10,
                    child: SvgPicture.asset(
                      'assets/svg/pen.svg',
                      width: 12,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    ),
                  ),
            ))
          ]
        )
      ],
    );
  }
}

// enum for radiobutton
enum SingingCharacter { nam , nu }
class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _date =  TextEditingController();
  DateTime selectedDate = DateTime.now();

  //default option for radiobutton
  SingingCharacter? _intialValue = SingingCharacter.nam;


  String _gender = '';
  String _address = '';
  String _bussiness = '';
  String _name = '';
  String _phone = '';
  String _dob = '';
  @override
  void initState() {
    super.initState();
    _gender = _intialValue == SingingCharacter.nam ? '0' : '1';
  }

 // Variable to store the entered email
  void _submitForm() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data
      // You can perform actions with the form data here and extract the details
      print('gender: $_gender'); // Print the name
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        _date.value = TextEditingValue(text: formattedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey, // Associate the form key with this Form widget
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Tên hiển thị',
                  labelStyle: const TextStyle(color: labelColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineColor, width: 0.7),

                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineColor, width: 0.7),
                  ),
                ),
                // validator: (value) {
                //   // Validation function for the name field
                //   if (value!.isEmpty) {
                //     return 'Please enter your name.'; // Return an error message if the name is empty
                //   }
                //   return null; // Return null if the name is valid
                // },
                onSaved: (value) {
                  _name = value!; // Save the entered name
                },
              ),
              TextFormField(
                onSaved: (value){
                  _phone = value!;
                },
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  labelStyle: const TextStyle(color: labelColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineColor, width: 0.7),

                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineColor, width: 0.7),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _date,
                    onSaved: (value){
                      _dob = value!;
                    },
                    decoration: InputDecoration(
                      labelText: 'Ngày sinh',
                      labelStyle: TextStyle(color: labelColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: underLineColor, width: 0.7),

                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: underLineColor, width: 0.7),
                      ),
                    ),
                  ),
                ),
              ),

              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _intialValue = SingingCharacter.nam;
                              _gender = '0';
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Radio<SingingCharacter>(
                                value: SingingCharacter.nam,
                                groupValue: _intialValue,
                                fillColor: MaterialStateProperty.resolveWith((states){
                                  if(states.contains(MaterialState.selected)) return primaryColor;
                                  return unselectedRadioButton;
                                }),
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _intialValue = value;
                                    _gender = '0';
                                  });
                                },
                              ),
                              const  Text('Nam', style: TextStyle(color: labelColor, fontSize: 16),),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _intialValue = SingingCharacter.nu;
                              _gender = '1';
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Radio<SingingCharacter>(
                                value: SingingCharacter.nu,
                                groupValue: _intialValue,
                                fillColor: MaterialStateProperty.resolveWith((states){
                                  if(states.contains(MaterialState.selected)) return primaryColor;
                                  return unselectedRadioButton;
                                }),
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _intialValue = value;
                                    _gender = '1';
                                  });
                                },
                              ),
                              Text('Nữ', style: TextStyle(color: labelColor, fontSize: 16),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 0.7, color: underLineColor,)
                ],
              ),

              TextFormField(
                onSaved: (value){
                  _address = value!;
                },
                decoration: InputDecoration(
                  labelText: 'Địa chỉ',
                  labelStyle: TextStyle(color: labelColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineColor, width: 0.7),

                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineColor, width: 0.7),
                  ),
                ),
              ),
              TextFormField(
                onSaved: (value){
                  _bussiness = value!;
                },
                decoration: InputDecoration(
                  labelText: 'Nghề nghiệp',
                  labelStyle: TextStyle(color: labelColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineColor, width: 0.7),

                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineColor, width: 0.7),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: buttonTextSize)
                  ),
                  onPressed: _submitForm, // Call the _submitForm function when the button is pressed
                  child: Text("Cập nhật",), // Text on the button
                ),
              ),
            ],
          ),
        ),
      );

  }
}







class _actionBar extends StatelessWidget {
  const _actionBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          GestureDetector(
            onTap: (){
              CustomNavigationHelper.router.pop();
            },
            child:  SvgPicture.asset(
                "assets/svg/angle-left-svgrepo-com.svg",
                height: 40,
                semanticsLabel: 'Back'
            )
          ),
          GestureDetector(
            onTap: (){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            },
            child:  SvgPicture.asset(
                "assets/svg/qrcode.svg",
                height: 40,
                semanticsLabel: 'Qrcode',
            )
          ),
        ]
      ),
    );
  }
}
