import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 80, bottom: 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.slate100)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                ScreenTypeLayout.builder(
                  desktop: (_) => _DesktopGrid(),
                  tablet: (_) => _MobileGrid(),
                  mobile: (_) => _MobileGrid(),
                ),
                const SizedBox(height: 64),
                const _BottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _BrandColumn()),
        const SizedBox(width: 32),
        Expanded(flex: 2, child: _LinkColumn(title: 'Solutions', links: ['Digital Identity', 'Interoperability API', 'Patient Portals', 'Telehealth Sync'])),
        const SizedBox(width: 32),
        Expanded(flex: 2, child: _LinkColumn(title: 'Company', links: ['About Us', 'Careers', 'Security Standards', 'Contact'])),
        const SizedBox(width: 32),
        Expanded(flex: 3, child: _NewsletterColumn()),
      ],
    );
  }
}

class _MobileGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BrandColumn(),
        const SizedBox(height: 40),
        const _LinkColumn(title: 'Solutions', links: ['Digital Identity', 'Interoperability API', 'Patient Portals', 'Telehealth Sync']),
        const SizedBox(height: 40),
        const _LinkColumn(title: 'Company', links: ['About Us', 'Careers', 'Security Standards', 'Contact']),
        const SizedBox(height: 40),
        _NewsletterColumn(),
      ],
    );
  }
}

class _BrandColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.shield_outlined, size: 18, color: AppColors.backgroundDark),
            ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.slate900,
                  letterSpacing: 0.5,
                ),
                children: const [
                  TextSpan(text: 'UHA'),
                  TextSpan(text: '.', style: TextStyle(color: AppColors.primary)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            'Redefining health identity for a more connected, efficient, and secure healthcare future.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.slate500,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _SocialButton(icon: Icons.share),
            const SizedBox(width: 12),
            _SocialButton(icon: Icons.language),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  const _SocialButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.slate100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: AppColors.slate600, size: 18),
    );
  }
}

class _LinkColumn extends StatelessWidget {
  final String title;
  final List<String> links;
  const _LinkColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.slate900,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                link,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.slate500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NewsletterColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stay Updated',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.slate900,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Subscribe to our newsletter for the latest in health tech.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.slate500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.slate50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.slate200),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  'Email address',
                  style: GoogleFonts.inter(color: AppColors.slate400, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.send, color: AppColors.backgroundDark, size: 18),
            ),
          ],
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.slate100)),
      ),
      child: ScreenTypeLayout.builder(
        desktop: (_) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: _bottomText('© 2024 Unified Health Alliance. All rights reserved. HIPAA Compliant.')),
            const SizedBox(width: 16),
            Wrap(
              spacing: 24,
              children: [
                _footerLink('Privacy Policy'),
                _footerLink('Terms of Service'),
                _footerLink('Cookie Settings'),
              ],
            ),
          ],
        ),
        mobile: (_) => Column(
          children: [
            _bottomText('© 2024 Unified Health Alliance. All rights reserved. HIPAA Compliant.'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 24,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _footerLink('Privacy Policy'),
                _footerLink('Terms of Service'),
                _footerLink('Cookie Settings'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomText(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(fontSize: 12, color: AppColors.slate400, fontWeight: FontWeight.w500),
    );
  }

  Widget _footerLink(String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 12, color: AppColors.slate400, fontWeight: FontWeight.w500),
      ),
    );
  }
}
