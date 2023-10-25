import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final CustomInfoWindowController  _customInfoWindowController = CustomInfoWindowController();

  final List<Marker> myMarker = [];

  final List<LatLng> latlngforMarker = <LatLng>
  [
    const LatLng(28.661907476395267, 77.47393333798365),
    const LatLng(28.660702454359384, 77.48011314759674),
    const LatLng(28.655693933090003, 77.47599327452134),
    const LatLng(28.656032863130058, 77.46818268181592),
    const LatLng(28.653848628095428, 77.47719490416833),
    const LatLng(28.66175684939837, 77.488953708571),
    const LatLng(28.66168811821313, 77.46982781201302),
    const LatLng(28.660685026690565, 77.47467481758706),
    const LatLng(28.659891971307765, 77.4734075319024),

  ];

  onLoadData()
  {
    for(int a=0 ; a<latlngforMarker.length; a++){
      myMarker.add(
          Marker(
              markerId: MarkerId(a.toString()),
              icon: BitmapDescriptor.defaultMarker,
              position: latlngforMarker[a],
              onTap: (){
                _customInfoWindowController.addInfoWindow!(
                    Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 90,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("https://cdn.i-scmp.com/sites/default/files/styles/1200x800/public/d8/images/2019/11/01/1a_bmw_wanchaishowroom_finedata_1.jpg"),
                                    fit: BoxFit.fitWidth,
                                    filterQuality: FilterQuality.high
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10 , left: 10 , right: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Toyota Car',
                                      maxLines: 2,
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                    ),
                                  ),
                                  Spacer(),
                                  Text('3 min...'),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10 , left: 10 , right: 10),
                              child: Text(
                                'Toyota Cars Showroom , buy one for good price here...',
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    latlngforMarker[a]
                );
              }
          )
      );
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
                target: LatLng(28.661907476395267, 77.47393333798365),
                zoom: 14
            ),
            markers: Set<Marker>.of(myMarker),
            onTap: (position)
            {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position)
            {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller)
            {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 150,
            width: 200,
            offset: 40,
          ),
        ],
      ),
    );
  }
}
