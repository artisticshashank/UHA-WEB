import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import 'registration_success_page.dart';

class CreateUhaIdPage extends StatefulWidget {
  const CreateUhaIdPage({super.key});

  @override
  State<CreateUhaIdPage> createState() => _CreateUhaIdPageState();
}

class _CreateUhaIdPageState extends State<CreateUhaIdPage> {
  // Form controllers
  final _fullNameCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _nationalIdCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  DateTime? _dob;
  String _gender = '';
  String _idType = 'National ID';
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  // Password requirements
  bool get _has8Chars => _passwordCtrl.text.length >= 8;
  bool get _hasNumber => _passwordCtrl.text.contains(RegExp(r'[0-9]'));
  bool get _hasUpper => _passwordCtrl.text.contains(RegExp(r'[A-Z]'));
  bool get _hasSpecial => _passwordCtrl.text.contains(RegExp(r'[!@#\$%^&*]'));

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _mobileCtrl.dispose();
    _emailCtrl.dispose();
    _nationalIdCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F5),
      body: Column(
        children: [
          _TopBar(),
          Expanded(
            child: ScreenTypeLayout.builder(
              desktop: (_) => _DesktopLayout(state: this),
              tablet: (_) => _DesktopLayout(state: this),
              mobile: (_) => _MobileLayout(state: this),
            ),
          ),
          _BottomFooter(),
        ],
      ),
    );
  }
}

