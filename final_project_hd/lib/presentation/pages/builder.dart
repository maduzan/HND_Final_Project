import 'package:final_project_hd/domain/entities/fechdata.dart';
import 'package:final_project_hd/presentation/providers/fechusers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Builders extends StatefulWidget {
  final Fechdata build;

  const Builders({super.key, required this.build});

  @override
  State<Builders> createState() => _BuildersState();
}

class _BuildersState extends State<Builders> {
  @override
  void initState() {
    super.initState();

    // Call the provider when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).fechdatabui();
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
          if (dataProvider.dataListbui.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: dataProvider.dataListbui.length,
            itemBuilder: (context, index) {
              final build = dataProvider.dataListbui[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(build.fullName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${build.username}'),
                      Text('Email: ${build.email}'),
                      Text('Job Role: ${build.jobrall}'),
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
