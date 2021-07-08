import 'package:conditional_builder/conditional_builder.dart';
import 'package:finalecommerce/Layout/HomeLayout/cubit/cubit.dart';
import 'package:finalecommerce/Layout/HomeLayout/cubit/states.dart';
import 'package:finalecommerce/Modules/login/loginscreen.dart';
import 'package:finalecommerce/shared/Network/cashHelper/cashhelper.dart';
import 'package:finalecommerce/shared/components/Constants.dart';
import 'package:finalecommerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  var NameController = TextEditingController() ;
  var EmailController = TextEditingController() ;
  var PasswordController = TextEditingController() ;
  var PhoneController = TextEditingController() ;
  var key_form = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context , state){},
      builder: (context , state){
        NameController.text =  HomeCubit.get(context).model.data.name ;
        EmailController.text =  HomeCubit.get(context).model.data.email ;
        PasswordController.text =  HomeCubit.get(context).model.data.password ;
        PhoneController.text =  HomeCubit.get(context).model.data.phone ;
        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: key_form,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('UPDATE PROFILE' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold), ) ,
                        SizedBox(
                          height: 20,
                        ) ,
                        defualt_Text_form(
                          color: Colors.white,
                          prefix_icon: Icons.email
                          , label: 'Email'
                          , type: TextInputType.emailAddress
                          , controller: EmailController ,
                          validate: (String value)
                          {
                            if (value.isEmpty)
                              return 'Email cannot be empty' ;
                            return null ;
                          } ,

                        ),
                        SizedBox(height: 15,) ,
                        defualt_Text_form(
                          color: Colors.white,
                          prefix_icon: Icons.person
                          , label: 'Name'
                          , type: TextInputType.text
                          , controller: NameController ,
                          validate: (String value)
                          {
                            if (value.isEmpty)
                              return 'Name cannot be empty' ;
                            return null ;
                          } ,
                        ),
                        SizedBox(height: 15,) ,
                        defualt_Text_form(
                          color: Colors.white,
                          prefix_icon: Icons.lock
                          , label: 'Phone'
                          , type: TextInputType.phone
                          , controller: PhoneController ,
                          validate: (String value)
                          {
                            if (value.isEmpty)
                              return 'Phone cannot be empty' ;
                            return null ;
                          }
                          ,
                        ),
                        SizedBox(height: 30,) ,
                        ConditionalBuilder(
                          condition: state is !UpdateUserLoadingState ,
                          builder: (context)=>default_button(
                            onpress: (){

                              if (key_form.currentState.validate())
                              {
                                HomeCubit.get(context).update_profile(email: EmailController.text , name: NameController.text , phone: PhoneController.text) ;
                              }
                            },
                            text: 'Update',
                          ),

                          fallback: (context)=>Center(child: LinearProgressIndicator()),
                        ) ,


                        SizedBox(height: 10.0,) ,
                        default_button(
                          onpress: (){

                            if (key_form.currentState.validate())
                            {
                              HomeCubit.get(context).Logout(context) ;
                            }
                          },
                          text: 'Logout',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ) ;
      },
    );
  }
}
