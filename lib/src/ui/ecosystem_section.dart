import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';

class EcosystemSection extends StatelessWidget {
  const EcosystemSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundDark,
                borderRadius: BorderRadius.circular(48),
              ),
              padding: const EdgeInsets.all(64),
              child: ScreenTypeLayout.builder(
                desktop: (_) => _DesktopLayout(),
                tablet: (_) => _MobileLayout(),
                mobile: (_) => _MobileLayout(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: _TextContent()),
        const SizedBox(width: 64),
        Expanded(child: _ImageGrid()),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TextContent(),
        const SizedBox(height: 64),
        _ImageGrid(),
      ],
    );
  }
}

class _TextContent extends StatelessWidget {
  const _TextContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Unified',
          style: GoogleFonts.inter(
            fontSize: 44,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.15,
          ),
        ),
        Text(
          'Ecosystem',
          style: GoogleFonts.inter(
            fontSize: 44,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Our platform is engineered on global standards to ensure seamless data flow and top-tier security for everyone in the healthcare chain.',
          style: GoogleFonts.inter(
            fontSize: 17,
            color: Colors.white.withOpacity(0.5),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 48),
        _FeatureItem(
          icon: Icons.dynamic_feed,
          title: 'Interoperability',
          description: 'Connect with any clinical software or legacy system within our secure node-network.',
        ),
        const SizedBox(height: 20),
        _FeatureItem(
          icon: Icons.verified_user_outlined,
          title: 'Uncompromising Security',
          description: 'HIPAA & GDPR compliant with end-to-end AES-256 encryption for every bit of data.',
        ),
        const SizedBox(height: 20),
        _FeatureItem(
          icon: Icons.bolt,
          title: 'Instant Sync',
          description: 'Real-time medical updates across devices and providers the moment a change is made.',
        ),
      ],
    );
  }
}

class _FeatureItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({required this.icon, required this.title, required this.description});

  @override
  State<_FeatureItem> createState() => _FeatureItemState();
}

class _FeatureItemState extends State<_FeatureItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? AppColors.primary.withOpacity(0.4) : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.icon, color: AppColors.primary, size: 32),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.slate400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _NetworkImageCard(
                height: 256,
                url: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDAJc730YmsS4jDefsg5k_j3UCVs6T4Qr-NWVcclmo0S6iGX6GuPb8lcFNhN_Kr7lo2PTmig4IHCSFTVblgVgOut7WOZRKEH110fglMRDCLu0iwyI7MtkWeOFRyRQpguJKprtbDxWXt6x74ufZJF4367ktrx4KzDlATLMyRhKLk1mN6glckg018KQ54Xhdla_ppSe8vNtdUXHZ1YErmrUp9lK1FCF04nLizI4KC1U69-GNA6z0yiFk-Z77w-g8FPYTCtPI5GGTF0PU',
              ),
              const SizedBox(height: 16),
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '99.9%',
                        style: GoogleFonts.inter(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: AppColors.backgroundDark,
                        ),
                      ),
                      Text(
                        'UPTIME SECURITY',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: AppColors.backgroundDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 32),
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.slate700,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '10M+',
                        style: GoogleFonts.inter(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'UNIFIED RECORDS',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _NetworkImageCard(
                height: 256,
                url: 'https://lh3.googleusercontent.com/aida-public/AB6AXuArW660TUTvP8xM24hmCu8w5oz3h1FXDZKn2zpyXCiIVXfjvoJltSkEtgSS60OVET9PtSOxX9KS72v7ymCD4vretgoSD36AmwdomH--PjOvttR3g6vuPnbypQbiQJ5WHci-d4Q_JIBEIAT2DMt20-iWLcebsxspgqULdNXkT_LEhgyZ2D9YD_RnfvyL-UscGHNQpYIYe14dFy8Ajb2x_y9je4WF68UwpA5xRiw_RYXWGRGNsSu0qZWyksBShOIYIB3jJFxPqEOeIbA',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NetworkImageCard extends StatelessWidget {
  final double height;
  final String url;

  const _NetworkImageCard({required this.height, required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: height,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          color: Colors.black.withOpacity(0.35),
          colorBlendMode: BlendMode.darken,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(color: AppColors.slate800);
          },
        ),
      ),
    );
  }
}