// ─────────────────────────── Top Bar ─────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shield_outlined,
                    color: AppColors.backgroundDark, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                'UHA Digital',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Nav links
          ScreenTypeLayout.builder(
            mobile: (_) => const SizedBox.shrink(),
            tablet: (_) => _navLinks(context),
            desktop: (_) => _navLinks(context),
          ),
        ],
      ),
    );
  }

  Widget _navLinks(BuildContext context) {
    return Row(
      children: [
        _navLink('How it works'),
        const SizedBox(width: 28),
        _navLink('Security'),
        const SizedBox(width: 28),
        _navLink('Support'),
        const SizedBox(width: 24),
        Container(width: 1, height: 20, color: AppColors.slate200),
        const SizedBox(width: 24),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(fontSize: 13, color: AppColors.slate600),
                children: [
                  const TextSpan(text: 'Already have an ID? '),
                  TextSpan(
                    text: 'Login',
                    style: GoogleFonts.inter(
                      fontSize: 13,
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
    );
  }

  Widget _navLink(String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(
        text,
        style: GoogleFonts.inter(
            fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.slate600),
      ),
    );
  }
}

// ─────────────────────────── Desktop Layout ──────────────────────────────────
class _DesktopLayout extends StatelessWidget {
  final _CreateUhaIdPageState state;
  const _DesktopLayout({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left panel
        SizedBox(
          width: 320,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: _LeftPanel(),
          ),
        ),
        // Right form
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
            child: _FormPanel(state: state),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────── Mobile Layout ───────────────────────────────────
class _MobileLayout extends StatelessWidget {
  final _CreateUhaIdPageState state;
  const _MobileLayout({required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _LeftPanel(),
          const SizedBox(height: 24),
          _FormPanel(state: state),
        ],
      ),
    );
  }
}

// ─────────────────────────── Left Panel ──────────────────────────────────────
class _LeftPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Text(
            'JOIN THE NETWORK',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.emerald700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Headline
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: AppColors.slate900,
              height: 1.2,
            ),
            children: const [
              TextSpan(text: 'Your health data,\n'),
              TextSpan(
                text: 'unified & secure.',
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'The Universal Health ID (UHA) connects your medical records across clinics, pharmacies, and labs instantly.',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.slate600,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        // Feature cards
        _FeatureCard(
          icon: Icons.lock_outline,
          iconBg: AppColors.primary.withOpacity(0.1),
          iconColor: AppColors.primary,
          title: 'End-to-End Encrypted',
          subtitle: 'Only you and authorized doctors can access your medical history.',
        ),
        const SizedBox(height: 12),
        _FeatureCard(
          icon: Icons.receipt_long_outlined,
          iconBg: AppColors.slate100,
          iconColor: AppColors.slate600,
          title: 'Lifetime Health Record',
          subtitle: 'Keep track of prescriptions, reports, and vaccines from birth.',
        ),
        const SizedBox(height: 28),
        // Testimonial
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"UHA has transformed how I manage my family\'s health documents. No more lost prescriptions!"',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: const Icon(Icons.person, size: 20, color: AppColors.backgroundDark),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sarah Jenkins',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'UHA Member since 2023',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _FeatureCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.slate500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Form Panel ──────────────────────────────────────
class _FormPanel extends StatefulWidget {
  final _CreateUhaIdPageState state;
  const _FormPanel({required this.state});

  @override
  State<_FormPanel> createState() => _FormPanelState();
}

class _FormPanelState extends State<_FormPanel> {
  _CreateUhaIdPageState get s => widget.state;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      widget.state.setState(() => widget.state._dob = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create your UHA ID',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.slate900,
                  ),
                ),
                Text(
                  'Step 1 of 4',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          // Progress bar
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 12, 28, 0),
            child: _ProgressBar(step: 1, total: 4),
          ),
          const SizedBox(height: 28),
          // ── Personal Details ──
          _SectionHeader(icon: Icons.person_outline, label: 'PERSONAL DETAILS'),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 28, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FormLabel('Full Legal Name'),
                const SizedBox(height: 6),
                _InputBox(
                  controller: s._fullNameCtrl,
                  hint: 'As per your National ID',
                ),
                const SizedBox(height: 16),
                LayoutBuilder(builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 500;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('Date of Birth'),
                              const SizedBox(height: 6),
                              _DatePickerBox(
                                value: s._dob,
                                onTap: _pickDate,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('Gender'),
                              const SizedBox(height: 6),
                              _DropdownBox(
                                value: s._gender.isEmpty ? null : s._gender,
                                items: const ['Male', 'Female', 'Other', 'Prefer not to say'],
                                hint: 'Select Gender',
                                onChanged: (v) => widget.state.setState(() => widget.state._gender = v ?? ''),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FormLabel('Date of Birth'),
                      const SizedBox(height: 6),
                      _DatePickerBox(value: s._dob, onTap: _pickDate),
                      const SizedBox(height: 16),
                      _FormLabel('Gender'),
                      const SizedBox(height: 6),
                      _DropdownBox(
                        value: s._gender.isEmpty ? null : s._gender,
                        items: const ['Male', 'Female', 'Other', 'Prefer not to say'],
                        hint: 'Select Gender',
                        onChanged: (v) => widget.state.setState(() => widget.state._gender = v ?? ''),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // ── Contact Information ──
          _SectionHeader(icon: Icons.phone_outlined, label: 'CONTACT INFORMATION'),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 28, 0),
            child: LayoutBuilder(builder: (context, constraints) {
              final isWide = constraints.maxWidth > 500;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FormLabel('Mobile Number'),
                          const SizedBox(height: 6),
                          _PhoneInputBox(controller: s._mobileCtrl),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FormLabel('Email Address'),
                          const SizedBox(height: 6),
                          _InputBox(
                            controller: s._emailCtrl,
                            hint: 'john@example.com',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FormLabel('Mobile Number'),
                  const SizedBox(height: 6),
                  _PhoneInputBox(controller: s._mobileCtrl),
                  const SizedBox(height: 16),
                  _FormLabel('Email Address'),
                  const SizedBox(height: 6),
                  _InputBox(
                    controller: s._emailCtrl,
                    hint: 'john@example.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 24),
          // ── Identity Verification ──
          _SectionHeader(icon: Icons.badge_outlined, label: 'IDENTITY VERIFICATION'),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 28, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                        child: Text(
                          'Select ID Type',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.slate500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: _IdTypeButton(
                                icon: Icons.credit_card_outlined,
                                label: 'National ID',
                                selected: s._idType == 'National ID',
                                onTap: () => widget.state.setState(() => widget.state._idType = 'National ID'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _IdTypeButton(
                                icon: Icons.fingerprint,
                                label: 'Aadhaar',
                                selected: s._idType == 'Aadhaar',
                                onTap: () => widget.state.setState(() => widget.state._idType = 'Aadhaar'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _FormLabel('${s._idType} Number'),
                const SizedBox(height: 6),
                _InputBox(
                  controller: s._nationalIdCtrl,
                  hint: 'XXXX-XXXX-XXXX',
                  suffixIcon: const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // ── Account Security ──
          _SectionHeader(icon: Icons.lock_outline, label: 'ACCOUNT SECURITY'),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 28, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 500;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('Create Password'),
                              const SizedBox(height: 6),
                              _PasswordBox(
                                controller: s._passwordCtrl,
                                obscure: s._obscurePass,
                                onToggle: () => widget.state.setState(() => widget.state._obscurePass = !widget.state._obscurePass),
                                onChanged: (_) => widget.state.setState(() {}),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('Confirm Password'),
                              const SizedBox(height: 6),
                              _PasswordBox(
                                controller: s._confirmPasswordCtrl,
                                obscure: s._obscureConfirm,
                                onToggle: () => widget.state.setState(() => widget.state._obscureConfirm = !widget.state._obscureConfirm),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FormLabel('Create Password'),
                      const SizedBox(height: 6),
                      _PasswordBox(
                        controller: s._passwordCtrl,
                        obscure: s._obscurePass,
                        onToggle: () => widget.state.setState(() => widget.state._obscurePass = !widget.state._obscurePass),
                        onChanged: (_) => widget.state.setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      _FormLabel('Confirm Password'),
                      const SizedBox(height: 6),
                      _PasswordBox(
                        controller: s._confirmPasswordCtrl,
                        obscure: s._obscureConfirm,
                        onToggle: () => widget.state.setState(() => widget.state._obscureConfirm = !widget.state._obscureConfirm),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 14),
                // Password requirements
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.slate50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.slate100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password Requirements:',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 24,
                        runSpacing: 6,
                        children: [
                          _ReqItem(met: s._has8Chars, label: '8+ Characters'),
                          _ReqItem(met: s._hasUpper, label: '1 Upper Case'),
                          _ReqItem(met: s._hasNumber, label: '1 Number'),
                          _ReqItem(met: s._hasSpecial, label: '1 Special Char'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // ── Submit Button ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        const RegistrationSuccessPage(
                      uhaid: 'UHA-2024-881001',
                      name: 'New Member',
                    ),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                    transitionDuration:
                        const Duration(milliseconds: 400),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.backgroundDark,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create my UHA ID',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.inter(fontSize: 12, color: AppColors.slate500),
                  children: [
                    const TextSpan(text: 'By clicking create, you agree to our '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Progress Bar ────────────────────────────────────
class _ProgressBar extends StatelessWidget {
  final int step;
  final int total;
  const _ProgressBar({required this.step, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final active = i < step;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < total - 1 ? 6 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : AppColors.slate200,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────── Section Header ──────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionHeader({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.slate100),
          bottom: BorderSide(color: AppColors.slate100),
        ),
        color: AppColors.slate50,
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: AppColors.slate500),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.slate500,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Form Helpers ────────────────────────────────────
class _FormLabel extends StatelessWidget {
  final String text;
  const _FormLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
          fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.slate700),
    );
  }
}

class _InputBox extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const _InputBox({
    required this.controller,
    required this.hint,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontSize: 14, color: AppColors.slate900),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.slate400),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _PhoneInputBox extends StatelessWidget {
  final TextEditingController controller;
  const _PhoneInputBox({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.slate200),
          ),
          alignment: Alignment.center,
          child: Text('+1',
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.slate700)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _InputBox(controller: controller, hint: '123-456-7890'),
        ),
      ],
    );
  }
}

class _DatePickerBox extends StatelessWidget {
  final DateTime? value;
  final VoidCallback onTap;
  const _DatePickerBox({required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.slate200),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value == null
                    ? 'mm/dd/yyyy'
                    : '${value!.month.toString().padLeft(2, '0')}/${value!.day.toString().padLeft(2, '0')}/${value!.year}',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: value == null ? AppColors.slate400 : AppColors.slate900,
                ),
              ),
            ),
            const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.slate400),
          ],
        ),
      ),
    );
  }
}

class _DropdownBox extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hint;
  final ValueChanged<String?> onChanged;
  const _DropdownBox({required this.value, required this.items, required this.hint, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint, style: GoogleFonts.inter(fontSize: 13, color: AppColors.slate400)),
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: GoogleFonts.inter(fontSize: 13, color: AppColors.slate900)),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _PasswordBox extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;
  final ValueChanged<String>? onChanged;
  const _PasswordBox({required this.controller, required this.obscure, required this.onToggle, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      style: GoogleFonts.inter(fontSize: 14, color: AppColors.slate900),
      decoration: InputDecoration(
        hintText: '••••••••',
        hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.slate400),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.slate400,
            size: 18,
          ),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _IdTypeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _IdTypeButton({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: selected ? Border.all(color: AppColors.primary.withOpacity(0.4)) : null,
          boxShadow: selected
              ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: selected ? AppColors.primary : AppColors.slate500),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? AppColors.slate900 : AppColors.slate500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReqItem extends StatelessWidget {
  final bool met;
  final String label;
  const _ReqItem({required this.met, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          met ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 14,
          color: met ? AppColors.primary : AppColors.slate400,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: met ? AppColors.slate700 : AppColors.slate400,
            fontWeight: met ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────── Bottom Footer ───────────────────────────────────
class _BottomFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Compliance bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.slate100)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ComplianceChip(icon: Icons.shield_outlined, label: 'GOVERNMENT APPROVED'),
                _dot(),
                _ComplianceChip(icon: Icons.lock_outline, label: 'HIPAA COMPLIANT'),
                _dot(),
                _ComplianceChip(icon: Icons.verified_outlined, label: 'ISO 27001 CERTIFIED'),
              ],
            ),
          ),
          // Main footer
          Container(
            color: AppColors.backgroundDark,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
            child: Column(
              children: [
                Row(
                  children: [
                    // Logo
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.shield_outlined,
                              color: AppColors.backgroundDark, size: 18),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'UHA Digital',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Footer links
                    ScreenTypeLayout.builder(
                      mobile: (_) => const SizedBox.shrink(),
                      tablet: (_) => _footerLinks(),
                      desktop: (_) => _footerLinks(),
                    ),
                    const SizedBox(width: 20),
                    const Icon(Icons.language, color: Colors.white54, size: 20),
                    const SizedBox(width: 16),
                    const Icon(Icons.share, color: Colors.white54, size: 20),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white12),
                const SizedBox(height: 12),
                Text(
                  '© 2024 Universal Health Association (UHA). All rights reserved. Secured by NextGen Encryption.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.slate300),
        ),
      );

  Widget _footerLinks() {
    const links = ['About Us', 'Privacy Policy', 'Terms of Use', 'Accessibility', 'Contact'];
    return Row(
      children: links
          .map((l) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(l,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.white60)),
              ))
          .toList(),
    );
  }
}

class _ComplianceChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ComplianceChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.slate500),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.slate500,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}
