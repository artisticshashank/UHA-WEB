import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import '../screens/login_page.dart';
import '../screens/create_uhaid_page.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            border: const Border(
              bottom: BorderSide(color: Color(0x1A34D399)),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLogo(),
                    ScreenTypeLayout.builder(
                      mobile: (_) => const SizedBox.shrink(),
                      tablet: (_) => const SizedBox.shrink(),
                      desktop: (_) => _buildNavLinks(),
                    ),
                    _buildAuthButtons(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.shield_outlined, color: AppColors.backgroundDark, size: 22),
        ),
        const SizedBox(width: 12),
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.slate900,
              letterSpacing: 1,
            ),
            children: const [
              TextSpan(text: 'UHA'),
              TextSpan(text: '.', style: TextStyle(color: AppColors.primary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavLinks() {
    const links = ['Services', 'Technology', 'About', 'Partners'];
    return Row(
      children: links
          .map(
            (link) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  link,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate600,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  void _goToLogin(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginPage(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _goToRegister(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const CreateUhaIdPage(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    return Row(
      children: [
        ScreenTypeLayout.builder(
          mobile: (_) => const SizedBox.shrink(),
          tablet: (_) => const SizedBox.shrink(),
          desktop: (_) => TextButton(
            onPressed: () => _goToLogin(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.slate700,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: const StadiumBorder(),
              textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            child: const Text('Log In'),
          ),
        ),
        const SizedBox(width: 8),
        ScreenTypeLayout.builder(
          mobile: (_) => const SizedBox.shrink(),
          tablet: (_) => const SizedBox.shrink(),
          desktop: (_) => ElevatedButton(
            onPressed: () => _goToRegister(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.backgroundDark,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              shape: const StadiumBorder(),
              textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            child: const Text('Create UHA ID'),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => _goToLogin(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.backgroundDark,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: const StadiumBorder(),
            textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          child: const Text('Get Started'),
        ),
      ],
    );
  }
}
