import 'package:final_project_hd/domain/entities/fechdata.dart';
import 'package:final_project_hd/presentation/providers/fechdata_provider.dart';
import 'package:final_project_hd/presentation/providers/fechusers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Plumber extends StatefulWidget {
  final Fechdata data;
  const Plumber({super.key, required this.data});

  @override
  State<Plumber> createState() => _PlumberState();
}

class _PlumberState extends State<Plumber> {
  @override
  void initState() {
    super.initState();

    // Call the provider when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).fechdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Plumbers'),
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          if (dataProvider.dataList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: dataProvider.dataList.length,
            itemBuilder: (context, index) {
              final data = dataProvider.dataList[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(data.fullName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${data.username}'),
                      Text('Email: ${data.email}'),
                      Text('Job Role: ${data.jobrall}'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          String email = data.email;
                          String name = data.fullName;
                          String jobrall = data.jobrall;

                          Navigator.of(context).pushNamed('/gmap', arguments: {
                            'email': email,
                            'name': name,
                            'jobrall': jobrall,
                          });
                        },
                        child: Text("Book Now"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
