import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Delete extends StatefulWidget {
  const Delete({super.key, this.data});
  final data;

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  void initState() {
    super.initState();
  }

  hapusData() async {
    var id = widget.data['id'];
    var url = Uri.parse(
        'https://irzanet.000webhostapp.com/api/api-hapus-mhs.php?id=$id');
    var response = await post(url, body: {"id": id});
    if (response.statusCode == 200) {
      print("Data Berhasil Dihapus");
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
        title: const Text('Delete'),
      ),
      body: Column(
        children: [
          // Display ID of Mahasiswa to be deleted
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'ID Mahasiswa: ${widget.data['id']}',
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
          // Delete button using query parameter
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.lightGreen.shade700,
                  onPressed: () {
                    hapusData();
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
