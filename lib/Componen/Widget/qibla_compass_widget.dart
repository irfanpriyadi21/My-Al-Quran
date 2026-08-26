import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';

class QiblaCompassWidget extends StatelessWidget {
  final double qiblaAngle; // Sudut kiblat (derajat dari Utara)
  final double currentHeading; // Sudut hadap kompas (derajat dari Utara)
  final double size;

  const QiblaCompassWidget({
    super.key,
    required this.qiblaAngle,
    this.currentHeading = 0.0,
    this.size = 280,
  });

  @override
  Widget build(BuildContext context) {
    // Selisih sudut antara hadap kompas dan arah kiblat
    final double relativeQiblaAngle = (qiblaAngle - currentHeading + 360) % 360;
    final bool isAligned = (relativeQiblaAngle < 3 || relativeQiblaAngle > 357);

    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Outer Compass Ring & Ticks (Berputar dinamis sesuai hadap sensor kompas)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: -currentHeading, end: -currentHeading),
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              builder: (context, headingAngle, child) {
                return Transform.rotate(
                  angle: headingAngle * (math.pi / 180.0),
                  child: child,
                );
              },
              child: CustomPaint(
                size: Size(size, size),
                painter: _CompassDialPainter(mainColor: mainColor),
              ),
            ),

            // 2. Ka'bah Pointer (Menunjuk ke arah Kiblat secara presisi)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: (qiblaAngle - currentHeading),
                end: (qiblaAngle - currentHeading),
              ),
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              builder: (context, angleToKaaba, child) {
                return Transform.rotate(
                  angle: angleToKaaba * (math.pi / 180.0),
                  child: child,
                );
              },
              child: SizedBox(
                width: size,
                height: size,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Ka'bah Icon Badge at Qibla angle
                    Positioned(
                      top: 12,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isAligned ? const Color(0xFF00C853) : const Color(0xFFFFA000),
                          boxShadow: [
                            BoxShadow(
                              color: (isAligned ? const Color(0xFF00C853) : const Color(0xFFFFA000))
                                  .withValues(alpha: 0.6),
                              blurRadius: isAligned ? 14 : 8,
                              spreadRadius: isAligned ? 3 : 1,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.mosque_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Pointer Line
                    Positioned(
                      top: 44,
                      child: Container(
                        width: 3.5,
                        height: (size / 2) - 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              isAligned ? const Color(0xFF00C853) : const Color(0xFFFFA000),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Central Cap & Status Readout
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: size * 0.40,
              height: size * 0.40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: (isAligned ? const Color(0xFF00C853) : Colors.black)
                        .withValues(alpha: isAligned ? 0.25 : 0.08),
                    blurRadius: isAligned ? 16 : 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: isAligned ? const Color(0xFF00C853) : mainColor.withValues(alpha: 0.2),
                  width: isAligned ? 2.5 : 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isAligned ? Icons.check_circle_rounded : Icons.explore_rounded,
                    color: isAligned ? const Color(0xFF00C853) : mainColor,
                    size: 26,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${qiblaAngle.toStringAsFixed(1)}°",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isAligned ? const Color(0xFF00C853) : Colors.black87,
                    ),
                  ),
                  Text(
                    isAligned ? "Tepat Kiblat" : "Arah Kiblat",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isAligned ? const Color(0xFF00C853) : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompassDialPainter extends CustomPainter {
  final Color mainColor;

  _CompassDialPainter({required this.mainColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, bgPaint);

    // Outer border
    final borderPaint = Paint()
      ..color = const Color(0xFFE8E8EE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius - 2, borderPaint);

    // Inner subtle glow
    final innerRingPaint = Paint()
      ..color = const Color(0xFFF7F8FA)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - 16, innerRingPaint);

    // Tick lines & labels
    final tickPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5;

    final majorTickPaint = Paint()
      ..color = Colors.grey.shade700
      ..strokeWidth = 2.5;

    final northPaint = Paint()
      ..color = const Color(0xFFE53935)
      ..strokeWidth = 3.5;

    for (int deg = 0; deg < 360; deg += 5) {
      final rad = deg * (math.pi / 180.0);
      final isMajor = deg % 30 == 0;
      final isCardinal = deg % 90 == 0;
      final isNorth = deg == 0;

      final tickLength = isCardinal ? 14.0 : (isMajor ? 10.0 : 6.0);
      final startR = radius - 8;
      final endR = startR - tickLength;

      final p1 = Offset(
        center.dx + startR * math.sin(rad),
        center.dy - startR * math.cos(rad),
      );
      final p2 = Offset(
        center.dx + endR * math.sin(rad),
        center.dy - endR * math.cos(rad),
      );

      final currentPaint = isNorth ? northPaint : (isCardinal ? majorTickPaint : tickPaint);
      canvas.drawLine(p1, p2, currentPaint);

      // Cardinal Letters (U, T, S, B)
      if (isCardinal) {
        String label = 'U';
        Color labelColor = const Color(0xFFE53935);
        if (deg == 90) {
          label = 'T';
          labelColor = Colors.black87;
        } else if (deg == 180) {
          label = 'S';
          labelColor = Colors.black87;
        } else if (deg == 270) {
          label = 'B';
          labelColor = Colors.black87;
        }

        final textSpan = TextSpan(
          text: label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: labelColor,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        )..layout();

        final labelRadius = radius - 30;
        final labelPos = Offset(
          center.dx + labelRadius * math.sin(rad) - (textPainter.width / 2),
          center.dy - labelRadius * math.cos(rad) - (textPainter.height / 2),
        );
        textPainter.paint(canvas, labelPos);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
