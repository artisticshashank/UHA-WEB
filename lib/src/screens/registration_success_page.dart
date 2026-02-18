import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'patient_dashboard.dart';

class RegistrationSuccessPage extends StatefulWidget {
  final String uhaid;
  final String name;

  const RegistrationSuccessPage({
    super.key,
    required this.uhaid,
    required this.name,
  });

  @override
  State<RegistrationSuccessPage> createState() =>
      _RegistrationSuccessPageState();
}

class _RegistrationSuccessPageState extends State<RegistrationSuccessPage>
    with TickerProviderStateMixin {
  late AnimationController _circleCtrl;
  late AnimationController _checkCtrl;
  late AnimationController _fadeCtrl;
  late Animation<double> _circleAnim;
  late Animation<double> _checkAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _circleCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _checkCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _circleAnim = CurvedAnimation(
        parent: _circleCtrl, curve: Curves.easeOutBack);
    _checkAnim =
        CurvedAnimation(parent: _checkCtrl, curve: Curves.easeOutCubic);
    _fadeAnim =
        CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);

    _circleCtrl.forward().then((_) {
      _checkCtrl.forward().then((_) {
        _fadeCtrl.forward();
      });
    });
  }

  @override
  void dispose() {
    _circleCtrl.dispose();
    _checkCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated circle + check
                ScaleTransition(
                  scale: _circleAnim,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.15),
                          border: Border.all(
                              color: AppColors.primary.withOpacity(0.4),
                              width: 2),
                        ),
                      ),
                      ScaleTransition(
                        scale: _checkAnim,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                          child: const Icon(Icons.check,
                              color: AppColors.backgroundDark, size: 40),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    children: [
                      Text('Welcome to UHA!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Colors.white)),
                      const SizedBox(height: 8),
                      Text('Your Unified Health Account is ready.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.6))),
                      const SizedBox(height: 36),
                      // UHAID card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: AppColors.primary.withOpacity(0.3)),
                        ),
                        child: Column(
                          children: [
                            Text('YOUR UHA ID',
                                style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                    letterSpacing: 2)),
                            const SizedBox(height: 10),
                            Text(widget.uhaid,
                                style: GoogleFonts.inter(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 4)),
                            const SizedBox(height: 6),
                            Text(widget.name,
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.6))),
                            const SizedBox(height: 16),
                            Container(
                              height: 1,
                              color: Colors.white.withOpacity(0.08),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                const Icon(Icons.lock_outline,
                                    size: 14,
                                    color: AppColors.primary),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Save this ID — you\'ll use it to access all UHA services.',
                                    style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: Colors.white.withOpacity(0.5)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // What's next
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("What's next?",
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white.withOpacity(0.7))),
                            const SizedBox(height: 10),
                            ...[
                              'Complete your health profile',
                              'Add your insurance details',
                              'Book your first appointment',
                              'Invite family members',
                            ].map((s) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 8),
                                  child: Row(children: [
                                    const Icon(Icons.arrow_right,
                                        size: 16,
                                        color: AppColors.primary),
                                    const SizedBox(width: 6),
                                    Text(s,
                                        style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: Colors.white
                                                .withOpacity(0.6))),
                                  ]),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      // CTA
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    const PatientDashboard(),
                                transitionsBuilder: (_, a, __, c) =>
                                    FadeTransition(opacity: a, child: c),
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                              ),
                              (r) => r.isFirst,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.backgroundDark,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            textStyle: GoogleFonts.inter(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          child: const Text('Go to Dashboard'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).popUntil((r) => r.isFirst),
                        child: Text('Return to Home',
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.4))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
