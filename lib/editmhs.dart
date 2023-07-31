import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Edit extends StatefulWidget {
  const Edit({super.key, this.data});
  final data;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController idController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.text = widget.data['id'];
    namaController.text = widget.data['nama'];
    alamatController.text = widget.data['alamat'];
    jurusanController.text = widget.data['jurusan'];
  }

  editData() async {
    var url =
        Uri.parse('https://irzanet.000webhostapp.com/api/api-edit-mhs.php');
    var postBody = {
      "id": idController.text,
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
        title: const Text('Edit'),
      ),
      body: Column(
        children: [
          // Bagian Form Id untuk Update API
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 14.0),
              controller: idController,
              decoration: const InputDecoration(labelText: "Id Mahasiswa"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 14.0),
              controller: namaController,
              decoration: const InputDecoration(labelText: "Name Mahasiswa"),
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
            padding: const EdgeInsets.all(10.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                color: Colors.lightGreen.shade700,
                onPressed: () {
                  editData();
                },
                child: const Text('Edit'),
              ),
            ]),
          ),
          // Bagian Form Id untuk Delete API
        ],
      ),
    );
  }
}
