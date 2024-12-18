import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/constants/images.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/widgets/custom_app_bar_primary.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_edit_controller.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_map_controller.dart';
import 'package:hellomultlan/app/modules/box/widgets/box_details_bottom_sheet.dart';
import 'package:latlong2/latlong.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BoxMapPage extends StatefulWidget {
  final BoxMapController controller;
  const BoxMapPage({super.key, required this.controller});

  @override
  State<BoxMapPage> createState() => _BoxMapPageState();
}

class _BoxMapPageState extends State<BoxMapPage>
    with
        MessageViewMixin,
        LoaderViewMixin,
        AutomaticKeepAliveClientMixin<BoxMapPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.getAllBoxs();
      messageListener(widget.controller);
      loaderListerner(widget.controller);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Modular.to.pushNamed("/box/form"),
          child: const Icon(Icons.add)),
      appBar: CustomAppBar(title: 'Mapa de Ctos'),
      body: Stack(
        children: [
          FlutterMap(
            mapController: widget.controller.mapController,
            options: MapOptions(
              initialCenter: const LatLng(-5.1750424, -42.7906436),
              keepAlive: true,
              initialZoom: 15,
              onMapReady: () => widget.controller.mapController.mapEventStream
                  .listen((event) {}),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                maxZoom: 19,
                userAgentPackageName: 'com.dev.vini',
              ),
              Watch.builder(
                builder: (_) => MarkerLayer(
                  markers: widget.controller.boxList
                      .map(
                        (boxElement) => Marker(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          point: LatLng(double.parse(boxElement.latitude),
                              double.parse(boxElement.longitude)),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(24),
                              onTap: () =>
                                  BoxDetailsBottomSheet.showBottomSheetBox(
                                      boxElement,
                                      BoxEditController(
                                          boxModel: boxElement,
                                          gateway: Modular.get()),
                                      context),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Image.asset(ImagesConstants.markIcon),
                                  Text(
                                    boxElement.label,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              CurrentLocationLayer()
            ],
          ),
        ],
      ),
    );
  }
}
