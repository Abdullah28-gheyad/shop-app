import 'package:finalecommerce/Layout/HomeLayout/cubit/cubit.dart';
import 'package:finalecommerce/Layout/HomeLayout/cubit/states.dart';
import 'package:finalecommerce/Modules/Search/SearchScreen.dart';
import 'package:finalecommerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeStates>(
      builder: (BuildContext context, state) { return Scaffold(
        backgroundColor:Colors.white,
        body:HomeCubit.get(context).Screens[HomeCubit.get(context).current_index] ,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(HomeCubit.get(context).Titels[HomeCubit.get(context).current_index] , style: TextStyle(color:Colors.red),),
          actions: [
            IconButton(
                color: Colors.black,
                iconSize: 30,
                icon: Icon(Icons.search),
                onPressed: (){
                  Navigateto(context, SearchScreen()) ;
                }
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:HomeCubit.get(context).current_index ,
          onTap:(int index){ HomeCubit.get(context).Change_Nav_bar(index);},
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.red,
          elevation: 20,
          type: BottomNavigationBarType.fixed,

          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories'
            ) ,
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites'
            ) ,
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting'
            ) ,
          ],
        ),
      ); },
      listener: (BuildContext context, state) {  },

    );
  }
}
