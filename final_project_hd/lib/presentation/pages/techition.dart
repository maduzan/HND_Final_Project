import 'package:final_project_hd/domain/entities/fechdata.dart';
import 'package:final_project_hd/presentation/providers/fechusers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Techition extends StatefulWidget {
  final Fechdata tec;

  const Techition({super.key, required this.tec});

  @override
  State<Techition> createState() => _TechitionState();
}

class _TechitionState extends State<Techition> {
  @override
  void initState() {
    super.initState();

    // Call the provider when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).fechdatat();
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
          if (dataProvider.dataListpt.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: dataProvider.dataListpt.length,
            itemBuilder: (context, index) {
              final tec = dataProvider.dataListpt[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(tec.fullName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${tec.username}'),
                      Text('Email: ${tec.email}'),
                      Text('Job Role: ${tec.jobrall}'),
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
