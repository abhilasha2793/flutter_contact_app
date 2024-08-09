import 'package:contact_app/presentation/screens/contact_list.dart';
import 'package:contact_app/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'data/DatabaseHelper.dart';
import 'data/repository/contact_repository.dart';
import 'domain/blocs/contact_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseHelper>(create: (context) => DatabaseHelper()),
        Provider<ContactRepository>(
          create: (context) => ContactRepository(context.read<DatabaseHelper>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ContactBloc>(
            create: (context) => ContactBloc(contactRepository: context.read<ContactRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Contact App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.contactList,
          onGenerateRoute: AppRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}