import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vupadhi/app/theme/colors.dart';
import 'package:vupadhi/viewmodels/home_vm.dart';
import 'package:vupadhi/views/dynamic_form/dynamic_form_screen.dart';

class HomeScreen extends StatelessWidget {
  final HomeVm controller = Get.put(HomeVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Smith',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              'ID:44 | Department',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 150.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {},
                  ),
                  items: controller.carouselItems.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              )),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              switch (controller.currentIndex.value) {
                case 0:
                  return Obx(() {
                    if (controller.servicesList.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              'Online Application', // Heading Text
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.servicesList.length,
                              itemBuilder: (context, index) {
                                final service = controller.servicesList[index];
                                final imageBytes = service.getImageBytes();
                                return Card(
                                  elevation: 5,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    leading: imageBytes != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.memory(
                                              imageBytes,
                                              fit: BoxFit.cover,
                                              width: 50,
                                              height: 50,
                                            ),
                                          )
                                        : null,
                                    title: Text(service.serviceName ??
                                        'No Service Name'),
                                    subtitle: Text(
                                        service.categoryName ?? 'No Category'),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.grey),
                                    onTap: () {
                                      Get.to(() => DynamicFormScreen(
                                            service: service,
                                            imageBytes: imageBytes,
                                          ));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  });
                case 1:
                  return const Center(child: Text("My Reports"));
                default:
                  return const Center(child: Text("Logout"));
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.currentIndex.value = index;
          },
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_sharp),
              label: 'My Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Logout',
            ),
          ],
        );
      }),
    );
  }
}
