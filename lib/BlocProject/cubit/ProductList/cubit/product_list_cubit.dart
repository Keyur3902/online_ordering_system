import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/ProductList/state/product_list_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../Data/data.dart';

class ProductListCubit extends Cubit<ProductListState>{

  ProductListCubit() : super(ProductListLoadingState()) {
    getData();
  }

  List<Welcome> data = [];
  List<bool> isLoadingList = List.generate(25, (index) => false);

  void getData() async {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      final api =
          'https://shopping-app-backend-t4ay.onrender.com/product/getAllProduct';
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(api), headers: header);
      var item = jsonDecode(response.body);
      if (response.statusCode == 200) {
        data = [Welcome.fromJson(item)];
        emit(ProductListLoadedState(data));
      }
      else{
        emit(ProductListErrorState());
      }
    }
    catch(e){
      emit(ProductListFailedState(e.toString()));
      // Navigator.pushNamedAndRemoveUntil(context, '/LoginPage', (route) => false);
      throw e;
    }
  }

  onTapEnableButton(int index) {
    isLoadingList[index] = true;
  }

  onTapDisableButton(int index) {
    isLoadingList[index] = false;
  }
}