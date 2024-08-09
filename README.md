# contact_app

A new Flutter project for managing contacts.

## Project Structure

### Model

#### Contact Model

The `Contact` model class represents a contact entity with the following properties:
- `id`: Unique identifier for the contact.
- `name`: Name of the contact.
- `mobile`: Mobile number of the contact.
- `landLine`: Landline number of the contact.
- `imageUrl`: URL of the contact's image.
- `favorite`: Boolean indicating if the contact is marked as favorite.

### Data

#### DatabaseHelper

The `DatabaseHelper` class manages database operations for the application. It includes methods for:
- Initializing the database.
- Creating the contacts table.
- Inserting, updating, deleting, and retrieving contacts.
- Closing the database.

### Repository

#### ContactRepository

The `ContactRepository` class manages contact data by interacting with the `DatabaseHelper`. It includes methods for:
- Retrieving contacts (optionally filtering by favorite).
- Inserting a new contact.
- Updating an existing contact.
- Deleting a contact.

### BLoC Structure

#### ContactBloc

The `ContactBloc` class manages the state of the contact list and handles events related to contacts.

#### ContactEvent

The `ContactEvent` class defines the various events that can occur in the contact management system, such as adding, updating, and deleting contacts.

#### ContactState

The `ContactState` class represents the different states of the contact list, such as loading, loaded, and error states.

### Screens

#### AddUpdateContact

The `AddUpdateContact` class provides a screen for adding or updating a contact. It includes a form for entering contact details and buttons for saving or deleting the contact.

#### ContactList

The `ContactList` class displays a list of contacts. It includes a search bar and options to filter contacts by favorites.

### Custom Widgets

#### ContactListItem

The `ContactListItem` widget displays a contact in the contact list, including the contact's name, mobile number, and a circular avatar.

#### FormWidget

The `FormWidget` class provides a form for adding or updating a contact. It includes fields for the contact's name, mobile number, landline number, and image URL.

#### NavDrawerHeader

The `NavDrawerHeader` widget displays the header of the navigation drawer, including the user's name and a circular avatar.

#### Navbar

The `Navbar` class creates a navigation drawer with a list of items, including the `NavDrawerHeader`.

#### ProfileImageWidget

The `ProfileImageWidget` class displays a circular avatar for the user's profile image.

### Routes

#### AppRoutes

The `AppRoutes` class defines the routes for the application. It includes routes for the contact list screen and the add/update contact screen.

### Utils

#### Validators

The `validators.dart` file defines validation functions for form fields, such as validating phone numbers and landline numbers.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project Structure and How to Run

### Project Structure

#### Model
- `lib/model/contact.dart`: Defines the `Contact` model class.

#### Data
- `lib/data/DatabaseHelper.dart`: Manages database operations.

#### Repository
- `lib/data/repository/contact_repository.dart`: Manages contact data by interacting with `DatabaseHelper`.

#### BLoC
- `lib/bloc/contact_bloc.dart`: Manages the state of the contact list.
- `lib/bloc/contact_event.dart`: Defines events for contact management.
- `lib/bloc/contact_state.dart`: Represents different states of the contact list.

#### Screens
- `lib/screen/add_update_contact.dart`: Screen for adding or updating a contact.
- `lib/screen/contact_list.dart`: Displays a list of contacts.

#### Widgets
- `lib/widgets/contact_list_item.dart`: Displays a contact in the contact list.
- `lib/widgets/form_widget.dart`: Provides a form for adding or updating a contact.
- `lib/widgets/nav_drawer_header.dart`: Displays the header of the navigation drawer.
- `lib/widgets/navbar.dart`: Creates a navigation drawer.
- `lib/widgets/profile_image_widget.dart`: Displays a circular avatar for the user's profile image.

#### Routes
- `lib/routes/app_routes.dart`: Defines the routes for the application.

#### Utils
- `lib/utils/validators.dart`: Defines validation functions for form fields.

### How to Run

1. **Clone the repository:**
   ```sh
   git clone <repository-url>
   cd <repository-directory>