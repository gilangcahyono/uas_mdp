import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uas_mdp3_fix/createmhs.dart';
import 'package:uas_mdp3_fix/editmhs.dart';
import 'package:uas_mdp3_fix/deletemhs.dart';
import 'package:http/http.dart';

// NAMA Kelompok:
// 202011420002 - Febrina Ade Susianti --> Get(Read) dan Delete code
// 202011420031 - Gilang Cahyono --> Post(Create) dan Delete code
// 202011420034 - Septian Dwi Prasetyo --> Put(Update) dan Delete Code

void main() => runApp(const MaterialApp(home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataList = [];
  var loading = true;

  getData() async {
    var url =
        Uri.parse('https://irzanet.000webhostapp.com/api/api-tampil-mhs.php');
    var response = await get(url);
    if (response.statusCode == 200) {
      print('Request Data Ke Api Berhasil');
      List<dynamic> jsonResponse = jsonDecode(response.body);
      setState(() {
        dataList =
            jsonResponse; // Tidak perlu menggunakan 'docs' karena jsonResponse sudah berisi list data.
        loading = false;
        print('Data Json : $dataList');
      });
    } else {
      print('Request Data Ke Api Gagal');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent.shade400,
        title: const Text('UAS MDP'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen.shade700,
        onPressed: () async {
          var result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const Create()));
          if (result == true) {
            setState(() {
              loading = true;
              getData();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      body: loading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: dataList.length,
              itemBuilder: (cxt, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 8.0,
                    child: ListTile(
                      onTap: () async {
                        var result =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Edit(
                                      data: dataList[i],
                                    )));
                        if (result == true) {
                          setState(() {
                            loading = true;
                            getData();
                          });
                        }
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nama : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(dataList[i]['nama']),
                          const Text(
                            'Alamat : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(dataList[i]['alamat']),
                          const Text(
                            'Jurusan : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(dataList[i]['jurusan']),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              var result = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (_) => Edit(
                                            data: dataList[i],
                                          )));
                              if (result == true) {
                                setState(() {
                                  loading = true;
                                  getData();
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              var result = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (_) => Delete(
                                            data: dataList[i],
                                          )));
                              if (result == true) {
                                setState(() {
                                  loading = true;
                                  getData();
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
