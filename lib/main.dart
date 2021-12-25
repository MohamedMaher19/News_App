import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_app/cubit/news_appss_cubit.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/network/local/cash_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Bloc.observer  = MyBlocObserver();
  DioHelper.init();
 await CacheHelper.init();
   bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final isDark;
  const MyApp(this.isDark);



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..changeAppMode(fromShared:isDark)..getBusiness()..getSports()..getScience(),

      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.teal,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
                unselectedItemColor: Colors.black,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            // دا ال light
            darkTheme: ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
                unselectedItemColor: Colors.blueGrey,
                backgroundColor: HexColor('333739'),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            // دا ال dark
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
