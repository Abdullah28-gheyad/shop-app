import 'package:bloc/bloc.dart';
import 'package:finalecommerce/Layout/HomeLayout/cubit/states.dart';
import 'package:finalecommerce/Modules/Categories/CategoryScreen.dart';
import 'package:finalecommerce/Modules/Favorites/FavoriteScreen.dart';
import 'package:finalecommerce/Modules/Products/ProductsScreen.dart';
import 'package:finalecommerce/Modules/Settings/SettingScreen.dart';
import 'package:finalecommerce/Modules/login/loginscreen.dart';
import 'package:finalecommerce/models/Categorymodel/categories.dart';
import 'package:finalecommerce/models/Homemodel/homemodel.dart';
import 'package:finalecommerce/models/loginmodel/LoginModel.dart';
import 'package:finalecommerce/shared/EndPoints.dart';
import 'package:finalecommerce/shared/Network/DioHelper/DioHelper.dart';
import 'package:finalecommerce/shared/Network/cashHelper/cashhelper.dart';
import 'package:finalecommerce/shared/components/Constants.dart';
import 'package:finalecommerce/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit <HomeStates>
{
  HomeCubit():super(HomeInitialState()) ;
  static HomeCubit get (context)=>BlocProvider.of(context) ;
  int current_index = 0 ;
  void Change_Nav_bar (int index)
  {
    current_index = index ;
    if (current_index==3)
      Get_User();
    emit(HomeChangeBottomNavState());
  }

  List <String> Titels =
  [
    'Home',
    'Categories',
    'Favorites' ,
    'Settings'
  ];
  List <Widget> Screens =
      [
        ProductScreen() ,
        CategoryScreen() ,
        FavoriteScreen() ,
        SettingScreen() ,
      ];

  HomeModel home_model ;
  void Get_Home_Data ()
  {
    emit (GegHomeDataLoadingState()) ;
    DioHelper.getData(url: HOME , query: null,token: Token)
        .then((value){
          home_model = HomeModel.FromJson(value.data) ;
          print (home_model.data.Banners[0].image) ;
          emit(GegHomeDataSuccessState()) ;
    })
        .catchError((onError){
          print (onError.toString()) ;
          emit(GegHomeDataErrorState(onError.toString())) ;
    });
  }
  CategoryModel categoryModel ;
  void Get_Category_Data()
  {
    emit (GegCategoryDataLoadingState()) ;
    DioHelper.getData(url: CATEGORY , query: null ,token: Token)
    .then((value) {
      categoryModel = CategoryModel.fromJson(value.data) ;
      print (categoryModel.data.data[1].image) ;
      emit(GegCategoryDataSuccessState()) ;
    })
    .catchError((onError){
      print (onError.toString()) ;
      emit(GegCategoryDataErrorState(onError.toString())) ;
    });
  }

  LoginModel model ;
  void Get_User ()
  {
      emit (GetUserLoadingState()) ; 
      DioHelper.getData(url: PROFILE , token: Token , query: null ,lang: 'en')
      .then((value) {
        model=LoginModel.FromJson(value.data) ;
        print (Token) ;
        print (value.data) ;
        emit (GetUserSuccessState()) ;
      })
      .catchError((onError){
        print (onError.toString()) ;
        emit (GetUserErrorState(onError.toString())) ;
      }) ;
  }


  void update_profile (
      {
        @required String name,
        @required String email,
        @required String phone,
      }
      )
  {
    emit(UpdateUserLoadingState()) ;
    DioHelper.Put_Data(url:UPDATE, query: null , token: Token,data: {
      'name':name ,
      'email':email ,
      'phone':phone
    }).then((value) {
      model=  LoginModel.FromJson(value.data) ;
      emit(UpdateUserSuccessState())  ;
      print(model.data.name) ;
    }).catchError((onError){
      print (onError.toString());
      emit(UpdateUserErrorState())  ;
    }) ;
  }

  void Logout(context)
  {
    CashHelper.clear(key: 'token')  ;
    Token='' ;
    Navigatetoandremove(context, LoginScreen()) ;
    emit (LogoutSuccessState());
  }
}