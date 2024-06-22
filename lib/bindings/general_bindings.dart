import 'package:get/get.dart';
import 'package:online_nursery_plant_shop/common/network_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
Get.put(NetworkManager());
  }
}