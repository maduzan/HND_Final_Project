import 'package:final_project_hd/domain/entities/fechdata.dart';
import 'package:final_project_hd/presentation/providers/fechusers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Electrition extends StatefulWidget {
  final Fechdata ele;

  const Electrition({super.key, required this.ele});

  @override
  State<Electrition> createState() => _ElectritionState();
}

class _ElectritionState extends State<Electrition> {
  @override
  void initState() {
    super.initState();

    // Call the provider when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).fechdataee();
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
          if (dataProvider.dataListee.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: dataProvider.dataListee.length,
            itemBuilder: (context, index) {
              final ele = dataProvider.dataListee[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(ele.fullName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${ele.username}'),
                      Text('Email: ${ele.email}'),
                      Text('Job Role: ${ele.jobrall}'),
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
