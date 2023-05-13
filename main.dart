import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

class ActivityModel {
  String nama;
  String jenis;
  ActivityModel({required this.nama, required this.jenis}); //constructor
}

class ActivityCubit extends Cubit<ActivityModel> {
  String url = "http://178.128.17.76:8000/daftar_umkm";
  ActivityCubit() : super(ActivityModel(nama: "", jenis: ""));

  //map dari json ke atribut
  void setFromJson(Map<String, dynamic> json) {
    var data = json['data'];
    for (var val in data) {
      var nama = val["nama"]; //thn dijadikan int
      var jenis = val["jenis"]; //populasi sudah int
      //tambahkan ke array
    }
    // emit(ActivityModel.fromJson(nama: nama, jenis: jenis));
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ActivityCubit(),
        child: const HalamanUtama(),
      ),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final textController = TextEditingController();
  List<String> data = []; //data untuk listview
  String _nama = "";
  @override
  Widget build(Object context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              '\n2107377, Alif Faturahman Firdaus, 2108724, Ravindra Maulana Sahman; Saya berjanji tidak akan berbuat curang data\natau membantu orang lain berbuat curang',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _nama = textController.text;
              });
            },
            child: const Text('Reload Daftar UMKM'),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                // return Container(
                //   decoration: BoxDecoration(border: Border.all()),
                //   padding: const EdgeInsets.all(14),
                //   child: Text(data[index]),
                // );
                return ListTile(
                  leading:
                      Image.network("https://unsplash.com/photos/AsnLBqPTy1s"),
                  title: Text(data[index]),
                  subtitle: Text('bawah'),
                );
              },
            ),
          ),
        ],
      ),
      // body: Center(
      //   child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      //     BlocBuilder<ActivityCubit, ActivityModel>(
      //       buildWhen: (previousState, state) {
      //         developer.log("${previousState.nama} -> ${state.nama}",
      //             name: 'logyudi');
      //         return true;
      //       },
      //       builder: (context, nama) {
      //         return Center(
      //             child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(bottom: 20),
      //                 child: ElevatedButton(
      //                   onPressed: () {
      //                     context.read<ActivityCubit>().fetchData();
      //                   },
      //                   child: const Text("Saya bosan ..."),
      //                 ),
      //               ),
      //               Text(nama.nama),
      //               Text("Jenis: ${nama.jenis}")
      //             ]));
      //       },
      //     ),
      //   ]),
      // ),
    ));
  }
}

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return MyAppState();
//   }
// }

// class MyAppState extends State<MyApp> {
//   final textController = TextEditingController();
//   List<String> data = []; //data untuk listview
//   String _nama = "";

//   @override
//   void initState() {
//     super.initState();
//     // isi data listview
//     for (int i = 0; i < 5; i++) {
//       data.add("Data ke $i ");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('My App'),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Text(
//                 '\n2107377, Alif Faturahman Firdaus, 2108724, Ravindra Maulana Sahman; Saya berjanji tidak akan berbuat curang data\natau membantu orang lain berbuat curang',
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _nama = textController.text;
//                 });
//               },
//               child: const Text('Reload Daftar UMKM'),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               height: 500,
//               child: ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   // return Container(
//                   //   decoration: BoxDecoration(border: Border.all()),
//                   //   padding: const EdgeInsets.all(14),
//                   //   child: Text(data[index]),
//                   // );
//                   return ListTile(
//                     leading: Image.network(
//                         "https://unsplash.com/photos/AsnLBqPTy1s"),
//                     title: Text(data[index]),
//                     subtitle: Text('bawah'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
