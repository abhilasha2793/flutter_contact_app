import 'package:contact_app/presentation/screens/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'data/DatabaseHelper.dart';
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ContactBloc>(
            create: (context) => ContactBloc(dbHelper: context.read<DatabaseHelper>()),
          ),
        ],
        child: MaterialApp(
          title: 'Contact App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const ContactListScreen(title: 'Contact List', favorite: false),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}