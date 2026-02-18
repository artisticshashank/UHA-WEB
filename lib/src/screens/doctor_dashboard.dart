import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'consultation_screen.dart';

// ── Data ─────────────────────────────────────────────────────────────────────

class _Appt {
  final String time;
  final String name;
  final String id;
  final String initials;
  final Color avatarColor;
  final int age;
  final String reason;
  const _Appt({
    required this.time,
    required this.name,
    required this.id,
    required this.initials,
    required this.avatarColor,
    required this.age,
    required this.reason,
  });
}

const _appointments = [
  _Appt(
    time: '09:00 AM',
    name: 'Jane Cooper',
    id: 'ID: #PT-9012',
    initials: 'JC',
    avatarColor: Color(0xFF7C3AED),
    age: 28,
    reason: 'Chronic Migraine',
  ),
  _Appt(
    time: '10:15 AM',
    name: 'Robert Fox',
    id: 'ID: #PT-8821',
    initials: 'RF',
    avatarColor: Color(0xFF2563EB),
    age: 45,
    reason: 'Post-op Follow up',
  ),
  _Appt(
    time: '11:00 AM',
    name: 'Cody Fisher',
    id: 'ID: #PT-1102',
    initials: 'CF',
    avatarColor: Color(0xFFD97706),
    age: 32,
    reason: 'Routine Checkup',
  ),
  _Appt(
    time: '12:30 PM',
    name: 'Leslie Williams',
    id: 'ID: #PT-2051',
    initials: 'LW',
    avatarColor: Color(0xFF0D9488),
    age: 37,
    reason: 'Hypertension Study',
  ),
];

class _NavDef {
  final IconData icon;
  final String label;
  const _NavDef(this.icon, this.label);
}

// ── Main Widget ───────────────────────────────────────────────────────────────

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});
  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int _nav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Row(
        children: [
          _Sidebar(selected: _nav, onSelect: (i) => setState(() => _nav = i)),
          Expanded(
            child: Column(
              children: [
                const _TopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(child: _SchedulePanel()),
                        SizedBox(width: 24),
                        SizedBox(width: 272, child: _AtAGlancePanel()),
                      ],
                    ),
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

// ── Sidebar ───────────────────────────────────────────────────────────────────

class _Sidebar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  const _Sidebar({required this.selected, required this.onSelect});

  static const _items = [
    _NavDef(Icons.calendar_today_outlined, 'Schedule'),
    _NavDef(Icons.people_outline, 'Patients'),
    _NavDef(Icons.videocam_outlined, 'Consultations'),
    _NavDef(Icons.description_outlined, 'Reports'),
    _NavDef(Icons.settings_outlined, 'Settings'),
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Row(
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
                  'UHA Portal',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.slate900,
                  ),
                ),
              ],
            ),
          ),
          // Nav
          ...List.generate(
            _items.length,
            (i) => _SidebarItem(
              item: _items[i],
              selected: i == selected,
              onTap: () => onSelect(i),
            ),
          ),
          const Spacer(),
          // Doctor card
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.slate100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.primary),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'ON DUTY',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: AppColors.emerald700,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.slate200,
                      child: const Icon(Icons.person,
                          size: 18, color: AppColors.slate600),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Dr. Alexander Smith',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).popUntil((r) => r.isFirst),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.slate700,
                      side: const BorderSide(color: AppColors.slate200),
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      textStyle: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Sign Out'),
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

