import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/pages/carro/carros_pages.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/draw_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage>{
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future<int> future = Prefs.getInt("tabIdx");
    future.then((int tabIdx){
      _tabController.index = tabIdx;

    });
    _tabController.addListener((){
      Prefs.setInt( "tabIdx", _tabController.index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(controller: _tabController,
            tabs: [
              Tab(text: "Clássicos",),
              Tab(text: "Esportivos",),
              Tab(text: "Luxo",),
            ]
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: [
            CarrosPages(TipoCarro.classicos),
            CarrosPages(TipoCarro.esportivos),
            CarrosPages(TipoCarro.luxo),
          ]
      ),
      drawer: DrawList(),
    );
  }
}
