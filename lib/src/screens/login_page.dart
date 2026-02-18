import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import 'create_uhaid_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _keepLoggedIn = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScreenTypeLayout.builder(
        desktop: (_) => _DesktopLayout(
          obscurePassword: _obscurePassword,
          keepLoggedIn: _keepLoggedIn,
          emailController: _emailController,
          passwordController: _passwordController,
          onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
          onToggleKeepLoggedIn: (v) => setState(() => _keepLoggedIn = v ?? false),
        ),
        tablet: (_) => _DesktopLayout(
          obscurePassword: _obscurePassword,
          keepLoggedIn: _keepLoggedIn,
          emailController: _emailController,
          passwordController: _passwordController,
          onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
          onToggleKeepLoggedIn: (v) => setState(() => _keepLoggedIn = v ?? false),
        ),
        mobile: (_) => _MobileLayout(
          obscurePassword: _obscurePassword,
          keepLoggedIn: _keepLoggedIn,
          emailController: _emailController,
          passwordController: _passwordController,
          onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
          onToggleKeepLoggedIn: (v) => setState(() => _keepLoggedIn = v ?? false),
        ),
      ),
    );
  }
}

// ─────────────────────────── Desktop Layout ──────────────────────────────────

class _DesktopLayout extends StatelessWidget {
  final bool obscurePassword;
  final bool keepLoggedIn;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onTogglePassword;
  final ValueChanged<bool?> onToggleKeepLoggedIn;

