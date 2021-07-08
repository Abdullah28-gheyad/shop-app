import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defualt_Text_form(
    {
      @required TextEditingController controller ,
      @required TextInputType type ,
      @required String label ,
      @required IconData prefix_icon ,
      IconData suffx_icon ,
      Function prefix_press ,
      Function suffix_press ,
      Function onsubmit ,
      Function onchange ,
      Function validate ,
      Color color = Colors.amberAccent,
      bool secure = false

    }
    )=>TextFormField(

  onFieldSubmitted:onsubmit ,
  obscureText: secure,
  validator:validate ,
  controller:controller ,
  keyboardType: type,
  decoration: InputDecoration(
    fillColor: color,
    filled: true,
    labelText: label ,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),

    ) ,
    prefixIcon: IconButton(
      onPressed: prefix_press,
      icon: Icon(prefix_icon),
      color: Colors.blue,
    ),
    suffixIcon: IconButton(
      onPressed:suffix_press ,
      icon: Icon(suffx_icon),
      color: Colors.blue,
    ),
  ),
  onChanged:onchange ,
);


Widget default_button (
    {
      @required Function onpress ,
      @required String text ,
      width = double.infinity,
      hight=40.0 ,
      Color color = Colors.blue ,
    }
    )=>Container(

  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25),
  ),
  width: width,
  height:hight,

  child: MaterialButton(
     shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)),
    onPressed: onpress,
    color: color,
    height: 40,
    child: Text(text , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),),
  ),
);


Widget default_text_button (
    {
      @required Function onpressed ,
      @required String text ,
      Color color = Colors.blue,
    }
    )=>TextButton(
    onPressed: onpressed,
    child: Text(
        text ,
        style: TextStyle(color:color  ,),
    )
);


void Navigateto(context , widget){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget,),);
}
void Navigatetoandremove(context , widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget,),
        (Route<dynamic> route) => false,
  );
}