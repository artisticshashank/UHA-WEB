import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'consultation_screen.dart';
import 'patient_appointments_page.dart';
import 'patient_records_page.dart';
import 'patient_meds_page.dart';

// ── Data ─────────────────────────────────────────────────────────────────────

class _PatNavDef {
  final IconData icon;
  final String label;
  const _PatNavDef(this.icon, this.label);
}

class _LabResult {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String name;
  final String date;
  final String status; // 'Normal' | 'Borderline' | 'Critical'
  const _LabResult(
      {required this.icon,
      required this.iconBg,
      required this.iconColor,
      required this.name,
      required this.date,
      required this.status});
}

const _labResults = [
  _LabResult(
    icon: Icons.science_outlined,
    iconBg: Color(0xFFE0F2FE),
    iconColor: Color(0xFF0284C7),
    name: 'Complete Blood Count',
    date: 'Oct 12, 2023',
    status: 'Normal',
  ),
  _LabResult(
    icon: Icons.water_drop_outlined,
    iconBg: Color(0xFFDCFCE7),
    iconColor: Color(0xFF16A34A),
    name: 'Lipid Panel',
    date: 'Oct 05, 2023',
    status: 'Normal',
  ),
  _LabResult(
    icon: Icons.bloodtype_outlined,
    iconBg: Color(0xFFFEF9C3),
    iconColor: Color(0xFFCA8A04),
    name: 'Glucose Level',
    date: 'Sep 28, 2023',
    status: 'Borderline',
  ),
];

const _hrData = [70.0, 72.0, 75.0, 73.0, 71.0, 74.0, 76.0, 72.0, 70.0, 73.0, 74.0, 72.0];
const _spo2Data = [97.8, 98.0, 98.2, 98.0, 98.3, 98.1, 98.2, 98.0, 98.1, 98.2, 98.0, 98.0];

