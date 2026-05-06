import 'package:flutter/material.dart';

class AssignmentsScreen extends StatefulWidget {
  final bool showBackButton;
  const AssignmentsScreen({super.key, this.showBackButton = true});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab = TabController(length: 2, vsync: this);

  final List<Map<String, dynamic>> _pending = [
    {
      'emoji': '🔢',
      'title': 'Number Tracing Sheet',
      'subject': 'Math',
      'detail': 'Pages 4–5 · 10 min',
      'due': 'Due Today',
      'urgent': true,
    },
    {
      'emoji': '👨‍👩‍👧',
      'title': 'Draw Your Family',
      'subject': 'Art',
      'detail': '1 drawing · 15 min',
      'due': 'Due Fri',
      'urgent': false,
    },
    {
      'emoji': '📖',
      'title': 'Read Aloud: 3 Sentences',
      'subject': 'Reading',
      'detail': 'Storybook p.8 · 5 min',
      'due': 'Due Thu',
      'urgent': false,
    },
  ];

  final List<Map<String, dynamic>> _completed = [
    {
      'emoji': '🔷',
      'title': 'Color the Shapes',
      'subject': 'Art',
      'when': 'Mon',
      'stars': 10,
    },
    {
      'emoji': '✏️',
      'title': 'Count & Write 1–10',
      'subject': 'Math',
      'when': 'Tue',
      'stars': 8,
    },
    {
      'emoji': '🌈',
      'title': 'Name 5 Colors',
      'subject': 'Science',
      'when': 'Last week',
      'stars': 6,
    },
  ];

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: widget.showBackButton
            ? GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.teal.shade200),
            ),
            child: Icon(Icons.arrow_back_ios_rounded,
                size: 16, color: Colors.teal.shade600),
          ),
        )
            : null,
        title: Row(children: [
          const Text('📝', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Text(
            'Assignments',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.teal.shade700,
            ),
          ),
        ]),
        bottom: TabBar(
          controller: _tab,
          labelColor: Colors.teal.shade700,
          unselectedLabelColor: Colors.grey.shade400,
          indicatorColor: Colors.teal.shade500,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          tabs: [
            Tab(text: '📋 Pending (${_pending.length})'),
            Tab(text: '✅ Done (${_completed.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [_pendingTab(), _doneTab()],
      ),
    );
  }

  Widget _pendingTab() => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(children: [
      // Urgent banner
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade400, Colors.red.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(children: [
          const Text('⚠️', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          const Text(
            'You have 1 assignment due today!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ]),
      ),
      const SizedBox(height: 14),
      Expanded(
        child: ListView.separated(
          itemCount: _pending.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => _PendingCard(hw: _pending[i]),
        ),
      ),
    ]),
  );

  Widget _doneTab() => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade400, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(children: [
          const Text('🎉', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Text(
            'Amazing! ${_completed.length} assignments done!',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ]),
      ),
      const SizedBox(height: 14),
      Expanded(
        child: ListView.separated(
          itemCount: _completed.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => _DoneCard(hw: _completed[i]),
        ),
      ),
    ]),
  );
}

// ── Pending Card ──────────────────────────────────────────────────────────────
class _PendingCard extends StatelessWidget {
  final Map<String, dynamic> hw;
  const _PendingCard({required this.hw});

  @override
  Widget build(BuildContext context) {
    final bool urgent = hw['urgent'] as bool;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: urgent ? Colors.red.shade200 : Colors.teal.shade100,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (urgent ? Colors.red : Colors.teal).withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: urgent ? Colors.red.shade50 : Colors.teal.shade50,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
              child: Text(hw['emoji'] as String, style: const TextStyle(fontSize: 24))),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    hw['title'] as String,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: urgent ? Colors.red.shade50 : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: urgent ? Colors.red.shade200 : Colors.orange.shade200,
                    ),
                  ),
                  child: Text(
                    hw['due'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: urgent ? Colors.red.shade600 : Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${hw['subject']} · ${hw['detail']}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 38,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade400, Colors.teal.shade600],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: const Center(
                      child: Text(
                        '▶  Start Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

// ── Done Card ─────────────────────────────────────────────────────────────────
class _DoneCard extends StatelessWidget {
  final Map<String, dynamic> hw;
  const _DoneCard({required this.hw});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.teal.shade100, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
              child: Text(hw['emoji'] as String, style: const TextStyle(fontSize: 24))),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(hw['title'] as String,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E))),
            const SizedBox(height: 4),
            Text('${hw['subject']} · Submitted ${hw['when']}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
          ]),
        ),
        Column(children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(color: Color(0xFFDCFCE7), shape: BoxShape.circle),
            child: const Icon(Icons.check_rounded, size: 18, color: Color(0xFF16A34A)),
          ),
          const SizedBox(height: 4),
          Text(
            '+${hw['stars']} ⭐',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Colors.amber.shade600,
            ),
          ),
        ]),
      ]),
    );
  }
}