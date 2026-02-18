import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class PatientMedsPage extends StatefulWidget {
  const PatientMedsPage({super.key});
  @override
  State<PatientMedsPage> createState() => _PatientMedsPageState();
}

class _PatientMedsPageState extends State<PatientMedsPage> {

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
        title: Text('Medications',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.slate900)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Adherence card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0A4A30), Color(0xFF0E6B44)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Adherence Score',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7))),
                    Row(
                      children: [
                        Text('87%',
                            style: GoogleFonts.inter(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: AppColors.primary)),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('↑ 4%',
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary)),
                            Text('this month',
                                style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: Colors.white.withOpacity(0.6))),
                          ],
                        ),
                      ],
                    ),
                    Text('Keep it up! Take your evening dose.',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7))),
                  ],
                ),
                const Spacer(),
                _CircleProgress(pct: 0.87),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Today's schedule
          Text("Today's Schedule",
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900)),
          const SizedBox(height: 12),
          _TodayDoseRow(
              med: 'Metformin 500mg',
              time: '8:00 AM',
              taken: true),
          _TodayDoseRow(
              med: 'Atorvastatin 20mg',
              time: '10:00 AM',
              taken: true),
          _TodayDoseRow(
              med: 'Lisinopril 10mg',
              time: '1:00 PM',
              taken: false),
          _TodayDoseRow(
              med: 'Metformin 500mg',
              time: '8:00 PM',
              taken: false),
          const SizedBox(height: 24),
          // Active medications
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Active Medications',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.slate900)),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('3 active',
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.emerald700)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._meds.map((m) => _MedCard(med: m)),
          const SizedBox(height: 24),
          // Refill reminders
          Text('Refill Reminders',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900)),
          const SizedBox(height: 12),
          _RefillCard(
            drug: 'Metformin 500mg',
            remaining: '5 days',
            urgent: true,
          ),
          _RefillCard(
            drug: 'Atorvastatin 20mg',
            remaining: '14 days',
            urgent: false,
          ),
        ],
      ),
    );
  }
}

// ── Circle Progress ───────────────────────────────────────────────────────────

class _CircleProgress extends StatelessWidget {
  final double pct;
  const _CircleProgress({required this.pct});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: pct,
            strokeWidth: 8,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          Text('${(pct * 100).toInt()}%',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white)),
        ],
      ),
    );
  }
}

// ── Today's Dose Row ──────────────────────────────────────────────────────────

class _TodayDoseRow extends StatelessWidget {
  final String med;
  final String time;
  final bool taken;
  const _TodayDoseRow(
      {required this.med, required this.time, required this.taken});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: taken
                ? AppColors.primary.withOpacity(0.3)
                : AppColors.slate100),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: taken
                  ? AppColors.primary.withOpacity(0.15)
                  : AppColors.slate100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              taken ? Icons.check : Icons.access_time,
              size: 14,
              color: taken ? AppColors.emerald700 : AppColors.slate400,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(med,
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: taken ? AppColors.slate400 : AppColors.slate800,
                    decoration:
                        taken ? TextDecoration.lineThrough : null)),
          ),
          Text(time,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  color:
                      taken ? AppColors.slate300 : AppColors.slate500)),
          const SizedBox(width: 12),
          if (!taken)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.backgroundDark,
                elevation: 0,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                textStyle: GoogleFonts.inter(
                    fontSize: 12, fontWeight: FontWeight.w700),
              ),
              child: const Text('Mark Taken'),
            ),
        ],
      ),
    );
  }
}

// ── Med Data ──────────────────────────────────────────────────────────────────

class _MedData {
  final String name;
  final String dose;
  final String frequency;
  final String prescribedBy;
  final String startDate;
  final String refillDate;
  final Color color;
  final IconData icon;
  const _MedData({
    required this.name,
    required this.dose,
    required this.frequency,
    required this.prescribedBy,
    required this.startDate,
    required this.refillDate,
    required this.color,
    required this.icon,
  });
}

const _meds = [
  _MedData(
    name: 'Metformin',
    dose: '500mg',
    frequency: 'Twice daily',
    prescribedBy: 'Dr. Kevin Park',
    startDate: 'Jan 15, 2024',
    refillDate: 'Oct 29, 2024',
    color: Color(0xFF2563EB),
    icon: Icons.medication_liquid_outlined,
  ),
  _MedData(
    name: 'Atorvastatin',
    dose: '20mg',
    frequency: 'Once daily (morning)',
    prescribedBy: 'Dr. Mira Patel',
    startDate: 'Jul 5, 2024',
    refillDate: 'Nov 8, 2024',
    color: Color(0xFF7C3AED),
    icon: Icons.medication_outlined,
  ),
  _MedData(
    name: 'Lisinopril',
    dose: '10mg',
    frequency: 'Once daily (noon)',
    prescribedBy: 'Dr. Sarah Johnson',
    startDate: 'Sep 22, 2024',
    refillDate: 'Nov 22, 2024',
    color: AppColors.emerald700,
    icon: Icons.medical_services_outlined,
  ),
];

class _MedCard extends StatefulWidget {
  final _MedData med;
  const _MedCard({required this.med});
  @override
  State<_MedCard> createState() => _MedCardState();
}

class _MedCardState extends State<_MedCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: _expanded
                ? widget.med.color.withOpacity(0.4)
                : AppColors.slate100),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: widget.med.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.med.icon,
                        size: 22, color: widget.med.color),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.med.name} ${widget.med.dose}',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.slate800)),
                        Text(widget.med.frequency,
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.slate400)),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.slate400,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.slate50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _DetailRow(
                        label: 'Prescribed by',
                        value: widget.med.prescribedBy),
                    const SizedBox(height: 8),
                    _DetailRow(
                        label: 'Start date',
                        value: widget.med.startDate),
                    const SizedBox(height: 8),
                    _DetailRow(
                        label: 'Next refill', value: widget.med.refillDate),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.slate700,
                              side: const BorderSide(
                                  color: AppColors.slate200),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              textStyle: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            child: const Text('View Rx'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.backgroundDark,
                              elevation: 0,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              textStyle: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                            child: const Text('Request Refill'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 12, color: AppColors.slate400)),
        Text(value,
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.slate700)),
      ],
    );
  }
}

// ── Refill Card ───────────────────────────────────────────────────────────────

class _RefillCard extends StatelessWidget {
  final String drug;
  final String remaining;
  final bool urgent;
  const _RefillCard(
      {required this.drug,
      required this.remaining,
      required this.urgent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: urgent
            ? const Color(0xFFFEF3C7)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: urgent
                ? const Color(0xFFFDE68A)
                : AppColors.slate100),
      ),
      child: Row(
        children: [
          Icon(
            urgent ? Icons.warning_amber_rounded : Icons.info_outline,
            size: 20,
            color: urgent
                ? const Color(0xFFD97706)
                : AppColors.slate400,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(drug,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: urgent
                            ? const Color(0xFF92400E)
                            : AppColors.slate800)),
                Text('$remaining supply remaining',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        color: urgent
                            ? const Color(0xFFB45309)
                            : AppColors.slate400)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  urgent ? const Color(0xFFD97706) : AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle: GoogleFonts.inter(
                  fontSize: 12, fontWeight: FontWeight.w700),
            ),
            child: const Text('Refill Now'),
          ),
        ],
      ),
    );
  }
}
