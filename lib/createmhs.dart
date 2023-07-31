import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();

  createData() async {
    var url =
        Uri.parse('https://irzanet.000webhostapp.com/api/api-tambah-mhs.php');
    var postBody = {
      "nama": namaController.text,
      "alamat": alamatController.text,
      "jurusan": jurusanController.text
    };
    var response = await post(url,
        body: postBody,
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Data Berhasil Disimpan");
      Navigator.of(context).pop(true);
    } else {
      print("Request Failed Dengan Status : ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent.shade400,
        title: const Text("Create Data"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 14.0),
              controller: namaController,
              decoration: const InputDecoration(labelText: "Nama Mahasiswa"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 14.0),
              controller: alamatController,
              decoration: const InputDecoration(labelText: "Alamat Mahasiswa"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 14.0),
              controller: jurusanController,
              decoration: const InputDecoration(labelText: "Jurusan Mahasiswa"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: MaterialButton(
              color: Colors.lightGreen.shade700,
              onPressed: () {
                createData();
              },
              child: const Text('SAVE'),
            ),
          )
        ],
      ),
    );
  }
}
