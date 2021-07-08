import 'package:conditional_builder/conditional_builder.dart';
import 'package:finalecommerce/Modules/Search/cubit/cubit.dart';
import 'package:finalecommerce/Modules/Search/cubit/states.dart';
import 'package:finalecommerce/models/Searchmodel/searchmodel.dart';
import 'package:finalecommerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {

  var SearchController = TextEditingController() ;
  var form_key = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),

      child: BlocConsumer<SearchCubit , SearchStates>(
        listener: (context , state){},
        builder: (context , state){

          return  Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              iconTheme:IconThemeData(
                color: Colors.black ,
              ),
              title: Text('Search' , style: TextStyle(color: Colors.black),),
            ),
            body: Form(
              key: form_key,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defualt_Text_form(
                        color: Colors.white,
                        prefix_icon: null,
                        suffx_icon: Icons.search,
                        suffix_press: (){},
                        validate: (String value){
                          if (value.isEmpty)
                            return 'enter word u need to search' ;
                          return null ;
                        },
                        label: 'Search',
                        controller: SearchController,
                        type: TextInputType.text ,
                        onchange: (text){
                          if (form_key.currentState.validate())
                            SearchCubit.get(context).Search_product(text: text) ;
                        },
                      onsubmit: (text){
                          if (form_key.currentState.validate())
                               SearchCubit.get(context).Search_product(text: text) ;
                      }
                    ) ,
                    SizedBox(height: 10.0,) ,
                    if (state is SearchLoadingState)
                      LinearProgressIndicator() ,
                    SizedBox(height: 20,) ,
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            physics:BouncingScrollPhysics(),
                            itemBuilder: (context, index) => product_item_search(context,SearchCubit.get(context).model.data.data[index], ),
                            separatorBuilder: (context, index) =>Container(height: 1, color: Colors.grey,),
                            itemCount: SearchCubit.get(context).model.data.data.length
                        ),
                      )
                  ],
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }
  Widget product_item_search(context , Product model)
  {
    return Container(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
              height: 200,
              width: 150,
              image: NetworkImage(model.image)),
          SizedBox(width: 5.0,) ,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name , maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption,) ,
                Spacer() ,
                Row(
                  children: [
                    Text('${model.price}' , style: Theme.of(context).textTheme.caption.copyWith(color: Colors.blue),) ,
                    Spacer() ,
                    IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: (){},
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
