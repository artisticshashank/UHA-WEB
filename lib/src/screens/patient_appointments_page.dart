import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'consultation_screen.dart';

class PatientAppointmentsPage extends StatefulWidget {
  const PatientAppointmentsPage({super.key});
  @override
  State<PatientAppointmentsPage> createState() =>
      _PatientAppointmentsPageState();
}

class _PatientAppointmentsPageState extends State<PatientAppointmentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        title: Text('My Appointments',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.slate900)),
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Book Appointment'),
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
              controller: _tabController,
              labelStyle: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w700),
              unselectedLabelStyle:
                  GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.slate500,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Past'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _UpcomingList(),
          _PastList(),
        ],
      ),
    );
  }
}

// ── Upcoming ──────────────────────────────────────────────────────────────────

class _UpcomingList extends StatelessWidget {
  const _UpcomingList();

  static final _appts = [
    _ApptData(
      doctor: 'Dr. Sarah Johnson',
      specialty: 'Cardiologist',
      date: 'Today, 3:30 PM',
      type: 'Virtual',
      status: 'Confirmed',
      statusColor: AppColors.primary,
      avatar: 'SJ',
      avatarColor: const Color(0xFF2563EB),
    ),
    _ApptData(
      doctor: 'Dr. Kevin Park',
      specialty: 'General Physician',
      date: 'Oct 28, 10:00 AM',
      type: 'In-Person',
      status: 'Confirmed',
      statusColor: AppColors.primary,
      avatar: 'KP',
      avatarColor: const Color(0xFF7C3AED),
    ),
    _ApptData(
      doctor: 'Dr. Anita Roy',
      specialty: 'Dermatologist',
      date: 'Nov 2, 2:00 PM',
      type: 'Virtual',
      status: 'Pending',
      statusColor: const Color(0xFFD97706),
      avatar: 'AR',
      avatarColor: const Color(0xFFD97706),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Next card highlight
        _NextAppointmentCard(appt: _appts[0]),
        const SizedBox(height: 24),
        Text('All Upcoming',
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.slate700)),
        const SizedBox(height: 12),
        ..._appts.skip(1).map((a) => _ApptCard(appt: a, isPast: false)),
      ],
    );
  }
}

class _NextAppointmentCard extends StatelessWidget {
  final _ApptData appt;
  const _NextAppointmentCard({required this.appt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A4A30), Color(0xFF0E6B44)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('NEXT APPOINTMENT',
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 0.8)),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppColors.primary.withOpacity(0.5)),
                ),
                child: Text(appt.type,
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: appt.avatarColor.withOpacity(0.3),
                child: Text(appt.avatar,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appt.doctor,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  Text(appt.specialty,
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.7))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.access_time,
                  size: 14, color: Colors.white54),
              const SizedBox(width: 6),
              Text(appt.date,
                  style: GoogleFonts.inter(
                      fontSize: 13, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => ConsultationScreen(
                        patientName: 'Rose Miller',
                        patientId: 'PT-9012',
                        patientInitials: 'RM',
                        patientColor: const Color(0xFF2563EB),
                        reason: 'Cardiac Check',
                        isDoctor: false,
                      ),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                      transitionDuration: const Duration(milliseconds: 300),
                    ));
                  },
                  icon: const Icon(Icons.videocam_outlined, size: 16),
                  label: const Text('Join Call'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.backgroundDark,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withOpacity(0.3)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textStyle: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w600),
                ),
                child: const Text('Reschedule'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ApptCard extends StatelessWidget {
  final _ApptData appt;
  final bool isPast;
  const _ApptCard({required this.appt, required this.isPast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: appt.avatarColor.withOpacity(0.15),
            child: Text(appt.avatar,
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: appt.avatarColor)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appt.doctor,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate800)),
                Text('${appt.specialty}  ·  ${appt.date}',
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.slate400)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: appt.statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(appt.status,
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: appt.statusColor)),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: appt.type == 'Virtual'
                          ? const Color(0xFFEDE9FE)
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(appt.type,
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: appt.type == 'Virtual'
                                ? const Color(0xFF7C3AED)
                                : AppColors.emerald700)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Past ──────────────────────────────────────────────────────────────────────

class _PastList extends StatelessWidget {
  const _PastList();

  static final _past = [
    _ApptData(
      doctor: 'Dr. Sarah Johnson',
      specialty: 'Cardiologist',
      date: 'Oct 10, 2024',
      type: 'Virtual',
      status: 'Completed',
      statusColor: AppColors.emerald700,
      avatar: 'SJ',
      avatarColor: const Color(0xFF2563EB),
    ),
    _ApptData(
      doctor: 'Dr. Kevin Park',
      specialty: 'General Physician',
      date: 'Sep 22, 2024',
      type: 'In-Person',
      status: 'Completed',
      statusColor: AppColors.emerald700,
      avatar: 'KP',
      avatarColor: const Color(0xFF7C3AED),
    ),
    _ApptData(
      doctor: 'Dr. Mira Patel',
      specialty: 'Endocrinologist',
      date: 'Aug 14, 2024',
      type: 'Virtual',
      status: 'Cancelled',
      statusColor: const Color(0xFFDC2626),
      avatar: 'MP',
      avatarColor: const Color(0xFFD97706),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        ..._past.map((a) => _PastApptCard(appt: a)),
      ],
    );
  }
}

class _PastApptCard extends StatelessWidget {
  final _ApptData appt;
  const _PastApptCard({required this.appt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: appt.avatarColor.withOpacity(0.15),
            child: Text(appt.avatar,
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: appt.avatarColor)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appt.doctor,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: appt.status == 'Cancelled'
                            ? AppColors.slate400
                            : AppColors.slate800)),
                Text('${appt.specialty}  ·  ${appt.date}',
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.slate400)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: appt.statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(appt.status,
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: appt.statusColor)),
              ),
              if (appt.status == 'Completed') ...[
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('View Summary',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary)),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────

class _ApptData {
  final String doctor;
  final String specialty;
  final String date;
  final String type;
  final String status;
  final Color statusColor;
  final String avatar;
  final Color avatarColor;
  const _ApptData({
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.type,
    required this.status,
    required this.statusColor,
    required this.avatar,
    required this.avatarColor,
  });
}
