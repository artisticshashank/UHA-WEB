import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import '../screens/create_uhaid_page.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      child: Stack(
        children: [
          // Wave background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(double.infinity, 200),
              painter: _WavePainter(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 64, bottom: 96),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1280),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ScreenTypeLayout.builder(
                    desktop: (_) => _DesktopHero(),
                    tablet: (_) => _MobileHero(),
                    mobile: (_) => _MobileHero(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _HeroText(textAlign: TextAlign.left)),
        const SizedBox(width: 64),
        const Expanded(child: _HeroImage()),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeroText(textAlign: TextAlign.center),
        const SizedBox(height: 48),
        const _HeroImage(),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  final TextAlign textAlign;
  const _HeroText({required this.textAlign});

  @override
  Widget build(BuildContext context) {
    final isCenter = textAlign == TextAlign.center;
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'NEXT-GEN HEALTH IDENTITY',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.emerald700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Headline
        Text(
          'One ID.',
          textAlign: textAlign,
          style: GoogleFonts.inter(
            fontSize: 60,
            fontWeight: FontWeight.w900,
            color: AppColors.slate900,
            height: 1.0,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.emerald600, AppColors.primary],
          ).createShader(bounds),
          child: Text(
            'Universal Care.',
            textAlign: textAlign,
            style: GoogleFonts.inter(
              fontSize: 60,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'Streamlining the healthcare journey through a unified digital identity. Access your records, connect with providers, and manage health—anywhere in the world.',
            textAlign: textAlign,
            style: GoogleFonts.inter(
              fontSize: 18,
              color: AppColors.slate600,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 40),
        // CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const CreateUhaIdPage(),
                  transitionsBuilder: (_, animation, __, child) =>
                      FadeTransition(opacity: animation, child: child),
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.backgroundDark,
                elevation: 8,
                shadowColor: AppColors.primary.withOpacity(0.3),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              child: const Text('Join the Network'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_circle_outline, size: 22),
              label: const Text('See how it works'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.slate900,
                side: const BorderSide(color: AppColors.slate200, width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        // Trusted by
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 8,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            Text(
              'TRUSTED BY',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.slate500,
                letterSpacing: 1.2,
              ),
            ),
            Container(width: 80, height: 20, decoration: BoxDecoration(color: AppColors.slate300, borderRadius: BorderRadius.circular(4))),
            Container(width: 80, height: 20, decoration: BoxDecoration(color: AppColors.slate300, borderRadius: BorderRadius.circular(4))),
            Container(width: 80, height: 20, decoration: BoxDecoration(color: AppColors.slate300, borderRadius: BorderRadius.circular(4))),
          ],
        ),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAtkVeqryQ98mgLbogZ1gYiJcAU7oi2WC0sJjyOrZQqTSPQNPNjwvsI10rX7OkBjpGFQSBOiFE5nqp4hEhj3DHOJ-_DcCpJGcaQun40ebmFqpwSkim4k9-VTSSvBC3GzSdEC0FoxltCfxPLM8TDc_oc3WTAm4_SvnlHoUvykBfQFUezz01TSoaZ7NGIgnMaeMwxYhHXk4E-4S3q2-FYJs21oUrj6SQqSx-2coXbpVl6MBsqrykhx7EGm156NbOROZJNqawvbYHPuOk',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                height: 400,
                color: AppColors.slate100,
                child: const Center(child: CircularProgressIndicator(color: AppColors.primary)),
              );
            },
          ),
        ),
        // Glow
        Positioned(
          top: -24,
          right: -24,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.15),
            ),
            child: const SizedBox(),
          ),
        ),
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF13ECA4).withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.cubicTo(size.width * 0.2, size.height * 0.3, size.width * 0.4, size.height * 0.7, size.width * 0.6, size.height * 0.4);
    path.cubicTo(size.width * 0.8, size.height * 0.1, size.width * 0.9, size.height * 0.5, size.width, size.height * 0.4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
