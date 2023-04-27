import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online_ordering_system/GetxProject/ModelClassGetx/productModelClassGet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListControllerGetx extends GetxController{

  RxList<WelcomeGet> data = <WelcomeGet>[].obs;
  RxBool isLoading = false.obs;
  
  WelcomeGet welcomeGet = WelcomeGet(status: 0, msg: '', totalProduct: 0, data: []);

  bool isLoad = false;

  @override
  void onInit() {
    super.onInit();
    isLoad = false;
    getData();
  }

  isLoadDone(){
    isLoad = true;
    update();
  }

   isLoadDone1(){
    isLoad = false;
    update();
  }

  bool check(){
    return isLoad;
  }



  Future<void> getData() async {
    try{
      isLoading.value = true;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      final api =
          'https://shopping-app-backend-t4ay.onrender.com/product/getAllProduct';
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(api), headers: header);
      var item = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(item);
        welcomeGet = WelcomeGet.fromJson(item);
        update();
      }
      else{
        welcomeGet = WelcomeGet.fromJson(item);
        update();
        print('sadsdasdasdasd${item}');
      }
    }
    catch(e){
      Get.offAllNamed('/LoginPageGet');
      throw e;
    }
    finally{
      isLoading.value = false;
    }
  }
}