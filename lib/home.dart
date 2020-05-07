import 'package:flutter/material.dart';
import 'splashscreen_view.dart';
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).textScaleFactor;
    var deviceData = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: deviceData.size.height,
            width: deviceData.size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            height: deviceData.size.height * 0.8,
            width: deviceData.size.width,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
          ),
          Container(
            height: deviceData.size.height * 0.6,
            width: deviceData.size.width,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("img/homepage.jpg"), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
          ),
          Positioned(
              right: 10.0,
              left: 10.0,
              top: deviceData.size.height * 0.63,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Membantu meringankan beban kerja peternak sapi untuk menghitung bobot sapi mereka",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .8,
                          fontSize: h*16)),
                ),
              )),
          //Tombol untuk membuka about developer
          Positioned(
              right: deviceData.size.width * 0.8,
              top: deviceData.size.height * 0.76,
              child: RawMaterialButton(
                onPressed: () => _onDevPressed(context),
                constraints: BoxConstraints(),
                elevation: 0.0,
                fillColor: Colors.blue,
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 55.0,
                ),
                shape: CircleBorder(),
              )),
          //Tombol untuk membuka cara pemakaian aplikasi
          Positioned(
              right: deviceData.size.width * 0.6,
              top: deviceData.size.height * 0.76,
              child: RawMaterialButton(
                onPressed: () => _onTutorPressed(),
                constraints: BoxConstraints(),
                elevation: 0.0,
                fillColor: Colors.blue,
                child: Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 55.0,
                ),
                shape: CircleBorder(),
              )),
          //Tombol untuk menuju perhitungan
          Positioned(
              right: deviceData.size.width * 0.1,
              top: deviceData.size.height * 0.76,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                constraints: BoxConstraints(),
                elevation: 0.0,
                fillColor: Colors.blue,
                child: Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                  size: 55.0,
                ),
                shape: CircleBorder(),
              )),
          Positioned(
              right: 10.0,
              left: 10.0,
              top: deviceData.size.height * 0.85,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Baca Syarat dan Ketentuan Untuk Pengambilan Citra Sapi",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.blue,
                          letterSpacing: .8,
                          fontSize: h*16)),
                ),
              )),
          //Tombol untuk ketentuan pengambilan gambar
          Positioned(
              right: 10.0,
              left: 10.0,
              top: deviceData.size.height * 0.89,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  textColor: Colors.white,
                  onPressed: () => _onTakePicPressed(),
                  child: Text(
                    "Disini",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.blue,
                            letterSpacing: .8,
                            fontSize: h*16)),
                  ),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
              )),
        ],
      ),
    );
  }

  _onDevPressed(context) {
    double h = MediaQuery.of(context).textScaleFactor;
    Alert(
      context: context,
      title: "TENTANG PENGEMBANG",
      content: Column(
        children: <Widget>[
          Text(
            "NAMA",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*12.0)),
          ),
          Text(
            "Fauzan Arif Sani",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*14.0)),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "PENDIDIKAN",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*12.0)),
          ),
          Text(
            "Teknik Informatika - UIN Sunan Kalijaga",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*14.0)),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "EMAIL",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*12.0)),
          ),
          Text(
            "arifsanimail@gmail.com",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*14.0)),
          ),
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
  }

  _onTakePicPressed() {
    double h = MediaQuery.of(context).textScaleFactor;
    Alert(
      context: context,
      title: "KETENTUAN PENGAMBILAN CITRA SAPI",
      image: Image.asset("img/sapi.png"),
      content: Column(
        children: <Widget>[
          Text(
            "1.Tempatkan Sapi pada Tempat Dengan Pencahayaan Yang Cukup",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*14.0)),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "2.Tempatkan Kamera Pada Jarak 150cm Serta Tinggi 75cm Dari Sisi Samping Sapi",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*14.0)),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "3.Ambil Citra Sapi Secara Landscape Untuk Melakukan Perhitungan",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*14.0)),
          ),
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
  }
  _onTutorPressed(){
    double h = MediaQuery.of(context).textScaleFactor;
    Alert(
      context: context,
      title: "PETUNJUK PENGGUNAAN",
      type: AlertType.info,
      content: Column(
        children: <Widget>[
          Text(
            "1.Upload Citra Sapi Dengan Camera / File Manager",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*14.0)),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "2.Pastikan Garis Tepi Pada Citra Sapi Sesuai Untuk Mendapat Bobot Yang Sesuai",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*14.0)),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "3.Tekan Tombol Hitung Bobot Untuk Memulai Perhitungan",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*14.0)),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "4.Tekan Tombol Hapus Gambar Untuk Menghapus Citra Yang Tidak Sesuai",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black, fontSize: h*14.0)),
          ),
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
  }
}
