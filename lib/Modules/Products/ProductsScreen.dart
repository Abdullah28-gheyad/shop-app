import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:finalecommerce/Layout/HomeLayout/cubit/cubit.dart';
import 'package:finalecommerce/Layout/HomeLayout/cubit/states.dart';
import 'package:finalecommerce/models/Categorymodel/categories.dart';
import 'package:finalecommerce/models/Homemodel/homemodel.dart';
import 'package:finalecommerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context , state){},
      builder: (context , state) {
        var cubit = HomeCubit.get(context) ;
        return Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConditionalBuilder(
            condition: cubit.home_model!=null,
            builder: (context)=>Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items:cubit.home_model.data.Banners.map((e) => Image(
                    image: NetworkImage(e.image) ,
                    width: double.infinity,
                    fit: BoxFit.cover,),
                  ).toList() ,
                  options: CarouselOptions(
                      height: 250,
                      initialPage: 0,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      reverse: false,autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal
                  ),) ,
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Categories' , style: TextStyle(fontSize: 22 ,fontWeight: FontWeight.bold),),
                ) ,
               Container(
                 height: 100,
                 child: ListView.separated(
                     itemBuilder: (context , index)=>build_category_item(context , cubit.categoryModel.data.data[index])
                      ,
                   scrollDirection:Axis.horizontal ,
                   physics: BouncingScrollPhysics(),
                   separatorBuilder: (BuildContext context, int index)=>SizedBox(width: 5.0,),
                   itemCount: cubit.categoryModel.data.data.length,

                 ),
               ) ,
                SizedBox(height: 20.0,) ,
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Products' , style: TextStyle(fontSize: 22 ,fontWeight: FontWeight.bold),),
                ) ,
                SizedBox(height: 10.0,) ,
                Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    shrinkWrap: true,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1/1.75,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(cubit.home_model.data.Products.length, (index) => build_Product_Item(context , cubit.home_model.data.Products[index],)),
                  ),
                ),
              ],
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),

          ),
        ),
      );}

    );
  }
  Widget build_Product_Item(context , products model)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              if (model.discount>0)
                   Container(
                color: Colors.red,
                child: Text(
                  'DISCOUNT' ,
                  style: TextStyle(color: Colors.black , fontSize: 10),
                ),
              ) ,
              Image(
                image: NetworkImage(model.image) ,
                height: 200,
                width: double.infinity,

              ),
            ],
          ),
        ) ,
        SizedBox(height: 5,) ,
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            model.name ,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ) ,
        SizedBox(height: 5,) ,
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              Text('${model.price}' , style: TextStyle(color: Colors.blue , fontSize: 12),) ,
              SizedBox(width: 3,),
              if (model.discount>0)
                   Text('${model.old_price}' , style: Theme.of(context).textTheme.caption.copyWith(decoration: TextDecoration.lineThrough),) ,
              Spacer() ,
              IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: (){})  ,
            ],
          ),
        )
      ],
    ),
  );
  Widget build_category_item (context , DataCategory model)=>Container(
    width: 100,
    child: Stack(
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
  );

}
