import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_hd/data/repositories/authdatarepo.dart';
import 'package:final_project_hd/data/repositories/chatdara_repo.dart';
import 'package:final_project_hd/data/repositories/data_reop_faechdata.dart';
import 'package:final_project_hd/data/repositories/duserrepo.dart';
import 'package:final_project_hd/data/repositories/fech_plumbers.dart';
import 'package:final_project_hd/domain/entities/chat.dart';
import 'package:final_project_hd/domain/usecase/authusecase.dart';
import 'package:final_project_hd/domain/usecase/chatusecase.dart';
import 'package:final_project_hd/domain/usecase/fech_data_usecase.dart';
import 'package:final_project_hd/domain/usecase/plumberusecase.dart';
import 'package:final_project_hd/domain/usecase/uscaseuser.dart';
import 'package:final_project_hd/presentation/pages/chat.dart';
import 'package:final_project_hd/presentation/pages/comfermorder.dart';
import 'package:final_project_hd/presentation/pages/regester.dart';
import 'package:final_project_hd/presentation/pages/Second.dart';
import 'package:final_project_hd/presentation/pages/details.dart';
import 'package:final_project_hd/presentation/pages/home.dart';
import 'package:final_project_hd/presentation/providers/authprovider.dart';
import 'package:final_project_hd/presentation/providers/chatprovider.dart';
import 'package:final_project_hd/presentation/providers/fechdata_provider.dart';
import 'package:final_project_hd/presentation/providers/fechusers.dart';
import 'package:final_project_hd/presentation/providers/useprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? senderId; // State variable to store the logged-in user’s ID

  @override
  void initState() {
    super.initState();
    getLoggedInUserId(); // Fetch senderId in initState
  }

  // Method to get the logged-in user's ID
  void getLoggedInUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        senderId = user.uid;

        print("Sender ID: $senderId");
        // Set the senderId when the user is logged in
      });
    } else {
      print("No user logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // User-related Providers
        Provider<UserRepositoryImpl>(
          create: (_) => UserRepositoryImpl(FirebaseFirestore.instance),
        ),
        ProxyProvider<UserRepositoryImpl, AddUser>(
          update: (_, userRepo, __) => AddUser(userrepo: userRepo),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(
            addUser: context.read<AddUser>(),
          ),
        ),

        // Auth-related Providers
        Provider<AuthRepositoryImpl>(
          create: (_) =>
              AuthRepositoryImpl(firebaseAuth: FirebaseAuth.instance),
        ),
        ProxyProvider<AuthRepositoryImpl, Authenticateusecase>(
          update: (_, authRepo, __) =>
              Authenticateusecase(authrepositoty: authRepo),
        ),
        ChangeNotifierProvider<Authprovider>(
          create: (context) => Authprovider(
            authenticateusecase: context.read<Authenticateusecase>(),
          ),
        ),

        // User-related Providers
        Provider<DataReopFaechdata>(
          create: (_) =>
              DataReopFaechdata(firestore: FirebaseFirestore.instance),
        ),
        ProxyProvider<DataReopFaechdata, FechDataUsecase>(
          update: (_, fechRepo, __) => FechDataUsecase(fechDataRepo: fechRepo),
        ),
        ChangeNotifierProvider<FechdataProvider>(
          create: (context) => FechdataProvider(
            fechDataUsecase: context.read<FechDataUsecase>(),
          ),
        ),

        Provider<FechPlumbers>(
          create: (_) => FechPlumbers(firestore: FirebaseFirestore.instance),
        ),
        ProxyProvider<FechPlumbers, Plumberusecase>(
          update: (_, fech, __) => Plumberusecase(prepo: fech),
        ),
        ChangeNotifierProvider<DataProvider>(
          create: (context) => DataProvider(
            plumberusecase: context.read<Plumberusecase>(),
          ),
        ),

        Provider<ChatdaraRepo>(
          create: (_) => ChatdaraRepo(firestore: FirebaseFirestore.instance),
        ),
        ProxyProvider<ChatdaraRepo, Chatusecase>(
          update: (_, fech, __) => Chatusecase(chatrepo: fech),
        ),
        ChangeNotifierProvider<Chatprovider>(
          create: (context) => Chatprovider(
            chatusecase: context.read<Chatusecase>(),
          ),
        ),
      ],
      child: MaterialApp(
        home: Home(),
        routes: {
          '/First': (context) => Second(),
          '/Home': (context) => Home(),
          '/Regester': (context) => Regester(),
          '/Details': (context) => Details(),
          '/message': (context) {
            final args = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            final String? senderId = 'KipsmUKWZFc2SiT6GA2w' as String?;
            final String? receiverId = 'LChLNm96GoFAYgCucXm1' as String?;

            print("Sender ID: $senderId");
            print("Receiver ID: $receiverId");

            if (senderId != null && receiverId != null) {
              return ChatScreen(senderId: senderId, receiverId: receiverId);
            } else {
              return Center(child: Text("User not logged in"));
            }
          },
          '/gmap': (context) => Confermorder(),
        },
      ),
    );
  }
}