class _SidebarItem extends StatefulWidget {
  final _NavDef item;
  final bool selected;
  final VoidCallback onTap;
  const _SidebarItem(
      {required this.item, required this.selected, required this.onTap});
  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
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

class _TopBar extends StatelessWidget {
  const _TopBar();
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
            width: 420,
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
                  'Search patient records, reports or ID...',
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
          const SizedBox(width: 16),
          // Date
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Current Date',
                  style: GoogleFonts.inter(
                      fontSize: 10, color: AppColors.slate400)),
              Text('Monday, Oct 23',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate800,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Schedule Panel ────────────────────────────────────────────────────────────

class _SchedulePanel extends StatelessWidget {
  const _SchedulePanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Schedule",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.slate900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'You have 12 appointments scheduled for today.',
                      style: GoogleFonts.inter(
                          fontSize: 13, color: AppColors.slate500),
                    ),
                  ],
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.tune, size: 15),
                  label: const Text('Filter'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.slate700,
                    side: const BorderSide(color: AppColors.slate200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('New Appointment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.backgroundDark,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Table header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.slate50,
              border: Border(
                top: BorderSide(color: AppColors.slate100),
                bottom: BorderSide(color: AppColors.slate100),
              ),
            ),
            child: Row(
              children: [
                _th('TIME', flex: 14),
                _th('PATIENT NAME', flex: 28),
                _th('AGE', flex: 8),
                _th('REASON', flex: 20),
                _th('ACTION', flex: 30),
              ],
            ),
          ),
          ..._appointments.map((a) => _ApptRow(appt: a)),
          // View all
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All Appointments',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down,
                        size: 18, color: AppColors.slate400),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _th(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.slate400,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _ApptRow extends StatefulWidget {
  final _Appt appt;
  const _ApptRow({required this.appt});
  @override
  State<_ApptRow> createState() => _ApptRowState();
}

class _ApptRowState extends State<_ApptRow> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final a = widget.appt;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: _hover ? AppColors.slate50 : Colors.white,
          border: const Border(
              bottom: BorderSide(color: AppColors.slate100)),
        ),
        child: Row(
          children: [
            // Time
            Expanded(
              flex: 14,
              child: Text(
                a.time,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate700,
                ),
              ),
            ),
            // Patient
            Expanded(
              flex: 28,
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: a.avatarColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        a.initials,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.name,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate800,
                          )),
                      Text(a.id,
                          style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppColors.slate400)),
                    ],
                  ),
                ],
              ),
            ),
            // Age
            Expanded(
              flex: 8,
              child: Text('${a.age}',
                  style: GoogleFonts.inter(
                      fontSize: 13, color: AppColors.slate600)),
            ),
            // Reason
            Expanded(
              flex: 20,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.slate100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    a.reason,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.slate600,
                    ),
                  ),
                ),
              ),
            ),
            // Action
            Expanded(
              flex: 30,
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => ConsultationScreen(
                        patientName: a.name,
                        patientId: a.id,
                        patientInitials: a.initials,
                        patientColor: a.avatarColor,
                        reason: a.reason,
                        isDoctor: true,
                      ),
                      transitionsBuilder: (_, anim, __, c) =>
                          FadeTransition(opacity: anim, child: c),
                      transitionDuration:
                          const Duration(milliseconds: 300),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.backgroundDark,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    textStyle: GoogleFonts.inter(
                        fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  child: const Text('Start Virtual Consultation'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── At a Glance Panel ─────────────────────────────────────────────────────────

class _AtAGlancePanel extends StatelessWidget {
  const _AtAGlancePanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'At a Glance',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.slate900,
          ),
        ),
        const SizedBox(height: 16),
        // Total Patients
        _StatCard(
          label: 'TOTAL PATIENTS',
          value: '12',
          badge: '↑ +20%',
          badgeBg: AppColors.primary.withOpacity(0.12),
          badgeFg: AppColors.emerald700,
          subtitle: 'Compared to last Monday',
          icon: Icons.people_alt_outlined,
          iconColor: AppColors.primary,
        ),
        const SizedBox(height: 12),
        // Pending Reports
        _StatCard(
          label: 'PENDING REPORTS',
          value: '4',
          badge: 'Action Needed',
          badgeBg: const Color(0xFFFEF3C7),
          badgeFg: const Color(0xFFD97706),
          subtitle: 'Critical approvals required',
          icon: Icons.assignment_late_outlined,
          iconColor: const Color(0xFFD97706),
        ),
        const SizedBox(height: 12),
        // UP NEXT card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UP NEXT',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.backgroundDark.withOpacity(0.65),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 2),
                    ),
                    child:
                        const Icon(Icons.person, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jane Cooper',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.backgroundDark,
                        ),
                      ),
                      Text(
                        'Starting in 4 mins',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.backgroundDark.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const ConsultationScreen(
                        patientName: 'Jane Cooper',
                        patientId: 'ID: #PT-9012',
                        patientInitials: 'JC',
                        patientColor: Color(0xFF7C3AED),
                        reason: 'Chronic Migraine',
                        isDoctor: true,
                      ),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                      transitionDuration:
                          const Duration(milliseconds: 300),
                    ));
                  },
                  icon: const Icon(Icons.videocam, size: 16),
                  label: const Text('Launch Call'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundDark,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Activity
        Container(
          padding: const EdgeInsets.all(16),
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
                  Text('ACTIVITY',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate400,
                        letterSpacing: 1,
                      )),
                  Text('HISTORY',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      )),
                ],
              ),
              const SizedBox(height: 12),
              _Activity(
                title: 'New Patient Registered',
                sub: 'Sarah Connor  •  20m ago',
              ),
              const SizedBox(height: 10),
              _Activity(
                title: 'Report Uploaded',
                sub: 'Lab Results  •  PT-9012  •  1m ago',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String badge;
  final Color badgeBg;
  final Color badgeFg;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.badge,
    required this.badgeBg,
    required this.badgeFg,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Text(label,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate400,
                    letterSpacing: 0.6,
                  )),
              Icon(icon, size: 20, color: iconColor),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(value,
                  style: GoogleFonts.inter(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: AppColors.slate900,
                  )),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(badge,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: badgeFg,
                    )),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(subtitle,
              style:
                  GoogleFonts.inter(fontSize: 12, color: AppColors.slate400)),
        ],
      ),
    );
  }
}

class _Activity extends StatelessWidget {
  final String title;
  final String sub;
  const _Activity({required this.title, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.primary, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.slate800,
              )),
          Text(sub,
              style:
                  GoogleFonts.inter(fontSize: 11, color: AppColors.slate400)),
        ],
      ),
    );
  }
}
