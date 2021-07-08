abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeChangeBottomNavState extends HomeStates {}

 class GegHomeDataLoadingState extends HomeStates {}

 class GegHomeDataSuccessState extends HomeStates {}

 class GegHomeDataErrorState extends HomeStates {
  final String error  ;
  GegHomeDataErrorState(this.error) ;
 }

class GegCategoryDataLoadingState extends HomeStates {}

class GegCategoryDataSuccessState extends HomeStates {}

class GegCategoryDataErrorState extends HomeStates {
 final String error  ;
 GegCategoryDataErrorState(this.error) ;
}

class GetUserLoadingState extends HomeStates {}

class GetUserSuccessState extends HomeStates {}

class GetUserErrorState extends HomeStates {
 final String error  ;
 GetUserErrorState(this.error) ;
}



class UpdateUserLoadingState extends HomeStates {}

class UpdateUserSuccessState extends HomeStates {}

class UpdateUserErrorState extends HomeStates {}

class LogoutSuccessState extends HomeStates {}


