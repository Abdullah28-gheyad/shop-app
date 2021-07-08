import 'package:finalecommerce/Layout/HomeLayout/cubit/cubit.dart';
import 'package:finalecommerce/Layout/HomeLayout/cubit/states.dart';
import 'package:finalecommerce/models/Categorymodel/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
     listener: (context , state){},
     builder: (context , state){

       return ListView.separated(
       physics:BouncingScrollPhysics(),
         itemBuilder: (context,index)=>Expanded(child: build_category_item(context , HomeCubit.get(context).categoryModel.data.data[index]))
        , separatorBuilder: (context , index)=>Container(
          height: 1,
         color: Colors.grey,
         ),
          itemCount: HomeCubit.get(context).categoryModel.data.data.length ,



       );
     },

     /* Scaffold(

      )*/
    );
  }
}




  Widget build_category_item (context , DataCategory model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: 100,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage(model.image)
                ,
                width: 100,
                height: 100,

              ),
              Container(
                width: 100,
                color: Colors.black,
                child: Text(
                  model.name ,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
          Spacer() ,
          Icon(
              (Icons.arrow_forward_ios_outlined)
          ),
        ],
      ),
    ),
  );

