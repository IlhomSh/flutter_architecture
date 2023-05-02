import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:module_business/module_business.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final MainBlock _mainBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainBloc = GetIt.I.get<MainBlock>();
    _mainBloc.add(MainBlocEvent.init());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<MainBlock>(
      create: (_) => _mainBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mainBloc.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainBlocState>(
        stream: context.read<MainBlock>().state,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final state = snapshot.data;

            return state!.map<Widget>(loading: (_)=>Scaffold(
              appBar: AppBar(
                title: Text("Demo"),
              ),
              body: Center(child: Text("Initializing"),),
            ), loaded:(state)=>Scaffold(
              appBar: AppBar(title: Text("Demo"),),
              body: Center(child: Text(
                "${state.userData.name}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),),

            floatingActionButton: FloatingActionButton(
              onPressed: ()=>context.read<MainBlock>().add(MainBlocEvent.setUser(userId: state.userData.id+1)),
              child: Icon(Icons.add),
              tooltip: "Increment",
            ),
            ),
            );
          }

          return CircularProgressIndicator();
        });
  }
}
