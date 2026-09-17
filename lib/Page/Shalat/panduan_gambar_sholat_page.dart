import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';

class ModelVisualStep {
  final int stepNumber;
  final String title;
  final String movementType;
  final String? imageUrl;
  final String description;
  final String? arabic;
  final String? latin;
  final String? translation;
  final List<String> postureChecklist;
  final List<String> commonMistakes;

  const ModelVisualStep({
    required this.stepNumber,
    required this.title,
    required this.movementType,
    this.imageUrl,
    required this.description,
    this.arabic,
    this.latin,
    this.translation,
    required this.postureChecklist,
    required this.commonMistakes,
  });
}

class PanduanGambarSholatPage extends StatefulWidget {
  final int initialIndex;

  const PanduanGambarSholatPage({super.key, this.initialIndex = 0});

  @override
  State<PanduanGambarSholatPage> createState() =>
      _PanduanGambarSholatPageState();
}

class _PanduanGambarSholatPageState extends State<PanduanGambarSholatPage> {
  int _currentMode = 0; // 0 = Gerakan Sholat (12), 1 = Langkah Wudhu (8)
  late PageController _pageController;
  int _currentStepIndex = 0;

  static const List<ModelVisualStep> _sholatSteps = [
    ModelVisualStep(
      stepNumber: 1,
      title: '1. Berdiri Tegak Menghadap Kiblat & Niat',
      movementType: 'berdiri',
      description:
          'Berdiri tegak lurus menghadap kiblat (Qiyam), meluruskan shaf, merapatkan kaki secara wajar, dan memasang niat ikhlas di dalam hati.',
      arabic:
          'أُصَلِّيْ فَرْضَ ... رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ لِلّٰهِ تَعَالَى',
      latin: 'Ushallii fardha ... mustaqbilal qiblati lillaahi ta\'aalaa.',
      translation:
          'Saya berniat sholat fardhu ... menghadap kiblat karena Allah Ta\'ala.',
      postureChecklist: [
        'Badan tegak lurus menghadap kiblat.',
        'Pandangan mata tertuju ke tempat sujud.',
        'Kedua kaki dibuka selebar bahu secara wajar.',
      ],
      commonMistakes: [
        'Pandangan mata menengadah ke atas atau melirik ke kanan-kiri.',
        'Kaki dibuka terlalu lebar atau terlalu rapat.',
      ],
    ),
    ModelVisualStep(
      stepNumber: 2,
      title: '2. Takbiratul Ihram',
      movementType: 'takbir',
      description:
          'Mengangkat kedua tangan sejajar telinga (bagi pria) atau sejajar dada/bahu (bagi wanita) sambil mengucapkan takbir.',
      arabic: 'اللهُ أَكْبَرُ',
      latin: 'Allaahu Akbar',
      translation: 'Allah Maha Besar.',
      postureChecklist: [
        'Telapak tangan dibuka menghadap kiblat.',
        'Jari-jemari tidak terlalu direnggangkan dan tidak digenggam.',
        'Ujung ibu jari sejajar daun telinga bawah / bahu.',
      ],
      commonMistakes: [
        'Mengangkat tangan terlalu tinggi di atas kepala atau terlalu rendah.',
        'Menggenggam jari-jemari tangan saat takbir.',
      ],
    ),
    ModelVisualStep(
      stepNumber: 3,
      title: '3. Bersedekap & Doa Iftitah',
      movementType: 'sedekap',
      description:
          'Meletakkan telapak tangan kanan di atas pergelangan tangan kiri pada dada / di atas pusar, lalu membaca Doa Iftitah, Al-Fatihah, dan surah pendek.',
      arabic:
          'اللهُ أَكْبَرُ كَبِيْرًا وَالْحَمْدُ لِلّٰهِ كَثِيْرًا وَسُبْحَانَ اللهِ بُكْرَةً وَأَصِيْلًا...',
      latin:
          'Allaahu akbaru kabiiraa walhamdu lillaahi katsiiraa, wa subhaanallaahi bukratan wa ashiilaa...',
      translation:
          'Allah Maha Besar sebesar-besarnya. Dan puji syukur sebanyak-banyaknya bagi Allah...',
      postureChecklist: [
        'Tangan kanan menggenggam / menempel pada pergelangan tangan kiri.',
        'Posisi sedekap berada di atas pusar / pada dada.',
        'Bahu relaks dan tidak tegang.',
      ],
      commonMistakes: [
        'Menempelkan tangan terlalu ke bawah perut.',
        'Membaca terburu-buru tanpa thuma\'ninah.',
      ],
    ),
    ModelVisualStep(
      stepNumber: 4,
      title: '4. Ruku\' & Thuma\'ninah',
      movementType: 'ruku',
      description:
          'Membungkukkan badan dengan punggung lurus mendatar 90 derajat, kedua tangan memegang tempurung lutut, dan jari-jari direnggangkan.',
      arabic: 'سُبْحَانَ رَبِّيَ الْعَظِيْمِ وَبِحَمْدِهِ (٣x)',
      latin: 'Subhaana rabbiyal \'azhiimi wa bihamdih (3x)',
      translation:
          'Maha Suci Tuhanku Yang Maha Agung dan dengan segala puji bagi-Nya.',
      postureChecklist: [
        'Punggung lurus mendatar (jika ditaruh segelas air tidak tumpah).',
        'Kepala lurus sejajar dengan tulang punggung (tidak terlalu menunduk/mendongak).',
        'Kedua tangan mencengkeram lutut dengan jari terbuka.',
      ],
      commonMistakes: [
        'Punggung melengkung / bungkuk.',
        'Kaki ditekuk saat ruku\'.',
        'Tidak diam sejenak (tanpa thuma\'ninah).',
      ],
    ),
    ModelVisualStep(
      stepNumber: 5,
      title: '5. I\'tidal & Thuma\'ninah',
      movementType: 'itidal',
      description:
          'Bangkit tegak berdiri kembali dari ruku\' sambil mengangkat kedua tangan dan membaca tasmi\', lalu membaca doa tahmid.',
      arabic:
          'سَمِعَ اللهُ لِمَنْ حَمِدَهُ. رَبَّنَا لَكَ الْحَمْدُ مِلْءُ السَّمٰوَاتِ وَمِلْءُ الأَرْضِ...',
      latin:
          'Sami\'allaahu liman hamidah. Rabbanaa lakal hamdu mil\'us samaawaati wa mil\'ul ardhi...',
      translation:
          'Allah mendengar orang yang memuji-Nya. Ya Tuhan kami, bagi-Mu lah segala puji...',
      postureChecklist: [
        'Berdiri tegak lurus sempurna.',
        'Kedua tangan dilepas lurus ke samping badan secara wajar.',
        'Diam sejenak thuma\'ninah sekurang-kurangnya selama membaca satu tasbih.',
      ],
      commonMistakes: [
        'Langsung sujud sebelum badan berdiri tegak sempurna.',
        'Tangan bergerak-gerak tidak tenang.',
      ],
    ),
    ModelVisualStep(
      stepNumber: 6,
      title: '6. Sujud & Thuma\'ninah',
      movementType: 'sujud',
      description:
          'Menempelkan 7 anggota badan ke lantai: dahi bersama hidung, kedua telapak tangan, kedua lutut, dan ujung jari-jemari kedua kaki.',
      arabic: 'سُبْحَانَ رَبِّيَ الأَعْلَى وَبِحَمْدِهِ (٣x)',
      latin: 'Subhaana rabbiyal a\'laa wa bihamdih (3x)',
      translation:
          'Maha Suci Tuhanku Yang Maha Tinggi dan dengan segala puji bagi-Nya.',
      postureChecklist: [
        'Dahi dan hidung menempel kuat pada sajadah.',
        'Kedua telapak tangan sejajar bahu dengan jari rapat menghadap kiblat.',
        'Kedua siku diangkat tidak menyentuh lantai.',
        'Ujung jari kedua kaki ditekuk menghadap kiblat dan kedua tumit dirapatkan.',
      ],
      commonMistakes: [
        'Hidung tidak menempel di lantai.',
        'Menempelkan siku tangan ke lantai seperti anjing mendekam.',
        'Kaki terangkat melayang dari lantai saat sujud.',
      ],
    ),
    ModelVisualStep(
      stepNumber: 7,
      title: '7. Duduk di Antara Dua Sujud (Iftirasy)',
      movementType: 'duduk',
      description:
          'Bangkit dari sujud pertama lalu duduk iftirasy: menduduki telapak kaki kiri dan menegakkan telapak kaki kanan dengan jari menekuk ke kiblat.',
      arabic:
          'رَبِّ اغْفِرْ لِيْ وَارْحَمْنِيْ وَاجْبُرْنِيْ وَارْفَعْنِيْ وَارْزُقْنِيْ وَاهْدِنِيْ وَعَافِنِيْ وَاعْفُ عَنِّيْ',
      latin:
          'Rabbighfirlii warhamnii wajburnii warfa\'nii warzuqnii wahdinii wa\'aafinii wa\'fu \'annii.',
      translation:
          'Ya Tuhanku ampunilah aku, rahmatilah aku, cukupkanlah kekuranganku, angkatlah derajatku, berilah aku rezeki, petunjuk, kesehatan dan maafkanlah aku.',
      postureChecklist: [
        'Duduk tegak di atas telapak kaki kiri.',
        'Telapak kaki kanan ditegakkan dengan jari menghadap kiblat.',
        'Kedua tangan diletakkan di atas paha dekat lutut dengan jari merapat.',
      ],
      commonMistakes: [
        'Duduk di atas kedua tumit (Iq\'a yang dilarang).',
        'Membaca doa terlalu cepat tanpa thuma\'ninah.',
      ],
    ),
    ModelVisualStep(
      stepNumber: 8,
      title: '8. Duduk Tasyahud Awal',
      movementType: 'tasyahud_awal',
      description:
          'Duduk iftirasy pada rakaat kedua sholat 3 atau 4 rakaat, meletakkan tangan di atas paha dan mengangkat telunjuk kanan saat membaca syahadat.',
      arabic:
          'التَّحِيَّاتُ الْمُبَارَكَاتُ الصَّلَوَاتُ الطَّيِّبَاتُ لِلّٰهِ... أَشْهَدُ أَنْ لاَ إِلٰهَ إِلاَّ اللهُ...',
      latin:
          'Attahiyyaatul mubaarakaatush shalawaatuth thayyibaatu lillaah... Asyhadu allaa ilaaha illallaah...',
      translation:
          'Segala kehormatan, keberkahan, shalawat dan kebaikan adalah milik Allah... Aku bersaksi tiada tuhan selain Allah...',
      postureChecklist: [
        'Duduk iftirasy seperti duduk antara dua sujud.',
        'Tangan kanan menggenggam jari selain telunjuk.',
        'Telunjuk kanan diangkat mengarah ke kiblat saat lafadz "Illallah".',
      ],
      commonMistakes: [
        'Menggerak-gerakkan telunjuk secara berlebihan.',
        'Lupa tasyahud awal (disunnahkan sujud sahwi).',
      ],
    ),
    ModelVisualStep(
      stepNumber: 9,
      title: '9. Duduk Tasyahud Akhir (Tawarruk)',
      movementType: 'tasyahud_akhir',
      description:
          'Duduk tawarruk pada rakaat terakhir: mendudukkan pinggul kiri langsung di atas lantai dan menyelipkan kaki kiri di bawah betis kanan.',
      arabic:
          'التَّحِيَّاتُ الْمُبَارَكَاتُ... اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ وَعَلَى آلِ سَيِّدِنَا مُحَمَّدٍ...',
      latin:
          'Attahiyyaatul mubaarakaatush... Allaahumma shalli \'alaa sayyidinaa Muhammad...',
      translation:
          'Segala kehormatan... Ya Allah limpahkanlah shalawat kepada junjungan kami Nabi Muhammad...',
      postureChecklist: [
        'Bokong / pinggul kiri menempel langsung ke lantai.',
        'Kaki kiri keluar di bawah kaki kanan.',
        'Kaki kanan tetap ditegakkan.',
        'Membaca Tasyahud, Shalawat Ibrahimiyah, dan doa perlindungan fitnah Dajjal.',
      ],
      commonMistakes: [
        'Duduk iftirasy saat tasyahud akhir (kecuali ada uzur sendi/lutut).',
      ],
    ),
    ModelVisualStep(
      stepNumber: 10,
      title: '10. Salam (Menoleh ke Kanan & Kiri)',
      movementType: 'salam',
      description:
          'Menolehkan kepala ke kanan hingga pipi terlihat dari belakang sambil mengucap salam pertama (Rukun), lalu menoleh ke kiri (Sunnah).',
      arabic: 'السَّلاَمُ عَلَيْكُمْ وَرَحْمَةُ اللهِ',
      latin: 'Assalaamu \'alaikum wa rahmatullaah',
      translation: 'Semoga keselamatan dan rahmat Allah tercurah kepadamu.',
      postureChecklist: [
        'Salam pertama menoleh ke arah kanan hingga pipi kanan terlihat dari belakang.',
        'Salam kedua menoleh ke arah kiri.',
        'Badan tetap menghadap kiblat, hanya leher dan kepala yang menoleh.',
      ],
      commonMistakes: [
        'Memutar seluruh badan bersamaan dengan kepala saat salam.',
        'Menundukkan kepala ke bawah saat salam.',
      ],
    ),
    ModelVisualStep(
      stepNumber: 11,
      title: '11. Doa Qunut (Khusus Sholat Subuh)',
      movementType: 'qunut',
      description:
          'Mengangkat kedua telapak tangan di depan dada saat i\'tidal rakaat kedua sholat Subuh sebelum sujud.',
      arabic:
          'اَللّٰهُمَّ اهْدِنِيْ فِيْمَنْ هَدَيْتَ، وَعَافِنِيْ فِيْمَنْ عَافَيْتَ، وَتَوَلَّنِيْ فِيْمَنْ تَوَلَّيْتَ...',
      latin:
          'Allaahummah dinii fii man hadait, wa \'aafinii fii man \'aafait...',
      translation:
          'Ya Allah, berilah aku petunjuk sebagaimana orang yang telah Engkau beri petunjuk...',
      postureChecklist: [
        'Kedua tangan diangkat sejajar dada dengan telapak tangan terbuka menengadah ke atas.',
        'Pandangan mata tetap ke tempat sujud.',
      ],
      commonMistakes: [
        'Mengusap wajah setelah selesai qunut (tidak disunnahkan dalam madzhab Syafi\'i saat sholat).',
      ],
    ),
  ];

