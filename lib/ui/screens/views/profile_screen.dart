import 'package:flutter/material.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';
import 'package:task_manager/ui/widgets/profile_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _firstNameTEController=TextEditingController();
  final TextEditingController _lastNameTEController=TextEditingController();
  final TextEditingController _mobileTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context,true),
      body: BackGroundWidget(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                const HeadingTwo(data: 'Update Profile'),
                const SizedBox(height: 20,),
                _buildPhotoPicker(),
                const SizedBox(height: 25,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(
                      hintText: 'Last Name'
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _mobileTEController,
                  decoration: const InputDecoration(
                      hintText: 'Mobile'
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordTEController,
                  decoration: const InputDecoration(
                      hintText: 'Password'
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildPhotoPicker() {
    return Container(
            height: 48,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.centerLeft,
            child: Container(
              height: 48,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8)
              ),
              child: const Center(child: HeadingThree(data: 'Photos',color: Colors.white,)),
            ),
          );
  }
}
