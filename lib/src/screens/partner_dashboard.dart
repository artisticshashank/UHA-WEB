import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class PartnerDashboard extends StatefulWidget {
  const PartnerDashboard({super.key});
  @override
  State<PartnerDashboard> createState() => _PartnerDashboardState();
}

class _PartnerDashboardState extends State<PartnerDashboard> {
  int _nav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Row(
        children: [
          _Sidebar(
              selected: _nav, onSelect: (i) => setState(() => _nav = i)),
          Expanded(
            child: Column(
              children: [
                const _TopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(28),
                    child: const _OverviewContent(),
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

class _NavDef {
  final IconData icon;
  final String label;
  const _NavDef(this.icon, this.label);
}

// ── Sidebar ───────────────────────────────────────────────────────────────────

class _Sidebar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  const _Sidebar({required this.selected, required this.onSelect});

  static const _items = [
    _NavDef(Icons.grid_view_rounded, 'Overview'),
    _NavDef(Icons.local_hospital_outlined, 'Facilities'),
    _NavDef(Icons.science_outlined, 'Lab Orders'),
    _NavDef(Icons.medication_outlined, 'Pharmacy'),
    _NavDef(Icons.bar_chart_outlined, 'Analytics'),
    _NavDef(Icons.settings_outlined, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppColors.slate100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('UHA',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.slate900)),
                    Text('PARTNER PORTAL',
                        style: GoogleFonts.inter(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            letterSpacing: 1)),
                  ],
                ),
              ],
            ),
          ),
          ...List.generate(
            _items.length,
            (i) => _SidebarItem(
              item: _items[i],
              selected: i == selected,
              onTap: () => onSelect(i),
            ),
          ),
          const Spacer(),
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
                            shape: BoxShape.circle,
                            color: AppColors.primary)),
                    const SizedBox(width: 6),
                    Text('VERIFIED',
                        style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: AppColors.emerald700,
                            letterSpacing: 1)),
                  ],
                ),
                const SizedBox(height: 8),
                Text('City General Hospital',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate800)),
                Text('Hospital · License #HOS-4421',
                    style: GoogleFonts.inter(
                        fontSize: 10, color: AppColors.slate400)),
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
              Text(widget.item.label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: widget.selected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: widget.selected
                        ? AppColors.emerald700
                        : AppColors.slate600,
                  )),
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
          Container(
            height: 38,
            width: 380,
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.slate200),
            ),
            child: Row(children: [
              const SizedBox(width: 12),
              const Icon(Icons.search, size: 16, color: AppColors.slate400),
              const SizedBox(width: 8),
              Text('Search facilities, orders, or patients...',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: AppColors.slate400)),
            ]),
          ),
          const Spacer(),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Today',
                  style: GoogleFonts.inter(
                      fontSize: 10, color: AppColors.slate400)),
              Text('Thursday, Oct 24',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate800)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Overview Content ──────────────────────────────────────────────────────────

