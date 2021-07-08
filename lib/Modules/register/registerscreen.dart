
import 'package:conditional_builder/conditional_builder.dart';
import 'package:finalecommerce/Layout/HomeLayout/layout.dart';
import 'package:finalecommerce/Modules/login/loginscreen.dart';
import 'package:finalecommerce/Modules/register/cubit/cubit.dart';
import 'package:finalecommerce/Modules/register/cubit/states.dart';
import 'package:finalecommerce/shared/Network/cashHelper/cashhelper.dart';
import 'package:finalecommerce/shared/components/Constants.dart';
import 'package:finalecommerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  var Email_controller = TextEditingController();
  var Password_controller = TextEditingController();
  var Name_controller = TextEditingController();
  var Phone_controller = TextEditingController();
  var key_form = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit , RegisterStates>(
       listener: (context , state){
         if (state is RegisterSuccessState)
           {
             Token = RegisterCubit.get(context).model.data.token ;
             CashHelper.saveData(key: 'token', value: RegisterCubit.get(context).model.data.token).then((value)
             {
               Token = RegisterCubit   .get(context).model.data.token ;
               Navigatetoandremove(context,HomeScreen(),) ;
             });
           }
       },
       builder: (context , state){

         return Scaffold(
           appBar: AppBar(),
           backgroundColor: Colors.amberAccent,
           body: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Form(
               key: key_form,
               child: SingleChildScrollView(
                 child: Center(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       CircleAvatar(
                         backgroundColor: Colors.amberAccent[100],
                         radius: 30,
                         child: Icon(Icons.shopping_cart , color: Colors.cyan[100],
                           size: 40,),
                       ) ,
                       SizedBox(height: 5,) ,
                       Text('Buy it' , style: TextStyle(fontSize: 24),) ,
                       SizedBox(height: 100,) ,
                       defualt_Text_form(
                         prefix_icon: Icons.email
                         , label: 'Email'
                         , type: TextInputType.emailAddress
                         , controller: Email_controller ,
                         validate: (String value)
                         {
                           if (value.isEmpty)
                             return 'Email cannot be empty' ;
                           return null ;
                         } ,

                       ),
                       SizedBox(height: 15,) ,
                       defualt_Text_form(
                         prefix_icon: Icons.person
                         , label: 'Name'
                         , type: TextInputType.text
                         , controller: Name_controller ,
                         validate: (String value)
                         {
                           if (value.isEmpty)
                             return 'Name cannot be empty' ;
                           return null ;
                         } ,
                       ),
                       SizedBox(height: 15,) ,
                       defualt_Text_form(
                           prefix_icon: Icons.lock
                           , label: 'Password'
                           , type: TextInputType.visiblePassword
                           , controller: Password_controller ,
                           secure: true,
                           validate: (String value)
                           {
                             if (value.isEmpty)
                               return 'Password cannot be empty' ;
                             return null ;
                           } ,
                           onsubmit: (String value)
                           {
                             if (key_form.currentState.validate())
                             {

                             }
                           }

                       ),
                       SizedBox(height: 15,) ,
                       defualt_Text_form(
                           prefix_icon: Icons.lock
                           , label: 'Phone'
                           , type: TextInputType.phone
                           , controller: Phone_controller ,
                           validate: (String value)
                           {
                             if (value.isEmpty)
                               return 'Phone cannot be empty' ;
                             return null ;
                           }
                           ,
                         onsubmit: (String value)
                           {
                             RegisterCubit.get(context).Create_Account(
                                 name: Name_controller.text,
                                 phone: Phone_controller.text,
                                 email: Email_controller.text,
                                 password: Password_controller.text
                             ) ;
                           }
                       ),
                       SizedBox(height: 30,) ,
                       ConditionalBuilder(
                         condition: state is ! RegisterLoadingState,
                         builder: (context)=>default_button(
                             onpress: (){

                               if (key_form.currentState.validate())
                               {
                                 RegisterCubit.get(context).Create_Account(
                                     name: Name_controller.text,
                                     phone: Phone_controller.text,
                                     email: Email_controller.text,
                                     password: Password_controller.text
                                 ) ;
                               }
                             },
                             text: 'Sign Up',
                             color: Colors.black ,
                             width: 150.0
                         ),
                         fallback: (context)=>Center(child: CircularProgressIndicator()),
                       ) ,
                       SizedBox(height: 10.0,) ,
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             'Do You have Account!?' ,
                             style: TextStyle(color: Colors.white  , fontWeight: FontWeight.bold),
                           ) ,
                           default_text_button(
                             onpressed: (){
                               Navigatetoandremove(context, LoginScreen()) ;
                             },
                             text: 'Login Now' ,
                             color: Colors.blue ,
                           )
                         ],
                       )

                     ],
                   ),
                 ),
               ),
             ),
           ),
         ) ;
       },
      ),
    );
  }
}
