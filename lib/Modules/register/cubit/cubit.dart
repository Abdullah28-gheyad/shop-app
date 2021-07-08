import 'package:bloc/bloc.dart';
import 'package:finalecommerce/Modules/register/cubit/states.dart';
import 'package:finalecommerce/models/loginmodel/LoginModel.dart';
import 'package:finalecommerce/shared/EndPoints.dart';
import 'package:finalecommerce/shared/Network/DioHelper/DioHelper.dart';
import 'package:finalecommerce/shared/components/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit <RegisterStates>
{
  RegisterCubit():super(RegisterInitialState()) ;
  static RegisterCubit get (context)=>BlocProvider.of(context) ;
  LoginModel model ;
  void Create_Account(
  {
  @required String name ,
  @required String phone ,
  @required String email ,
  @required String password ,
}
      )
  {
    emit (RegisterLoadingState()) ;
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name':name ,
          'phone':phone ,
          'email' : email ,
          'password':password
        }
    ).then((value)  {
      model = LoginModel.FromJson(value.data) ;
      print (model.data.token) ;
      Token = model.data.token ;
      emit (RegisterSuccessState()) ;
    })
    .catchError((onError){
      print (onError.toString()) ;
      emit (RegisterErrorState(onError.toString())) ;
    }) ;
  }
}