class _OverviewContent extends StatelessWidget {
  const _OverviewContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Partner Overview',
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.slate900)),
                Text('City General Hospital  ·  Thursday, Oct 24',
                    style: GoogleFonts.inter(
                        fontSize: 14, color: AppColors.slate500)),
              ],
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('New Lab Order'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.backgroundDark,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle: GoogleFonts.inter(
                    fontSize: 13, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        // Stats row
        LayoutBuilder(builder: (context, constraints) {
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: (constraints.maxWidth - 48) / 4,
                child: _StatCard(
                  label: 'TOTAL PATIENTS',
                  value: '1,284',
                  badge: '↑ 8%',
                  badgeBg: AppColors.primary.withOpacity(0.1),
                  badgeFg: AppColors.emerald700,
                  icon: Icons.people_outline,
                  iconColor: AppColors.primary,
                ),
              ),
              SizedBox(
                width: (constraints.maxWidth - 48) / 4,
                child: _StatCard(
                  label: 'PENDING LAB ORDERS',
                  value: '47',
                  badge: 'Action',
                  badgeBg: const Color(0xFFFEF3C7),
                  badgeFg: const Color(0xFFD97706),
                  icon: Icons.science_outlined,
                  iconColor: const Color(0xFFD97706),
                ),
              ),
              SizedBox(
                width: (constraints.maxWidth - 48) / 4,
                child: _StatCard(
                  label: 'PRESCRIPTIONS TODAY',
                  value: '132',
                  badge: 'Normal',
                  badgeBg: const Color(0xFFDCFCE7),
                  badgeFg: const Color(0xFF16A34A),
                  icon: Icons.medication_outlined,
                  iconColor: const Color(0xFF16A34A),
                ),
              ),
              SizedBox(
                width: (constraints.maxWidth - 48) / 4,
                child: _StatCard(
                  label: 'BED OCCUPANCY',
                  value: '78%',
                  badge: 'High',
                  badgeBg: const Color(0xFFFEE2E2),
                  badgeFg: const Color(0xFFDC2626),
                  icon: Icons.bed_outlined,
                  iconColor: const Color(0xFFDC2626),
                ),
              ),
            ],
          );
        }),
        const SizedBox(height: 24),
        // Two columns
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(flex: 3, child: _LabOrdersPanel()),
                SizedBox(width: 20),
                Expanded(flex: 2, child: _FacilityStatusPanel()),
              ],
            );
          }
          return const Column(
            children: [
              _LabOrdersPanel(),
              SizedBox(height: 20),
              _FacilityStatusPanel(),
            ],
          );
        }),
        const SizedBox(height: 20),
        const _PharmacyPanel(),
      ],
    );
  }
}

// ── Stat Card ─────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String badge;
  final Color badgeBg;
  final Color badgeFg;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.badge,
    required this.badgeBg,
    required this.badgeFg,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
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
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate400,
                      letterSpacing: 0.6)),
              Icon(icon, size: 20, color: iconColor),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(value,
                  style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: AppColors.slate900)),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(badge,
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: badgeFg)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Lab Orders Panel ──────────────────────────────────────────────────────────

class _LabOrdersPanel extends StatelessWidget {
  const _LabOrdersPanel();

  static const _orders = [
    _OrderRow('CBC + Differential', 'Jane Cooper · PT-9012', 'Pending',
        Color(0xFFFEF3C7), Color(0xFFD97706)),
    _OrderRow('Lipid Panel', 'Robert Fox · PT-8821', 'Processing',
        Color(0xFFDCFCE7), Color(0xFF16A34A)),
    _OrderRow('HbA1c', 'Cody Fisher · PT-1102', 'Complete',
        AppColors.primary, AppColors.emerald700),
    _OrderRow('Thyroid Panel', 'Leslie Williams · PT-2051', 'Pending',
        Color(0xFFFEF3C7), Color(0xFFD97706)),
    _OrderRow('Urinalysis', 'Mark Wilson · PT-3312', 'Critical',
        Color(0xFFFEE2E2), Color(0xFFDC2626)),
  ];

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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lab Orders',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.slate900)),
                TextButton(
                  onPressed: () {},
                  child: Text('View All',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            color: AppColors.slate50,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text('TEST',
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate400,
                            letterSpacing: 0.8))),
                Expanded(
                    flex: 3,
                    child: Text('PATIENT',
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate400,
                            letterSpacing: 0.8))),
                Expanded(
                    flex: 2,
                    child: Text('STATUS',
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate400,
                            letterSpacing: 0.8))),
                Expanded(
                    flex: 2,
                    child: Text('ACTION',
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate400,
                            letterSpacing: 0.8))),
              ],
            ),
          ),
          ..._orders.map((o) => _LabOrderRow(order: o)),
        ],
      ),
    );
  }
}

class _OrderRow {
  final String test;
  final String patient;
  final String status;
  final Color badgeBg;
  final Color badgeFg;
  const _OrderRow(
      this.test, this.patient, this.status, this.badgeBg, this.badgeFg);
}

class _LabOrderRow extends StatefulWidget {
  final _OrderRow order;
  const _LabOrderRow({required this.order});
  @override
  State<_LabOrderRow> createState() => _LabOrderRowState();
}

