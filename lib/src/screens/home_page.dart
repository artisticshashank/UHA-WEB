import 'package:flutter/material.dart';
import '../ui/header.dart';
import '../ui/hero_section.dart';
import '../ui/role_selection_section.dart';
import '../ui/entry_points_section.dart';
import '../ui/ecosystem_section.dart';
import '../ui/cta_section.dart';
import '../ui/footer.dart';
import '../constants/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: const [
                SizedBox(height: 80),
                HeroSection(),
                RoleSelectionSection(),
                EntryPointsSection(),
                EcosystemSection(),
                CtaSection(),
                Footer(),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(),
          ),
        ],
      ),
    );
  }
}