// ── Main Widget ───────────────────────────────────────────────────────────────

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});
  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  int _nav = 0;

  static const _navItems = [
    _PatNavDef(Icons.grid_view_rounded, 'Home'),
    _PatNavDef(Icons.calendar_today_outlined, 'Appointments'),
    _PatNavDef(Icons.folder_outlined, 'Records'),
    _PatNavDef(Icons.medication_outlined, 'Meds'),
    _PatNavDef(Icons.show_chart, 'Vitals'),
    _PatNavDef(Icons.person_outline, 'Profile'),
  ];

  void _handleNav(int i) {
    switch (i) {
      case 1:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PatientAppointmentsPage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: const Duration(milliseconds: 250),
        ));
        break;
      case 2:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PatientRecordsPage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: const Duration(milliseconds: 250),
        ));
        break;
      case 3:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PatientMedsPage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: const Duration(milliseconds: 250),
        ));
        break;
      default:
        setState(() => _nav = i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Row(
        children: [
          _PatientSidebar(
              selected: _nav, onSelect: _handleNav),
          Expanded(
            child: Column(
              children: [
                const _PatientTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
                    child: _HomeContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  static List<_PatNavDef> get items => _navItems;
}

// ── Sidebar ───────────────────────────────────────────────────────────────────

class _PatientSidebar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  const _PatientSidebar({required this.selected, required this.onSelect});

  static const _items = [
    _PatNavDef(Icons.grid_view_rounded, 'Home'),
    _PatNavDef(Icons.calendar_today_outlined, 'Appointments'),
    _PatNavDef(Icons.folder_outlined, 'Records'),
    _PatNavDef(Icons.medication_outlined, 'Meds'),
    _PatNavDef(Icons.show_chart, 'Vitals'),
    _PatNavDef(Icons.person_outline, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 184,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppColors.slate100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add,
                      color: AppColors.backgroundDark, size: 22),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UHA Hub',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.slate900,
                      ),
                    ),
                    Text(
                      'PATIENT PORTAL',
                      style: GoogleFonts.inter(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Nav
          ...List.generate(
            _items.length,
            (i) => _PatNavItem(
              item: _items[i],
              selected: i == selected,
              onTap: () => onSelect(i),
            ),
          ),
          const Spacer(),
          // User info
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.slate200,
                  child: Text(
                    'R',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.slate600,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rose Miller',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate800,
                        ),
                      ),
                      Text(
                        'rose.m@example.com',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: AppColors.slate400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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

class _PatNavItem extends StatefulWidget {
  final _PatNavDef item;
  final bool selected;
  final VoidCallback onTap;
  const _PatNavItem(
      {required this.item, required this.selected, required this.onTap});
  @override
  State<_PatNavItem> createState() => _PatNavItemState();
}

class _PatNavItemState extends State<_PatNavItem> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: widget.selected
                ? AppColors.primary.withOpacity(0.12)
                : _hover
                    ? AppColors.slate50
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(widget.item.icon,
                  size: 18,
                  color: widget.selected
                      ? AppColors.emerald700
                      : AppColors.slate500),
              const SizedBox(width: 10),
              Text(
                widget.item.label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight:
                      widget.selected ? FontWeight.w700 : FontWeight.w500,
                  color: widget.selected
                      ? AppColors.emerald700
                      : AppColors.slate600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Top Bar ───────────────────────────────────────────────────────────────────

class _PatientTopBar extends StatelessWidget {
  const _PatientTopBar();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.slate100)),
      ),
      child: Row(
        children: [
          // Search
          Container(
            height: 38,
            width: 380,
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.slate200),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const Icon(Icons.search, size: 16, color: AppColors.slate400),
                const SizedBox(width: 8),
                Text(
                  'Search records, doctors, or results...',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: AppColors.slate400),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Bell
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.slate200),
            ),
            child: const Icon(Icons.notifications_outlined,
                size: 18, color: AppColors.slate600),
          ),
          const SizedBox(width: 10),
          // Settings
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.slate200),
            ),
            child: const Icon(Icons.settings_outlined,
                size: 18, color: AppColors.slate600),
          ),
          const SizedBox(width: 16),
          // Date
          Row(
            children: [
              Text('Today, 24 Oct',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate800,
                  )),
              const SizedBox(width: 6),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.slate50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: const Icon(Icons.calendar_month_outlined,
                    size: 14, color: AppColors.slate500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Home Content ──────────────────────────────────────────────────────────────

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome header
        Text(
          'Welcome back, Rose',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.slate900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Here's a quick look at your health profile for today.",
          style: GoogleFonts.inter(fontSize: 14, color: AppColors.slate500),
        ),
        const SizedBox(height: 24),
        // Top row: AI Summary + Next Appointment
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 640) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 5, child: _AiSummaryCard()),
                const SizedBox(width: 20),
                const SizedBox(width: 240, child: _NextAppointmentCard()),
              ],
            );
          }
          return const Column(
            children: [
              _AiSummaryCard(),
              SizedBox(height: 16),
              _NextAppointmentCard(),
            ],
          );
        }),
        const SizedBox(height: 20),
        // Bottom row: Vitals + Lab Results
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 640) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 5,
                    child: _VitalCard(
                      icon: Icons.favorite,
                      iconColor: const Color(0xFFEF4444),
                      label: 'Heart Rate',
                      value: '72',
                      unit: 'BPM',
                      status: 'Normal',
                      statusColor: AppColors.primary,
                      statusIcon: Icons.trending_up,
                      chartData: _hrData,
                      lineColor: const Color(0xFFEF4444),
                      fillColor: const Color(0xFFEF4444),
                    )),
                const SizedBox(width: 16),
                Expanded(
                    flex: 5,
                    child: _VitalCard(
                      icon: Icons.water_drop,
                      iconColor: const Color(0xFF2563EB),
                      label: 'SpO2',
                      value: '98',
                      unit: '%',
                      status: 'Optimal',
                      statusColor: AppColors.primary,
                      statusIcon: Icons.check_circle_outline,
                      chartData: _spo2Data,
                      lineColor: const Color(0xFF2563EB),
                      fillColor: const Color(0xFF2563EB),
                    )),
                const SizedBox(width: 16),
                const Expanded(flex: 7, child: _LabResultsCard()),
              ],
            );
          }
          return const Column(
            children: [
              _VitalCard(
                icon: Icons.favorite,
                iconColor: Color(0xFFEF4444),
                label: 'Heart Rate',
                value: '72',
                unit: 'BPM',
                status: 'Normal',
                statusColor: AppColors.primary,
                statusIcon: Icons.trending_up,
                chartData: _hrData,
                lineColor: Color(0xFFEF4444),
                fillColor: Color(0xFFEF4444),
              ),
              SizedBox(height: 16),
              _VitalCard(
                icon: Icons.water_drop,
                iconColor: Color(0xFF2563EB),
                label: 'SpO2',
                value: '98',
                unit: '%',
                status: 'Optimal',
                statusColor: AppColors.primary,
                statusIcon: Icons.check_circle_outline,
                chartData: _spo2Data,
                lineColor: Color(0xFF2563EB),
                fillColor: Color(0xFF2563EB),
              ),
              SizedBox(height: 16),
              _LabResultsCard(),
            ],
          );
        }),
      ],
    );
  }
}

// ── AI Summary Card ───────────────────────────────────────────────────────────

class _AiSummaryCard extends StatelessWidget {
  const _AiSummaryCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_awesome,
                color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'AI Health Summary',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.slate900,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.backgroundDark,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'LIVE',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppColors.backgroundDark,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Your vitals have been stable over the last 7 days. Your sleep cycle shows a 12% improvement in REM stages. Your next medication refill for Lisinopril is due in 3 days.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.slate600,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 12),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Full Report',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward,
                          size: 14, color: AppColors.primary),
                    ],
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

