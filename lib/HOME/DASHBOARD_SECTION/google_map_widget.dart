
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../CONTROLERS/home_conntroller.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../NETWORK/base_client.dart';
import '../../UTILS/app_color.dart';

class GoogleMapWidget extends StatelessWidget {
  GoogleMapWidget({super.key});
  final controller = Get.find<HomeController>();



  void loadMap(){
    Future.delayed(Duration.zero,() {
      // Create a JavaScript script tag with the API key
      var script = ScriptElement()
        ..type = 'text/javascript'
        ..innerHtml = '''
    var mapApiKey = '${BaseClient.a + BaseClient.b + BaseClient.c + BaseClient.d}';
    var script = document.createElement('script');
    script.src = 'https://maps.googleapis.com/maps/api/js?key=' + mapApiKey + '&libraries=drawing,visualization,places';
    script.async = true;
    script.defer = true;
    document.head.appendChild(script);
    ''';
      // Append the script tag to the document's head
      document.head?.append(script);
    },);
  }

  @override
  Widget build(BuildContext context) {
    //loadMap();
    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(color: btnColor, width: 2),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Top Spot Information',
                style: TextStyle(
                  color: fishColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        controller.listOfLocation.length,
                        (index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: OutlinedButton(
                                  onPressed: () {
                                    controller.selectedLocation.value = index;
                                    index == 0
                                        ? controller.movePosition(
                                            -32.23802154105024,
                                            146.28119669514828)
                                        : index == 1
                                            ? controller.movePosition(
                                                -36.9828112132686,
                                                144.2686501261222)
                                            : index == 2
                                                ? controller.movePosition(
                                                    -22.633166402197528,
                                                    144.84005532902137)
                                                : index == 3
                                                    ? controller.movePosition(
                                                        -29.521097058397896,
                                                        135.05382333850554)
                                                    : index == 4
                                                        ? controller.movePosition(
                                                            -26.149853400088684,
                                                            121.88542090863693)
                                                        : index == 5
                                                            ? controller.movePosition(
                                                                -41.95706819204696,
                                                                146.520821377283)
                                                            : index == 6
                                                                ? controller.movePosition(
                                                                    -35.43367677006962,
                                                                    148.9697532888674)
                                                                : controller.movePosition(
                                                                    -19.427257281941447,
                                                                    133.41503280664466);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        controller.selectedLocation.value ==
                                                index
                                            ? fishColor
                                            : Colors.transparent,
                                  ),
                                  child: CustomText(
                                    text: controller.listOfLocation[index],
                                    color: controller.selectedLocation.value ==
                                            index
                                        ? Colors.white
                                        : secondaryColor,
                                  )),
                            )),
                  ),
                  const SizedBox(
                    width: 16,
                  ),

                  /// Map Screen
                  SizedBox(
                    height: Get.height * 0.65,
                    width: Get.width * 0.24,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GoogleMap(
                        initialCameraPosition:
                            controller.initialCameraPosition.value,
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController cont) {
                          controller.googleMapController.value.complete(cont);
                        },
                        markers: Set<Marker>.of(controller.markers),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
