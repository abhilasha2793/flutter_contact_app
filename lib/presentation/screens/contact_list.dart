import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/blocs/contact_bloc.dart';
import '../../domain/blocs/contact_event.dart';
import '../../domain/blocs/contact_state.dart';
import '../widgets/contact_list_item.dart';
import '../widgets/navbar.dart';
import 'add_update_contact.dart';

/// A stateless widget to render ContactListScreen.
class ContactListScreen extends StatelessWidget {
  final String title;
  final bool favorite;

  const ContactListScreen(
      {super.key, required this.title, required this.favorite});

  @override
  Widget build(BuildContext context) {
    context.read<ContactBloc>().add(FetchAllContactEvent());
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        title: Text(title),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessState) {
            final contacts = state.contacts;
            return contacts.isNotEmpty
                ? ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      if (favorite && !contacts[index].favorite) {
                        return const SizedBox.shrink();
                      }
                      return ContactListItem(
                        contactItem: contacts[index],
                        onUpdate: () => context.read<ContactBloc>().add(FetchAllContactEvent()),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No contact available',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                  );
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: !favorite
          ? FloatingActionButton(
              onPressed: () => _navigateToAddUpdateScreen(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Future<void> _navigateToAddUpdateScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddUpdateContactScreen(
          update: false,
          contactToUpdate: null,
        ),
      ),
    );

    if (result != null) {
      if (!context.mounted) return;
      context.read<ContactBloc>().add(FetchAllContactEvent());
    }
  }
}
