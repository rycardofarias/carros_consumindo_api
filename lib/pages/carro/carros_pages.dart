import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carrosBloc.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

import 'CarroPage.dart';

class CarrosPages extends StatefulWidget {
  String tipo;
  CarrosPages(this.tipo);

  @override
  _CarrosPagesState createState() => _CarrosPagesState();
}

class _CarrosPagesState extends State<CarrosPages> with AutomaticKeepAliveClientMixin<CarrosPages> {
  List<Carro> carros;

  String get tipo => widget.tipo;
  final _bloc = Carros_Bloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.loadCarros(widget.tipo);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);

    //print("CarrosListView build ${widget.tipo}");

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possivel buscar os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;

        return RefreshIndicator(
            child: CarrosListView(carros), onRefresh: _onRefresh);

      },
    );
  }

  Future<void> _onRefresh(){
    return _bloc.loadCarros(tipo);
  }


  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}