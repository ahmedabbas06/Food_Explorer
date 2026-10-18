import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../auth/login_page/login_page.dart';
import 'widgets/privacy_action_card_widget.dart';
import 'widgets/privacy_confirm_dialog_widget.dart';
import 'widgets/privacy_footer_widget.dart';
import 'widgets/privacy_header_widget.dart';
import 'widgets/privacy_section_title_widget.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  Future<void> changePassword(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    final email = authProvider.currentUser?.email;

    if (email == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => PrivacyConfirmDialog(
        title: 'Change Password',
        message: 'We will send a password reset link to $email',
        confirmText: 'Send Link',
      ),
    );

    if (confirmed != true) return;

    await authProvider.forgotPassword(email);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(authProvider.errorMessage ?? 'Reset link sent to $email'),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => PrivacyConfirmDialog(
        title: 'Log Out',
        message: 'Are you sure you want to sign out?',
        confirmText: 'Log Out',
        isDanger: true,
      ),
    );

    if (confirmed != true) return;

    await authProvider.logout();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrivacyHeader(),

              SizedBox(height: 38),

              Text(
                'Privacy & Security',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 6),

              Text(
                'Manage your account security and privacy',
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 32),

              PrivacySectionTitle(
                title: 'Account Security',
                subtitle: 'Keep your account secure',
              ),

              SizedBox(height: 18),

              PrivacyActionCard(
                icon: Icons.lock_outline_rounded,
                title: 'Change Password',
                subtitle: 'Update your account password',
                onTap: () => changePassword(context),
              ),

              SizedBox(height: 30),

              PrivacySectionTitle(
                title: 'Account',
                subtitle: 'Manage your account session',
              ),

              SizedBox(height: 18),

              PrivacyActionCard(
                icon: Icons.logout_rounded,
                title: 'Log Out',
                subtitle: 'Sign out from your account',
                isDanger: true,
                onTap: () => logout(context),
              ),

              SizedBox(height: 45),

              PrivacyFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
