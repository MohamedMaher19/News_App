import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/local/cash_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';

part 'news_appss_state.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context); // عملت اوبجكت منه لسهوله استخدامه ف اي مكان تاني

    int currentIndex = 0 ;

    List<BottomNavigationBarItem> BottomItems = [
      
      BottomNavigationBarItem(

          icon:Icon (Icons.business),
          label: 'Business',

      ),
      BottomNavigationBarItem(

        icon:Icon (Icons.sports),
        label: 'Sports',

      ),
      BottomNavigationBarItem(

        icon:Icon (Icons.science),
        label: 'Science',

      ),
    ];

    List<Widget> screens = [

      BusinessScreen(),
      SportsScreen(),
      ScienceScreen(),


    ];

    void changeBottomNavBar (int index){

      currentIndex = index ;

      emit(NewsBottomNavState());
      

    }

    List<dynamic> business = [];

    void getBusiness(){

      emit(NewsGetBusinessLoadingState());

      DioHelper.getData(
          url:'v2/top-headlines' ,
          query:{
            'country':'eg',
            'category':'business',
            'apiKey':'bf2a0c8166cc46efa3b7b0ca4c696bdf',

          } ).then((value)  {
        // print(value.data['articles'][0]['title']);
        business = value.data['articles'];
        print(business[0]['title']);

        emit(NewsGetBusinessSuccessState());



      }).catchError((error) {
        print(error.toString());

        emit(NewsGetBusinessErrorState(error.toString()));
      });



    }

    //////////////////////////////

  List<dynamic> sports = [];

  void getSports(){

    emit(NewsGetSportsLoadingState());

    DioHelper.getData(
        url:'v2/top-headlines' ,
        query:{
          'country':'eg',
          'category':'sports',
          'apiKey':'bf2a0c8166cc46efa3b7b0ca4c696bdf',

        } ).then((value)  {
      // print(value.data['articles'][0]['title']);
      sports = value.data['articles'];
      print(sports[0]['title']);

      emit(NewsGetSportsSuccessState());



    }).catchError((error) {
      print(error.toString());

      emit(NewsGetSportsErrorState(error.toString()));
    });



  }

  //////////////////////////////////

  List<dynamic> science = [];

  void getScience(){

    emit(NewsGetScienceLoadingState());

    DioHelper.getData(
        url:'v2/top-headlines' ,
        query:{
          'country':'eg',
          'category':'science',
          'apiKey':'bf2a0c8166cc46efa3b7b0ca4c696bdf',

        } ).then((value)  {
      // print(value.data['articles'][0]['title']);
      science = value.data['articles'];
      print(science[0]['title']);

      emit(NewsGetScienceSuccessState());



    }).catchError((error) {
      print(error.toString());

      emit(NewsGetScienceErrorState(error.toString()));
    });



  }




  bool isDark = false ;
  void changeAppMode ({bool? fromShared}){

    if  (fromShared != null){
      isDark = fromShared;
  }
    else {
      isDark = !isDark;
    }
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)

    => emit(NewsChangeModeStates()));

  }


  List<dynamic> search = [];

  void getsearch( String value){

    emit(NewsGetSearchLoadingState());




    DioHelper.getData(
        url:'v2/everything' ,
        query:{

          'q':'$value',
          'apiKey':'bf2a0c8166cc46efa3b7b0ca4c696bdf',

        } ).then((value)  {
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());



    }).catchError((error) {
      print(error.toString());

      emit(NewsGetSearchErrorState(error.toString()));
    });



  }

}
