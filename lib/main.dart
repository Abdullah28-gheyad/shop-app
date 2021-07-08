
import 'package:finalecommerce/Layout/HomeLayout/cubit/cubit.dart';
import 'package:finalecommerce/Layout/HomeLayout/layout.dart';
import 'package:finalecommerce/shared/MyBlocObserver/MyBlocObserver.dart';
import 'package:finalecommerce/shared/Network/DioHelper/DioHelper.dart';
import 'package:finalecommerce/shared/Network/cashHelper/cashhelper.dart';
import 'package:finalecommerce/shared/components/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Modules/login/loginscreen.dart';
Widget widget ;
void main() async{
  WidgetsFlutterBinding.ensureInitialized() ;
  Bloc.observer = MyBlocObserver();
  DioHelper.init()  ;
  await CashHelper.init() ;
   Token = CashHelper.getData(key: 'token') ;
  // print (Token+'thus uuasdasdjnsflkjhaksjhfkajsfhkjafhskjafhskjahf') ;
  if (Token==null||Token=='')
    {
      widget = LoginScreen() ;
    }
  else
    {
      widget = HomeScreen() ;
    }

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>HomeCubit()..Get_Home_Data()..Get_Category_Data()..Get_User(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                elevation: 0.0,
                backgroundColor: Colors.amberAccent,
                iconTheme: IconThemeData(
                  color: Colors.amberAccent ,

                )
            )
        ),
        home: widget,
      ),
    );
  }
}
