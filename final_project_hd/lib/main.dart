import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_hd/data/repositories/authdatarepo.dart';
import 'package:final_project_hd/data/repositories/duserrepo.dart';
import 'package:final_project_hd/domain/usecase/authusecase.dart';
import 'package:final_project_hd/domain/usecase/uscaseuser.dart';
import 'package:final_project_hd/presentation/pages/regester.dart';
import 'package:final_project_hd/presentation/pages/Second.dart';
import 'package:final_project_hd/presentation/pages/details.dart';
import 'package:final_project_hd/presentation/pages/home.dart';
import 'package:final_project_hd/presentation/providers/authprovider.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      ],
      child: MaterialApp(
        home: Home(),
        routes: {
          '/First': (context) => Second(),
          '/Home': (context) => Home(),
          '/Regester': (context) => Regester(),
          '/Details': (context) => Details(),
        },
      ),
    );
  }
}
