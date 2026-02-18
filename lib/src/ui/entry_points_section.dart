import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';

class EntryPointsSection extends StatelessWidget {
  const EntryPointsSection({super.key});

  static const _cards = [
    _CardData(
      icon: Icons.assignment_ind_outlined,
      title: 'For Patients',
      description:
          'Take full control of your health data. Use one secure ID to access records across every clinic and provider in our global network.',
      actionText: 'Manage Health Records',
    ),
    _CardData(
      icon: Icons.monitor_heart_outlined,
      title: 'For Doctors',
      description:
          'Access real-time, longitudinal patient history instantly. Make data-driven decisions with superior insights and reduced friction.',
      actionText: 'Join Provider Network',
    ),
    _CardData(
      icon: Icons.hub_outlined,
      title: 'For Partners',
      description:
          'Build on the UHA infrastructure. Integrate your digital health solution into our secure ecosystem and reach millions.',
      actionText: 'Explore Integration',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  'Tailored for your ecosystem',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: AppColors.slate900,
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    'Select your entry point to discover how Unified Health Alliance transforms your professional or personal healthcare experience.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.slate500,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                ScreenTypeLayout.builder(
                  desktop: (_) => _buildRow(),
                  tablet: (_) => _buildRow(),
                  mobile: (_) => _buildColumn(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _cards
          .map((card) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _EntryCard(data: card),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildColumn() {
    return Column(
      children: _cards
          .map((card) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _EntryCard(data: card),
              ))
          .toList(),
    );
  }
}

class _CardData {
  final IconData icon;
  final String title;
  final String description;
  final String actionText;
  const _CardData({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionText,
  });
}

class _EntryCard extends StatefulWidget {
  final _CardData data;
  const _EntryCard({required this.data});

  @override
  State<_EntryCard> createState() => _EntryCardState();
}

class _EntryCardState extends State<_EntryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovered ? AppColors.primary.withOpacity(0.4) : AppColors.slate100,
            width: 1.5,
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: AppColors.primary.withOpacity(0.08), blurRadius: 40, offset: const Offset(0, 8))]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _hovered ? AppColors.primary : AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                widget.data.icon,
                color: _hovered ? AppColors.backgroundDark : AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.data.title,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.slate900,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.data.description,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: AppColors.slate600,
                height: 1.65,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    widget.data.actionText,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward, size: 16, color: AppColors.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
