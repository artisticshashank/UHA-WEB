import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'consultation_screen.dart';

class PatientDetailScreen extends StatefulWidget {
  final String name;
  final String id;
  final String initials;
  final Color avatarColor;
  final String reason;
  final String time;

  const PatientDetailScreen({
    super.key,
    required this.name,
    required this.id,
    required this.initials,
    required this.avatarColor,
    required this.reason,
    required this.time,
  });

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: AppColors.slate700),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Patient Profile',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.slate900)),
        actions: [
          ElevatedButton.icon(
            onPressed: _launchConsultation,
            icon: const Icon(Icons.videocam_outlined, size: 16),
            label: const Text('Start Consultation'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.backgroundDark,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textStyle: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 20),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: AppColors.slate100))),
            child: TabBar(
              controller: _tabs,
              labelStyle: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w700),
              unselectedLabelStyle:
                  GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.slate500,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Vitals'),
                Tab(text: 'History'),
                Tab(text: 'Reports'),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _PatientHeader(
            name: widget.name,
            id: widget.id,
            initials: widget.initials,
            avatarColor: widget.avatarColor,
            reason: widget.reason,
            time: widget.time,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: const [
                _OverviewTab(),
                _VitalsTab(),
                _HistoryTab(),
                _ReportsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchConsultation() {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (_, __, ___) => ConsultationScreen(
        patientName: widget.name,
        patientId: widget.id,
        patientInitials: widget.initials,
        patientColor: widget.avatarColor,
        reason: widget.reason,
        isDoctor: true,
      ),
      transitionsBuilder: (_, a, __, c) =>
          FadeTransition(opacity: a, child: c),
      transitionDuration: const Duration(milliseconds: 300),
    ));
  }
}

// ── Patient Header ────────────────────────────────────────────────────────────

class _PatientHeader extends StatelessWidget {
  final String name;
  final String id;
  final String initials;
  final Color avatarColor;
  final String reason;
  final String time;

  const _PatientHeader({
    required this.name,
    required this.id,
    required this.initials,
    required this.avatarColor,
    required this.reason,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: avatarColor.withOpacity(0.2),
            child: Text(initials,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: avatarColor)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.slate900)),
                Row(
                  children: [
                    Text('$id  ·  ', style: GoogleFonts.inter(fontSize: 13, color: AppColors.slate400)),
                    Text('F  ·  42 yrs', style: GoogleFonts.inter(fontSize: 13, color: AppColors.slate400)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(reason,
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.emerald700)),
              ),
              const SizedBox(height: 4),
              Text(time,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: AppColors.slate400)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Overview Tab ──────────────────────────────────────────────────────────────

class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        LayoutBuilder(builder: (context, c) {
          final half = (c.maxWidth - 16) / 2;
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(width: half, child: _InfoCard(
                title: 'Contact',
                icon: Icons.phone_outlined,
                lines: const [
                  _Line('Phone', '+1 (555) 987-6543'),
                  _Line('Email', 'rose.miller@example.com'),
                  _Line('Emergency', 'John Miller · +1 (555) 111-2222'),
                ],
              )),
              SizedBox(width: half, child: _InfoCard(
                title: 'Insurance',
                icon: Icons.shield_outlined,
                lines: const [
                  _Line('Provider', 'BlueCross BlueShield'),
                  _Line('Policy #', 'BCBS-774421'),
                  _Line('Coverage', 'Full · Active'),
                ],
              )),
              SizedBox(width: half, child: _InfoCard(
                title: 'Allergies',
                icon: Icons.warning_amber_outlined,
                iconColor: const Color(0xFFDC2626),
                lines: const [
                  _Line('Drug', 'Penicillin (Severe)'),
                  _Line('Food', 'Peanuts (Moderate)'),
                  _Line('Other', 'Latex (Mild)'),
                ],
              )),
              SizedBox(width: half, child: _InfoCard(
                title: 'Chronic Conditions',
                icon: Icons.medical_services_outlined,
                lines: const [
                  _Line('Condition', 'Type 2 Diabetes (2019)'),
                  _Line('Condition', 'Hypertension (2020)'),
                  _Line('Condition', 'Hypercholesterolemia'),
                ],
              )),
            ],
          );
        }),
        const SizedBox(height: 20),
        _ActiveMedsPanel(),
      ],
    );
  }
}

