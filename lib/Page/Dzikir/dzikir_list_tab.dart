import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/model_dzikir.dart';
import 'package:share_plus/share_plus.dart';

class DzikirListTab extends StatefulWidget {
  final List<ModelDzikir> listDzikir;
  final String title;
  final String description;

  const DzikirListTab({
    super.key,
    required this.listDzikir,
    required this.title,
    required this.description,
  });

  @override
  State<DzikirListTab> createState() => _DzikirListTabState();
}

class _DzikirListTabState extends State<DzikirListTab> {
  final Map<String, int> _progressMap = {};

  void _increment(ModelDzikir dzikir) {
    final current = _progressMap[dzikir.id] ?? 0;
    if (current < dzikir.repeatCount) {
      HapticFeedback.lightImpact();
      setState(() {
        _progressMap[dzikir.id] = current + 1;
      });
      if (_progressMap[dzikir.id] == dzikir.repeatCount) {
        HapticFeedback.mediumImpact();
      }
    }
  }

  void _resetAll() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Reset Progres Dzikir?",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        content: Text(
          "Semua checklist dan hitungan bacaan pada halaman ini akan diulang dari awal.",
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal", style: TextStyle(color: isDark ? Colors.white60 : Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _progressMap.clear();
              });
            },
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }

  void _copyDzikir(ModelDzikir dzikir) {
    final text = '''${dzikir.title} (${dzikir.repeatCount}x)

${dzikir.arabic}

${dzikir.latin}

Artinya:
"${dzikir.translation}"

Keutamaan:
${dzikir.fadhilah} ${dzikir.riwayat != null ? '(${dzikir.riwayat})' : ''}

(Dibagikan dari Aplikasi My Quran)''';

    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              "Bacaan dzikir disalin ke clipboard",
              style: GoogleFonts.poppins(fontSize: 13),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF240F4F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareDzikir(ModelDzikir dzikir) {
    final text = '''${dzikir.title} (${dzikir.repeatCount}x)

${dzikir.arabic}

${dzikir.latin}

Artinya:
"${dzikir.translation}"

Keutamaan:
${dzikir.fadhilah}

Dibagikan dari Aplikasi My Quran''';

    Share.share(text, subject: dzikir.title);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    // Calculate completion progress
    int completedCount = 0;
    for (var d in widget.listDzikir) {
      if ((_progressMap[d.id] ?? 0) >= d.repeatCount) {
        completedCount++;
      }
    }
    final double completionRatio =
        widget.listDzikir.isNotEmpty ? (completedCount / widget.listDzikir.length) : 0.0;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      children: [
        // 1. Progress Banner Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.2) : Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.description,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (completedCount > 0)
                    InkWell(
                      onTap: _resetAll,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE53935).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.refresh_rounded, size: 14, color: Color(0xFFE53935)),
                            const SizedBox(width: 4),
                            Text(
                              "Reset",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFE53935),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),

              // Progress Bar
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: completionRatio,
                        minHeight: 7,
                        backgroundColor: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEDE7F6),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          completionRatio >= 1.0 ? const Color(0xFF00C853) : mainColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "$completedCount / ${widget.listDzikir.length}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: completionRatio >= 1.0 ? const Color(0xFF00C853) : mainColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 2. List of Dzikir Cards
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.listDzikir.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final dzikir = widget.listDzikir[index];
            final currentProgress = _progressMap[dzikir.id] ?? 0;
            final bool isCompleted = currentProgress >= dzikir.repeatCount;

            return _buildDzikirCard(
              dzikir: dzikir,
              number: index + 1,
              currentProgress: currentProgress,
              isCompleted: isCompleted,
              isDark: isDark,
              cardColor: cardColor,
            );
          },
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDzikirCard({
    required ModelDzikir dzikir,
    required int number,
    required int currentProgress,
    required bool isCompleted,
    required bool isDark,
    required Color cardColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted
              ? const Color(0xFF00C853).withOpacity(0.5)
              : (isDark ? Colors.white10 : Colors.transparent),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.25) : Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header: Number + Title + Action Buttons
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xFF00C853).withOpacity(0.15)
                        : mainColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$number",
                    style: GoogleFonts.poppins(
                      color: isCompleted ? const Color(0xFF00C853) : mainColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dzikir.title,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        "Anjuran: ${dzikir.repeatCount}x",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: isDark ? Colors.white60 : Colors.black45,
                  ),
                  tooltip: "Salin",
                  onPressed: () => _copyDzikir(dzikir),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(6),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: Icon(
                    Icons.share_rounded,
                    size: 18,
                    color: isDark ? Colors.white60 : Colors.black45,
                  ),
                  tooltip: "Bagikan",
                  onPressed: () => _shareDzikir(dzikir),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(6),
                ),
              ],
            ),

            Divider(
              height: 24,
              thickness: 0.7,
              color: isDark ? Colors.white12 : const Color(0xFFF0F0F0),
            ),

            // Arabic Text
            Text(
              dzikir.arabic,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.amiri(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 2.0,
                color: isDark ? Colors.white : const Color(0xFF240F4F),
              ),
            ),
            const SizedBox(height: 12),

            // Latin Text
            if (dzikir.latin.isNotEmpty) ...[
              Text(
                dzikir.latin,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  color: isDark ? const Color(0xFFD0A8FF) : mainColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Translation Text
            if (dzikir.translation.isNotEmpty) ...[
              Text(
                dzikir.translation,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Fadhilah / Keutamaan Box
            if (dzikir.fadhilah.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF282438) : const Color(0xFFF9F6FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: mainColor.withOpacity(isDark ? 0.25 : 0.15),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      size: 16,
                      color: Color(0xFFFFA000),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Keutamaan:",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF240F4F),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dzikir.fadhilah,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isDark ? Colors.white70 : Colors.black87,
                              height: 1.4,
                            ),
                          ),
                          if (dzikir.riwayat != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              dzikir.riwayat!,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: isDark ? Colors.white54 : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],

            // Counter Tap Button
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => _increment(dzikir),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFF00C853)
                      : mainColor.withOpacity(isDark ? 0.18 : 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isCompleted ? const Color(0xFF00C853) : mainColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isCompleted ? Icons.check_circle_rounded : Icons.touch_app_rounded,
                      size: 18,
                      color: isCompleted ? Colors.white : mainColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCompleted
                          ? "Selesai (${dzikir.repeatCount}x)"
                          : "Dibaca: $currentProgress / ${dzikir.repeatCount}x",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isCompleted ? Colors.white : mainColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
