import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Custom_Image_Marker extends StatefulWidget {
  const Custom_Image_Marker({super.key});

  @override
  State<Custom_Image_Marker> createState() => _Custom_Image_MarkerState();
}

class _Custom_Image_MarkerState extends State<Custom_Image_Marker> {

  final  Completer<GoogleMapController> _controller = Completer();
  final  CameraPosition _initialPosition = const CameraPosition(
      target: LatLng(28.661907476395267, 77.47393333798365),
      zoom:14
  );
  final Set<Marker> myMarker = {};

  final List<LatLng> myPoints = <LatLng>
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

  Future<Uint8List?> forLoadingNetworkImage(String path) async
  {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);

    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info) )
    );

    final imageInfo = await completer.future,
        byteData = await imageInfo.image.toByteData(format:ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  onLoadData() async
  {
    for(int a = 0; a< myPoints.length; a++)
    {
      Uint8List? image = await forLoadingNetworkImage("https://cdn.i-scmp.com/sites/default/files/styles/1200x800/public/d8/images/2019/11/01/1a_bmw_wanchaishowroom_finedata_1.jpg");

      final ui.Codec imageCodeMarker = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 110,
        targetWidth: 110,
      );

      final ui.FrameInfo frameInfo = await imageCodeMarker.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
          format: ui.ImageByteFormat.png
      );

      final Uint8List imageMarkerResized = byteData!.buffer.asUint8List();

      myMarker.add(
          Marker(markerId: MarkerId(a.toString()),
              position: myPoints[a],
              icon: BitmapDescriptor.fromBytes(imageMarkerResized),
              infoWindow: InfoWindow(
                title: 'My Marker title $a',
              )
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
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          markers: Set<Marker>.of(myMarker),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
