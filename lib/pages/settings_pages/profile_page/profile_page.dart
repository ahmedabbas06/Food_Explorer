import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import 'widgets/profile_avatar_widget.dart';
import 'widgets/profile_footer_widget.dart';
import 'widgets/profile_header_widget.dart';
import 'widgets/profile_info_field_widget.dart';
import 'widgets/profile_name_field_widget.dart';
import 'widgets/profile_save_button_widget.dart';
import 'widgets/profile_section_title_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool nameLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final authProvider = Provider.of<AuthProvider>(context);
    final name = authProvider.userData?.name ?? '';

    if (!nameLoaded && name.isNotEmpty) {
      nameController.text = name;
      nameLoaded = true;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> saveName() async {
    if (!formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.updateName(nameController.text.trim());

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Name updated successfully'
              : authProvider.errorMessage ?? 'Something went wrong.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final name = authProvider.userData?.name ?? '';
    final email =
        authProvider.userData?.email ?? authProvider.currentUser?.email ?? '';

    final newName = nameController.text.trim();
    final canSave = newName.isNotEmpty && newName != name;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(),

                SizedBox(height: 35),

                ProfileAvatar(name: name),

                SizedBox(height: 30),

                ProfileSectionTitle(
                  title: 'Personal Information',
                  subtitle: 'Manage your account information',
                ),

                SizedBox(height: 20),

                ProfileNameField(
                  controller: nameController,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),

                ProfileInfoField(
                  icon: Icons.email_outlined,
                  label: 'Email Address',
                  value: email,
                ),

                SizedBox(height: 10),

                ProfileSaveButton(
                  isLoading: authProvider.isLoading,
                  isEnabled: canSave,
                  onPressed: saveName,
                ),

                SizedBox(height: 35),

                ProfileFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
