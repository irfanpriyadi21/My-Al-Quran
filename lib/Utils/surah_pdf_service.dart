import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../Model/ModelListAyat.dart';

class SurahPdfService {
  /// Generate Surah PDF Document
  static Future<Uint8List> generateSurahPdf({
    required int surahId,
    required String surahName,
    required String jumlahAyat,
    required String tempatTurun,
    required String arti,
    required List<Ayat> ayatList,
    bool includeLatin = true,
    bool includeTranslation = true,
    double arabicFontSize = 20.0,
  }) async {
    final pdf = pw.Document(
      title: "Surah $surahName - My Al-Quran",
      author: "My Al-Quran Mobile App",
    );

    // Load High-Quality Fonts via PdfGoogleFonts
    final arabicFont = await PdfGoogleFonts.amiriBold();
    final regularFont = await PdfGoogleFonts.poppinsRegular();
    final boldFont = await PdfGoogleFonts.poppinsBold();
    final italicFont = await PdfGoogleFonts.poppinsItalic();

    final primaryPdfColor = PdfColor.fromHex('#9543FF');
    final darkPdfColor = PdfColor.fromHex('#1E1E1E');
    final greyPdfColor = PdfColor.fromHex('#555555');
    final lightBgColor = PdfColor.fromHex('#F7F5FA');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 28, vertical: 32),
        header: (pw.Context context) {
          if (context.pageNumber == 1) {
            return pw.SizedBox.shrink();
          }
          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 12),
            padding: const pw.EdgeInsets.only(bottom: 6),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.8),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "Surah $surahName (Ayat 1 - $jumlahAyat)",
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: 9,
                    color: primaryPdfColor,
                  ),
                ),
                pw.Text(
                  "My Al-Quran Mobile App",
                  style: pw.TextStyle(
                    font: regularFont,
                    fontSize: 9,
                    color: greyPdfColor,
                  ),
                ),
              ],
            ),
          );
        },
        footer: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.only(top: 12),
            padding: const pw.EdgeInsets.only(top: 6),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(color: PdfColors.grey300, width: 0.8),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "Dibuat dengan Aplikasi My Al-Quran",
                  style: pw.TextStyle(
                    font: italicFont,
                    fontSize: 8,
                    color: greyPdfColor,
                  ),
                ),
                pw.Text(
                  "Halaman ${context.pageNumber} dari ${context.pagesCount}",
                  style: pw.TextStyle(
                    font: regularFont,
                    fontSize: 8,
                    color: greyPdfColor,
                  ),
                ),
              ],
            ),
          );
        },
        build: (pw.Context context) {
          return [
            // HERO BANNER
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(18),
              decoration: pw.BoxDecoration(
                color: primaryPdfColor,
                borderRadius: pw.BorderRadius.circular(12),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    "SURAH $surahName".toUpperCase(),
                    style: pw.TextStyle(
                      font: boldFont,
                      fontSize: 18,
                      color: PdfColors.white,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    "\"$arti\"",
                    style: pw.TextStyle(
                      font: italicFont,
                      fontSize: 12,
                      color: PdfColors.white,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: pw.BorderRadius.circular(20),
                    ),
                    child: pw.Text(
                      "$tempatTurun • $jumlahAyat Ayat • Surah Ke-$surahId",
                      style: pw.TextStyle(
                        font: boldFont,
                        fontSize: 9,
                        color: primaryPdfColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 18),

            // BISMILLAH (Exclude Surah At-Tawbah #9 & Al-Fatihah #1 already has it as Ayah 1)
            if (surahId != 9 && surahId != 1) ...[
              pw.Center(
                child: pw.Directionality(
                  textDirection: pw.TextDirection.rtl,
                  child: pw.Text(
                    "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 22,
                      color: darkPdfColor,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Center(
                child: pw.Text(
                  "\"Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.\"",
                  style: pw.TextStyle(
                    font: italicFont,
                    fontSize: 9,
                    color: greyPdfColor,
                  ),
                ),
              ),
              pw.SizedBox(height: 16),
            ],

            // LIST OF AYAT
            ...ayatList.map((ayat) {
              final ayatNum = ayat.nomorAyat ?? 0;
              final arabicText = ayat.teksArab ?? '';
              final latinText = ayat.teksLatin ?? '';
              final translationText = ayat.teksIndonesia ?? '';

              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 12),
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: lightBgColor,
                  borderRadius: pw.BorderRadius.circular(8),
                  border: pw.Border.all(
                    color: PdfColors.grey200,
                    width: 0.8,
                  ),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Top Bar: Ayah Number
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          width: 22,
                          height: 22,
                          decoration: pw.BoxDecoration(
                            color: primaryPdfColor,
                            shape: pw.BoxShape.circle,
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              "$ayatNum",
                              style: pw.TextStyle(
                                font: boldFont,
                                fontSize: 9,
                                color: PdfColors.white,
                              ),
                            ),
                          ),
                        ),
                        pw.Text(
                          "Ayat $ayatNum",
                          style: pw.TextStyle(
                            font: boldFont,
                            fontSize: 9,
                            color: primaryPdfColor,
                          ),
                        ),
                      ],
                    ),

                    pw.SizedBox(height: 8),

                    // Arabic Text (Right-to-Left)
                    pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Directionality(
                        textDirection: pw.TextDirection.rtl,
                        child: pw.Text(
                          arabicText,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: arabicFontSize,
                            color: darkPdfColor,
                            lineSpacing: 4,
                          ),
                        ),
                      ),
                    ),

                    // Latin Transliteration
                    if (includeLatin && latinText.isNotEmpty) ...[
                      pw.SizedBox(height: 8),
                      pw.Text(
                        latinText,
                        style: pw.TextStyle(
                          font: boldFont,
                          fontSize: 10,
                          color: primaryPdfColor,
                        ),
                      ),
                    ],

                    // Indonesian Translation
                    if (includeTranslation && translationText.isNotEmpty) ...[
                      pw.SizedBox(height: 4),
                      pw.Text(
                        "\"$translationText\"",
                        style: pw.TextStyle(
                          font: italicFont,
                          fontSize: 9.5,
                          color: darkPdfColor,
                          lineSpacing: 2,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }),
          ];
        },
      ),
    );

    return pdf.save();
  }

  /// Print / Layout PDF preview screen
  static Future<void> previewPdf({
    required BuildContext context,
    required int surahId,
    required String surahName,
    required String jumlahAyat,
    required String tempatTurun,
    required String arti,
    required List<Ayat> ayatList,
    bool includeLatin = true,
    bool includeTranslation = true,
    double arabicFontSize = 20.0,
  }) async {
    await Printing.layoutPdf(
      name: "Surah_${surahName.replaceAll(' ', '_')}.pdf",
      onLayout: (PdfPageFormat format) async {
        return generateSurahPdf(
          surahId: surahId,
          surahName: surahName,
          jumlahAyat: jumlahAyat,
          tempatTurun: tempatTurun,
          arti: arti,
          ayatList: ayatList,
          includeLatin: includeLatin,
          includeTranslation: includeTranslation,
          arabicFontSize: arabicFontSize,
        );
      },
    );
  }

  /// Share PDF via WhatsApp, Email, etc.
  static Future<void> sharePdf({
    required int surahId,
    required String surahName,
    required String jumlahAyat,
    required String tempatTurun,
    required String arti,
    required List<Ayat> ayatList,
    bool includeLatin = true,
    bool includeTranslation = true,
    double arabicFontSize = 20.0,
  }) async {
    final bytes = await generateSurahPdf(
      surahId: surahId,
      surahName: surahName,
      jumlahAyat: jumlahAyat,
      tempatTurun: tempatTurun,
      arti: arti,
      ayatList: ayatList,
      includeLatin: includeLatin,
      includeTranslation: includeTranslation,
      arabicFontSize: arabicFontSize,
    );

    final fileName = "Surah_${surahName.replaceAll(' ', '_')}.pdf";
    await Printing.sharePdf(bytes: bytes, filename: fileName);
  }

  /// Save PDF directly to user storage / documents
  static Future<File> savePdfToStorage({
    required int surahId,
    required String surahName,
    required String jumlahAyat,
    required String tempatTurun,
    required String arti,
    required List<Ayat> ayatList,
    bool includeLatin = true,
    bool includeTranslation = true,
    double arabicFontSize = 20.0,
  }) async {
    final bytes = await generateSurahPdf(
      surahId: surahId,
      surahName: surahName,
      jumlahAyat: jumlahAyat,
      tempatTurun: tempatTurun,
      arti: arti,
      ayatList: ayatList,
      includeLatin: includeLatin,
      includeTranslation: includeTranslation,
      arabicFontSize: arabicFontSize,
    );

    final outputDir = await getApplicationDocumentsDirectory();
    final fileName = "Surah_${surahName.replaceAll(' ', '_')}.pdf";
    final file = File("${outputDir.path}/$fileName");
    await file.writeAsBytes(bytes);
    return file;
  }
}
