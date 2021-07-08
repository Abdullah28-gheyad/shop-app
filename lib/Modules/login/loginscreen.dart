
import 'package:conditional_builder/conditional_builder.dart';
import 'package:finalecommerce/Layout/HomeLayout/layout.dart';
import 'package:finalecommerce/Modules/login/cubit/cubit.dart';
import 'package:finalecommerce/Modules/login/cubit/states.dart';
import 'package:finalecommerce/Modules/register/registerscreen.dart';
import 'package:finalecommerce/shared/Network/cashHelper/cashhelper.dart';
import 'package:finalecommerce/shared/components/Constants.dart';
import 'package:finalecommerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {

  var Email_controller = TextEditingController();
  var Password_controller = TextEditingController();
  var key_form = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit , LoginStates>(
        listener: (context , state){
          if (state is LoginSuccessState)
            {
              Token = LoginCubit.get(context).model.data.token ;
              CashHelper.saveData(key: 'token', value: LoginCubit.get(context).model.data.token).then((value)
              {
                Token = LoginCubit.get(context).model.data.token ;
                Navigatetoandremove(context,HomeScreen(),) ;
              });
            }
        },
        builder: (context , state){
          return Scaffold(
            backgroundColor: Colors.amberAccent,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.amberAccent,
              iconTheme: IconThemeData(
                color: Colors.amberAccent ,

              ) ,
            ),
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
                                LoginCubit.get(context).User_Login(
                                    Email: Email_controller.text
                                    , Password: Password_controller.text);
                              }
                            }

                        ),
                        SizedBox(height: 20,) ,
                        ConditionalBuilder(
                          condition: state is ! LoginLoadingState,
                          builder: (context)=>default_button(
                              onpress: (){

                                if (key_form.currentState.validate())
                                {
                                  LoginCubit.get(context).User_Login(
                                      Email: Email_controller.text
                                      , Password: Password_controller.text);

                                }
                              },
                              text: 'Login',
                              color: Colors.black ,
                              width: 150.0
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ) ,
                        SizedBox(height: 20.0,) ,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dont Have Account!?' ,
                              style: TextStyle(color: Colors.white  , fontWeight: FontWeight.bold),
                            ) ,
                            default_text_button(
                              onpressed: (){
                                Navigateto(context, RegisterScreen()) ;
                              },
                              text: 'Register Now' ,
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
