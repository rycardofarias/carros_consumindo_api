import 'dart:async';

import 'package:carros/utils/simple_bloc.dart';

import 'carro.dart';
import 'carros_api.dart';

class Carros_Bloc extends SimpleBloc<List<Carro>>{

Future<List<Carro>> loadCarros(String tipo) async {
  try {
    List<Carro> carros = await CarrosApi.getCarros(tipo);

    add(carros);

    return carros;
  } catch (e) {
    print("Erro no carrobloc>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    addError(e);
  }
}
}