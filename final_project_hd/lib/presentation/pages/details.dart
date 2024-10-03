import 'package:final_project_hd/presentation/pages/builder.dart';
import 'package:final_project_hd/presentation/pages/carpenter.dart';
import 'package:final_project_hd/presentation/pages/electrition.dart';
import 'package:final_project_hd/presentation/pages/plumber.dart';
import 'package:final_project_hd/presentation/pages/techition.dart';
import 'package:final_project_hd/presentation/providers/fechdata_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project_hd/data/model/fechdata_model.dart';

class Details extends StatefulWidget {
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  get senderId => null;

  get receiverId => null;

  @override
  void initState() {
    super.initState();

    // Call the provider when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FechdataProvider>(context, listen: false).fetchFechdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fechdata List'),
        leading: IconButton(
          icon: Icon(Icons.message),
          onPressed: () {
            // Assuming you have senderId and receiverId available
            String defaultReceiverId =
                "ktkRlh9U7qKcggjEbFyr"; // Set your default receiver ID

            Navigator.of(context).pushNamed(
              '/message',
              arguments: {
                'senderId': senderId ?? '', // Provide a default value if null
                'receiverId': defaultReceiverId,
              },
            );
          },
        ),
      ),
      body: Consumer<FechdataProvider>(
        builder: (context, fechdataProvider, child) {
          if (fechdataProvider.fechdataList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: fechdataProvider.fechdataList.length,
            itemBuilder: (context, index) {
              final data = fechdataProvider.fechdataList[index];
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Container(
                      height: 110,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            Image.network(data.ImageUrl, fit: BoxFit.fitWidth),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(child: Text(data.name)),
                    Center(child: Text(data.Discriotion)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Plumber(data: data),
                              // Passing data to the new page
                            ),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Builders(build: data)
                                // Passing data to the new page
                                ),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Carpenter(dataa: data),
                              // Passing data to the new page
                            ),
                          );
                        } else if (index == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Electrition(ele: data)
                                // Passing data to the new page
                                ),
                          );
                        } else if (index == 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Techition(tec: data)
                                // Passing data to the new page
                                ),
                          );
                        } else if (index == 5) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Builders(build: data)
                                // Passing data to the new page
                                ),
                          );
                        }
                      },
                      child: Text("Go to Details"),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
