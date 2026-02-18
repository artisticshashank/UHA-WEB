import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class PatientRecordsPage extends StatefulWidget {
  const PatientRecordsPage({super.key});
  @override
  State<PatientRecordsPage> createState() => _PatientRecordsPageState();
}

class _PatientRecordsPageState extends State<PatientRecordsPage> {
  String _filter = 'All';
  final _filters = ['All', 'Lab Reports', 'Prescriptions', 'Imaging', 'Vitals'];

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
        title: Text('Health Records',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.slate900)),
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload_outlined, size: 16),
            label: const Text('Upload Record'),
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter chips
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters
                    .map((f) => _FilterChip(
                          label: f,
                          selected: _filter == f,
                          onTap: () => setState(() => _filter = f),
                        ))
                    .toList(),
              ),
            ),
          ),
          Container(height: 1, color: AppColors.slate100),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Summary banner
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0A4A30), Color(0xFF0E6B44)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.folder_outlined,
                          color: AppColors.primary, size: 28),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('24 Records',
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white)),
                          Text('Last updated 2 days ago',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.7))),
                        ],
                      ),
                      const Spacer(),
                      _MiniStat(label: 'Labs', value: '12'),
                      const SizedBox(width: 20),
                      _MiniStat(label: 'Rx', value: '7'),
                      const SizedBox(width: 20),
                      _MiniStat(label: 'Imaging', value: '5'),
                    ],
                  ),
                ),
                // Records list
                ..._records
                    .where((r) =>
                        _filter == 'All' || r.type == _filter)
                    .map((r) => _RecordCard(record: r)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  const _MiniStat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.primary)),
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 11,
                color: Colors.white.withOpacity(0.7))),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip(
      {required this.label,
      required this.selected,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.12)
              : AppColors.slate100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected
                  ? AppColors.primary
                  : Colors.transparent),
        ),
        child: Text(label,
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight:
                    selected ? FontWeight.w700 : FontWeight.w500,
                color: selected
                    ? AppColors.emerald700
                    : AppColors.slate600)),
      ),
    );
  }
}

class _RecordData {
  final String title;
  final String subtitle;
  final String date;
  final String type;
  final String size;
  final IconData icon;
  final Color iconColor;
  const _RecordData({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.type,
    required this.size,
    required this.icon,
    required this.iconColor,
  });
}

const _records = [
  _RecordData(
    title: 'Complete Blood Count',
    subtitle: 'Dr. Sarah Johnson  ·  City General Hospital',
    date: 'Oct 10, 2024',
    type: 'Lab Reports',
    size: '245 KB',
    icon: Icons.science_outlined,
    iconColor: Color(0xFF2563EB),
  ),
  _RecordData(
    title: 'Metformin Prescription',
    subtitle: 'Dr. Kevin Park  ·  Sep 22, 2024',
    date: 'Sep 22, 2024',
    type: 'Prescriptions',
    size: '82 KB',
    icon: Icons.medication_outlined,
    iconColor: Color(0xFF16A34A),
  ),
  _RecordData(
    title: 'Chest X-Ray',
    subtitle: 'City Radiology Lab  ·  Aug 14, 2024',
    date: 'Aug 14, 2024',
    type: 'Imaging',
    size: '2.1 MB',
    icon: Icons.image_outlined,
    iconColor: Color(0xFFD97706),
  ),
  _RecordData(
    title: 'Lipid Panel Results',
    subtitle: 'Dr. Mira Patel  ·  Jul 5, 2024',
    date: 'Jul 5, 2024',
    type: 'Lab Reports',
    size: '190 KB',
    icon: Icons.science_outlined,
    iconColor: Color(0xFF2563EB),
  ),
  _RecordData(
    title: 'Atorvastatin Prescription',
    subtitle: 'Dr. Mira Patel  ·  Jul 5, 2024',
    date: 'Jul 5, 2024',
    type: 'Prescriptions',
    size: '74 KB',
    icon: Icons.medication_outlined,
    iconColor: Color(0xFF16A34A),
  ),
  _RecordData(
    title: 'Thyroid Ultrasound',
    subtitle: 'City Radiology Lab  ·  Jun 20, 2024',
    date: 'Jun 20, 2024',
    type: 'Imaging',
    size: '3.4 MB',
    icon: Icons.image_outlined,
    iconColor: Color(0xFFD97706),
  ),
  _RecordData(
    title: 'HbA1c Test',
    subtitle: 'Dr. Sarah Johnson  ·  Jun 10, 2024',
    date: 'Jun 10, 2024',
    type: 'Lab Reports',
    size: '155 KB',
    icon: Icons.science_outlined,
    iconColor: Color(0xFF2563EB),
  ),
];

class _RecordCard extends StatefulWidget {
  final _RecordData record;
  const _RecordCard({required this.record});
  @override
  State<_RecordCard> createState() => _RecordCardState();
}

class _RecordCardState extends State<_RecordCard> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _hover ? AppColors.slate50 : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color:
                  _hover ? AppColors.primary.withOpacity(0.3) : AppColors.slate100),
          boxShadow: _hover
              ? [
                  BoxShadow(
                      color: AppColors.primary.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4))
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: widget.record.iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(widget.record.icon,
                  size: 22, color: widget.record.iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.record.title,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate800)),
                  Text(widget.record.subtitle,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: AppColors.slate400)),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.record.date,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.slate400)),
                const SizedBox(height: 4),
                Text(widget.record.size,
                    style: GoogleFonts.inter(
                        fontSize: 11, color: AppColors.slate300)),
              ],
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                _ActionBtn(
                    icon: Icons.visibility_outlined,
                    tooltip: 'View',
                    onTap: () {}),
                const SizedBox(width: 4),
                _ActionBtn(
                    icon: Icons.download_outlined,
                    tooltip: 'Download',
                    onTap: () {}),
                const SizedBox(width: 4),
                _ActionBtn(
                    icon: Icons.share_outlined,
                    tooltip: 'Share',
                    onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  const _ActionBtn(
      {required this.icon, required this.tooltip, required this.onTap});
  @override
  State<_ActionBtn> createState() => _ActionBtnState();
}

class _ActionBtnState extends State<_ActionBtn> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color:
                  _hover ? AppColors.primary.withOpacity(0.12) : AppColors.slate100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(widget.icon,
                size: 16,
                color: _hover ? AppColors.emerald700 : AppColors.slate500),
          ),
        ),
      ),
    );
  }
}
