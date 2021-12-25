
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';

Widget buildArticleItem (article , context) => InkWell(
  onTap: (){

    navigationTo(context , WebViewScreen(article['url']));


  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 140.0,

          height: 140.0,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10.0),

              image:DecorationImage(

                image: NetworkImage('${article['urlToImage']}'),

                fit: BoxFit.cover,

              )

          ),



        ),

        SizedBox(width: 20,),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,



                    maxLines: 5,

                    overflow: TextOverflow.ellipsis,





                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                      fontWeight: FontWeight.w600,

                      fontSize: 13.0

                  ),



                ),



              ],

            ),

          ),

        )

      ],





    ),

  ),
);

Widget myDivider (){

  return Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],


  );


}

Widget articleBuilder (list , {isSearch = false} ) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) =>
        ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>buildArticleItem(list[index],context),

            separatorBuilder: (context, index) => myDivider(),
            itemCount: 20 ),
    fallback: (context) => isSearch ? Container() :  Center(child: CircularProgressIndicator(),)
);


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function ?onChange,
  Function ?onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData ?suffix,
  Function ?suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s){
        onSubmit!(s);
      },
      onChanged: (s){
        onChange!(s);
      },
      onTap: (){
        onTap!();
      },
      validator: (s){
        validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: (){
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigationTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    )
);

//https://newsapi.org/v2/everything?q=tesla&apiKey=5c0f8f04b16e46d4a951efce4abc991e