  static const List<ModelVisualStep> _wudhuSteps = [
    ModelVisualStep(
      stepNumber: 1,
      title: '1. Membasuh Kedua Telapak Tangan & Niat',
      movementType: 'wudhu_tangan',
      description:
          'Membaca Basmalah, berniat dalam hati, lalu membasuh kedua telapak tangan dan menyela-nyela jari hingga bersih sebanyak 3 kali.',
      arabic:
          'نَوَيْتُ الْوُضُوْءَ لِرَفْعِ الْحَدَثِ الأَصْغَرِ فَرْضًا لِلّٰهِ تَعَالَى',
      latin:
          'Nawaitul wudhuu-a liraf\'il hadatsil ashghari fardhan lillaahi ta\'aalaa.',
      translation:
          'Saya berniat wudhu untuk menghilangkan hadats kecil fardhu karena Allah Ta\'ala.',
      postureChecklist: [
        'Basuh telapak, punggung tangan, dan sela-sela jari.',
        'Pastikan tidak ada kotoran yang menghalangi air sampai ke kulit.',
      ],
      commonMistakes: ['Tidak menyela-nyela jari tangan.'],
    ),
    ModelVisualStep(
      stepNumber: 2,
      title: '2. Berkumur-kumur (Madhmadhoh)',
      movementType: 'wudhu_kumur',
      description:
          'Memasukkan air ke dalam mulut menggunakan tangan kanan lalu berkumur-kumur untuk membersihkan sisa makanan sebanyak 3 kali.',
      arabic: 'اَللّٰهُمَّ أَعِنِّيْ عَلَى تِلَاوَةِ كِتَابِكَ وَذِكْرِكَ',
      latin: 'Allaahumma a\'innii \'alaa tilaawati kitaabika wa dzikrika.',
      translation:
          'Ya Allah tolonglah aku untuk membaca kitab-Mu dan berdzikir kepada-Mu.',
      postureChecklist: ['Kumur air hingga ke seluruh sela gigi.'],
      commonMistakes: ['Hanya memasukkan air tanpa berkumur.'],
    ),
    ModelVisualStep(
      stepNumber: 3,
      title: '3. Menghirup Air ke Hidung (Istinsyaq)',
      movementType: 'wudhu_hidung',
      description:
          'Menghirup air ke dalam rongga hidung dengan tangan kanan lalu mengeluarkannya (Istintsar) dengan tangan kiri sebanyak 3 kali.',
      postureChecklist: [
        'Tarik air perlahan agar membersihkan kotoran rongga hidung.',
      ],
      commonMistakes: ['Hanya membasahi ujung hidung luar.'],
    ),
    ModelVisualStep(
      stepNumber: 4,
      title: '4. Membasuh Seluruh Wajah (Rukun)',
      movementType: 'wudhu_wajah',
      description:
          'Membasuh seluruh permukaan wajah dari batas tumbuhnya rambut kepala hingga bawah dagu, dan dari telinga kanan ke telinga kiri sebanyak 3 kali.',
      postureChecklist: [
        'Ratakan air ke seluruh wajah termasuk jenggot/alis.',
        'Hadirkan niat wudhu di dalam hati saat air pertama kali menyentuh wajah.',
      ],
      commonMistakes: [
        'Bagian pinggir dekat telinga atau bawah dagu tidak terkena air.',
      ],
    ),
    ModelVisualStep(
      stepNumber: 5,
      title: '5. Membasuh Kedua Tangan Hingga Siku (Rukun)',
      movementType: 'wudhu_tangan_siku',
      description:
          'Membasuh tangan kanan dari ujung jari hingga melebihi siku 3 kali, kemudian tangan kiri dengan cara yang sama.',
      postureChecklist: [
        'Air harus merata dari ujung kuku hingga melewati siku.',
        'Dahulukan tangan kanan sebelum tangan kiri.',
      ],
      commonMistakes: [
        'Hanya membasahi lengan bawah tanpa meratakan air ke siku.',
      ],
    ),
    ModelVisualStep(
      stepNumber: 6,
      title: '6. Mengusap Sebagian Kepala / Rambut (Rukun)',
      movementType: 'wudhu_kepala',
      description:
          'Membasahi kedua telapak tangan lalu mengusapkannya ke sebagian kepala atau rambut sebanyak 3 kali.',
      postureChecklist: [
        'Usap kepala dari depan ke belakang lalu kembali ke depan.',
      ],
      commonMistakes: ['Hanya memercikkan setetes air tanpa mengusap.'],
    ),
    ModelVisualStep(
      stepNumber: 7,
      title: '7. Mengusap Kedua Daun Telinga',
      movementType: 'wudhu_telinga',
      description:
          'Memasukkan jari telunjuk ke dalam lubang telinga dan ibu jari mengusap bagian luar daun telinga sebanyak 3 kali.',
      postureChecklist: [
        'Gunakan air baru untuk mengusap kedua telinga secara bersamaan.',
      ],
      commonMistakes: ['Melewatkan bagian lekukan telinga.'],
    ),
    ModelVisualStep(
      stepNumber: 8,
      title: '8. Membasuh Kedua Kaki Hingga Mata Kaki (Rukun)',
      movementType: 'wudhu_kaki',
      description:
          'Membasuh kaki kanan hingga melewati mata kaki sambil menyela-nyela jari kaki dengan jari kelingking tangan kiri 3 kali, lalu kaki kiri.',
      postureChecklist: [
        'Pastikan tumit dan sela-sela jari kaki terbasuh air sempurna.',
      ],
      commonMistakes: ['Tumit bagian belakang kering tidak terkena air.'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<ModelVisualStep> get _activeSteps =>
      _currentMode == 0 ? _sholatSteps : _wudhuSteps;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final steps = _activeSteps;

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
          "Panduan Bergambar",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Segment Mode Toggle (Gerakan Sholat vs Tata Cara Wudhu)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(18),
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black26
                      : Colors.grey.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildModeButton(
                    0,
                    "Gerakan Sholat (11)",
                    Icons.accessibility_new_rounded,
                    isDark,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildModeButton(
                    1,
                    "Tata Cara Wudhu (8)",
                    Icons.water_drop_rounded,
                    isDark,
                  ),
                ),
              ],
            ),
          ),

