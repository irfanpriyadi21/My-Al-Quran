import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/ModelListAyat.dart';
import 'package:my_quran/Utils/surah_pdf_service.dart';
import 'package:nb_utils/nb_utils.dart';

class SurahPdfExportModal extends StatefulWidget {
  final int surahId;
  final String surahName;
  final String jumlahAyat;
  final String tempatTurun;
  final String arti;
  final List<Ayat> ayatList;

  const SurahPdfExportModal({
    super.key,
    required this.surahId,
    required this.surahName,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.ayatList,
  });

  static void show(
    BuildContext context, {
    required int surahId,
    required String surahName,
    required String jumlahAyat,
    required String tempatTurun,
    required String arti,
    required List<Ayat> ayatList,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SurahPdfExportModal(
        surahId: surahId,
        surahName: surahName,
        jumlahAyat: jumlahAyat,
        tempatTurun: tempatTurun,
        arti: arti,
        ayatList: ayatList,
      ),
    );
  }

  @override
  State<SurahPdfExportModal> createState() => _SurahPdfExportModalState();
}

class _SurahPdfExportModalState extends State<SurahPdfExportModal> {
  bool _includeLatin = true;
  bool _includeTranslation = true;
  double _arabicFontSize = 20.0;
  bool _isExporting = false;

  Future<void> _handlePreview() async {
    setState(() => _isExporting = true);
    try {
      await SurahPdfService.previewPdf(
        context: context,
        surahId: widget.surahId,
        surahName: widget.surahName,
        jumlahAyat: widget.jumlahAyat,
        tempatTurun: widget.tempatTurun,
        arti: widget.arti,
        ayatList: widget.ayatList,
        includeLatin: _includeLatin,
        includeTranslation: _includeTranslation,
        arabicFontSize: _arabicFontSize,
      );
    } catch (e) {
      toast("Gagal memuat PDF: $e");
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  Future<void> _handleShare() async {
    setState(() => _isExporting = true);
    try {
      await SurahPdfService.sharePdf(
        surahId: widget.surahId,
        surahName: widget.surahName,
        jumlahAyat: widget.jumlahAyat,
        tempatTurun: widget.tempatTurun,
        arti: widget.arti,
        ayatList: widget.ayatList,
        includeLatin: _includeLatin,
        includeTranslation: _includeTranslation,
        arabicFontSize: _arabicFontSize,
      );
    } catch (e) {
      toast("Gagal membagikan PDF: $e");
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  Future<void> _handleSave() async {
    setState(() => _isExporting = true);
    try {
      final file = await SurahPdfService.savePdfToStorage(
        surahId: widget.surahId,
        surahName: widget.surahName,
        jumlahAyat: widget.jumlahAyat,
        tempatTurun: widget.tempatTurun,
        arti: widget.arti,
        ayatList: widget.ayatList,
        includeLatin: _includeLatin,
        includeTranslation: _includeTranslation,
        arabicFontSize: _arabicFontSize,
      );
      if (mounted) {
        Navigator.pop(context);
        toast("Tersimpan di: ${file.path}");
      }
    } catch (e) {
      toast("Gagal menyimpan PDF: $e");
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Header Banner
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5722).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf_rounded,
                    color: Color(0xFFFF5722),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Download Surah ${widget.surahName}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        "Format PDF Lengkap (${widget.jumlahAyat} Ayat)",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Settings Box
            Material(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Opsi Konten Dokumen PDF",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),

                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      tileColor: Colors.transparent,
                      value: _includeLatin,
                      activeThumbColor: mainColor,
                      title: Text(
                        "Sertakan Teks Latin (Transliterasi)",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      onChanged: _isExporting
                          ? null
                          : (val) => setState(() => _includeLatin = val),
                    ),
                    Divider(
                      height: 1,
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      tileColor: Colors.transparent,
                      value: _includeTranslation,
                      activeThumbColor: mainColor,
                      title: Text(
                        "Sertakan Terjemahan Bahasa Indonesia",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      onChanged: _isExporting
                          ? null
                          : (val) => setState(() => _includeTranslation = val),
                    ),
                  Divider(
                    height: 1,
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  ),
                  const SizedBox(height: 10),

                  // Font Size
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ukuran Font Arab di PDF",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: mainColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "${_arabicFontSize.round()} pt",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: mainColor,
                      inactiveTrackColor: mainColor.withOpacity(0.15),
                      thumbColor: mainColor,
                      trackHeight: 3,
                    ),
                    child: Slider(
                      value: _arabicFontSize,
                      min: 16.0,
                      max: 26.0,
                      divisions: 5,
                      onChanged: _isExporting
                          ? null
                          : (val) => setState(() => _arabicFontSize = val),
                    ),
                  ),
                ],
              ),
            ),
          ),

            const SizedBox(height: 20),

            if (_isExporting)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Membuat dokumen PDF...",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: mainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              // Action 1: Preview & Print
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _handlePreview,
                  icon: const Icon(Icons.remove_red_eye_rounded, size: 18),
                  label: Text(
                    "Pratinjau & Cetak (Preview & Print)",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 2,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Action 2 & 3: Share & Save
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _handleShare,
                      icon: const Icon(Icons.share_rounded, size: 18),
                      label: Text(
                        "Bagikan PDF",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: mainColor,
                        side: const BorderSide(color: mainColor, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _handleSave,
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: Text(
                        "Simpan File",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF00C853),
                        side: const BorderSide(
                          color: Color(0xFF00C853),
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