  const _DesktopLayout({
    required this.obscurePassword,
    required this.keepLoggedIn,
    required this.emailController,
    required this.passwordController,
    required this.onTogglePassword,
    required this.onToggleKeepLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Panel — 60%
        Expanded(
          flex: 60,
          child: _LeftPanel(),
        ),
        // Right Panel — 40%
        Expanded(
          flex: 40,
          child: _RightPanel(
            obscurePassword: obscurePassword,
            keepLoggedIn: keepLoggedIn,
            emailController: emailController,
            passwordController: passwordController,
            onTogglePassword: onTogglePassword,
            onToggleKeepLoggedIn: onToggleKeepLoggedIn,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────── Mobile Layout ───────────────────────────────────

class _MobileLayout extends StatelessWidget {
  final bool obscurePassword;
  final bool keepLoggedIn;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onTogglePassword;
  final ValueChanged<bool?> onToggleKeepLoggedIn;

  const _MobileLayout({
    required this.obscurePassword,
    required this.keepLoggedIn,
    required this.emailController,
    required this.passwordController,
    required this.onTogglePassword,
    required this.onToggleKeepLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 200, child: _LeftPanel()),
          _RightPanel(
            obscurePassword: obscurePassword,
            keepLoggedIn: keepLoggedIn,
            emailController: emailController,
            passwordController: passwordController,
            onTogglePassword: onTogglePassword,
            onToggleKeepLoggedIn: onToggleKeepLoggedIn,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Left Panel ──────────────────────────────────────

class _LeftPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.network(
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDAJc730YmsS4jDefsg5k_j3UCVs6T4Qr-NWVcclmo0S6iGX6GuPb8lcFNhN_Kr7lo2PTmig4IHCSFTVblgVgOut7WOZRKEH110fglMRDCLu0iwyI7MtkWeOFRyRQpguJKprtbDxWXt6x74ufZJF4367ktrx4KzDlATLMyRhKLk1mN6glckg018KQ54Xhdla_ppSe8vNtdUXHZ1YErmrUp9lK1FCF04nLizI4KC1U69-GNA6z0yiFk-Z77w-g8FPYTCtPI5GGTF0PU',
          fit: BoxFit.cover,
          loadingBuilder: (ctx, child, progress) {
            if (progress == null) return child;
            return Container(color: AppColors.backgroundDark);
          },
        ),
        // Dark green overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.backgroundDark.withOpacity(0.75),
                AppColors.backgroundDark.withOpacity(0.88),
              ],
            ),
          ),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.medical_services_outlined,
                        color: AppColors.backgroundDark, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'HealthPortal',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Headline — sits in the vertical middle
              const Spacer(),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  children: const [
                    TextSpan(text: 'Secure access to your\n'),
                    TextSpan(
                      text: 'health records ',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    TextSpan(text: 'anytime, anywhere.'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Manage your appointments, view lab results, and connect with your healthcare providers in a single, encrypted dashboard.',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.primary.withOpacity(0.85),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),
              // Trusted by
              Row(
                children: [
                  _AvatarStack(),
                  const SizedBox(width: 12),
                  Text(
                    'Trusted by over 10,000+ medical professionals.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Bottom badges
              Row(
                children: [
                  _ComplianceBadge(
                      icon: Icons.shield_outlined, label: 'HIPAA COMPLIANT'),
                  const SizedBox(width: 8),
                  Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  _ComplianceBadge(
                      icon: Icons.lock_outline,
                      label: '256-BIT AES ENCRYPTION'),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvatarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF6EE7B7),
      const Color(0xFF34D399),
      const Color(0xFF10B981),
    ];
    return SizedBox(
      width: 64,
      height: 36,
      child: Stack(
        children: List.generate(
          3,
          (i) => Positioned(
            left: i * 18.0,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors[i],
                border: Border.all(color: AppColors.backgroundDark, width: 2),
              ),
              child: const Icon(Icons.person, size: 18, color: AppColors.backgroundDark),
            ),
          ),
        ),
      ),
    );
  }
}

class _ComplianceBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ComplianceBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white.withOpacity(0.5)),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.5),
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────── Right Panel (Form) ───────────────────────────────

class _RightPanel extends StatelessWidget {
  final bool obscurePassword;
  final bool keepLoggedIn;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onTogglePassword;
  final ValueChanged<bool?> onToggleKeepLoggedIn;

  const _RightPanel({
    required this.obscurePassword,
    required this.keepLoggedIn,
    required this.emailController,
    required this.passwordController,
    required this.onTogglePassword,
    required this.onToggleKeepLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF6F8F7),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Shield icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shield_outlined,
                        color: AppColors.primary, size: 30),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.slate900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please enter your credentials to access your\nsecure patient dashboard.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.slate500,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Email field
                  _FieldLabel('Email or UHID'),
                  const SizedBox(height: 8),
                  _InputField(
                    controller: emailController,
                    hint: 'e.g. name@hospital.com',
                    prefixIcon: Icons.person_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Password row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _FieldLabel('Password'),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _InputField(
                    controller: passwordController,
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    obscureText: obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.slate400,
                        size: 20,
                      ),
                      onPressed: onTogglePassword,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Keep me logged in
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: keepLoggedIn,
                          onChanged: onToggleKeepLoggedIn,
                          activeColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          side: const BorderSide(color: AppColors.slate300),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Keep me logged in for 30 days',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.slate600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Sign In button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const SizedBox.shrink(),
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Secure Sign In',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.backgroundDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // OR divider
                  Row(
                    children: [
                      const Expanded(child: Divider(color: AppColors.slate200)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR CONTINUE WITH',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate400,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: AppColors.slate200)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Google button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.slate700,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: AppColors.slate200),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _GoogleIcon(),
                          const SizedBox(width: 10),
                          Text(
                            'Sign in with Google',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Sign up link
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const CreateUhaIdPage(),
                          transitionsBuilder: (_, animation, __, child) =>
                              FadeTransition(opacity: animation, child: child),
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(
                              fontSize: 14, color: AppColors.slate500),
                          children: [
                            const TextSpan(text: "Don't have an account yet?  "),
                            TextSpan(
                              text: 'Create UHID',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────── Reusable Widgets ────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.slate700,
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontSize: 14, color: AppColors.slate900),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.slate400),
        prefixIcon: Icon(prefixIcon, color: AppColors.slate400, size: 18),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw colored arcs approximating the Google logo colors
    final colors = [
      const Color(0xFF4285F4), // Blue
      const Color(0xFF34A853), // Green
      const Color(0xFFFBBC05), // Yellow
      const Color(0xFFEA4335), // Red
    ];

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.28;

    for (int i = 0; i < 4; i++) {
      paint.color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.7),
        i * (3.14159 / 2) - 0.3,
        3.14159 / 2 - 0.1,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
