import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../screens/patient_dashboard.dart';
import '../screens/doctor_dashboard.dart';
import '../screens/partner_dashboard.dart';

class RoleSelectionSection extends StatelessWidget {
  const RoleSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860),
          child: Column(
            children: [
              // Heading
              Text(
                'Welcome to UHA.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: AppColors.slate900,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Who are you?',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Please select your role to continue to your personalized dashboard and\naccess our health network.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.slate500,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 48),
              // Role cards
              LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _RoleCard(
                          icon: Icons.person_outline,
                          label: 'Patient',
                          description:
                              'Manage your health records, book appointments, and chat with specialists in real-time.',
                          onSelect: () => _navigate(
                              context, const PatientDashboard()),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _RoleCard(
                          icon: Icons.medical_services_outlined,
                          label: 'Doctor',
                          description:
                              'Access patient charts, manage your schedule, and provide high-quality virtual consultations.',
                          onSelect: () => _navigate(
                              context, const DoctorDashboard()),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _RoleCard(
                          icon: Icons.biotech_outlined,
                          label: 'Partner',
                          description:
                              'For Hospitals, Labs, and Pharmacies to manage complex operations and medical fulfillment.',
                          onSelect: () => _navigate(
                              context, const PartnerDashboard()),
                        ),
                      ),
                    ],
                  );
                }
                // Mobile: column
                return Column(
                  children: [
                    _RoleCard(
                      icon: Icons.person_outline,
                      label: 'Patient',
                      description:
                          'Manage your health records, book appointments, and chat with specialists in real-time.',
                      onSelect: () =>
                          _navigate(context, const PatientDashboard()),
                    ),
                    const SizedBox(height: 16),
                    _RoleCard(
                      icon: Icons.medical_services_outlined,
                      label: 'Doctor',
                      description:
                          'Access patient charts, manage your schedule, and provide high-quality virtual consultations.',
                      onSelect: () =>
                          _navigate(context, const DoctorDashboard()),
                    ),
                    const SizedBox(height: 16),
                    _RoleCard(
                      icon: Icons.biotech_outlined,
                      label: 'Partner',
                      description:
                          'For Hospitals, Labs, and Pharmacies to manage complex operations and medical fulfillment.',
                      onSelect: () => _navigate(
                          context, const PartnerDashboard()),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 36),
              // Register org link
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.inter(
                      fontSize: 14, color: AppColors.slate500),
                  children: [
                    const TextSpan(text: 'Looking to join our network?  '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          'Register Organization',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

// ── Role Card ─────────────────────────────────────────────────────────────────

class _RoleCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onSelect;

  const _RoleCard({
    required this.icon,
    required this.label,
    required this.description,
    required this.onSelect,
  });

  @override
  State<_RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<_RoleCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onSelect,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _hover ? AppColors.primary : AppColors.slate200,
              width: _hover ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _hover
                    ? AppColors.primary.withOpacity(0.08)
                    : Colors.black.withOpacity(0.04),
                blurRadius: _hover ? 24 : 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon circle
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: _hover
                      ? AppColors.primary.withOpacity(0.2)
                      : AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  size: 32,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900,
                ),
              ),
              const SizedBox(height: 10),
              // Description
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.slate500,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              // Select Role button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: widget.onSelect,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.slate800,
                    side: BorderSide(
                      color: _hover ? AppColors.primary : AppColors.slate300,
                      width: 1.5,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Text('Select Role'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
