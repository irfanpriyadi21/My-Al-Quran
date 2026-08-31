class ModelTajwid {
  final String id;
  final String title;
  final String category; // 'nun_tanwin', 'mim_sukun', 'mad', 'qalqalah', 'alif_lam', 'waqaf_lainnya'
  final String subtitle;
  final String pengertian;
  final String caraBaca;
  final List<String> huruf;
  final String? panjangHarakat;
  final List<ContohTajwid> contoh;

  const ModelTajwid({
    required this.id,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.pengertian,
    required this.caraBaca,
    this.huruf = const [],
    this.panjangHarakat,
    this.contoh = const [],
  });
}

class ContohTajwid {
  final String lafadzArab;
  final String lafadzLatin;
  final String surah;
  final String penjelasan;

  const ContohTajwid({
    required this.lafadzArab,
    required this.lafadzLatin,
    required this.surah,
    required this.penjelasan,
  });
}

class TajwidData {
  static const List<ModelTajwid> list = [
    // ==========================================
    // 1. HUKUM NUN SUKUN (نْ) & TANWIN (ً ٍ ٌ)
    // ==========================================
    ModelTajwid(
      id: 'idzhar_halqi',
      title: 'Idzhar Halqi',
      category: 'nun_tanwin',
      subtitle: 'Membaca jelas tanpa dengung',
      pengertian: 'Idzhar artinya jelas/terang, Halqi artinya tenggorokan. Terjadi apabila Nun Sukun (نْ) atau Tanwin (ً ٍ ٌ) bertemu dengan salah satu dari 6 huruf halq (tenggorokan).',
      caraBaca: 'Nun mati atau tanwin dibaca jelas, terang, dan tegas tanpa ada dengungan sama sekali.',
      huruf: ['ء', 'هـ', 'ع', 'غ', 'ح', 'خ'],
      panjangHarakat: '1 Harakat (Jelas)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'مِنْ حَيْثُ',
          lafadzLatin: 'Min haitsu',
          surah: 'QS. Al-Baqarah',
          penjelasan: 'Nun sukun (نْ) bertemu huruf Ha (ح), dibaca jelas "Min haitsu" tanpa berdengung.',
        ),
        ContohTajwid(
          lafadzArab: 'عَذَابٌ أَلِيْمٌ',
          lafadzLatin: "'Adzaabun aliim",
          surah: 'QS. Al-Baqarah: 10',
          penjelasan: 'Dhommatain bertemu huruf Hamzah/Alif (أ), dibaca jelas "-bun aliim".',
        ),
        ContohTajwid(
          lafadzArab: 'مَنْ آمَنَ',
          lafadzLatin: 'Man aamana',
          surah: 'QS. Al-Baqarah: 62',
          penjelasan: 'Nun sukun bertemu huruf Alif (ء), dibaca terang "Man aamana".',
        ),
      ],
    ),

    ModelTajwid(
      id: 'idgham_bighunnah',
      title: 'Idgham Bighunnah',
      category: 'nun_tanwin',
      subtitle: 'Memasukkan huruf disertai dengung',
      pengertian: 'Idgham artinya memasukkan/melebur, Bighunnah artinya dengan dengung. Terjadi apabila Nun Sukun (نْ) atau Tanwin (ً ٍ ٌ) bertemu dengan salah satu dari 4 huruf: Ya, Nun, Mim, Wawu (disingkat: YANMU).',
      caraBaca: 'Nun sukun atau tanwin dileburkan masuk ke huruf di depannya disertai suara dengung di pangkal hidung (ghunnah) sepanjang 2 harakat.',
      huruf: ['ي', 'ن', 'م', 'و'],
      panjangHarakat: '2 Harakat (Dengung)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'مَنْ يَّقُوْلُ',
          lafadzLatin: 'May yaquulu',
          surah: 'QS. Al-Baqarah: 8',
          penjelasan: 'Nun sukun bertemu Ya (ي), bunyi "n" melebur menjadi "y" berharakat dengung.',
        ),
        ContohTajwid(
          lafadzArab: 'مِنْ وَّرَائِهِمْ',
          lafadzLatin: 'Miw waraa-ihim',
          surah: 'QS. Al-Baqarah: 90',
          penjelasan: 'Nun sukun bertemu Wawu (و), bunyi "n" melebur ke huruf "w" dengan dengung.',
        ),
        ContohTajwid(
          lafadzArab: 'حَبْلٌ مِّنْ مَّسَدٍ',
          lafadzLatin: 'Hablum mim masad',
          surah: 'QS. Al-Lahab: 5',
          penjelasan: 'Dhommatain bertemu Mim (م), melebur menjadi "-lum mim" berdengung.',
        ),
      ],
    ),

    ModelTajwid(
      id: 'idgham_bilaghunnah',
      title: 'Idgham Bilaghunnah',
      category: 'nun_tanwin',
      subtitle: 'Memasukkan huruf tanpa dengung',
      pengertian: 'Idgham artinya memasukkan, Bilaghunnah artinya tanpa dengung. Terjadi apabila Nun Sukun (نْ) atau Tanwin (ً ٍ ٌ) bertemu dengan huruf Lam (ل) atau Ra (ر).',
      caraBaca: 'Nun sukun atau tanwin dimasukkan/dileburkan sepenuhnya ke dalam huruf Lam atau Ra tanpa ditahan dan tanpa mendengung.',
      huruf: ['ل', 'ر'],
      panjangHarakat: 'Tanpa dengung',
      contoh: [
        ContohTajwid(
          lafadzArab: 'مِنْ لَّدُنْهُ',
          lafadzLatin: 'Mil ladunhu',
          surah: 'QS. Al-Kahfi: 2',
          penjelasan: 'Nun sukun bertemu Lam (ل), langsung dibaca "Mil ladunhu" tanpa dengung.',
        ),
        ContohTajwid(
          lafadzArab: 'مِنْ رَّبِّهِمْ',
          lafadzLatin: 'Mir rabbihim',
          surah: 'QS. Al-Baqarah: 5',
          penjelasan: 'Nun sukun bertemu Ra (ر), langsung dilebur menjadi "Mir rabbihim".',
        ),
        ContohTajwid(
          lafadzArab: 'غَفُوْرٌ رَّحِيْمٌ',
          lafadzLatin: 'Ghafuurur rahiim',
          surah: 'QS. Al-Baqarah: 173',
          penjelasan: 'Dhommatain bertemu Ra (ر), dibaca lebur "-rur rahiim" tanpa dengung.',
        ),
      ],
    ),

    ModelTajwid(
      id: 'iqlab',
      title: 'Iqlab',
      category: 'nun_tanwin',
      subtitle: 'Mengubah bunyi Nun/Tanwin menjadi Mim',
      pengertian: 'Iqlab artinya menukar/mengganti. Terjadi apabila Nun Sukun (نْ) atau Tanwin (ً ٍ ٌ) bertemu dengan huruf Ba (ب). Di dalam mushaf Al-Qur\'an biasanya ditandai dengan huruf Mim kecil (م) di atasnya.',
      caraBaca: 'Bunyi "n" pada nun sukun atau tanwin diganti menjadi bunyi "m" disertai dengungan ringan di bibir sepanjang 2 harakat.',
      huruf: ['ب'],
      panjangHarakat: '2 Harakat (Dengung)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'مِنْ بَعْدِ',
          lafadzLatin: 'Mim ba\'di',
          surah: 'QS. Al-Baqarah: 27',
          penjelasan: 'Nun sukun bertemu Ba (ب), dibaca "Mim ba\'di" dengan merapatkan kedua bibir berdengung.',
        ),
        ContohTajwid(
          lafadzArab: 'سَمِيْعٌ بَصِيْرٌ',
          lafadzLatin: 'Samii\'um bashiir',
          surah: 'QS. Al-Hajj: 61',
          penjelasan: 'Dhommatain bertemu Ba (ب), dibaca "-\'um bashiir".',
        ),
        ContohTajwid(
          lafadzArab: 'أَنْۢبِئْهُمْ',
          lafadzLatin: 'Ambi\'hum',
          surah: 'QS. Al-Baqarah: 33',
          penjelasan: 'Nun sukun bertemu Ba (ب) dalam satu kata, dibaca "Ambi\'hum".',
        ),
      ],
    ),

    ModelTajwid(
      id: 'ikhfa_haqiqi',
      title: 'Ikhfa Haqiqi',
      category: 'nun_tanwin',
      subtitle: 'Membaca samar disertai dengung',
      pengertian: 'Ikhfa artinya menyamarkan/menyembunyikan. Terjadi apabila Nun Sukun (نْ) atau Tanwin (ً ٍ ٌ) bertemu dengan salah satu dari 15 huruf Ikhfa.',
      caraBaca: 'Nun sukun atau tanwin dibaca antara Idzhar dan Idgham (samar-samar menuju makhraj huruf berikutnya) disertai dengung 2 harakat.',
      huruf: ['ت', 'ث', 'ج', 'د', 'ذ', 'ز', 'س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ف', 'ق', 'ك'],
      panjangHarakat: '2 Harakat (Samar Dengung)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'مِنْ دُوْنِ اللّٰهِ',
          lafadzLatin: 'Min duunillaah (samar)',
          surah: 'QS. Al-Baqarah: 23',
          penjelasan: 'Nun sukun bertemu Dal (د), bunyi "n" disamarkan menuju makhraj dal.',
        ),
        ContohTajwid(
          lafadzArab: 'مِنْ قَبْلُ',
          lafadzLatin: 'Ming qablu (tebal)',
          surah: 'QS. Al-Baqarah: 25',
          penjelasan: 'Nun sukun bertemu Qaf (ق), bunyi samar cenderung tebal "ng" di pangkal lidah.',
        ),
        ContohTajwid(
          lafadzArab: 'كُنْتُمْ',
          lafadzLatin: 'Kuntum (samar)',
          surah: 'QS. Al-Baqarah: 23',
          penjelasan: 'Nun sukun bertemu Ta (ت), bunyi nun disamarkan tipis mendekati huruf ta.',
        ),
      ],
    ),

    // ==========================================
    // 2. HUKUM MIM SUKUN (مْ)
    // ==========================================
    ModelTajwid(
      id: 'ikhfa_syafawi',
      title: 'Ikhfa Syafawi',
      category: 'mim_sukun',
      subtitle: 'Mim sukun bertemu huruf Ba (ب)',
      pengertian: 'Syafawi artinya bibir. Terjadi apabila Mim Sukun (مْ) bertemu dengan huruf Ba (ب).',
      caraBaca: 'Mim sukun dibaca samar di kedua bibir dengan merapatkan bibir ringan dan disertai dengungan sepanjang 2 harakat.',
      huruf: ['ب'],
      panjangHarakat: '2 Harakat (Dengung)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'تَرْمِيْهِمْ بِحِجَارَةٍ',
          lafadzLatin: 'Tarmiihim bihijaarah',
          surah: 'QS. Al-Fiil: 4',
          penjelasan: 'Mim sukun bertemu Ba (ب), bibir dirapatkan lembut sambil mendengung.',
        ),
        ContohTajwid(
          lafadzArab: 'يَعْتَصِمْ بِاللّٰهِ',
          lafadzLatin: "Ya'tashim billaah",
          surah: 'QS. Ali Imran: 101',
          penjelasan: 'Mim sukun bertemu Ba (ب), dibaca samar berdengung.',
        ),
      ],
    ),

    ModelTajwid(
      id: 'idgham_mimi',
      title: 'Idgham Mimi / Mitslain',
      category: 'mim_sukun',
      subtitle: 'Mim sukun bertemu huruf Mim (م)',
      pengertian: 'Terjadi apabila Mim Sukun (مْ) bertemu dengan huruf Mim (م) berharakat.',
      caraBaca: 'Mim pertama dileburkan sepenuhnya ke dalam Mim kedua seolah-olah bertasydid (مّ) disertai dengung 2 harakat.',
      huruf: ['م'],
      panjangHarakat: '2 Harakat (Dengung)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'فِيْ قُلُوْبِهِمْ مَّرَضٌ',
          lafadzLatin: 'Fii quluubihim maradh',
          surah: 'QS. Al-Baqarah: 10',
          penjelasan: 'Mim sukun melebur ke huruf mim berikutnya "-him maradun" berdengung.',
        ),
        ContohTajwid(
          lafadzArab: 'أَطْعَمَهُمْ مِّنْ جُوْعٍ',
          lafadzLatin: "Ath'amahum min juu'",
          surah: 'QS. Quraisy: 4',
          penjelasan: 'Mim sukun bertemu Mim, dibaca lebur bertasydid dan berdengung.',
        ),
      ],
    ),

    ModelTajwid(
      id: 'idzhar_syafawi',
      title: 'Idzhar Syafawi',
      category: 'mim_sukun',
      subtitle: 'Mim sukun bertemu selain huruf Mim & Ba',
      pengertian: 'Terjadi apabila Mim Sukun (مْ) bertemu dengan salah satu dari 26 huruf hijaiyah selain huruf Mim (م) dan Ba (ب).',
      caraBaca: 'Mim sukun dibaca terang, jelas, dan bibir dirapatkan tanpa dengung sama sekali. Terutama jika bertemu huruf Wawu (و) dan Fa (ف), harus ekstra jelas agar tidak tertukar dengan ikhfa.',
      huruf: ['26 Huruf Hijaiyah selain م dan ب'],
      panjangHarakat: '1 Harakat (Jelas)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'أَنْعَمْتَ عَلَيْهِمْ',
          lafadzLatin: "An'amta 'alaihim",
          surah: 'QS. Al-Fatihah: 7',
          penjelasan: 'Mim sukun bertemu Ta (ت) pada kata "An\'amta", dibaca jelas tanpa dengung.',
        ),
        ContohTajwid(
          lafadzArab: 'لَمْ يَلِدْ وَلَمْ يُوْلَدْ',
          lafadzLatin: 'Lam yalid wa lam yuulad',
          surah: 'QS. Al-Ikhlas: 3',
          penjelasan: 'Mim sukun bertemu Ya (ي) dan Wawu (و), dibaca jelas dan tegas.',
        ),
      ],
    ),

    // ==========================================
    // 3. HUKUM QALQALAH (MEMANTUL)
    // ==========================================
    ModelTajwid(
      id: 'qalqalah_sughra',
      title: 'Qalqalah Sughra',
      category: 'qalqalah',
      subtitle: 'Pantulan ringan di tengah kata',
      pengertian: 'Qalqalah artinya getaran/pantulan suara. Sughra artinya kecil/ringan. Terjadi apabila huruf Qalqalah (Ba, Jim, Dal, Tha, Qaf / disingkat BAJUDITOKO) berharakat sukun ASLI dan berada di tengah kata.',
      caraBaca: 'Huruf qalqalah dipantulkan secara ringan tanpa ada jeda atau henti.',
      huruf: ['ق', 'ط', 'ب', 'ج', 'د'],
      contoh: [
        ContohTajwid(
          lafadzArab: 'يَجْعَلُوْنَ',
          lafadzLatin: "Yaj'aluun",
          surah: 'QS. Al-Baqarah: 19',
          penjelasan: 'Huruf Jim (جْ) mati di tengah kata, dipantulkan ringan "Yaj-..".',
        ),
        ContohTajwid(
          lafadzArab: 'يَقْطَعُوْنَ',
          lafadzLatin: "Yaqtha'uun",
          surah: 'QS. Al-Baqarah: 27',
          penjelasan: 'Huruf Qaf (قْ) mati di tengah kata, dipantulkan ringan.',
        ),
        ContohTajwid(
          lafadzArab: 'إِبْرَاهِيْمُ',
          lafadzLatin: 'Ibraahiim',
          surah: 'QS. Al-Baqarah: 124',
          penjelasan: 'Huruf Ba (بْ) sukun di tengah kata, dipantulkan ringan "Ib-..".',
        ),
      ],
    ),

    ModelTajwid(
      id: 'qalqalah_kubra',
      title: 'Qalqalah Kubra',
      category: 'qalqalah',
      subtitle: 'Pantulan kuat di akhir ayat/waqaf',
      pengertian: 'Kubra artinya besar/kuat. Terjadi apabila huruf Qalqalah berada di AKHIR kata/ayat dan dibaca mati karena waqaf (berhenti).',
      caraBaca: 'Huruf qalqalah dipantulkan dengan pantulan yang jelas, mantap, dan kuat.',
      huruf: ['ق', 'ط', 'ب', 'ج', 'د'],
      contoh: [
        ContohTajwid(
          lafadzArab: 'قُلْ هُوَ اللّٰهُ أَحَدٌ ۚ',
          lafadzLatin: "Qul huwallaahu ahad",
          surah: 'QS. Al-Ikhlas: 1',
          penjelasan: 'Huruf Dal (د) di akhir ayat dibaca waqaf, dipantulkan kuat "Ahad-de".',
        ),
        ContohTajwid(
          lafadzArab: 'مِنْ شَرِّ مَا خَلَقَ ۙ',
          lafadzLatin: 'Min syarri maa khalaq',
          surah: 'QS. Al-Falaq: 2',
          penjelasan: 'Huruf Qaf (ق) di akhir ayat dipantulkan mantap "Khalaq-qe".',
        ),
        ContohTajwid(
          lafadzArab: 'تَبَّتْ يَدَا أَبِيْ لَهَبٍ وَّتَبَّ ۗ',
          lafadzLatin: '...wa tabb',
          surah: 'QS. Al-Lahab: 1',
          penjelasan: 'Huruf Ba bertasydid di akhir ayat (Qalqalah Akbar/Sangat Besar), ditekan sejenak lalu dipantulkan kuat.',
        ),
      ],
    ),

    // ==========================================
    // 4. HUKUM MAD (BACAAN PANJANG)
    // ==========================================
    ModelTajwid(
      id: 'mad_thabii',
      title: 'Mad Thabi\'i (Mad Asli)',
      category: 'mad',
      subtitle: 'Panjang dasar 2 harakat (1 alif)',
      pengertian: 'Mad artinya panjang, Thabi\'i artinya alami/asli. Terjadi jika: Fathah diikuti Alif (ـَ + ا), Kasrah diikuti Ya sukun (ـِ + يْ), atau Dhammah diikuti Wawu sukun (ـُ + وْ).',
      caraBaca: 'Dibaca panjang 2 harakat (1 ketukan alif / 1 ayunan).',
      huruf: ['ا', 'و', 'ي'],
      panjangHarakat: '2 Harakat (1 Alif)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'نُوْحِيْهَا',
          lafadzLatin: 'Nuu-hii-haa',
          surah: 'QS. Hud: 49',
          penjelasan: 'Kata ini menghimpun ketiga huruf mad: Nuu (wawu), hii (ya), haa (alif), masing-masing dibaca 2 harakat.',
        ),
        ContohTajwid(
          lafadzArab: 'قَالُوْا',
          lafadzLatin: 'Qaaluu',
          surah: 'QS. Al-Baqarah: 11',
          penjelasan: 'Qaa (fathah + alif) dan Luu (dhammah + wawu), dibaca panjang 2 harakat.',
        ),
      ],
    ),

    ModelTajwid(
      id: 'mad_wajib_muttashil',
      title: 'Mad Wajib Muttashil',
      category: 'mad',
      subtitle: 'Mad bertemu Hamzah dalam SATU kata',
      pengertian: 'Muttashil artinya bersambung. Terjadi apabila Mad Thabi\'i bertemu dengan huruf Hamzah (ء) dalam SATU kata yang sama. Biasanya ditandai dengan tanda layar / gelombang tebal di atas huruf mad.',
      caraBaca: 'Wajib dibaca panjang 4 sampai 5 harakat (2.5 alif).',
      panjangHarakat: '4 - 5 Harakat (Wajib)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'جَآءَ نَصْرُ اللّٰهِ',
          lafadzLatin: "Jaa-a nashrullaah",
          surah: 'QS. An-Nashr: 1',
          penjelasan: 'Huruf mad bertemu hamzah dalam satu kata "Jaa-a", dibaca panjang 5 harakat.',
        ),
        ContohTajwid(
          lafadzArab: 'السَّمَآءِ',
          lafadzLatin: "As-samaa-i",
          surah: 'QS. Al-Baqarah: 19',
          penjelasan: 'Mad bertemu hamzah dalam satu kata, dibaca panjang 4-5 harakat.',
        ),
        ContohTajwid(
          lafadzArab: 'سُوْٓءَ',
          lafadzLatin: 'Suu-a',
          surah: 'QS. An-Nisa: 18',
          penjelasan: 'Wawu mad bertemu hamzah dalam satu kata.',
        ),
      ],
    ),

    ModelTajwid(
      id: 'mad_jaiz_munfashil',
      title: 'Mad Jaiz Munfashil',
      category: 'mad',
      subtitle: 'Mad bertemu Hamzah di KATA TERPISAH',
      pengertian: 'Munfashil artinya terpisah. Terjadi apabila Mad Thabi\'i di akhir kata bertemu dengan huruf Hamzah/Alif di AWAL kata berikutnya.',
      caraBaca: 'Boleh dibaca panjang 2, 4, atau 5 harakat (umumnya dalam qira\'ah Imam Ashim 4-5 harakat).',
      panjangHarakat: '4 - 5 Harakat (Boleh 2)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'إِنَّآ أَعْطَيْنَاكَ',
          lafadzLatin: "Innaa a'thainaak",
          surah: 'QS. Al-Kautsar: 1',
          penjelasan: '"Innaa" (kata 1) bertemu "A\'thainaaka" (kata 2), dibaca panjang 4-5 harakat.',
        ),
        ContohTajwid(
          lafadzArab: 'يٰٓأَيُّهَا النَّاسُ',
          lafadzLatin: 'Yaa ayyuhan naas',
          surah: 'QS. Al-Baqarah: 21',
          penjelasan: 'Seruan "Yaa" terpisah dari "Ayyuha", dibaca panjang 4-5 harakat.',
        ),
      ],
    ),

    ModelTajwid(
      id: 'mad_aridh_lissukun',
      title: 'Mad \'Aridh Lissukun',
      category: 'mad',
      subtitle: 'Mad thabi\'i di akhir bacaan karena waqaf',
      pengertian: 'Terjadi apabila Mad Thabi\'i berada sebelum huruf hidup di akhir kata, dan bacaan BERHENTI (waqaf) pada huruf tersebut sehingga huruf terakhir dibaca sukun.',
      caraBaca: 'Boleh dibaca 2 harakat (qashr), 4 harakat (tawassuth), atau 6 harakat (thuul - paling utama).',
      panjangHarakat: '2, 4, atau 6 Harakat (Fleksibel)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'الرَّحْمٰنِ الرَّحِيْمِ ۙ',
          lafadzLatin: 'Ar-rahmaanir rahiim',
          surah: 'QS. Al-Fatihah: 3',
          penjelasan: 'Huruf Ya mad sebelum Mim di akhir ayat karena waqaf, dibaca 2, 4, atau 6 harakat.',
        ),
        ContohTajwid(
          lafadzArab: 'مَالِكِ يَوْمِ الدِّيْنِ ۗ',
          lafadzLatin: 'Maaliki yaumid diin',
          surah: 'QS. Al-Fatihah: 4',
          penjelasan: 'Ya mad sebelum Nun di akhir ayat dihentikan dengan panjang 2/4/6 harakat.',
        ),
      ],
    ),

    ModelTajwid(
      id: 'mad_lazim_mutsaqqal_kilmi',
      title: 'Mad Lazim Mutsaqqal Kilmi',
      category: 'mad',
      subtitle: 'Mad bertemu huruf bertasydid dalam 1 kata',
      pengertian: 'Lazim artinya pasti (wajib 6 harakat), Mutsaqqal artinya diberatkan. Terjadi apabila Mad Thabi\'i bertemu huruf bertasydid dalam satu kata.',
      caraBaca: 'Wajib dibaca panjang 6 harakat (3 alif) lalu ditekan (diberatkan) ke huruf yang bertasydid.',
      panjangHarakat: '6 Harakat (3 Alif - Pasti)',
      contoh: [
        ContohTajwid(
          lafadzArab: 'وَلَا الضَّآلِّيْنَ',
          lafadzLatin: 'Waladh dhaaaalliiin',
          surah: 'QS. Al-Fatihah: 7',
          penjelasan: 'Alif mad pada "Dhaa" bertemu Lam bertasydid (لّ), dipanjangkan 6 harakat lalu ditekan ke lam.',
        ),
        ContohTajwid(
          lafadzArab: 'الصَّآخَّةُ',
          lafadzLatin: 'Ash-shaaakh-khah',
          surah: 'QS. Abasa: 33',
          penjelasan: 'Alif mad bertemu huruf Kha bertasydid, dibaca 6 harakat penuh.',
        ),
      ],
    ),

    // ==========================================
    // 5. HUKUM ALIF LAM (ال)
    // ==========================================
    ModelTajwid(
      id: 'alif_lam_qomariyah',
      title: 'Alif Lam Qomariyah (Idzhar Qomariyah)',
      category: 'alif_lam',
      subtitle: 'Huruf Lam (ل) dibaca jelas / terang',
      pengertian: 'Qamar artinya bulan. Terjadi apabila Alif Lam (ال) bertemu dengan salah satu dari 14 huruf Qomariyah: ا ب غ ح ج ك و خ ف ع ق ي م هـ (disingkat: اَبْغِ حَجَّكَ وَخَفْ عَقِيْمَهُ).',
      caraBaca: 'Huruf Lam (ل) dibaca dengan jelas, sukunnya terdengar tegas.',
      huruf: ['ا', 'ب', 'غ', 'ح', 'ج', 'ك', 'و', 'خ', 'ف', 'ع', 'ق', 'ي', 'م', 'هـ'],
      contoh: [
        ContohTajwid(
          lafadzArab: 'اَلْحَمْدُ لِلّٰهِ',
          lafadzLatin: 'Al-hamdu lillaah',
          surah: 'QS. Al-Fatihah: 2',
          penjelasan: 'Alif lam bertemu Ha (ح), bunyi "Al" terdengar jelas.',
        ),
        ContohTajwid(
          lafadzArab: 'اَلْقَمَرُ',
          lafadzLatin: 'Al-qamar',
          surah: 'QS. Al-Qamar: 1',
          penjelasan: 'Alif lam bertemu Qaf (ق), dibaca "Al-Qamar".',
        ),
        ContohTajwid(
          lafadzArab: 'اَلْكِتَابُ',
          lafadzLatin: 'Al-kitaab',
          surah: 'QS. Al-Baqarah: 2',
          penjelasan: 'Alif lam bertemu Kaf (ك), dibaca jelas "Al-kitaab".',
        ),
      ],
    ),

    ModelTajwid(
      id: 'alif_lam_syamsiyah',
      title: 'Alif Lam Syamsiyah (Idgham Syamsiyah)',
      category: 'alif_lam',
      subtitle: 'Huruf Lam (ل) dilebur ke huruf berikutnya',
      pengertian: 'Syams artinya matahari. Terjadi apabila Alif Lam (ال) bertemu dengan salah satu dari 14 huruf Syamsiyah: ط ث ص ر ت ض ذ ن د س ظ ز ش ل.',
      caraBaca: 'Huruf Lam tidak dibaca, melainkan langsung dileburkan masuk ke huruf di depannya seolah-olah bertasydid.',
      huruf: ['ط', 'ث', 'ص', 'ر', 'ت', 'ض', 'ذ', 'ن', 'د', 'س', 'ظ', 'ز', 'ش', 'ل'],
      contoh: [
        ContohTajwid(
          lafadzArab: 'اَلشَّمْسُ',
          lafadzLatin: 'Asy-syamsu',
          surah: 'QS. Asy-Syams: 1',
          penjelasan: 'Alif lam bertemu Syin (ش), lam lebur sehingga dibaca "Asy-syamsu" bukan "Al-syamsu".',
        ),
        ContohTajwid(
          lafadzArab: 'اَلرَّحْمٰنِ الرَّحِيْمِ',
          lafadzLatin: 'Ar-rahmaanir rahiim',
          surah: 'QS. Al-Fatihah: 1',
          penjelasan: 'Alif lam bertemu Ra (ر), lam lebur menjadi "Ar-rahmaan".',
        ),
        ContohTajwid(
          lafadzArab: 'اَلنَّاسِ',
          lafadzLatin: 'An-naas',
          surah: 'QS. An-Naas: 1',
          penjelasan: 'Alif lam bertemu Nun (ن), dibaca langsung "An-naas" disertai dengung.',
        ),
      ],
    ),

    // ==========================================
    // 6. TANDA-TANDA WAQAF & MAKHORIJUL HURUF
    // ==========================================
    ModelTajwid(
      id: 'tanda_waqaf',
      title: 'Tanda-Tanda Waqaf (Tanda Berhenti)',
      category: 'waqaf_lainnya',
      subtitle: 'Panduan tanda berhenti membaca Al-Qur\'an',
      pengertian: 'Waqaf artinya berhenti sejenak untuk mengambil nafas dengan niat melanjutkan kembali bacaan. Tanda-tanda waqaf memandu qari di mana harus berhenti atau melanjutkan bacaan agar makna ayat tidak rusak.',
      caraBaca: 'Ikuti hukum simbol waqaf sesuai aturan berikut:',
      huruf: ['م (Wajib)', 'لا (Dilarang)', 'ج (Boleh)', 'صلى (Utama Lanjut)', 'قلى (Utama Berhenti)', '∴ ... ∴ (Mu\'anaqah)'],
      contoh: [
        ContohTajwid(
          lafadzArab: 'م (Waqaf Lazim)',
          lafadzLatin: 'Harus / Wajib Berhenti',
          surah: 'Simbol: م',
          penjelasan: 'Wajib berhenti di tanda ini karena jika dilanjutkan akan merusak makna ayat.',
        ),
        ContohTajwid(
          lafadzArab: 'لا (Waqaf La Washal)',
          lafadzLatin: 'Dilarang Berhenti',
          surah: 'Simbol: لا',
          penjelasan: 'Tidak boleh berhenti di tengah ayat, kecuali jika tanda ini berada di akhir ayat (nomor ayat).',
        ),
        ContohTajwid(
          lafadzArab: 'ج (Waqaf Jaiz)',
          lafadzLatin: 'Boleh Berhenti atau Lanjut',
          surah: 'Simbol: ج',
          penjelasan: 'Boleh memilih untuk berhenti atau melanjutkan bacaan dengan tingkat keutamaan yang sama.',
        ),
        ContohTajwid(
          lafadzArab: 'قلى (Al-Waqfu Ula)',
          lafadzLatin: 'Lebih Utama Berhenti',
          surah: 'Simbol: قلى',
          penjelasan: 'Boleh lanjut, tetapi berhenti lebih utama dan lebih dianjurkan.',
        ),
        ContohTajwid(
          lafadzArab: 'صلى (Al-Washlu Ula)',
          lafadzLatin: 'Lebih Utama Lanjut',
          surah: 'Simbol: صلى',
          penjelasan: 'Boleh berhenti jika nafas tidak sampai, tetapi menyambung (washal) lebih utama.',
        ),
        ContohTajwid(
          lafadzArab: '∴ ... ∴ (Waqaf Mu\'anaqah)',
          lafadzLatin: 'Berhenti di Salah Satu',
          surah: 'Simbol: ∴ ... ∴',
          penjelasan: 'Harus berhenti di salah satu tanda titik tiga tersebut, dan tidak boleh berhenti di keduanya.',
        ),
      ],
    ),

    ModelTajwid(
      id: 'makhorijul_huruf',
      title: 'Makhorijul Huruf (Tempat Keluar Huruf)',
      category: 'waqaf_lainnya',
      subtitle: '5 Tempat keluarnya huruf-huruf hijaiyah',
      pengertian: 'Makhorijul Huruf adalah tempat-tempat keluarnya huruf hijaiyah saat diucapkan agar bunyi setiap huruf terdengar tepat dan fasih sesuai kaidah bahasa Arab.',
      caraBaca: 'Keluarkan huruf dari tempat asalnya dengan menyempurnakan sifat-sifat hurufnya.',
      huruf: ['Al-Jauf', 'Al-Halq', 'Al-Lisan', 'Asy-Syafatain', 'Al-Khaisyum'],
      contoh: [
        ContohTajwid(
          lafadzArab: 'اَلْجَوْفُ (Al-Jauf)',
          lafadzLatin: 'Rongga Mulut & Tenggorokan',
          surah: 'Huruf Mad: ا و ي',
          penjelasan: 'Tempat keluarnya bunyi vokal panjang huruf mad tanpa terhambat persendian mulut.',
        ),
        ContohTajwid(
          lafadzArab: 'اَلْحَلْقُ (Al-Halq)',
          lafadzLatin: 'Tenggorokan',
          surah: '6 Huruf Halq',
          penjelasan: 'Pangkal tenggorokan (ء, هـ), tengah tenggorokan (ع, ح), dan ujung tenggorokan (غ, خ).',
        ),
        ContohTajwid(
          lafadzArab: 'اَللِّسَانُ (Al-Lisan)',
          lafadzLatin: 'Lidah (18 Huruf)',
          surah: '18 Huruf Lisan',
          penjelasan: 'Tempat makhraj terbanyak: pangkal lidah, tengah lidah, tepi lidah, dan ujung lidah.',
        ),
        ContohTajwid(
          lafadzArab: 'اَلشَّفَتَيْنِ (Asy-Syafatain)',
          lafadzLatin: 'Dua Bibir',
          surah: '4 Huruf Bibir',
          penjelasan: 'Bibir atas/bawah (ف) dan pertemuan kedua bibir (ب, م, و).',
        ),
        ContohTajwid(
          lafadzArab: 'اَلْخَيْشُوْمُ (Al-Khaisyum)',
          lafadzLatin: 'Pangkal Hidung (Rongga Hidung)',
          surah: 'Rongga Hidung (Ghunnah)',
          penjelasan: 'Sumber suara dengung (ghunnah) pada huruf Nun dan Mim bertasydid atau ikhfa/idgham.',
        ),
      ],
    ),
  ];
}
