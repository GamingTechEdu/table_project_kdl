import 'package:get/get.dart';
import '../data/api_service.dart';

class Controller extends GetxController {
  var isSearch = false.obs;
  RxList<Map<String, dynamic>> source = RxList<Map<String, dynamic>>([]);

  void setSearchState(bool newState) {
    isSearch.value = newState;
  }

  Future<void> fetchData() async {
    try {
      RxList<Map<String, dynamic>> source1 = await ApiService.fetchData();
        source = source1;
        print(source);
        // _sourceFiltered = List.from(_source);
        // _total = _sourceFiltered.length;
        // _resetData();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }



}
