import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;
import 'package:image/image.dart' as Img;
import 'package:canny_edge_detection/canny_edge_detection.dart';
import 'package:timbangsapi/home.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'splashscreen_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('font/montserrat/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(new MaterialApp(
    title: "Penghitung Bobot Sapi",
    home: SplashScreenPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Img.Image imageHitung;
  File _image;
  TextEditingController cTitle = new TextEditingController();
  String _hasil;
  String _panjang;
  String _lingkar;

  Future getImageGallery() async {
    //Untuk Ambil file image
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    // //untuk penamaan acak
    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 816, height: 612);
    var grey = Img.grayscale(smallerImg);
    //gambar untuk display
    canny(grey);
    var cannyImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(grey));

    //decode file canny menjadi image
    Img.Image image2 = Img.decodeImage(cannyImg.readAsBytesSync());

    // var compressImg = new File("$path/image_$rand.jpg")
    // ..writeAsBytesSync(Img.encodeJpg(smallerImg,quality:85));
    //4286079568
    //4285160522

    setState(() {
      _image = cannyImg;
      imageHitung = image2;
    });
  }

  Future getImageCamera() async {
    //Untuk Ambil file image
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    // //untuk penamaan acak
    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 816, height: 612);
    var grey = Img.grayscale(smallerImg);
    //gambar untuk display
    canny(grey);
    var cannyImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(grey));

    //decode file canny menjadi image
    Img.Image image2 = Img.decodeImage(cannyImg.readAsBytesSync());

    // var compressImg = new File("$path/image_$rand.jpg")
    // ..writeAsBytesSync(Img.encodeJpg(smallerImg,quality:85));
    //4286079568
    //4285160522

    setState(() {
      _image = cannyImg;
      imageHitung = image2;
    });
  }

  void hapusData() async {
    setState(() {
      _image = null;
      _hasil = null;
    });
  }

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).textScaleFactor;
    var deviceData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        leading: RawMaterialButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          constraints: BoxConstraints(),
          elevation: 0.0,
          fillColor: Colors.white,
          child: Icon(
            Icons.arrow_back,
            color: Color(0xFF303030),
          ),
          padding: EdgeInsets.all(15.0),
        ),
        centerTitle: true,
        title: Text(
          "PENGHITUNG BOBOT SAPI",
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(color: Color(0xFF303030), fontSize: 20.0)),
        ),
        titleSpacing: NavigationToolbar.kMiddleSpacing,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              width: deviceData.size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: _image == null
                    ? new Text(
                        "No Image Selected",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Color(0xFF303030), fontSize: h*12.0)),
                      )
                    : new Image.file(_image),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue)),
                  onPressed: getImageGallery,
                  child: new Icon(
                    Icons.image,
                    color: Color(0xFF303030),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                FlatButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue)),
                  onPressed: getImageCamera,
                  child: new Icon(Icons.camera_alt, color: Color(0xFF303030)),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: ButtonTheme(
              minWidth: 200,
              height: 50,
              child: RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                onPressed: hapusData,
                child: Text(
                  "HAPUS GAMBAR",
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(color: Color(0xFF303030), fontSize: h*14.0)),
                ),
              ),
            )),
            SizedBox(
              height: 10,
            ),
            Center(
                child: ButtonTheme(
              minWidth: 200,
              height: 50,
              child: RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                onPressed: hitungBerat,
                child: Text(
                  "HITUNG BOBOT",
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(color: Color(0xFF303030), fontSize: h*14.0)),
                ),
              ),
            )),
            SizedBox(
              height: 165,
            ),
            Container(
              child: WaveWidget(
                duration: 1,
                config: CustomConfig(
                  gradients: [
                    [Color(0xFF3A2DB3), Color(0xFF3A2DB1)],
                    [Color(0xFFEC72EE), Color(0xFFFF7D9C)],
                    [Color(0xFFfc00ff), Color(0xFF00dbde)],
                    [Color(0xFF396afc), Color(0xFF2948ff)]
                  ],
                  durations: [35000, 19440, 10800, 6000],
                  heightPercentages: [0.20, 0.23, 0.25, 0.30],
                  blur: MaskFilter.blur(BlurStyle.inner, 5),
                  gradientBegin: Alignment.centerLeft,
                  gradientEnd: Alignment.centerRight,
                ),
                waveAmplitude: 1.0,
                backgroundColor: Colors.blue,
                size: Size(double.infinity, 50.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  void hitungBerat() async {
    double h = MediaQuery.of(context).textScaleFactor;
    var ykanan = 306;
    var xkanan = 408;
    for (xkanan; xkanan <= 815; xkanan++) {
      var pixel = imageHitung.getPixelSafe(xkanan, ykanan);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kanan sapi = $xkanan");
        break;
      }
    }

    var ykiri = 306;
    var xkiri = 408;
    for (xkiri; xkiri >= 0; xkiri--) {
      var pixel = imageHitung.getPixelSafe(xkiri, ykiri);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kiri sapi = $xkiri");
        break;
      }
    }

    var yatas = 306;
    var xatas = 408;
    for (yatas; yatas <= 611; yatas++) {
      var pixel = imageHitung.getPixelSafe(xatas, yatas);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik atas sapi = $yatas");
        break;
      }
    }

    var ybawah = 306;
    var xbawah = 408;
    for (ybawah; ybawah >= 0; ybawah--) {
      var pixel = imageHitung.getPixelSafe(xbawah, ybawah);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik bawah sapi =$ybawah");
        break;
      }
    }

    var panjangSapi = xkanan - xkiri;
    // print("panjang sapi = $panjangSapi");

    var lebarSapi = yatas - ybawah;
    // print("lebar sapi = $lebarSapi");

    //hitung panjang titik tengah sapi
    var titikTengahX = panjangSapi * 0.5;
    var titikTengahY = lebarSapi * 0.5;
    var diameterSapi = lebarSapi * 2 / 5;
    //Konversi ke CM
    var panjangKonversi = panjangSapi * 0.48;
    var lingkarDada = 0.5 * 3.14 * (lebarSapi + diameterSapi) * 0.48;
    var beratBadan = panjangKonversi + lingkarDada * lingkarDada / 10840;

    //titik tengah badan

    var tengahSapiKanan5X = titikTengahX.toInt();
    var tengahSapiKanan5Y = titikTengahY.toInt();

    for (tengahSapiKanan5X;
        tengahSapiKanan5X <= tengahSapiKanan5X * 2;
        tengahSapiKanan5X++) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiKanan5X, tengahSapiKanan5Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kanan sapi = $tengahSapiKanan5X");
        break;
      }
    }
    var tengahSapiKiri5X = titikTengahX.toInt();
    var tengahSapiKiri5Y = titikTengahY.toInt();

    for (tengahSapiKiri5X;
        tengahSapiKiri5X >= tengahSapiKiri5X / 2;
        tengahSapiKiri5X--) {
      var pixel = imageHitung.getPixelSafe(tengahSapiKiri5X, tengahSapiKiri5Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kiri sapi = $tengahSapiKiri5X");
        break;
      }
    }

    var tengahSapiAtas5X = titikTengahX.toInt();
    var tengahSapiAtas5Y = titikTengahY.toInt();

    for (tengahSapiAtas5Y;
        tengahSapiAtas5Y <= tengahSapiAtas5X * 2;
        tengahSapiAtas5Y++) {
      var pixel = imageHitung.getPixelSafe(tengahSapiAtas5X, tengahSapiAtas5Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik Atas sapi = $tengahSapiAtas5Y");
        break;
      }
    }
    var tengahSapiBawah5X = titikTengahX.toInt();
    var tengahSapiBawah5Y = titikTengahY.toInt();

    for (tengahSapiBawah5Y;
        tengahSapiBawah5Y >= tengahSapiBawah5Y / 2;
        tengahSapiBawah5Y--) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiBawah5X, tengahSapiBawah5Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik Bawah sapi = $tengahSapiBawah5Y");
        break;
      }
    }
    var tengahSapiKanan4X = titikTengahX.toInt();
    var tengahSapiKanan4Y = titikTengahY.toInt();

    for (tengahSapiKanan4X;
        tengahSapiKanan4X <= tengahSapiKanan4X * 2;
        tengahSapiKanan4X++) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiKanan4X, tengahSapiKanan4Y - 1);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kanan sapi = $tengahSapiKanan4X");
        break;
      }
    }
    var tengahSapiKiri4X = titikTengahX.toInt();
    var tengahSapiKiri4Y = titikTengahY.toInt();

    for (tengahSapiKiri4X;
        tengahSapiKiri4X >= tengahSapiKiri4X / 2;
        tengahSapiKiri4X--) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiKiri4X, tengahSapiKiri4Y - 1);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kiri sapi = $tengahSapiKiri4X");
        break;
      }
    }

    var tengahSapiAtas4X = titikTengahX.toInt();
    var tengahSapiAtas4Y = titikTengahY.toInt();

    for (tengahSapiAtas4Y;
        tengahSapiAtas4Y <= tengahSapiAtas4X * 2;
        tengahSapiAtas4Y++) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiAtas4X - 1, tengahSapiAtas4Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik Atas sapi = $tengahSapiAtas4Y");
        break;
      }
    }
    var tengahSapiBawah4X = titikTengahX.toInt();
    var tengahSapiBawah4Y = titikTengahY.toInt();

    for (tengahSapiBawah4Y;
        tengahSapiBawah4Y >= tengahSapiBawah4Y / 2;
        tengahSapiBawah4Y--) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiBawah4X - 1, tengahSapiBawah4Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik Bawah sapi = $tengahSapiBawah4Y");
        break;
      }
    }
    var tengahSapiKanan3X = titikTengahX.toInt();
    var tengahSapiKanan3Y = titikTengahY.toInt();

    for (tengahSapiKanan3X;
        tengahSapiKanan3X <= tengahSapiKanan3X * 2;
        tengahSapiKanan3X++) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiKanan3X, tengahSapiKanan3Y - 2);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kanan sapi = $tengahSapiKanan3X");
        break;
      }
    }
    var tengahSapiKiri3X = titikTengahX.toInt();
    var tengahSapiKiri3Y = titikTengahY.toInt();

    for (tengahSapiKiri3X;
        tengahSapiKiri3X >= tengahSapiKiri3X / 2;
        tengahSapiKiri3X--) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiKiri3X, tengahSapiKiri3Y - 2);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kiri sapi = $tengahSapiKiri3X");
        break;
      }
    }

    var tengahSapiAtas3X = titikTengahX.toInt();
    var tengahSapiAtas3Y = titikTengahY.toInt();

    for (tengahSapiAtas3Y;
        tengahSapiAtas3Y <= tengahSapiAtas3X * 2;
        tengahSapiAtas3Y++) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiAtas3X - 2, tengahSapiAtas3Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik Atas sapi = $tengahSapiAtas3Y");
        break;
      }
    }
    var tengahSapiBawah3X = titikTengahX.toInt();
    var tengahSapiBawah3Y = titikTengahY.toInt();

    for (tengahSapiBawah3Y;
        tengahSapiBawah3Y >= tengahSapiBawah3Y / 2;
        tengahSapiBawah3Y--) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiBawah3X - 2, tengahSapiBawah3Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik Bawah sapi = $tengahSapiBawah3Y");
        break;
      }
    }
    var tengahSapiKanan6X = titikTengahX.toInt();
    var tengahSapiKanan6Y = titikTengahY.toInt();

    for (tengahSapiKanan6X;
        tengahSapiKanan6X <= tengahSapiKanan6X * 2;
        tengahSapiKanan6X++) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiKanan6X, tengahSapiKanan6Y + 1);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kanan sapi = $tengahSapiKanan6X");
        break;
      }
    }
    var tengahSapiKiri6X = titikTengahX.toInt();
    var tengahSapiKiri6Y = titikTengahY.toInt();

    for (tengahSapiKiri6X;
        tengahSapiKiri6X >= tengahSapiKiri6X / 2;
        tengahSapiKiri6X--) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiKiri6X, tengahSapiKiri6Y + 1);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kiri sapi = $tengahSapiKiri6X");
        break;
      }
    }

    var tengahSapiAtas6X = titikTengahX.toInt();
    var tengahSapiAtas6Y = titikTengahY.toInt();

    for (tengahSapiAtas6Y;
        tengahSapiAtas6Y <= tengahSapiAtas6X * 2;
        tengahSapiAtas6Y++) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiAtas6X + 1, tengahSapiAtas6Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik Atas sapi = $tengahSapiAtas6Y");
        break;
      }
    }
    var tengahSapiBawah6X = titikTengahX.toInt();
    var tengahSapiBawah6Y = titikTengahY.toInt();

    for (tengahSapiBawah6Y;
        tengahSapiBawah6Y >= tengahSapiBawah6Y / 2;
        tengahSapiBawah6Y--) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiBawah6X + 1, tengahSapiBawah6Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik Bawah sapi = $tengahSapiBawah6Y");
        break;
      }
    }
    var tengahSapiKanan7X = titikTengahX.toInt();
    var tengahSapiKanan7Y = titikTengahY.toInt();

    for (tengahSapiKanan7X;
        tengahSapiKanan7X <= tengahSapiKanan7X * 2;
        tengahSapiKanan7X++) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiKanan7X, tengahSapiKanan7Y + 2);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kanan sapi = $tengahSapiKanan7X");
        break;
      }
    }
    var tengahSapiKiri7X = titikTengahX.toInt();
    var tengahSapiKiri7Y = titikTengahY.toInt();

    for (tengahSapiKiri7X;
        tengahSapiKiri7X >= tengahSapiKiri7X / 2;
        tengahSapiKiri7X--) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiKiri7X, tengahSapiKiri7Y + 2);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik kiri sapi = $tengahSapiKiri7X");
        break;
      }
    }

    var tengahSapiAtas7X = titikTengahX.toInt();
    var tengahSapiAtas7Y = titikTengahY.toInt();

    for (tengahSapiAtas7Y;
        tengahSapiAtas7Y <= tengahSapiAtas7X * 2;
        tengahSapiAtas7Y++) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiAtas7X + 2, tengahSapiAtas7Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik Atas sapi = $tengahSapiAtas7Y");
        break;
      }
    }
    var tengahSapiBawah7X = titikTengahX.toInt();
    var tengahSapiBawah7Y = titikTengahY.toInt();

    for (tengahSapiBawah7Y;
        tengahSapiBawah7Y >= tengahSapiBawah7Y / 2;
        tengahSapiBawah7Y--) {
      var pixel =
          imageHitung.getPixelSafe(tengahSapiBawah7X + 2, tengahSapiBawah7Y);
      if (pixel >= 4286000000) {
        // print(pixel);
        // print("titik Bawah sapi = $tengahSapiBawah7Y");
        break;
      }
    }
    var panjangPixel3 = tengahSapiKanan3X - tengahSapiKiri3X;
    var panjangPixel4 = tengahSapiKanan4X - tengahSapiKiri4X;
    var panjangPixel5 = tengahSapiKanan5X - tengahSapiKiri5X;
    var panjangPixel6 = tengahSapiKanan6X - tengahSapiKiri6X;
    var panjangPixel7 = tengahSapiKanan7X - tengahSapiKiri7X;
    var panjangTotal = (panjangPixel3 +
            panjangPixel4 +
            panjangPixel5 +
            panjangPixel6 +
            panjangPixel7) /
        5;
    var lebarPixel3 = tengahSapiAtas3Y - tengahSapiBawah3Y;
    var lebarPixel4 = tengahSapiAtas4Y - tengahSapiBawah4Y;
    var lebarPixel5 = tengahSapiAtas5Y - tengahSapiBawah5Y;
    var lebarPixel6 = tengahSapiAtas6Y - tengahSapiBawah6Y;
    var lebarPixel7 = tengahSapiAtas7Y - tengahSapiBawah7Y;
    var lebarTotal =
        (lebarPixel3 + lebarPixel4 + lebarPixel5 + lebarPixel6 + lebarPixel7) /
            5;
    var diameterPixel = lebarTotal * 2 / 5;
    var panjangKonversiSapi = panjangTotal * 0.48;
    var lingkarDadaSapi = 0.5 * 3.14 * (lebarTotal + diameterPixel) * 0.48;
    var beratBadanSapi =
        panjangKonversiSapi + lingkarDadaSapi * lingkarDadaSapi / 10840;
    setState(() {
      print(panjangKonversiSapi);
      print(lingkarDadaSapi);
      print(beratBadanSapi);

      _hasil = beratBadanSapi.roundToDouble().toString();
      _lingkar = lingkarDadaSapi.roundToDouble().toString();
      _panjang = panjangKonversiSapi.roundToDouble().toString();
    });

    Alert(
      context: context,
      title: "HASIL PERHITUNGAN",
      content: Column(
        children: <Widget>[
          _hasil == null
              ? new Text(
                  "Bobot Sapi",
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(color: Colors.black, fontSize: h*13.0)),
                )
              : new Text(
                  "Bobot Sapi = $_hasil Kg",
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(color: Colors.black, fontSize: h*16.0)),
                )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "CLOSE",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white, fontSize: h*20.0)),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     // return object of type Dialog
    //     return AlertDialog(
    //       title: new Text(
    //         "HASIL PERHITUNGAN",
    //         textAlign: TextAlign.center,
    //       ),
    //       content: Container(
    //         height: 50.0,
    //         width: 350.0,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             _hasil == null
    //                 ? new Text(
    //                     "Bobot Sapi =",
    //                     style:
    //                         new TextStyle(color: Colors.black, fontSize: 20.0),
    //                   )
    //                 : new Text(
    //                     " Bobot Sapi = $_hasil Kg",
    //                     style:
    //                         new TextStyle(color: Colors.black, fontSize: 20.0),
    //                     textAlign: TextAlign.left,
    //                   ),
    //           ],
    //         ),
    //       ),
    //       actions: <Widget>[
    //         // usually buttons at the bottom of the dialog
    //         new FlatButton(
    //           child: new Text("Close"),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
