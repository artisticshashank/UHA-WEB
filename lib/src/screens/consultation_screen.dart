import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

// ── Data ─────────────────────────────────────────────────────────────────────

class _ChatMsg {
  final String sender; // 'doctor' | 'patient'
  final String text;
  final String time;
  const _ChatMsg(
      {required this.sender, required this.text, required this.time});
}

// ── Main Screen ───────────────────────────────────────────────────────────────

class ConsultationScreen extends StatefulWidget {
  final String patientName;
  final String patientId;
  final String patientInitials;
  final Color patientColor;
  final String reason;
  final bool isDoctor; // true = doctor view, false = patient view

  const ConsultationScreen({
    super.key,
    this.patientName = 'Jane Cooper',
    this.patientId = 'PT-9012',
    this.patientInitials = 'JC',
    this.patientColor = const Color(0xFF7C3AED),
    this.reason = 'Chronic Migraine',
    this.isDoctor = true,
  });

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen>
    with TickerProviderStateMixin {
  bool _micOn = true;
  bool _camOn = true;
  bool _handRaised = false;
  bool _chatOpen = true;
  bool _notesOpen = false;
  bool _infoOpen = false;

  int _elapsed = 0;
  Timer? _timer;

  final _chatCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;

  final List<_ChatMsg> _messages = [
    _ChatMsg(
        sender: 'doctor',
        text: 'Good morning! How are you feeling today?',
        time: '09:01'),
    _ChatMsg(
        sender: 'patient',
        text:
            'Morning doctor. I\'ve been having the migraines again since Tuesday.',
        time: '09:02'),
    _ChatMsg(
        sender: 'doctor',
        text:
            'I see. On a scale of 1-10, how would you rate the pain intensity?',
        time: '09:03'),
    _ChatMsg(
        sender: 'patient', text: 'Around a 7. It\'s quite debilitating.', time: '09:04'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed++);
    });
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = Tween(begin: 0.95, end: 1.05).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseCtrl.dispose();
    _chatCtrl.dispose();
    _notesCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  String get _timeStr {
    final m = (_elapsed ~/ 60).toString().padLeft(2, '0');
    final s = (_elapsed % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _sendMessage() {
    final text = _chatCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMsg(
        sender: widget.isDoctor ? 'doctor' : 'patient',
        text: text,
        time:
            '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}',
      ));
      _chatCtrl.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Column(
        children: [
          _TopBar(
            patientName: widget.patientName,
            patientId: widget.patientId,
            reason: widget.reason,
            timeStr: _timeStr,
            onEnd: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Row(
              children: [
                // ── Main video area
                Expanded(
                  child: Stack(
                    children: [
                      _MainVideoArea(
                        patientName: widget.patientName,
                        patientInitials: widget.patientInitials,
                        patientColor: widget.patientColor,
                        pulse: _pulse,
                        isDoctor: widget.isDoctor,
                      ),
                      // Self preview (bottom-right)
                      Positioned(
                        right: 16,
                        bottom: 88,
                        child: _SelfPreview(isDoctor: widget.isDoctor),
                      ),
                      // Controls bar
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: _ControlsBar(
                          micOn: _micOn,
                          camOn: _camOn,
                          handRaised: _handRaised,
                          onMic: () => setState(() => _micOn = !_micOn),
                          onCam: () => setState(() => _camOn = !_camOn),
                          onHand: () =>
                              setState(() => _handRaised = !_handRaised),
                          onChat: () => setState(() {
                            _chatOpen = !_chatOpen;
                            if (_chatOpen) {
                              _notesOpen = false;
                              _infoOpen = false;
                            }
                          }),
                          onNotes: () => setState(() {
                            _notesOpen = !_notesOpen;
                            if (_notesOpen) {
                              _chatOpen = false;
                              _infoOpen = false;
                            }
                          }),
                          onInfo: () => setState(() {
                            _infoOpen = !_infoOpen;
                            if (_infoOpen) {
                              _chatOpen = false;
                              _notesOpen = false;
                            }
                          }),
                          chatOpen: _chatOpen,
                          notesOpen: _notesOpen,
                          infoOpen: _infoOpen,
                          onEnd: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
                // ── Side panel
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: (_chatOpen || _notesOpen || _infoOpen)
                      ? SizedBox(
                          width: 320,
                          child: _SidePanel(
                            chatOpen: _chatOpen,
                            notesOpen: _notesOpen,
                            infoOpen: _infoOpen,
                            messages: _messages,
                            chatCtrl: _chatCtrl,
                            notesCtrl: _notesCtrl,
                            scrollCtrl: _scrollCtrl,
                            onSend: _sendMessage,
                            patientName: widget.patientName,
                            patientId: widget.patientId,
                            patientInitials: widget.patientInitials,
                            patientColor: widget.patientColor,
                            reason: widget.reason,
                            isDoctor: widget.isDoctor,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Top Bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final String patientName;
  final String patientId;
  final String reason;
  final String timeStr;
  final VoidCallback onEnd;

  const _TopBar({
    required this.patientName,
    required this.patientId,
    required this.reason,
    required this.timeStr,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF161B22),
        border: Border(bottom: BorderSide(color: Color(0xFF30363D))),
      ),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.shield_outlined,
                    color: AppColors.backgroundDark, size: 16),
              ),
              const SizedBox(width: 8),
              Text('UHA',
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
            ],
          ),
          const SizedBox(width: 20),
          Container(width: 1, height: 20, color: const Color(0xFF30363D)),
          const SizedBox(width: 20),
          // Session info
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(patientName,
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              Text('$patientId  ·  $reason',
                  style: GoogleFonts.inter(
                      fontSize: 11, color: Colors.white38)),
            ],
          ),
          const Spacer(),
          // Live timer
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFDC2626).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: const Color(0xFFDC2626).withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFDC2626)),
                ),
                const SizedBox(width: 6),
                Text('LIVE  $timeStr',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFDC2626),
                      letterSpacing: 0.8,
                    )),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // End call
          ElevatedButton.icon(
            onPressed: onEnd,
            icon: const Icon(Icons.call_end, size: 14),
            label: const Text('End Call'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle:
                  GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Main Video Area ───────────────────────────────────────────────────────────

class _MainVideoArea extends StatelessWidget {
  final String patientName;
  final String patientInitials;
  final Color patientColor;
  final Animation<double> pulse;
  final bool isDoctor;

  const _MainVideoArea({
    required this.patientName,
    required this.patientInitials,
    required this.patientColor,
    required this.pulse,
    required this.isDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1117),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pulsing avatar
            AnimatedBuilder(
              animation: pulse,
              builder: (_, __) => Transform.scale(
                scale: pulse.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: patientColor,
                    boxShadow: [
                      BoxShadow(
                        color: patientColor.withOpacity(0.35),
                        blurRadius: 32,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      isDoctor ? patientInitials : 'Dr',
                      style: GoogleFonts.inter(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isDoctor ? patientName : 'Dr. Alexander Smith',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                ),
                const SizedBox(width: 6),
                Text(
                  'Camera Off  ·  Connected',
                  style: GoogleFonts.inter(
                      fontSize: 13, color: Colors.white54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Self Preview ──────────────────────────────────────────────────────────────

class _SelfPreview extends StatelessWidget {
  final bool isDoctor;
  const _SelfPreview({required this.isDoctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 96,
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: isDoctor
                      ? const Color(0xFF059669)
                      : const Color(0xFF2563EB),
                  child: Text(
                    isDoctor ? 'Dr' : 'Me',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isDoctor ? 'You (Doctor)' : 'You (Patient)',
                  style: GoogleFonts.inter(
                      fontSize: 10, color: Colors.white60),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('You',
                  style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: AppColors.backgroundDark)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Controls Bar ─────────────────────────────────────────────────────────────

class _ControlsBar extends StatelessWidget {
  final bool micOn;
  final bool camOn;
  final bool handRaised;
  final bool chatOpen;
  final bool notesOpen;
  final bool infoOpen;
  final VoidCallback onMic;
  final VoidCallback onCam;
  final VoidCallback onHand;
  final VoidCallback onChat;
  final VoidCallback onNotes;
  final VoidCallback onInfo;
  final VoidCallback onEnd;

  const _ControlsBar({
    required this.micOn,
    required this.camOn,
    required this.handRaised,
    required this.chatOpen,
    required this.notesOpen,
    required this.infoOpen,
    required this.onMic,
    required this.onCam,
    required this.onHand,
    required this.onChat,
    required this.onNotes,
    required this.onInfo,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Color(0xCC0D1117)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CtrlBtn(
            icon: micOn ? Icons.mic : Icons.mic_off,
            label: micOn ? 'Mute' : 'Unmute',
            active: micOn,
            onTap: onMic,
          ),
          const SizedBox(width: 12),
          _CtrlBtn(
            icon: camOn ? Icons.videocam : Icons.videocam_off,
            label: camOn ? 'Stop Video' : 'Start Video',
            active: camOn,
            onTap: onCam,
          ),
          const SizedBox(width: 12),
          _CtrlBtn(
            icon: Icons.pan_tool_outlined,
            label: 'Raise Hand',
            active: handRaised,
            activeColor: const Color(0xFFF59E0B),
            onTap: onHand,
          ),
          const SizedBox(width: 24),
          // Chat
          _CtrlBtn(
            icon: Icons.chat_bubble_outline,
            label: 'Chat',
            active: chatOpen,
            activeColor: AppColors.primary,
            onTap: onChat,
          ),
          const SizedBox(width: 12),
          _CtrlBtn(
            icon: Icons.note_outlined,
            label: 'Notes',
            active: notesOpen,
            activeColor: AppColors.primary,
            onTap: onNotes,
          ),
          const SizedBox(width: 12),
          _CtrlBtn(
            icon: Icons.info_outline,
            label: 'Info',
            active: infoOpen,
            activeColor: AppColors.primary,
            onTap: onInfo,
          ),
          const SizedBox(width: 24),
          // End call
          _CtrlBtn(
            icon: Icons.call_end,
            label: 'End',
            active: true,
            activeColor: const Color(0xFFDC2626),
            onTap: onEnd,
          ),
        ],
      ),
    );
  }
}

class _CtrlBtn extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool active;
  final Color activeColor;
  final VoidCallback onTap;

  const _CtrlBtn({
    required this.icon,
    required this.label,
    required this.active,
    this.activeColor = Colors.white,
    required this.onTap,
  });

  @override
  State<_CtrlBtn> createState() => _CtrlBtnState();
}

class _CtrlBtnState extends State<_CtrlBtn> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final bg = widget.active
        ? widget.activeColor.withOpacity(0.15)
        : const Color(0xFF30363D);
    final fg =
        widget.active ? widget.activeColor : Colors.white60;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hover ? bg.withOpacity(0.9) : bg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.active
                  ? widget.activeColor.withOpacity(0.3)
                  : Colors.white12,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: fg),
              const SizedBox(height: 2),
              Text(widget.label,
                  style: GoogleFonts.inter(fontSize: 9, color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Side Panel ────────────────────────────────────────────────────────────────

class _SidePanel extends StatelessWidget {
  final bool chatOpen;
  final bool notesOpen;
  final bool infoOpen;
  final List<_ChatMsg> messages;
  final TextEditingController chatCtrl;
  final TextEditingController notesCtrl;
  final ScrollController scrollCtrl;
  final VoidCallback onSend;
  final String patientName;
  final String patientId;
  final String patientInitials;
  final Color patientColor;
  final String reason;
  final bool isDoctor;

  const _SidePanel({
    required this.chatOpen,
    required this.notesOpen,
    required this.infoOpen,
    required this.messages,
    required this.chatCtrl,
    required this.notesCtrl,
    required this.scrollCtrl,
    required this.onSend,
    required this.patientName,
    required this.patientId,
    required this.patientInitials,
    required this.patientColor,
    required this.reason,
    required this.isDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF161B22),
        border: Border(left: BorderSide(color: Color(0xFF30363D))),
      ),
      child: Column(
        children: [
          // Panel header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Color(0xFF30363D))),
            ),
            child: Row(
              children: [
                Icon(
                  chatOpen
                      ? Icons.chat_bubble_outline
                      : notesOpen
                          ? Icons.note_outlined
                          : Icons.info_outline,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  chatOpen
                      ? 'Chat'
                      : notesOpen
                          ? 'Clinical Notes'
                          : 'Patient Info',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: chatOpen
                ? _ChatPanel(
                    messages: messages,
                    chatCtrl: chatCtrl,
                    scrollCtrl: scrollCtrl,
                    onSend: onSend,
                    isDoctor: isDoctor,
                  )
                : notesOpen
                    ? _NotesPanel(notesCtrl: notesCtrl)
                    : _InfoPanel(
                        patientName: patientName,
                        patientId: patientId,
                        patientInitials: patientInitials,
                        patientColor: patientColor,
                        reason: reason,
                      ),
          ),
        ],
      ),
    );
  }
}

// ── Chat Panel ────────────────────────────────────────────────────────────────

class _ChatPanel extends StatelessWidget {
  final List<_ChatMsg> messages;
  final TextEditingController chatCtrl;
  final ScrollController scrollCtrl;
  final VoidCallback onSend;
  final bool isDoctor;

  const _ChatPanel({
    required this.messages,
    required this.chatCtrl,
    required this.scrollCtrl,
    required this.onSend,
    required this.isDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollCtrl,
            padding: const EdgeInsets.all(14),
            itemCount: messages.length,
            itemBuilder: (_, i) {
              final m = messages[i];
              final isMine = (isDoctor && m.sender == 'doctor') ||
                  (!isDoctor && m.sender == 'patient');
              return _ChatBubble(msg: m, isMine: isMine);
            },
          ),
        ),
        // Input
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF30363D))),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: chatCtrl,
                  onSubmitted: (_) => onSend(),
                  style: GoogleFonts.inter(
                      fontSize: 13, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: GoogleFonts.inter(
                        fontSize: 13, color: Colors.white38),
                    filled: true,
                    fillColor: const Color(0xFF0D1117),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onSend,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.send,
                      size: 16, color: AppColors.backgroundDark),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final _ChatMsg msg;
  final bool isMine;
  const _ChatBubble({required this.msg, required this.isMine});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        constraints: const BoxConstraints(maxWidth: 220),
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                color: isMine
                    ? AppColors.primary.withOpacity(0.2)
                    : const Color(0xFF21262D),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: Radius.circular(isMine ? 12 : 2),
                  bottomRight: Radius.circular(isMine ? 2 : 12),
                ),
                border: isMine
                    ? Border.all(
                        color: AppColors.primary.withOpacity(0.3))
                    : null,
              ),
              child: Text(
                msg.text,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.87),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(msg.time,
                style: GoogleFonts.inter(
                    fontSize: 10, color: Colors.white38)),
          ],
        ),
      ),
    );
  }
}

// ── Notes Panel ───────────────────────────────────────────────────────────────

class _NotesPanel extends StatelessWidget {
  final TextEditingController notesCtrl;
  const _NotesPanel({required this.notesCtrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clinical Notes',
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white54)),
          const SizedBox(height: 8),
          Expanded(
            child: TextField(
              controller: notesCtrl,
              maxLines: null,
              expands: true,
              style: GoogleFonts.inter(fontSize: 13, color: Colors.white),
              decoration: InputDecoration(
                hintText:
                    'Type clinical notes here...\n\nChief complaint:\nAssessment:\nPlan:',
                hintStyle: GoogleFonts.inter(
                    fontSize: 12, color: Colors.white24, height: 1.8),
                filled: true,
                fillColor: const Color(0xFF0D1117),
                contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF30363D)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF30363D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.backgroundDark,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                textStyle: GoogleFonts.inter(
                    fontSize: 13, fontWeight: FontWeight.w700),
              ),
              child: const Text('Save Notes'),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info Panel ────────────────────────────────────────────────────────────────

class _InfoPanel extends StatelessWidget {
  final String patientName;
  final String patientId;
  final String patientInitials;
  final Color patientColor;
  final String reason;

  const _InfoPanel({
    required this.patientName,
    required this.patientId,
    required this.patientInitials,
    required this.patientColor,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Patient header
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    color: patientColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(patientInitials,
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(patientName,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  Text(patientId,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: Colors.white38)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _InfoRow(label: 'Chief Complaint', value: reason),
          _InfoRow(label: 'Age', value: '28 years'),
          _InfoRow(label: 'Gender', value: 'Female'),
          _InfoRow(label: 'Blood Type', value: 'O+'),
          _InfoRow(label: 'Last Visit', value: 'Oct 02, 2023'),
          const SizedBox(height: 16),
          Text('Allergies',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white38,
                  letterSpacing: 0.8)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: ['Penicillin', 'Aspirin'].map((a) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color:
                          const Color(0xFFDC2626).withOpacity(0.3)),
                ),
                child: Text(a,
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        color: const Color(0xFFF87171))),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text('Current Medications',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white38,
                  letterSpacing: 0.8)),
          const SizedBox(height: 8),
          _MedItem('Sumatriptan', '50mg · As needed'),
          _MedItem('Lisinopril', '10mg · Daily'),
          const SizedBox(height: 16),
          Text('Recent Vitals',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white38,
                  letterSpacing: 0.8)),
          const SizedBox(height: 8),
          _InfoRow(label: 'BP', value: '118 / 76 mmHg'),
          _InfoRow(label: 'Heart Rate', value: '72 BPM'),
          _InfoRow(label: 'SpO2', value: '98%'),
          _InfoRow(label: 'Temp', value: '98.4°F'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 12, color: Colors.white38)),
          Text(value,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70)),
        ],
      ),
    );
  }
}

class _MedItem extends StatelessWidget {
  final String name;
  final String dose;
  const _MedItem(this.name, this.dose);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF21262D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70)),
          Text(dose,
              style: GoogleFonts.inter(
                  fontSize: 11, color: Colors.white38)),
        ],
      ),
    );
  }
}