class _LabOrderRowState extends State<_LabOrderRow> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: _hover ? AppColors.slate50 : Colors.white,
          border: const Border(
              bottom: BorderSide(color: AppColors.slate100)),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(widget.order.test,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate800))),
            Expanded(
                flex: 3,
                child: Text(widget.order.patient,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.slate500))),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: widget.order.badgeBg.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(widget.order.status,
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: widget.order.badgeFg)),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text('View Result',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Facility Status Panel ─────────────────────────────────────────────────────

class _FacilityStatusPanel extends StatelessWidget {
  const _FacilityStatusPanel();

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
          Text('Facility Status',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900)),
          const SizedBox(height: 18),
          _FacilityItem(
              dept: 'Emergency',
              beds: 12,
              total: 20,
              color: const Color(0xFFDC2626)),
          const SizedBox(height: 12),
          _FacilityItem(
              dept: 'ICU',
              beds: 6,
              total: 10,
              color: const Color(0xFFD97706)),
          const SizedBox(height: 12),
          _FacilityItem(
              dept: 'General Ward',
              beds: 34,
              total: 60,
              color: AppColors.primary),
          const SizedBox(height: 12),
          _FacilityItem(
              dept: 'Pediatrics',
              beds: 8,
              total: 15,
              color: const Color(0xFF2563EB)),
          const SizedBox(height: 12),
          _FacilityItem(
              dept: 'Maternity',
              beds: 5,
              total: 12,
              color: const Color(0xFF7C3AED)),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline,
                    size: 16, color: AppColors.emerald700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '3 patients waiting for bed assignment in General Ward.',
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.emerald700),
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

class _FacilityItem extends StatelessWidget {
  final String dept;
  final int beds;
  final int total;
  final Color color;
  const _FacilityItem(
      {required this.dept,
      required this.beds,
      required this.total,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final pct = beds / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dept,
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate700)),
            Text('$beds / $total beds',
                style: GoogleFonts.inter(
                    fontSize: 12, color: AppColors.slate400)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 6,
            backgroundColor: AppColors.slate100,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

// ── Pharmacy Panel ────────────────────────────────────────────────────────────

class _PharmacyPanel extends StatelessWidget {
  const _PharmacyPanel();

  static const _rxList = [
    _RxItem('Metformin 500mg', 'Jane Cooper', 'x30 tabs', '2h ago', true),
    _RxItem('Atorvastatin 20mg', 'Robert Fox', 'x60 tabs', '3h ago', true),
    _RxItem('Lisinopril 10mg', 'Leslie Williams', 'x30 tabs', '4h ago', false),
    _RxItem('Amoxicillin 500mg', 'Cody Fisher', 'x21 tabs', '5h ago', false),
  ];

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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Prescriptions',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.slate900)),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('2 Need Dispensing',
                      style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFD97706))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ..._rxList.map((rx) => _RxRow(rx: rx)),
        ],
      ),
    );
  }
}

class _RxItem {
  final String drug;
  final String patient;
  final String qty;
  final String time;
  final bool dispensed;
  const _RxItem(
      this.drug, this.patient, this.qty, this.time, this.dispensed);
}

class _RxRow extends StatefulWidget {
  final _RxItem rx;
  const _RxRow({required this.rx});
  @override
  State<_RxRow> createState() => _RxRowState();
}

class _RxRowState extends State<_RxRow> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: _hover ? AppColors.slate50 : Colors.white,
          border: const Border(
              bottom: BorderSide(color: AppColors.slate100)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.medication_outlined,
                  size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.rx.drug,
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate800)),
                  Text(
                      '${widget.rx.patient}  ·  ${widget.rx.qty}  ·  ${widget.rx.time}',
                      style: GoogleFonts.inter(
                          fontSize: 11, color: AppColors.slate400)),
                ],
              ),
            ),
            widget.rx.dispensed
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Dispensed',
                        style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF16A34A))))
                : ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.backgroundDark,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      textStyle: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    child: const Text('Dispense'),
                  ),
          ],
        ),
      ),
    );
  }
}
