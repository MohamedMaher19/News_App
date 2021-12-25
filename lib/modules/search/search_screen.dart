import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/layout/news_app/cubit/news_appss_cubit.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  var searchControler = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state) {
        var list = NewsCubit.get(context).search;

       return
        Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchControler,
                    prefix: Icons.search,
                    label: 'Search',
                    type: TextInputType.text,
                    onChange: (value) {
                    NewsCubit.get(context).getsearch(value);

                    },
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'ياعم حط حاجه نعمل سيرش عليها الله يباركلك';
                      }
                      return null;
                    }

                ),
              ),
              Expanded(child: articleBuilder(list , isSearch : true)),
            ],
          ),
        );
      });
  }
}
