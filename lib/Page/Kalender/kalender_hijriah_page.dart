import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:my_quran/Componen/colors.dart';

class KalenderHijriahPage extends StatefulWidget {
  const KalenderHijriahPage({super.key});

  @override
  State<KalenderHijriahPage> createState() => _KalenderHijriahPageState();
}

class _KalenderHijriahPageState extends State<KalenderHijriahPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentHijriYear;
  late int _currentHijriMonth;
  late HijriCalendar _selectedDate;
  final HijriCalendar _todayHijri = HijriCalendar.now();

  static const List<String> _hijriMonthNames = [
    '',
    'Muharram',
    'Safar',
    "Rabi'ul Awwal",
    "Rabi'ul Akhir",
    'Jumadil Ula',
    'Jumadil Akhir',
    'Rajab',
    "Sya'ban",
    'Ramadhan',
    'Syawal',
    "Dzulqa'dah",
    'Dzulhijjah',
  ];

  static const List<String> _gregorianMonthNames = [
    '',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static const List<String> _dayNamesShort = [
    'Ahad',
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _currentHijriYear = _todayHijri.hYear;
    _currentHijriMonth = _todayHijri.hMonth;
    _selectedDate = HijriCalendar.now();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _goToPreviousMonth() {
    setState(() {
      if (_currentHijriMonth == 1) {
        _currentHijriMonth = 12;
        _currentHijriYear--;
      } else {
        _currentHijriMonth--;
      }
      _selectedDate = HijriCalendar()
        ..hYear = _currentHijriYear
        ..hMonth = _currentHijriMonth
        ..hDay = 1;
    });
  }

  void _goToNextMonth() {
    setState(() {
      if (_currentHijriMonth == 12) {
        _currentHijriMonth = 1;
        _currentHijriYear++;
      } else {
        _currentHijriMonth++;
      }
      _selectedDate = HijriCalendar()
        ..hYear = _currentHijriYear
        ..hMonth = _currentHijriMonth
        ..hDay = 1;
    });
  }

  void _goToToday() {
    setState(() {
      _currentHijriYear = _todayHijri.hYear;
      _currentHijriMonth = _todayHijri.hMonth;
      _selectedDate = HijriCalendar.now();
    });
  }

  // --- Islamic Events & Fasting Rules ---
  List<IslamicDayInfo> _getEventsForHijriDate(int year, int month, int day, DateTime gDate) {
    final List<IslamicDayInfo> events = [];
    final weekday = gDate.weekday; // 1 = Monday, ..., 7 = Sunday

    // 1. Hari Libur & Peristiwa Besar Islam
    if (month == 1 && day == 1) {
      events.add(const IslamicDayInfo(
        title: 'Tahun Baru Islam',
        description: '1 Muharram - Awal Tahun Baru Hijriyah',
        type: DayType.majorHoliday,
      ));
    } else if (month == 1 && day == 9) {
      events.add(const IslamicDayInfo(
        title: 'Puasa Tasu\'a',
        description: 'Puasa sunnah sehari sebelum hari Asyura',
        type: DayType.sunnahFast,
        niatKey: 'tasua',
      ));
    } else if (month == 1 && day == 10) {
      events.add(const IslamicDayInfo(
        title: 'Hari Asyura & Puasa Asyura',
        description: '10 Muharram - Menghapus dosa setahun yang lalu',
        type: DayType.sunnahFast,
        niatKey: 'asyura',
      ));
    } else if (month == 3 && day == 12) {
      events.add(const IslamicDayInfo(
        title: 'Maulid Nabi Muhammad SAW',
        description: '12 Rabi\'ul Awwal - Hari kelahiran Rasulullah SAW',
        type: DayType.majorHoliday,
      ));
    } else if (month == 7 && day == 27) {
      events.add(const IslamicDayInfo(
        title: 'Isra Mi\'raj Nabi Muhammad SAW',
        description: '27 Rajab - Peristiwa perjalanan malam & perintah shalat 5 waktu',
        type: DayType.majorHoliday,
      ));
    } else if (month == 8 && day == 15) {
      events.add(const IslamicDayInfo(
        title: 'Malam Nisfu Sya\'ban',
        description: '15 Sya\'ban - Malam pengampunan & pergantian catatan amal',
        type: DayType.event,
      ));
    } else if (month == 9 && day == 1) {
      events.add(const IslamicDayInfo(
        title: 'Awal Puasa Ramadhan',
        description: '1 Ramadhan - Hari pertama ibadah puasa wajib Ramadhan',
        type: DayType.wajibFast,
        niatKey: 'ramadhan',
      ));
    } else if (month == 9 && day == 17) {
      events.add(const IslamicDayInfo(
        title: 'Nuzulul Qur\'an',
        description: '17 Ramadhan - Peringatan turunnya ayat suci Al-Qur\'an',
        type: DayType.event,
      ));
    } else if (month == 9 && (day == 21 || day == 23 || day == 25 || day == 27 || day == 29)) {
      events.add(IslamicDayInfo(
        title: 'Malam Ganjil Ramadhan (Lailatul Qadar)',
        description: 'Malam ke-$day Ramadhan - Dianjurkan memperbanyak ibadah & i\'tikaf',
        type: DayType.event,
      ));
    } else if (month == 10 && day == 1) {
      events.add(const IslamicDayInfo(
        title: 'Hari Raya Idul Fitri (1 Syawal)',
        description: 'Hari Kemenangan Umat Islam - Diharamkan berpuasa',
        type: DayType.haramFast,
      ));
    } else if (month == 10 && day == 2) {
      events.add(const IslamicDayInfo(
        title: 'Hari Raya Idul Fitri Hari Ke-2',
        description: '2 Syawal - Idul Fitri',
        type: DayType.majorHoliday,
      ));
    } else if (month == 12 && day == 8) {
      events.add(const IslamicDayInfo(
        title: 'Hari Tarwiyah (Puasa Tarwiyah)',
        description: '8 Dzulhijjah - Puasa sunnah persiapan wukuf',
        type: DayType.sunnahFast,
        niatKey: 'tarwiyah',
      ));
    } else if (month == 12 && day == 9) {
      events.add(const IslamicDayInfo(
        title: 'Hari Arafah (Puasa Arafah)',
        description: '9 Dzulhijjah - Menghapus dosa setahun lalu & setahun akan datang',
        type: DayType.sunnahFast,
        niatKey: 'arafah',
      ));
    } else if (month == 12 && day == 10) {
      events.add(const IslamicDayInfo(
        title: 'Hari Raya Idul Adha (10 Dzulhijjah)',
        description: 'Hari Raya Kurban - Diharamkan berpuasa',
        type: DayType.haramFast,
      ));
    } else if (month == 12 && (day == 11 || day == 12 || day == 13)) {
      events.add(IslamicDayInfo(
        title: 'Hari Tasyrik ($day Dzulhijjah)',
        description: 'Hari makan, minum, & mengingat Allah - Diharamkan berpuasa',
        type: DayType.haramFast,
      ));
    }

    // 2. Puasa Wajib Ramadhan
    if (month == 9 && day != 1) {
      events.add(IslamicDayInfo(
        title: 'Puasa Ramadhan Hari ke-$day',
        description: 'Ibadah puasa wajib bulan suci Ramadhan',
        type: DayType.wajibFast,
        niatKey: 'ramadhan',
      ));
    }

    // 3. Puasa Ayyamul Bidh (13, 14, 15 tiap bulan kecuali Ramadhan dan 13 Dzulhijjah)
    if ((day == 13 || day == 14 || day == 15) && month != 9 && !(month == 12 && day == 13)) {
      events.add(IslamicDayInfo(
        title: 'Puasa Ayyamul Bidh ($day ${_hijriMonthNames[month]})',
        description: 'Puasa hari-hari putih di pertengahan bulan Hijriyah',
        type: DayType.sunnahFast,
        niatKey: 'ayyamul_bidh',
      ));
    }

    // 4. Puasa 6 Hari Syawal (2-30 Syawal)
    if (month == 10 && day >= 2 && day <= 30) {
      events.add(const IslamicDayInfo(
        title: 'Puasa Sunnah 6 Hari Syawal',
        description: 'Disunnahkan berpuasa 6 hari di bulan Syawal pahala setara puasa setahun',
        type: DayType.sunnahFast,
        niatKey: 'syawal',
      ));
    }

    // 5. 9 Hari Awal Dzulhijjah (1-7 Dzulhijjah)
    if (month == 12 && day >= 1 && day <= 7) {
      events.add(IslamicDayInfo(
        title: 'Puasa Awal Dzulhijjah (Hari ke-$day)',
        description: 'Amalan terbaik di 10 hari pertama bulan Dzulhijjah',
        type: DayType.sunnahFast,
        niatKey: 'dzulhijjah',
      ));
    }

    // 6. Puasa Senin & Kamis
    final isHaram = (month == 10 && day == 1) || (month == 12 && day >= 10 && day <= 13);
    if (!isHaram && month != 9) {
      if (weekday == DateTime.monday) {
        events.add(const IslamicDayInfo(
          title: 'Puasa Sunnah Senin',
          description: 'Hari dibukanya pintu surga & penyetoran amal ibadah',
          type: DayType.sunnahFast,
          niatKey: 'senin_kamis',
        ));
      } else if (weekday == DateTime.thursday) {
        events.add(const IslamicDayInfo(
          title: 'Puasa Sunnah Kamis',
          description: 'Hari diangkatnya amalan manusia kepada Allah SWT',
          type: DayType.sunnahFast,
          niatKey: 'senin_kamis',
        ));
      }
    }

    return events;
  }

  // --- Hijri to Gregorian Helper ---
  DateTime _getGregorianForHijri(int year, int month, int day) {
    try {
      final h = HijriCalendar()
        ..hYear = year
        ..hMonth = month
        ..hDay = day;
      return h.hijriToGregorian(year, month, day);
    } catch (_) {
      return DateTime.now();
    }
  }

  int _getDaysInHijriMonth(int year, int month) {
    try {
      final h = HijriCalendar();
      return h.getDaysInMonth(year, month);
    } catch (_) {
      return 30;
    }
  }

  void _showNiatPuasaModal(String niatKey) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final niatData = _getNiatPuasaDetail(niatKey);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C853).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: Color(0xFF00C853),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      niatData['title'] ?? 'Lafadz Niat Puasa',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.white10 : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      niatData['arabic'] ?? '',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 22,
                        height: 2.0,
                        fontWeight: FontWeight.w600,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        niatData['latin'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: isDark ? Colors.white70 : Colors.grey.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Artinya: \"${niatData['meaning'] ?? ''}\"",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    "Tutup",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Map<String, String> _getNiatPuasaDetail(String key) {
    switch (key) {
      case 'ramadhan':
        return {
          'title': 'Niat Puasa Ramadhan',
          'arabic': 'نَوَيْتُ صَوْمَ غَدٍ عَنْ أَدَاءِ فَرْضِ شَهْرِ رَمَضَانَ هَذِهِ السَّنَةِ لِلّٰهِ تَعَالَى',
          'latin': "Nawaitu shauma ghadin 'an adaa'i fardhi syahri ramadhaana haadzihis sanati lillaahi ta'aalaa.",
          'meaning': 'Saya berniat puasa esok hari untuk menunaikan kewajiban bulan Ramadhan tahun ini karena Allah Ta\'ala.',
        };
      case 'senin_kamis':
        return {
          'title': 'Niat Puasa Senin / Kamis',
          'arabic': 'نَوَيْتُ صَوْمَ يَوْمِ الِاثْنَيْنِ / الخَمِيْسِ سُنَّةً لِلّٰهِ تَعَالَى',
          'latin': "Nawaitu shauma yaumal itsnaini / yaumal khamiisi sunnatan lillaahi ta'aalaa.",
          'meaning': 'Saya berniat puasa hari Senin / Kamis, sunnah karena Allah Ta\'ala.',
        };
      case 'ayyamul_bidh':
        return {
          'title': 'Niat Puasa Ayyamul Bidh',
          'arabic': 'نَوَيْتُ صَوْمَ أَيَّامِ الْبِيْضِ سُنَّةً لِلّٰهِ تَعَالَى',
          'latin': "Nawaitu shauma ayyaamil biidhi sunnatan lillaahi ta'aalaa.",
          'meaning': 'Saya berniat puasa Ayyamul Bidh (hari-hari putih), sunnah karena Allah Ta\'ala.',
        };
      case 'arafah':
        return {
          'title': 'Niat Puasa Arafah',
          'arabic': 'نَوَيْتُ صَوْمَ عَرَفَةَ سُنَّةً لِلّٰهِ تَعَالَى',
          'latin': "Nawaitu shauma 'arafata sunnatan lillaahi ta'aalaa.",
          'meaning': 'Saya berniat puasa sunnah Arafah karena Allah Ta\'ala.',
        };
      case 'tarwiyah':
        return {
          'title': 'Niat Puasa Tarwiyah',
          'arabic': 'نَوَيْتُ صَوْمَ تَرْوِيَةَ سُنَّةً لِلّٰهِ تَعَالَى',
          'latin': "Nawaitu shauma tarwiyata sunnatan lillaahi ta'aalaa.",
          'meaning': 'Saya berniat puasa sunnah Tarwiyah karena Allah Ta\'ala.',
        };
      case 'asyura':
        return {
          'title': 'Niat Puasa Asyura (10 Muharram)',
          'arabic': 'نَوَيْتُ صَوْمَ عَاشُورَاءَ سُنَّةً لِلّٰهِ تَعَالَى',
          'latin': "Nawaitu shauma 'aasyuuraa-a sunnatan lillaahi ta'aalaa.",
          'meaning': 'Saya berniat puasa sunnah Asyura karena Allah Ta\'ala.',
        };
      case 'tasua':
        return {
          'title': 'Niat Puasa Tasu\'a (9 Muharram)',
          'arabic': 'نَوَيْتُ صَوْمَ تَاسُوعَاءَ سُنَّةً لِلّٰهِ تَعَالَى',
          'latin': "Nawaitu shauma taasuU'aa-a sunnatan lillaahi ta'aalaa.",
          'meaning': 'Saya berniat puasa sunnah Tasu\'a karena Allah Ta\'ala.',
        };
      case 'syawal':
        return {
          'title': 'Niat Puasa 6 Hari Syawal',
          'arabic': 'نَوَيْتُ صَوْمَ سِتَّةِ أَيَّامٍ مِنْ شَهْرِ شَوَّالٍ سُنَّةً لِلّٰهِ تَعَالَى',
          'latin': "Nawaitu shauma sittati ayyaamin min syahri syawwaalin sunnatan lillaahi ta'aalaa.",
          'meaning': 'Saya berniat puasa enam hari di bulan Syawal sunnah karena Allah Ta\'ala.',
        };
      default:
        return {
          'title': 'Niat Puasa Sunnah',
          'arabic': 'نَوَيْتُ صَوْمَ غَدٍ سُنَّةً لِلّٰهِ تَعَالَى',
          'latin': "Nawaitu shauma ghadin sunnatan lillaahi ta'aalaa.",
          'meaning': 'Saya berniat puasa sunnah esok hari karena Allah Ta\'ala.',
        };
    }
  }

  void _showDateConverterModal() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    DateTime tempGregorian = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final convertedHijri = HijriCalendar.fromDate(tempGregorian);
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 16),
                  Text(
                    "Konversi Tanggal Masehi ➔ Hijriah",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Pilih tanggal Masehi untuk mengetahui padanan tanggal Hijriyahnya.",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: isDark ? Colors.white60 : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: isDark ? Colors.white12 : Colors.grey.shade300,
                      ),
                    ),
                    tileColor: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
                    leading: const Icon(Icons.calendar_today_rounded, color: mainColor),
                    title: Text(
                      "Pilih Tanggal Masehi",
                      style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
                    ),
                    subtitle: Text(
                      DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(tempGregorian),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    trailing: const Icon(Icons.edit_calendar_rounded, color: mainColor),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: tempGregorian,
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2099),
                      );
                      if (picked != null) {
                        setModalState(() {
                          tempGregorian = picked;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFB176F2), mainColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hasil Konversi Hijriyah:",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${convertedHijri.hDay} ${_hijriMonthNames[convertedHijri.hMonth]} ${convertedHijri.hYear} H",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(
                            "Tutup",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            Navigator.pop(ctx);
                            setState(() {
                              _currentHijriYear = convertedHijri.hYear;
                              _currentHijriMonth = convertedHijri.hMonth;
                              _selectedDate = convertedHijri;
                            });
                          },
                          child: Text(
                            "Buka di Kalender",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Kalender Hijriah",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz_rounded, color: mainColor),
            tooltip: "Konversi Tanggal",
            onPressed: _showDateConverterModal,
          ),
          IconButton(
            icon: const Icon(Icons.today_rounded, color: mainColor),
            tooltip: "Kembali ke Hari Ini",
            onPressed: _goToToday,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: mainColor,
          unselectedLabelColor: isDark ? Colors.white60 : Colors.grey,
          indicatorColor: mainColor,
          labelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13),
          tabs: const [
            Tab(text: "Kalender"),
            Tab(text: "Hari Besar & Puasa"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCalendarView(isDark),
          _buildAnnualEventsView(isDark),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 1: CALENDAR MONTHLY GRID VIEW
  // ==========================================
  Widget _buildCalendarView(bool isDark) {
    final daysInMonth = _getDaysInHijriMonth(_currentHijriYear, _currentHijriMonth);
    final firstDayG = _getGregorianForHijri(_currentHijriYear, _currentHijriMonth, 1);
    final lastDayG = _getGregorianForHijri(_currentHijriYear, _currentHijriMonth, daysInMonth);

    // Weekday in Dart: 1 = Mon, ..., 7 = Sun. For Sunday as index 0:
    final firstDayWeekdayOffset = firstDayG.weekday % 7;

    // Gregorian range text e.g. "Februari - Maret 2026"
    final gregorianRange = firstDayG.month == lastDayG.month
        ? "${_gregorianMonthNames[firstDayG.month]} ${firstDayG.year}"
        : "${_gregorianMonthNames[firstDayG.month]} – ${_gregorianMonthNames[lastDayG.month]} ${lastDayG.year}";

    final selectedEvents = _getEventsForHijriDate(
      _selectedDate.hYear,
      _selectedDate.hMonth,
      _selectedDate.hDay,
      _getGregorianForHijri(_selectedDate.hYear, _selectedDate.hMonth, _selectedDate.hDay),
    );

    final selectedGregorian = _getGregorianForHijri(
      _selectedDate.hYear,
      _selectedDate.hMonth,
      _selectedDate.hDay,
    );

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // --- Month Header Selector ---
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF282828) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded, size: 28, color: mainColor),
                onPressed: _goToPreviousMonth,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${_hijriMonthNames[_currentHijriMonth]} $_currentHijriYear H",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      gregorianRange,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded, size: 28, color: mainColor),
                onPressed: _goToNextMonth,
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // --- Calendar Grid Container ---
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF282828) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Days of week Header (Ahad - Sab)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) {
                  final isSunday = index == 0;
                  final isFriday = index == 5;
                  return Expanded(
                    child: Center(
                      child: Text(
                        _dayNamesShort[index],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSunday
                              ? const Color(0xFFE53935)
                              : isFriday
                                  ? const Color(0xFF00C853)
                                  : isDark
                                      ? Colors.white60
                                      : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const Divider(height: 16),

              // Monthly Days Grid
              _buildMonthGrid(daysInMonth, firstDayWeekdayOffset, isDark),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // --- Legend / Keterangan Warna ---
        _buildColorLegend(isDark),

        const SizedBox(height: 14),

        // --- Selected Date Detail Card ---
        _buildSelectedDateCard(selectedEvents, selectedGregorian, isDark),
      ],
    );
  }

  Widget _buildMonthGrid(int daysInMonth, int startOffset, bool isDark) {
    final totalCells = ((daysInMonth + startOffset) / 7).ceil() * 7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.88,
        mainAxisSpacing: 6,
        crossAxisSpacing: 4,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        if (index < startOffset || index >= startOffset + daysInMonth) {
          return const SizedBox.shrink();
        }

        final hDay = index - startOffset + 1;
        final gDate = _getGregorianForHijri(_currentHijriYear, _currentHijriMonth, hDay);
        final events = _getEventsForHijriDate(_currentHijriYear, _currentHijriMonth, hDay, gDate);

        final isToday = _todayHijri.hYear == _currentHijriYear &&
            _todayHijri.hMonth == _currentHijriMonth &&
            _todayHijri.hDay == hDay;

        final isSelected = _selectedDate.hYear == _currentHijriYear &&
            _selectedDate.hMonth == _currentHijriMonth &&
            _selectedDate.hDay == hDay;

        final isSunday = (index % 7) == 0;
        final isFriday = (index % 7) == 5;

        final hasMajorHoliday = events.any((e) => e.type == DayType.majorHoliday);
        final hasSunnahFast = events.any((e) => e.type == DayType.sunnahFast);
        final hasWajibFast = events.any((e) => e.type == DayType.wajibFast);
        final hasHaramFast = events.any((e) => e.type == DayType.haramFast);

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              _selectedDate = HijriCalendar()
                ..hYear = _currentHijriYear
                ..hMonth = _currentHijriMonth
                ..hDay = hDay;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? mainColor
                  : isToday
                      ? mainColor.withValues(alpha: 0.15)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? mainColor
                    : isToday
                        ? mainColor.withValues(alpha: 0.5)
                        : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hijri Date Number
                Text(
                  "$hDay",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : isSunday
                            ? const Color(0xFFE53935)
                            : isFriday
                                ? const Color(0xFF00C853)
                                : isDark
                                    ? Colors.white
                                    : Colors.black87,
                  ),
                ),
                // Small Gregorian Day
                Text(
                  "${gDate.day} ${_gregorianMonthNames[gDate.month].substring(0, 3)}",
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.85)
                        : isDark
                            ? Colors.white54
                            : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                // Event Indicator Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (hasHaramFast)
                      Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE53935),
                          shape: BoxShape.circle,
                        ),
                      )
                    else ...[
                      if (hasMajorHoliday)
                        Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFFFFB300),
                            shape: BoxShape.circle,
                          ),
                        ),
                      if (hasSunnahFast)
                        Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFF00C853),
                            shape: BoxShape.circle,
                          ),
                        ),
                      if (hasWajibFast)
                        Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFF7E57C2),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorLegend(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF222222) : const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildLegendDot(const Color(0xFF00C853), "Puasa Sunnah", isDark),
            const SizedBox(width: 12),
            _buildLegendDot(const Color(0xFFFFB300), "Hari Besar", isDark),
            const SizedBox(width: 12),
            _buildLegendDot(const Color(0xFF7E57C2), "Ramadhan", isDark),
            const SizedBox(width: 12),
            _buildLegendDot(const Color(0xFFE53935), "Haram Puasa", isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: isDark ? Colors.white60 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedDateCard(
    List<IslamicDayInfo> events,
    DateTime gDate,
    bool isDark,
  ) {
    final hDay = _selectedDate.hDay;
    final hMonth = _selectedDate.hMonth;
    final hYear = _selectedDate.hYear;

    final weekdayIndo = [
      '',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      "Jum'at",
      'Sabtu',
      'Ahad',
    ][gDate.weekday];

    final isToday = _todayHijri.hYear == hYear &&
        _todayHijri.hMonth == hMonth &&
        _todayHijri.hDay == hDay;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF282828) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                      "$weekdayIndo, $hDay ${_hijriMonthNames[hMonth]} $hYear H",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      DateFormat('d MMMM yyyy', 'id_ID').format(gDate),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: mainColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isToday)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: mainColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Hari Ini",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),
            ],
          ),
          const Divider(height: 20),
          if (events.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: isDark ? Colors.white38 : Colors.grey.shade400,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Tidak ada agenda puasa khusus pada hari ini.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDark ? Colors.white54 : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: events.map((event) {
                final isFast = event.type == DayType.sunnahFast || event.type == DayType.wajibFast;
                Color badgeColor;
                IconData badgeIcon;

                switch (event.type) {
                  case DayType.majorHoliday:
                    badgeColor = const Color(0xFFFFB300);
                    badgeIcon = Icons.star_rounded;
                    break;
                  case DayType.sunnahFast:
                    badgeColor = const Color(0xFF00C853);
                    badgeIcon = Icons.eco_rounded;
                    break;
                  case DayType.wajibFast:
                    badgeColor = const Color(0xFF7E57C2);
                    badgeIcon = Icons.nights_stay_rounded;
                    break;
                  case DayType.haramFast:
                    badgeColor = const Color(0xFFE53935);
                    badgeIcon = Icons.block_rounded;
                    break;
                  case DayType.event:
                    badgeColor = const Color(0xFF00B0FF);
                    badgeIcon = Icons.event_available_rounded;
                    break;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(badgeIcon, color: badgeColor, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              event.description,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: isDark ? Colors.white60 : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isFast && event.niatKey != null) ...[
                        const SizedBox(width: 8),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: badgeColor,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => _showNiatPuasaModal(event.niatKey!),
                          child: Text(
                            "Niat",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 2: ANNUAL ISLAMIC EVENTS & FASTINGS
  // ==========================================
  Widget _buildAnnualEventsView(bool isDark) {
    final List<Map<String, dynamic>> majorEvents = [
      {
        'month': 1,
        'day': 1,
        'title': 'Tahun Baru Islam (1 Muharram)',
        'desc': 'Awal tahun baru penanggalan Hijriyah.',
        'type': DayType.majorHoliday,
      },
      {
        'month': 1,
        'day': 9,
        'title': 'Puasa Tasu\'a (9 Muharram)',
        'desc': 'Puasa sunnah penyerta sebelum hari Asyura.',
        'type': DayType.sunnahFast,
        'niatKey': 'tasua',
      },
      {
        'month': 1,
        'day': 10,
        'title': 'Hari Asyura & Puasa Asyura (10 Muharram)',
        'desc': 'Puasa sunnah dengan keutamaan menghapus dosa setahun lalu.',
        'type': DayType.sunnahFast,
        'niatKey': 'asyura',
      },
      {
        'month': 3,
        'day': 12,
        'title': 'Maulid Nabi Muhammad SAW (12 Rabi\'ul Awwal)',
        'desc': 'Peringatan hari kelahiran Nabi Muhammad SAW.',
        'type': DayType.majorHoliday,
      },
      {
        'month': 7,
        'day': 27,
        'title': 'Isra Mi\'raj Nabi Muhammad SAW (27 Rajab)',
        'desc': 'Peristiwa mukjizat Rasulullah & perintah shalat 5 waktu.',
        'type': DayType.majorHoliday,
      },
      {
        'month': 8,
        'day': 15,
        'title': 'Malam Nisfu Sya\'ban (15 Sya\'ban)',
        'desc': 'Malam pertengahan bulan Sya\'ban yang penuh rahmat.',
        'type': DayType.event,
      },
      {
        'month': 9,
        'day': 1,
        'title': 'Awal Puasa Ramadhan (1 Ramadhan)',
        'desc': 'Hari pertama menjalankan ibadah puasa wajib satu bulan penuh.',
        'type': DayType.wajibFast,
        'niatKey': 'ramadhan',
      },
      {
        'month': 9,
        'day': 17,
        'title': 'Nuzulul Qur\'an (17 Ramadhan)',
        'desc': 'Peristiwa pertama kali diturunkannya wahyu Al-Qur\'an.',
        'type': DayType.event,
      },
      {
        'month': 9,
        'day': 21,
        'title': 'Malam Lailatul Qadar (10 Hari Terakhir)',
        'desc': 'Malam yang lebih baik dari seribu bulan.',
        'type': DayType.event,
      },
      {
        'month': 10,
        'day': 1,
        'title': 'Hari Raya Idul Fitri (1-2 Syawal)',
        'desc': 'Hari raya kemenangan umat Islam setelah sebulan berpuasa.',
        'type': DayType.majorHoliday,
      },
      {
        'month': 10,
        'day': 2,
        'title': 'Puasa Sunnah 6 Hari Syawal (2-30 Syawal)',
        'desc': 'Pahala puasa setara dengan puasa setahun penuh.',
        'type': DayType.sunnahFast,
        'niatKey': 'syawal',
      },
      {
        'month': 12,
        'day': 1,
        'title': '10 Hari Pertama Dzulhijjah (1-9 Dzulhijjah)',
        'desc': 'Hari-hari yang paling dicintai Allah untuk beramal shalih.',
        'type': DayType.sunnahFast,
        'niatKey': 'dzulhijjah',
      },
      {
        'month': 12,
        'day': 8,
        'title': 'Hari Tarwiyah (8 Dzulhijjah)',
        'desc': 'Puasa sunnah sehari sebelum hari wukuf Arafah.',
        'type': DayType.sunnahFast,
        'niatKey': 'tarwiyah',
      },
      {
        'month': 12,
        'day': 9,
        'title': 'Hari Arafah (9 Dzulhijjah)',
        'desc': 'Puasa sunnah keutamaan menghapus dosa 2 tahun (lalu & akan datang).',
        'type': DayType.sunnahFast,
        'niatKey': 'arafah',
      },
      {
        'month': 12,
        'day': 10,
        'title': 'Hari Raya Idul Adha (10 Dzulhijjah)',
        'desc': 'Hari raya qurban dan penyembelihan hewan kurban.',
        'type': DayType.majorHoliday,
      },
      {
        'month': 12,
        'day': 11,
        'title': 'Hari Tasyrik (11-13 Dzulhijjah)',
        'desc': 'Hari tasyrik kurban - Diharamkan berpuasa.',
        'type': DayType.haramFast,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: majorEvents.length,
      itemBuilder: (context, index) {
        final event = majorEvents[index];
        final month = event['month'] as int;
        final day = event['day'] as int;
        final title = event['title'] as String;
        final desc = event['desc'] as String;
        final type = event['type'] as DayType;
        final niatKey = event['niatKey'] as String?;

        final gDate = _getGregorianForHijri(_currentHijriYear, month, day);

        Color badgeColor;
        IconData badgeIcon;

        switch (type) {
          case DayType.majorHoliday:
            badgeColor = const Color(0xFFFFB300);
            badgeIcon = Icons.star_rounded;
            break;
          case DayType.sunnahFast:
            badgeColor = const Color(0xFF00C853);
            badgeIcon = Icons.eco_rounded;
            break;
          case DayType.wajibFast:
            badgeColor = const Color(0xFF7E57C2);
            badgeIcon = Icons.nights_stay_rounded;
            break;
          case DayType.haramFast:
            badgeColor = const Color(0xFFE53935);
            badgeIcon = Icons.block_rounded;
            break;
          case DayType.event:
            badgeColor = const Color(0xFF00B0FF);
            badgeIcon = Icons.event_available_rounded;
            break;
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF282828) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(badgeIcon, color: badgeColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Perkiraan Masehi: ${DateFormat('d MMMM yyyy', 'id_ID').format(gDate)}",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: isDark ? Colors.white60 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (niatKey != null)
                IconButton(
                  icon: const Icon(Icons.menu_book_rounded, color: mainColor, size: 20),
                  tooltip: "Lihat Niat",
                  onPressed: () => _showNiatPuasaModal(niatKey),
                ),
            ],
          ),
        );
      },
    );
  }
}

enum DayType {
  majorHoliday,
  sunnahFast,
  wajibFast,
  haramFast,
  event,
}

class IslamicDayInfo {
  final String title;
  final String description;
  final DayType type;
  final String? niatKey;

  const IslamicDayInfo({
    required this.title,
    required this.description,
    required this.type,
    this.niatKey,
  });
}