class _Line {
  final String label;
  final String value;
  const _Line(this.label, this.value);
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<_Line> lines;
  const _InfoCard({
    required this.title,
    required this.icon,
    this.iconColor = AppColors.primary,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 8),
            Text(title,
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.slate800)),
          ]),
          const SizedBox(height: 12),
          ...lines.map((l) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l.label,
                        style: GoogleFonts.inter(
                            fontSize: 12, color: AppColors.slate400)),
                    Flexible(
                      child: Text(l.value,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate700)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _ActiveMedsPanel extends StatelessWidget {
  const _ActiveMedsPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Medications',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate800)),
          const SizedBox(height: 12),
          ...[
            ('Metformin 500mg', 'Twice daily', AppColors.primary),
            ('Atorvastatin 20mg', 'Once daily', const Color(0xFF7C3AED)),
            ('Lisinopril 10mg', 'Once daily (noon)', const Color(0xFF2563EB)),
          ].map((m) => _MedChip(name: m.$1, freq: m.$2, color: m.$3)),
        ],
      ),
    );
  }
}

class _MedChip extends StatelessWidget {
  final String name;
  final String freq;
  final Color color;
  const _MedChip({required this.name, required this.freq, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(children: [
        Container(
            width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
        const SizedBox(width: 10),
        Text(name,
            style: GoogleFonts.inter(
                fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.slate700)),
        const Spacer(),
        Text(freq,
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.slate400)),
      ]),
    );
  }
}

// ── Vitals Tab ────────────────────────────────────────────────────────────────

class _VitalsTab extends StatelessWidget {
  const _VitalsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        LayoutBuilder(builder: (context, c) {
          final third = (c.maxWidth - 32) / 3;
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(width: third, child: _VitalBox(label: 'Heart Rate', value: '78', unit: 'bpm', status: 'Normal', color: const Color(0xFFDC2626))),
              SizedBox(width: third, child: _VitalBox(label: 'Blood Pressure', value: '128/84', unit: 'mmHg', status: 'Borderline', color: const Color(0xFFD97706))),
              SizedBox(width: third, child: _VitalBox(label: 'SpO₂', value: '97', unit: '%', status: 'Normal', color: AppColors.primary)),
              SizedBox(width: third, child: _VitalBox(label: 'Temperature', value: '98.4', unit: '°F', status: 'Normal', color: const Color(0xFF2563EB))),
              SizedBox(width: third, child: _VitalBox(label: 'Weight', value: '148', unit: 'lbs', status: 'Stable', color: const Color(0xFF7C3AED))),
              SizedBox(width: third, child: _VitalBox(label: 'Blood Glucose', value: '126', unit: 'mg/dL', status: 'Elevated', color: const Color(0xFFD97706))),
            ],
          );
        }),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.slate100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Trend (Last 6 months)',
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.slate800)),
              const SizedBox(height: 12),
              Text('Blood Pressure',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate500)),
              const SizedBox(height: 8),
              _BpTrendRow(label: 'May', sys: 0.68, dia: 0.55),
              _BpTrendRow(label: 'Jun', sys: 0.70, dia: 0.57),
              _BpTrendRow(label: 'Jul', sys: 0.72, dia: 0.60),
              _BpTrendRow(label: 'Aug', sys: 0.74, dia: 0.59),
              _BpTrendRow(label: 'Sep', sys: 0.71, dia: 0.58),
              _BpTrendRow(label: 'Oct', sys: 0.76, dia: 0.62),
            ],
          ),
        ),
      ],
    );
  }
}

