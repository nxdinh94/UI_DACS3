import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:intl/intl.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/custom_toast.dart';
import 'package:provider/provider.dart';

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
            child: Consumer<UserProvider>(
              builder: (context, value, child){
                Map<String, dynamic> userData = value.meData;
                return ListView(
                    children: [
                      _avatar_section(avatar: userData['avatar'],),
                      MyForm(userData: userData),
                    ]
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

class _avatar_section extends StatelessWidget {
  const _avatar_section({
    required this.avatar,
  });
  final String avatar;
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
                child: ClipOval(
                  child: avatar == '' ? Image.asset('assets/another_icon/avt-fb.jpg')
                      :  Image.network(avatar) ,
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
                      colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
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
  const MyForm({super.key, required this.userData});
  final Map<String, dynamic> userData;
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController dobController =  TextEditingController();
  DateTime selectedDate = DateTime.now();

  //default option for radiobutton
  SingingCharacter? _intialValue = SingingCharacter.nam;

  String _gender = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if(widget.userData['gender'] == 0){
      _intialValue = SingingCharacter.nam;
    }else {
      _intialValue = SingingCharacter.nu;
    }

    // print(widget.userData);
    _gender = _intialValue == SingingCharacter.nam ? '0' : '1';
    nameController.text = widget.userData['name'];
    phoneController.text = widget.userData['phone'];
    addressController.text = widget.userData['address'];
    jobController.text = widget.userData['job'];

    selectedDate = DateTime.parse(widget.userData['dob']) ;
    dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate);


    // _date.text = selectedDate;

  }

 // Variable to store the entered email
  void _submitForm() async {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data
      // You can perform actions with the form data here and extract the details
      // print('name: ${nameController.text}');
      // print('phone: ${phoneController.text}');
      // print('selectedDate: ${dobController.text}');
      // print('gender: $_gender');
      // print('gender: ${addressController.text}');
      // print('gender: ${jobController.text}');

      Map<String, String> dataToUpdate = {
        'name':nameController.text,
        'phone': phoneController.text,
        'dob': dobController.text,
        'address': addressController.text,
        'job': jobController.text,
        'gender': _gender,
      };
      print(dataToUpdate);
      Map<String, dynamic> result =  await Provider.of<UserProvider>(context, listen: false).updateMeProvider(dataToUpdate);
      if(result['status'] == '200'){
        showCustomSuccessToast(context, result['result'],duration: 1 );
        await Provider.of<UserProvider>(context, listen: false).getMeProvider();
      }else {
        showCustomErrorToast(context, result['result'], 1);
      }


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
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        dobController.value = TextEditingValue(text: formattedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey, // Associate the form key with this Form widget
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                style: defaultTextStyle,
                decoration: const InputDecoration(
                  labelText: 'Tên hiển thị',
                  labelStyle: TextStyle(color: labelColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineColor, width: 0.7),

                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineColor, width: 0.7),
                  ),
                ),
                onSaved: (value) {
                  nameController.text = value!; // Save the entered name
                },
              ),
              TextFormField(
                onSaved: (value){
                  phoneController.text = value!;
                },
                style: defaultTextStyle,
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                  labelStyle: TextStyle(color: labelColor),
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
                    controller: dobController,
                    onSaved: (value){
                      dobController.text = value!;
                    },
                    decoration: const InputDecoration(
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
                                fillColor: WidgetStateProperty.resolveWith((states){
                                  if(states.contains(WidgetState.selected)) return primaryColor;
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
                                fillColor: WidgetStateProperty.resolveWith((states){
                                  if(states.contains(WidgetState.selected)) return primaryColor;
                                  return unselectedRadioButton;
                                }),
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _intialValue = value;
                                    _gender = '1';
                                  });
                                },
                              ),
                              const Text('Nữ', style: TextStyle(color: labelColor, fontSize: 16),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0, color: underLineColor,)
                ],
              ),

              TextFormField(
                onSaved: (value){
                  addressController.text = value!;
                },
                style: defaultTextStyle,

                controller: addressController,
                decoration: const InputDecoration(
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
                controller: jobController,
                onSaved: (value){
                  jobController.text = value!;
                },
                style: defaultTextStyle,
                decoration: const InputDecoration(
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
              const SizedBox(height: 20.0),
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
                  child: const Text("Cập nhật",), // Text on the button
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
