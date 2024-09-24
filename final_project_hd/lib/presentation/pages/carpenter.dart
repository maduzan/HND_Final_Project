import 'package:final_project_hd/data/model/fechdata_model.dart';
import 'package:final_project_hd/domain/entities/fechdata.dart';
import 'package:final_project_hd/presentation/providers/fechusers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Carpenter extends StatefulWidget {
  final Fechdata dataa;

  const Carpenter({super.key, required this.dataa});

  @override
  State<Carpenter> createState() => _CarpenterState();
}

class _CarpenterState extends State<Carpenter> {
  @override
  void initState() {
    super.initState();

    // Call the provider when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).fechdatac();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Carpenters'),
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          if (dataProvider.dataListc.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: dataProvider.dataListc.length,
            itemBuilder: (context, index) {
              final dataa = dataProvider.dataListc[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(dataa.fullName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${dataa.username}'),
                      Text('Email: ${dataa.email}'),
                      Text('Job Role: ${dataa.jobrall}'),
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
