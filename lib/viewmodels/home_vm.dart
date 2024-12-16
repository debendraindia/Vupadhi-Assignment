import 'package:get/get.dart';
import 'package:vupadhi/data/models/get_all_service_list_model.dart';
import 'package:vupadhi/data/repositories/service_repository.dart';

class HomeVm extends GetxController {
  var currentIndex = 0.obs;
  var carouselItems = <CarouselItem>[
    CarouselItem(
        imageUrl: 'https://via.placeholder.com/600x300', title: 'Item 1'),
    CarouselItem(
        imageUrl: 'https://via.placeholder.com/600x300', title: 'Item 2'),
    CarouselItem(
        imageUrl: 'https://via.placeholder.com/600x300', title: 'Item 3'),
  ].obs;
  var servicesList = <Datum>[].obs;
  final ServiceRepository serviceRepository = ServiceRepository();

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
    try {
      servicesList.value = await serviceRepository.fetchServices();
    } catch (e) {
      print('Error fetching services: $e');
    }
  }
}

class CarouselItem {
  final String imageUrl;
  final String title;

  CarouselItem({required this.imageUrl, required this.title});
}
