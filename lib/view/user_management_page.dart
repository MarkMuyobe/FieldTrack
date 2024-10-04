import 'package:flutter/material.dart';
import '../model/user.dart';
import '../controller/user_provider.dart';
import 'package:provider/provider.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  @override
  void initState() {
    super.initState();
    // Fetch users when the page is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final List<User> users = userProvider.allUsers;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              title: Text(user.firstName),
              subtitle: Text(user.email),
              trailing: DropdownButton<UserRole>(
                value: user.role,
                onChanged: (UserRole? newRole) {
                  if (newRole != null) {
                    userProvider.updateUserRole(user.uid, newRole);
                  }
                },
                items: UserRole.values.map((UserRole role) {
                  return DropdownMenuItem<UserRole>(
                    value: role,
                    child: Text(role.toString().split('.').last),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
