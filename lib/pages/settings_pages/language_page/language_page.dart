import 'package:flutter/material.dart';
import 'widgets/language_footer_widget.dart';
import 'widgets/language_header_widget.dart';
import 'widgets/language_option_card_widget.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => LanguagePageState();
}

class LanguagePageState extends State<LanguagePage> {
  int selectedLanguage = 0;

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
              LanguageHeader(),

              SizedBox(height: 38),

              Text(
                'Language',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 6),

              Text(
                'Choose your preferred language',
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 28),

              LanguageOptionCard(
                icon: '🇬🇧',
                title: 'English',
                subtitle: 'English language',
                isSelected: selectedLanguage == 0,
                onTap: () {
                  setState(() {
                    selectedLanguage = 0;
                  });
                },
              ),

              LanguageOptionCard(
                icon: '🇪🇬',
                title: 'العربية',
                subtitle: 'اللغة العربية',
                isSelected: selectedLanguage == 1,
                onTap: () {
                  setState(() {
                    selectedLanguage = 1;
                  });
                },
              ),

              SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    final languageName = selectedLanguage == 0 ? 'English' : 'العربية';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Language set to $languageName'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF8A3D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 45),

              LanguageFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