          // Step Progress Numbers Bar
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final isSelected = _currentStepIndex == index;
                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? mainColor
                          : (isDark
                                ? const Color(0xFF282828)
                                : const Color(0xFFF0F1F5)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        "Langkah ${index + 1}",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                    ? Colors.white70
                                    : Colors.grey.shade700),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Main Step PageView Slider
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: steps.length,
              onPageChanged: (index) {
                setState(() {
                  _currentStepIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final step = steps[index];
                return _buildStepDetailView(step, isDark);
              },
            ),
          ),

          // Bottom Navigation Buttons (Prev - Next)
          Container(
            padding: EdgeInsets.fromLTRB(
              20,
              10,
              20,
              MediaQuery.of(context).padding.bottom + 12,
            ),
            decoration: BoxDecoration(
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black26
                      : Colors.grey.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentStepIndex > 0
                        ? (isDark
                              ? const Color(0xFF282828)
                              : Colors.grey.shade100)
                        : Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _currentStepIndex > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back_rounded, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "Sebelumnya",
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${_currentStepIndex + 1} / ${steps.length}",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _currentStepIndex < steps.length - 1
                      ? () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Alhamdulillah, Anda telah menyelesaikan seluruh panduan gerakan!",
                              ),
                              backgroundColor: mainColor,
                            ),
                          );
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _currentStepIndex < steps.length - 1
                            ? "Berikutnya"
                            : "Selesai",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(
    int modeIndex,
    String label,
    IconData icon,
    bool isDark,
  ) {
    final isSelected = _currentMode == modeIndex;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        setState(() {
          _currentMode = modeIndex;
          _currentStepIndex = 0;
          _pageController.jumpToPage(0);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? mainColor
              : (isDark ? const Color(0xFF282828) : const Color(0xFFF0F1F5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.white70 : Colors.grey.shade700),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.white70 : Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepDetailView(ModelVisualStep step, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Title Header
          Text(
            step.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Illustration Graphic Banner
          // SholatIllustrationWidget(
          //   movementType: step.movementType,
          //   imageUrl: step.imageUrl,
          //   height: 190,
          //   badgeLabel: "Gerakan Ke-${step.stepNumber}",
          // ),
          const SizedBox(height: 16),

          // Description Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF242424) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.grey.shade200,
              ),
            ),
            child: Text(
              step.description,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: isDark ? Colors.white70 : Colors.grey.shade800,
                height: 1.5,
              ),
            ),
          ),

          // Arabic & Prayer Recitation (if available)
          if (step.arabic != null && step.arabic!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF282828)
                    : const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: mainColor.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: mainColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Lafadz Bacaan",
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy_rounded,
                          size: 16,
                          color: mainColor,
                        ),
                        tooltip: "Salin Doa",
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text:
                                  "${step.arabic}\n\n${step.latin}\n\nArtinya: ${step.translation}",
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Bacaan disalin ke clipboard"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    step.arabic!,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                      height: 1.8,
                      fontWeight: FontWeight.w600,
                      color: mainColor,
                    ),
                  ),
                  if (step.latin != null) ...[
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        step.latin!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: isDark ? Colors.white70 : Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                  if (step.translation != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Artinya: \"${step.translation}\"",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],

          const SizedBox(height: 18),

          // Posture Guidance Checklist
          Text(
            "Kaidah Posisi Tubuh yang Benar",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ...step.postureChecklist.map((tip) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF4CAF50),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tip,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDark ? Colors.white70 : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          // Common Mistakes
          if (step.commonMistakes.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              "Kesalahan yang Sering Terjadi",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF44336),
              ),
            ),
            const SizedBox(height: 6),
            ...step.commonMistakes.map((mistake) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.cancel_rounded,
                      color: Color(0xFFF44336),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        mistake,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? Colors.white60 : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}
