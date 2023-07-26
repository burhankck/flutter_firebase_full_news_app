import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../product/models/news.dart';
import '../../product/utility/exception/custom_exceptions.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 1 future builder
  // 2 datayi init oldugu anda cekip set state ile gostermek

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Home_ListView(),
    );
  }
}

class Home_ListView extends StatelessWidget {
  const Home_ListView();

  @override
  Widget build(BuildContext context) {
    CollectionReference news = FirebaseFirestore.instance.collection('news');

// burdaki amac gelen objeyi pars etmek icin
    final response = news.withConverter(
      fromFirestore: (snapshot, options) {
        return News().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        // ignore: unnecessary_null_comparison
        if (value == null) {
          throw FirebaseCustomException('$value not null');
        }
        return value.toJson();
      },
    ).get();
    return FutureBuilder(
      future: response,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<News?>> snapshot,
      ) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Placeholder();

          case ConnectionState.waiting:
          case ConnectionState.active:
            const LinearProgressIndicator();

          case ConnectionState.done:
            if (snapshot.hasData) {
              final values = snapshot.data!.docs.map((e) => e.data()).toList();
              return ListView.builder(
                itemCount: values.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        Image.network(
                          values[index]?.backgroundImage ?? '',
                          // ignore: deprecated_member_use
                          height: context.dynamicHeight(0.1),
                        ),
                        // ignore: deprecated_member_use
                        Text(
                          values[index]?.title ?? '',
                          // ignore: deprecated_member_use
                          style: context.textTheme.labelLarge,
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
