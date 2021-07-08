import 'package:bloc/bloc.dart';
import 'package:finalecommerce/Modules/login/cubit/states.dart';
import 'package:finalecommerce/models/loginmodel/LoginModel.dart';
import 'package:finalecommerce/shared/EndPoints.dart';
import 'package:finalecommerce/shared/Network/DioHelper/DioHelper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel model;

  void User_Login({
    @required String Email,
    @required String Password,
  }) {
    emit(LoginLoadingState()) ;
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':Email ,
          'password':Password
        })
        .then((value) {
          model = LoginModel.FromJson(value.data) ;
          print (model.status) ;
          print (model.message) ;
          print (model.data.token) ;
          emit(LoginSuccessState()) ;
    })
        .catchError((onError){
      print (onError.toString()) ;
      emit(LoginErrorState(onError.toString())) ;
    }) ;
  }
}
