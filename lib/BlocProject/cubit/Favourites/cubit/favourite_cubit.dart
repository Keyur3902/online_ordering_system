import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Data/favoriteDataModel.dart';
import '../state/favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteLoadingState()){
    getMyFavorite();
  }

  List<FavoriteData> favoriteProduct = [];
  List<bool> isLoadingList = List.generate(25, (index) => false);

  void getMyFavorite() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken').toString();
      print(jwtToken);

      final api = 'https://shopping-app-backend-t4ay.onrender.com/watchList/getWatchList';
      final header = {
        'Authorization': 'Bearer $jwtToken',
      };
      final response = await http.get(Uri.parse(api), headers: header);
      var responsebody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(responsebody);
        favoriteProduct = [FavoriteData.fromJson(responsebody)];
        if(favoriteProduct[0].data.isEmpty){
          emit(FavouriteEmptyState());
        }
        else{
          emit(FavouriteLoadedState(favoriteProduct));
        }
      }
      else {
        emit(FavouriteFailedState());
        print(responsebody);
      }
    }
    catch (e){
      emit(FavouriteErrorState(e.toString()));
      // Navigator.pushNamedAndRemoveUntil(context, '/LoginPage', (route) => false);
      // throw e;
    }
  }

  addToFavorite(String productId) async {
    emit(AddToFavouriteLoadingState());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var jwtToken = preferences.getString('jwtToken');
    print(jwtToken);

    final api = 'https://shopping-app-backend-t4ay.onrender.com/watchList/addToWatchList';
    final data = {
      'productId' : productId,
    };
    final header = {
      'Authorization' : 'Bearer $jwtToken',
    };

    var response = await http.post(Uri.parse(api), body: data, headers: header);

    if(response.statusCode == 200){
      emit(AddToFavouriteSuccessState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      print('Item Added to favorite');
    }
    else{
      emit(AddToFavouriteFailedState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }

  removeFromFavorite(String favoriteItemId) async {
    emit(RemoveFromFavouriteLoadingState());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken').toString();
    print(jwtToken);
    final api = 'https://shopping-app-backend-t4ay.onrender.com/watchList/removeFromWatchList';
    final data = {
      'wathListItemId' : favoriteItemId,
    };
    final header = {
      'Authorization' : 'Bearer $jwtToken',
    };

    var response = await http.post(Uri.parse(api), body: data, headers: header);

    if(response.statusCode == 200){
      emit(RemoveFromFavouriteSuccessState());
      var responsebody = jsonDecode(response.body);
      print('Item removed from favorite');
      print(responsebody);
    }
    else if(response.statusCode == 400){
      emit(RemoveFromFavouriteFailedState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }

  onTapEnableButton(int index) {
    isLoadingList[index] = true;
  }

  onTapDisableButton(int index) {
    isLoadingList[index] = false;
  }

}