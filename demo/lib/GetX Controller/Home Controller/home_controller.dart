import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../API Response Model/Home Page Model/home_page_model.dart';

class HomeController extends GetxController {

  List<DummyDataModel> dummyDataList = [];

  Future<List<DummyDataModel>?> getData() async {
    try {
      var response = await Dio().get('https://hub.dummyapis.com/employee?');
      if (response.statusCode == 200) {
        List temp = response.data;
        dummyDataList =
            temp.map((data) => DummyDataModel.fromJson(data)).toList();
        return dummyDataList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