// ── Next Appointment Card ─────────────────────────────────────────────────────

class _NextAppointmentCard extends StatelessWidget {
  const _NextAppointmentCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NEXT APPOINTMENT',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.backgroundDark.withOpacity(0.6),
                  letterSpacing: 1,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.calendar_month_outlined,
                    size: 16, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                'Dr. Smith',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.backgroundDark,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward,
                  size: 18, color: AppColors.backgroundDark),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            'Cardiology Consultation',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.backgroundDark.withOpacity(0.65),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.access_time,
                  size: 14, color: AppColors.backgroundDark),
              const SizedBox(width: 5),
              Text(
                'Tomorrow, 10:30 AM',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.backgroundDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const ConsultationScreen(
                        patientName: 'Rose Miller',
                        patientId: 'PT-9012',
                        patientInitials: 'RM',
                        patientColor: Color(0xFF2563EB),
                        reason: 'Cardiac Check',
                        isDoctor: false,
                      ),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                      transitionDuration:
                          const Duration(milliseconds: 300),
                    ));
                  },
                  icon: const Icon(Icons.videocam, size: 14),
                  label: const Text('Join Call'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundDark,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: GoogleFonts.inter(
                        fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.location_on_outlined,
                    size: 18, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Vital Card ────────────────────────────────────────────────────────────────

class _VitalCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String unit;
  final String status;
  final Color statusColor;
  final IconData statusIcon;
  final List<double> chartData;
  final Color lineColor;
  final Color fillColor;

  const _VitalCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.unit,
    required this.status,
    required this.statusColor,
    required this.statusIcon,
    required this.chartData,
    required this.lineColor,
    required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 22, color: iconColor),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 12, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 13, color: AppColors.slate500),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: AppColors.slate900,
                  height: 1,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.slate400,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 56,
            child: CustomPaint(
              painter: _SparklinePainter(
                data: chartData,
                lineColor: lineColor,
                fillColor: fillColor.withOpacity(0.1),
              ),
              size: Size.infinite,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Lab Results Card ──────────────────────────────────────────────────────────

class _LabResultsCard extends StatelessWidget {
  const _LabResultsCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Lab Results',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900,
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  'See All',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ..._labResults.map((r) => _LabRow(result: r)),
        ],
      ),
    );
  }
}

class _LabRow extends StatefulWidget {
  final _LabResult result;
  const _LabRow({required this.result});
  @override
  State<_LabRow> createState() => _LabRowState();
}

class _LabRowState extends State<_LabRow> {
  bool _hover = false;

  Color get _badgeBg {
    switch (widget.result.status) {
      case 'Normal':
        return const Color(0xFFDCFCE7);
      case 'Borderline':
        return const Color(0xFFFEF9C3);
      case 'Critical':
        return const Color(0xFFFEE2E2);
      default:
        return AppColors.slate100;
    }
  }

  Color get _badgeFg {
    switch (widget.result.status) {
      case 'Normal':
        return const Color(0xFF16A34A);
      case 'Borderline':
        return const Color(0xFFCA8A04);
      case 'Critical':
        return const Color(0xFFDC2626);
      default:
        return AppColors.slate600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.result;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _hover ? AppColors.slate50 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.slate100),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: r.iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(r.icon, size: 18, color: r.iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.name,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate800,
                      )),
                  Text(r.date,
                      style: GoogleFonts.inter(
                          fontSize: 11, color: AppColors.slate400)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _badgeBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(r.status,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _badgeFg,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Sparkline Painter ─────────────────────────────────────────────────────────

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final Color fillColor;

  const _SparklinePainter({
    required this.data,
    required this.lineColor,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final minVal = data.reduce(min);
    final maxVal = data.reduce(max);
    final range = maxVal == minVal ? 1.0 : maxVal - minVal;
    final yPad = size.height * 0.12;

    double norm(double v) =>
        size.height - yPad - ((v - minVal) / range) * (size.height - yPad * 2);

    final linePath = Path();
    final fillPath = Path();

    for (int i = 0; i < data.length; i++) {
      final x = i / (data.length - 1) * size.width;
      final y = norm(data[i]);

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        final prevX = (i - 1) / (data.length - 1) * size.width;
        final prevY = norm(data[i - 1]);
        final cpX = (prevX + x) / 2;
        linePath.cubicTo(cpX, prevY, cpX, y, x, y);
        fillPath.cubicTo(cpX, prevY, cpX, y, x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(
        fillPath,
        Paint()
          ..color = fillColor
          ..style = PaintingStyle.fill);

    canvas.drawPath(
        linePath,
        Paint()
          ..color = lineColor
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter old) =>
      old.data != data || old.lineColor != lineColor;
}
