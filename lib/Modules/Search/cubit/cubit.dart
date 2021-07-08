import 'package:bloc/bloc.dart';
import 'package:finalecommerce/Modules/Search/cubit/states.dart';
import 'package:finalecommerce/models/Searchmodel/searchmodel.dart';
import 'package:finalecommerce/shared/EndPoints.dart';
import 'package:finalecommerce/shared/Network/DioHelper/DioHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit <SearchStates>
{
  SearchCubit():super(SearchInitialState()) ;
  static SearchCubit get(context)=>BlocProvider.of(context) ;

   Search_Model model ;
  void Search_product (
  {
  @required String text
}
      )
  {
     emit (SearchLoadingState()) ;
     DioHelper.postData
       (url: SEARCH,
         data: {
           'text':text
         }
     ).then((value)
     {
       model = Search_Model.fromJson(value.data) ;
       emit (SearchSuccessState()) ;
     })
     .catchError((onError){
      print (onError.toString()) ;
       emit (SearchErrorState()) ;
     }) ;
  }
}