class _BpTrendRow extends StatelessWidget {
  final String label;
  final double sys;
  final double dia;
  const _BpTrendRow({required this.label, required this.sys, required this.dia});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(label,
                style: GoogleFonts.inter(fontSize: 11, color: AppColors.slate400)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: sys,
                    minHeight: 14,
                    backgroundColor: AppColors.slate100,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFDC2626)),
                  ),
                ),
                Positioned.fill(
                  child: FractionallySizedBox(
                    widthFactor: dia,
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFD97706).withOpacity(0.4))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('${(sys * 180).toInt()}/${(dia * 100 + 60).toInt()}',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.slate600)),
        ],
      ),
    );
  }
}

class _VitalBox extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final String status;
  final Color color;
  const _VitalBox({
    required this.label,
    required this.value,
    required this.unit,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.slate400,
                  letterSpacing: 0.4)),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value,
                  style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.slate900)),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(unit,
                    style: GoogleFonts.inter(
                        fontSize: 11, color: AppColors.slate400)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(status,
                style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color)),
          ),
        ],
      ),
    );
  }
}

// ── History Tab ───────────────────────────────────────────────────────────────

class _HistoryTab extends StatelessWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        _HistoryItem(
          date: 'Oct 10, 2024',
          title: 'Cardiology Follow-up',
          doctor: 'Dr. Sarah Johnson',
          note: 'BP slightly elevated. Adjusted Lisinopril dosage. Follow up in 6 weeks.',
          type: 'Virtual',
        ),
        _HistoryItem(
          date: 'Sep 22, 2024',
          title: 'General Check-up',
          doctor: 'Dr. Kevin Park',
          note: 'Annual wellness visit. All within normal parameters. Flu vaccine administered.',
          type: 'In-Person',
        ),
        _HistoryItem(
          date: 'Aug 14, 2024',
          title: 'Diabetes Management',
          doctor: 'Dr. Mira Patel',
          note: 'HbA1c improved from 7.8% to 7.1%. Continue current medication regimen.',
          type: 'Virtual',
        ),
        _HistoryItem(
          date: 'Jul 5, 2024',
          title: 'Lab Review',
          doctor: 'Dr. Mira Patel',
          note: 'Lipid panel within target range. Atorvastatin effective. No changes.',
          type: 'In-Person',
        ),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String date;
  final String title;
  final String doctor;
  final String note;
  final String type;
  const _HistoryItem({
    required this.date,
    required this.title,
    required this.doctor,
    required this.note,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary)),
              Expanded(
                child: Container(
                    width: 2, color: AppColors.slate100),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.slate100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate800)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: type == 'Virtual'
                              ? const Color(0xFFEDE9FE)
                              : AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(type,
                            style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: type == 'Virtual'
                                    ? const Color(0xFF7C3AED)
                                    : AppColors.emerald700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('$doctor  ·  $date',
                      style: GoogleFonts.inter(
                          fontSize: 12, color: AppColors.slate400)),
                  const SizedBox(height: 8),
                  Text(note,
                      style: GoogleFonts.inter(
                          fontSize: 13, color: AppColors.slate600,
                          height: 1.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reports Tab ───────────────────────────────────────────────────────────────

class _ReportsTab extends StatelessWidget {
  const _ReportsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        _ReportRow('CBC + Differential', 'Oct 10, 2024', 'Normal', AppColors.primary),
        _ReportRow('HbA1c', 'Oct 10, 2024', '7.1% — Improved', Color(0xFF2563EB)),
        _ReportRow('Lipid Panel', 'Jul 5, 2024', 'Within Range', AppColors.primary),
        _ReportRow('Thyroid Panel', 'Jun 20, 2024', 'Normal', AppColors.primary),
        _ReportRow('Urinalysis', 'May 15, 2024', 'No Abnormalities', AppColors.primary),
      ],
    );
  }
}

class _ReportRow extends StatelessWidget {
  final String name;
  final String date;
  final String result;
  final Color color;
  const _ReportRow(this.name, this.date, this.result, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.science_outlined, size: 20, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate800)),
                Text(date,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.slate400)),
              ],
            ),
          ),
          Text(result,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: color)),
          const SizedBox(width: 16),
          const Icon(Icons.download_outlined,
              size: 18, color: AppColors.slate400),
        ],
      ),
    );
  }
}
