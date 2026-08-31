class ModelTuntunanSholat {
  final String id;
  final String title;
  final String category; // 'wajib', 'sunnah', 'bersuci', 'dzikir'
  final String subtitle;
  final String rakaat;
  final String waktu;
  final String hukum;
  final String keutamaan;
  final NiatSholat? niatMunfarid;
  final NiatSholat? niatImam;
  final NiatSholat? niatMakmum;
  final List<StepSholat> steps;
  final List<DoaTambahan>? doaTambahan;

  const ModelTuntunanSholat({
    required this.id,
    required this.title,
    required this.category,
    required this.subtitle,
    this.rakaat = '',
    this.waktu = '',
    this.hukum = '',
    this.keutamaan = '',
    this.niatMunfarid,
    this.niatImam,
    this.niatMakmum,
    this.steps = const [],
    this.doaTambahan,
  });
}

class NiatSholat {
  final String arabic;
  final String latin;
  final String translation;

  const NiatSholat({
    required this.arabic,
    required this.latin,
    required this.translation,
  });
}

class StepSholat {
  final String title;
  final String description;
  final String? arabic;
  final String? latin;
  final String? translation;

  const StepSholat({
    required this.title,
    required this.description,
    this.arabic,
    this.latin,
    this.translation,
  });
}

class DoaTambahan {
  final String title;
  final String arabic;
  final String latin;
  final String translation;

  const DoaTambahan({
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
  });
}

class TuntunanSholatData {
  static const List<ModelTuntunanSholat> list = [
    // ==========================================
    // 1. SHOLAT WAJIB (FARDHU)
    // ==========================================
    ModelTuntunanSholat(
      id: 'subuh',
      title: 'Sholat Subuh',
      category: 'wajib',
      subtitle: '2 Rakaat - Fardhu sebelum terbit fajar',
      rakaat: '2 Rakaat',
      waktu: 'Mulai terbit fajar shadiq sampai menjelang terbit matahari',
      hukum: 'Fardhu \'Ain (Wajib)',
      keutamaan: 'Disaksikan para malaikat malam dan siang, serta mendapat jaminan perlindungan Allah.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الصُّبْحِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhash shubhi rak'ataini mustaqbilal qiblati adaa-an lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Subuh dua rakaat menghadap kiblat, tunai karena Allah Ta\'ala.',
      ),
      niatImam: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الصُّبْحِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً إِمَامًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhash shubhi rak'ataini mustaqbilal qiblati adaa-an imaaman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Subuh dua rakaat menghadap kiblat, sebagai imam karena Allah Ta\'ala.',
      ),
      niatMakmum: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الصُّبْحِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhash shubhi rak'ataini mustaqbilal qiblati adaa-an ma'muuman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Subuh dua rakaat menghadap kiblat, sebagai makmum karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: '1. Takbiratul Ihram',
          description: 'Berdiri tegak menghadap kiblat, berniat dalam hati, lalu mengangkat kedua tangan sejajar telinga/bahu sambil membaca takbir.',
          arabic: 'اللهُ أَكْبَرُ',
          latin: 'Allaahu Akbar',
          translation: 'Allah Maha Besar.',
        ),
        StepSholat(
          title: '2. Membaca Doa Iftitah',
          description: 'Membaca doa pembuka sholat setelah meletakkan tangan kanan di atas tangan kiri pada dada/perut.',
          arabic: 'اللهُ أَكْبَرُ كَبِيْرًا وَالْحَمْدُ لِلّٰهِ كَثِيْرًا وَسُبْحَانَ اللهِ بُكْرَةً وَأَصِيْلًا. وَجَّهْتُ وَجْهِيَ لِلَّذِيْ فَطَرَ السَّمٰوَاتِ وَالأَرْضَ حَنِيْفًا مُسْلِمًا وَمَا أَنَا مِنَ الْمُشْرِكِيْنَ، إِنَّ صَلَاتِيْ وَنُسُكِيْ وَمَحْيَايَ وَمَمَاتِيْ لِلّٰهِ رَبِّ الْعَالَمِيْنَ، لاَ شَرِيْكَ لَهُ وَبِذٰلِكَ أُمِرْتُ وَأَنَا مِنَ الْمُسْلِمِيْنَ',
          latin: 'Allaahu akbaru kabiiraa walhamdu lillaahi katsiiraa, wa subhaanallaahi bukratan wa ashiilaa. Wajjahtu wajhiya lilladzii fatharas samaawaati wal ardha haniifan musliman wa maa ana minal musyrikiin, inna shalaatii wa nusukii wa mahyaaya wa mamaatii lillaahi rabbil \'aalamiin, laa syariika lahu wa bidzaalika umirtu wa ana minal muslimiin.',
          translation: 'Allah Maha Besar sebesar-besarnya. Dan puji syukur yang sebanyak-banyaknya bagi Allah. Dan Maha Suci Allah pada pagi dan petang hari. Aku menghadapkan wajahku kepada Dzat yang menciptakan langit dan bumi dengan keadaan lurus dan berserah diri dan aku bukanlah termasuk orang-orang yang musyrik. Sesungguhnya sholatku, ibadahku, hidupku dan matiku hanya untuk Allah Tuhan semesta alam...',
        ),
        StepSholat(
          title: '3. Membaca Surah Al-Fatihah & Surah Pendek',
          description: 'Membaca Surat Al-Fatihah (wajib di setiap rakaat) dilanjutkan dengan surat pendek pilihan.',
          arabic: 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ. اَلْحَمْدُ لِلّٰهِ رَبِّ الْعَالَمِيْنَ. الرَّحْمٰنِ الرَّحِيْمِ. مٰلِكِ يَوْمِ الدِّيْنِ. إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِيْنُ. اِهْدِنَا الصِّرَاطَ الْمُسْتَقِيْمَ. صِرَاطَ الَّذِيْنَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوْبِ عَلَيْهِمْ وَلَا الضَّالِّيْنَ. آمِيْن',
          latin: 'Bismillaahir rahmaanir rahiim. Alhamdu lillaahi rabbil \'aalamiin. Ar-rahmaanir rahiim. Maaliki yaumid diin. Iyyaaka na\'budu wa iyyaaka nasta\'iin. Ihdinash shiraathal mustaqiim. Shiraathal ladziina an\'amta \'alaihim ghairil maghdhuubi \'alaihim waladh dhaalliin. Aamiin.',
          translation: 'Dengan nama Allah Yang Maha Pengasih lagi Maha Penyayang. Segala puji bagi Allah, Tuhan semesta alam...',
        ),
        StepSholat(
          title: '4. Ruku\' dan Thuma\'ninah',
          description: 'Membungkuk dengan meletakkan kedua telapak tangan di atas lutut, punggung lurus mendatar.',
          arabic: 'سُبْحَانَ رَبِّيَ الْعَظِيْمِ وَبِحَمْدِهِ (٣x)',
          latin: "Subhaana rabbiyal 'azhiimi wa bihamdih (3x)",
          translation: 'Maha Suci Tuhanku Yang Maha Agung dan dengan segala puji bagi-Nya.',
        ),
        StepSholat(
          title: '5. I\'tidal dan Thuma\'ninah',
          description: 'Bangkit dari ruku\' berdiri tegak kembali.',
          arabic: 'سَمِعَ اللهُ لِمَنْ حَمِدَهُ. رَبَّنَا لَكَ الْحَمْدُ مِلْءُ السَّمٰوَاتِ وَمِلْءُ الأَرْضِ وَمِلْءُ مَا شِئْتَ مِنْ شَيْءٍ بَعْدُ',
          latin: "Sami'allaahu liman hamidah. Rabbanaa lakal hamdu mil'us samaawaati wa mil'ul ardhi wa mil'u maa syi'ta min syai-in ba'du.",
          translation: 'Allah mendengar orang yang memuji-Nya. Ya Tuhan kami, bagi-Mu lah segala puji sepenuh langit dan sepenuh bumi dan sepenuh apa yang Engkau kehendaki sesudah itu.',
        ),
        StepSholat(
          title: '6. Sujud dan Thuma\'ninah',
          description: 'Meletakkan dahi, hidung, kedua telapak tangan, kedua lutut, dan ujung jari kaki di lantai.',
          arabic: 'سُبْحَانَ رَبِّيَ الأَعْلَى وَبِحَمْدِهِ (٣x)',
          latin: "Subhaana rabbiyal a'laa wa bihamdih (3x)",
          translation: 'Maha Suci Tuhanku Yang Maha Tinggi dan dengan segala puji bagi-Nya.',
        ),
        StepSholat(
          title: '7. Duduk di Antara Dua Sujud',
          description: 'Bangkit dari sujud pertama lalu duduk iftirasy dengan tenang.',
          arabic: 'رَبِّ اغْفِرْ لِيْ وَارْحَمْنِيْ وَاجْبُرْنِيْ وَارْفَعْنِيْ وَارْزُقْنِيْ وَاهْدِنِيْ وَعَافِنِيْ وَاعْفُ عَنِّيْ',
          latin: "Rabbighfirlii warhamnii wajburnii warfa'nii warzuqnii wahdinii wa'aafinii wa'fu 'annii.",
          translation: 'Ya Tuhanku ampunilah aku, rahmatilah aku, cukupkanlah kekuranganku, angkatlah derajatku, berilah aku rezeki, berilah aku petunjuk, berilah aku kesehatan dan maafkanlah aku.',
        ),
        StepSholat(
          title: '8. Sujud Kedua & Rakaat Kedua',
          description: 'Lakukan sujud kedua, lalu bangkit melaksanakan rakaat kedua seperti rakaat pertama. Pada saat I\'tidal rakaat kedua Subuh disunnahkan membaca doa Qunut.',
        ),
        StepSholat(
          title: '9. Tasyahud Akhir & Salam',
          description: 'Duduk tawarruk di akhir rakaat kedua membaca tasyahud akhir dan shalawat, lalu mengucap salam ke kanan dan kiri.',
          arabic: 'التَّحِيَّاتُ الْمُبَارَكَاتُ الصَّلَوَاتُ الطَّيِّبَاتُ لِلّٰهِ، السَّلاَمُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللهِ وَبَرَكَاتُهُ، السَّلاَمُ عَلَيْنَا وَعَلَى عِبَادِ اللهِ الصَّالِحِيْنَ، أَشْهَدُ أَنْ لاَ إِلٰهَ إِلاَّ اللهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا رَسُوْلُ اللهِ. اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ وَعَلَى آلِ سَيِّدِنَا مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى سَيِّدِنَا إِبْرَاهِيْمَ وَعَلَى آلِ سَيِّدِنَا إِبْرَاهِيْمَ، وَبَارِكْ عَلَى سَيِّدِنَا مُحَمَّدٍ وَعَلَى آلِ سَيِّدِنَا مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى سَيِّدِنَا إِبْرَاهِيْمَ وَعَلَى آلِ سَيِّدِنَا إِبْرَاهِيْمَ فِي الْعَالَمِيْنَ إِنَّكَ حَمِيْدٌ مَجِيْدٌ',
          latin: 'Attahiyyaatul mubaarakaatush shalawaatuth thayyibaatu lillaah. Assalaamu \'alaika ayyuhan nabiyyu wa rahmatullaahi wa barakaatuh. Assalaamu \'alainaa wa \'alaa \'ibaadillaahish shaalihiin. Asyhadu allaa ilaaha illallaah wa asyhadu anna Muhammadan rasuulullaah. Allaahumma shalli \'alaa sayyidinaa Muhammad wa \'alaa aali sayyidinaa Muhammad...',
          translation: 'Segala kehormatan, keberkahan, kebahagiaan dan kebaikan bagi Allah. Keselamatan bagimu wahai Nabi, beserta rahmat dan berkah Allah...',
        ),
      ],
      doaTambahan: [
        DoaTambahan(
          title: 'Doa Qunut Subuh',
          arabic: 'اَللّٰهُمَّ اهْدِنِيْ فِيْمَنْ هَدَيْتَ، وَعَافِنِيْ فِيْمَنْ عَافَيْتَ، وَتَوَلَّنِيْ فِيْمَنْ تَوَلَّيْتَ، وَبَارِكْ لِيْ فِيْمَا أَعْطَيْتَ، وَقِنِيْ شَرَّ مَا قَضَيْتَ، فَإِنَّكَ تَقْضِيْ وَلاَ يُقْضَى عَلَيْكَ، وَإِنَّهُ لاَ يَذِلُّ مَنْ وَالَيْتَ، وَلاَ يَعِزُّ مَنْ عَادَيْتَ، تَبَارَكْتَ رَبَّنَا وَتَعَالَيْتَ، فَلَكَ الْحَمْدُ عَلَى مَا قَضَيْتَ، أَسْتَغْفِرُكَ وَأَتُوْبُ إِلَيْكَ، وَصَلَّى اللهُ عَلَى سَيِّدِنَا مُحَمَّدٍ النَّبِيِّ الأُمِّيِّ وَعَلَى آلِهِ وَصَحْبِهِ وَسَلَّمَ',
          latin: "Allaahummah dinii fii man hadait, wa 'aafinii fii man 'aafait, wa tawallanii fii man tawallait, wa baarik lii fii maa a'thait, wa qinii syarra maa qadhait, fa innaka taqdhii wa laa yuqdhaa 'alaik, wa innahu laa yadzillu man waalait, wa laa ya'izzu man 'aadait, tabaarakta rabbanaa wa ta'aalait, fa lakal hamdu 'alaa maa qadhait, astaghfiruka wa atuubu ilaik, wa shallallaahu 'alaa sayyidinaa Muhammadin nabiyyil ummiyyi wa 'alaa aalihi wa shahbihii wa sallam.",
          translation: 'Ya Allah, berilah aku petunjuk sebagaimana orang yang telah Engkau beri petunjuk. Berilah aku kesehatan sebagaimana orang yang telah Engkau beri kesehatan...',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'dzuhur',
      title: 'Sholat Dzuhur',
      category: 'wajib',
      subtitle: '4 Rakaat - Fardhu setelah tergelincir matahari',
      rakaat: '4 Rakaat',
      waktu: 'Mulai tergelincir matahari ke barat hingga bayangan sama panjang dengan bendanya',
      hukum: 'Fardhu \'Ain (Wajib)',
      keutamaan: 'Waktu dibukanya pintu-pintu langit dan saat yang baik untuk beramal shalih.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الظُّهْرِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhazh zhuhri arba'a raka'aatin mustaqbilal qiblati adaa-an lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Dzuhur empat rakaat menghadap kiblat, tunai karena Allah Ta\'ala.',
      ),
      niatImam: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الظُّهْرِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً إِمَامًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhazh zhuhri arba'a raka'aatin mustaqbilal qiblati adaa-an imaaman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Dzuhur empat rakaat menghadap kiblat, sebagai imam karena Allah Ta\'ala.',
      ),
      niatMakmum: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الظُّهْرِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhazh zhuhri arba'a raka'aatin mustaqbilal qiblati adaa-an ma'muuman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Dzuhur empat rakaat menghadap kiblat, sebagai makmum karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Tata Cara 4 Rakaat Dzuhur',
          description: 'Dilakukan sebanyak 4 rakaat dengan bacaan sirr (suara pelan). Rakaat 1 dan 2 membaca Al-Fatihah dan surah pendek, diakhiri Tasyahud Awal pada rakaat ke-2. Rakaat 3 dan 4 hanya membaca Al-Fatihah, lalu duduk Tasyahud Akhir pada rakaat ke-4 ditutup dengan salam.',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'ashar',
      title: 'Sholat Ashar',
      category: 'wajib',
      subtitle: '4 Rakaat - Sholat Wustha di sore hari',
      rakaat: '4 Rakaat',
      waktu: 'Mulai bayangan benda melebihi panjang aslinya sampai matahari menguning/terbenam',
      hukum: 'Fardhu \'Ain (Wajib)',
      keutamaan: 'Termasuk Sholat Wustha. Barangsiapa menjaga sholat Ashar, Allah menjaminnya masuk surga.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الْعَصْرِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhal 'ashri arba'a raka'aatin mustaqbilal qiblati adaa-an lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Ashar empat rakaat menghadap kiblat, tunai karena Allah Ta\'ala.',
      ),
      niatImam: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الْعَصْرِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً إِمَامًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhal 'ashri arba'a raka'aatin mustaqbilal qiblati adaa-an imaaman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Ashar empat rakaat menghadap kiblat, sebagai imam karena Allah Ta\'ala.',
      ),
      niatMakmum: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الْعَصْرِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhal 'ashri arba'a raka'aatin mustaqbilal qiblati adaa-an ma'muuman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Ashar empat rakaat menghadap kiblat, sebagai makmum karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Tata Cara 4 Rakaat Ashar',
          description: 'Sama seperti sholat Dzuhur, dilakukan 4 rakaat dengan bacaan sirr (pelan). Ada Tasyahud Awal di rakaat ke-2 dan Tasyahud Akhir di rakaat ke-4.',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'maghrib',
      title: 'Sholat Maghrib',
      category: 'wajib',
      subtitle: '3 Rakaat - Fardhu saat terbenam matahari',
      rakaat: '3 Rakaat',
      waktu: 'Mulai matahari terbenam sampai hilangnya mega merah (syafaq)',
      hukum: 'Fardhu \'Ain (Wajib)',
      keutamaan: 'Waktu terkabulnya doa dan perpindahan dari siang menuju malam.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الْمَغْرِبِ ثَلاَثَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhal maghribi tsalaatsa raka'aatin mustaqbilal qiblati adaa-an lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Maghrib tiga rakaat menghadap kiblat, tunai karena Allah Ta\'ala.',
      ),
      niatImam: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الْمَغْرِبِ ثَلاَثَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً إِمَامًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhal maghribi tsalaatsa raka'aatin mustaqbilal qiblati adaa-an imaaman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Maghrib tiga rakaat menghadap kiblat, sebagai imam karena Allah Ta\'ala.',
      ),
      niatMakmum: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الْمَغْرِبِ ثَلاَثَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhal maghribi tsalaatsa raka'aatin mustaqbilal qiblati adaa-an ma'muuman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Maghrib tiga rakaat menghadap kiblat, sebagai makmum karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Tata Cara 3 Rakaat Maghrib',
          description: 'Rakaat 1 dan 2 dibaca jahr (nyaring/keras untuk bacaan Al-Fatihah dan surah) lalu duduk Tasyahud Awal. Rakaat ke-3 dibaca sirr (pelan) hanya membaca Al-Fatihah, lalu duduk Tasyahud Akhir dan salam.',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'isya',
      title: 'Sholat Isya',
      category: 'wajib',
      subtitle: '4 Rakaat - Fardhu malam hari',
      rakaat: '4 Rakaat',
      waktu: 'Mulai hilangnya mega merah sampai terbit fajar shadiq',
      hukum: 'Fardhu \'Ain (Wajib)',
      keutamaan: 'Sholat berjamaah Isya bernilai pahala sholat separuh malam.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الْعِشَاءِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhal 'isyaa-i arba'a raka'aatin mustaqbilal qiblati adaa-an lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Isya empat rakaat menghadap kiblat, tunai karena Allah Ta\'ala.',
      ),
      niatImam: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الْعِشَاءِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً إِمَامًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhal 'isyaa-i arba'a raka'aatin mustaqbilal qiblati adaa-an imaaman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Isya empat rakaat menghadap kiblat, sebagai imam karena Allah Ta\'ala.',
      ),
      niatMakmum: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الْعِشَاءِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhal 'isyaa-i arba'a raka'aatin mustaqbilal qiblati adaa-an ma'muuman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Isya empat rakaat menghadap kiblat, sebagai makmum karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Tata Cara 4 Rakaat Isya',
          description: 'Rakaat 1 dan 2 dibaca jahr (nyaring), lalu duduk Tasyahud Awal. Rakaat 3 dan 4 dibaca sirr (pelan), lalu duduk Tasyahud Akhir dan salam.',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'jumat',
      title: 'Sholat Jum\'at',
      category: 'wajib',
      subtitle: '2 Rakaat - Pengganti Dzuhur di hari Jum\'at',
      rakaat: '2 Rakaat',
      waktu: 'Waktu Dzuhur hari Jum\'at didahului 2 khutbah',
      hukum: 'Fardhu \'Ain bagi laki-laki muslim',
      keutamaan: 'Hari terbaik dalam sepekan, menghapus dosa antara dua Jum\'at.',
      niatMakmum: NiatSholat(
        arabic: 'أُصَلِّيْ فَرْضَ الْجُمُعَةِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً مَأْمُوْمًا لِلّٰهِ تَعَالَى',
        latin: "Ushallii fardhal jumu'ati rak'ataini mustaqbilal qiblati adaa-an ma'muuman lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat fardhu Jum\'at dua rakaat menghadap kiblat, sebagai makmum karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Tata Cara Sholat Jum\'at',
          description: 'Dilaksanakan berjamaah sebanyak 2 rakaat setelah mendengarkan dua khutbah Jum\'at dengan khusyuk.',
        ),
      ],
    ),

    // ==========================================
    // 2. SHOLAT SUNNAH
    // ==========================================
    ModelTuntunanSholat(
      id: 'tahajjud',
      title: 'Sholat Tahajjud',
      category: 'sunnah',
      subtitle: 'Minimal 2 Rakaat - Sholat malam setelah tidur',
      rakaat: 'Min. 2 Rakaat',
      waktu: 'Malam hari setelah bangun tidur (terutama sepertiga malam terakhir)',
      hukum: 'Sunnah Muakkad',
      keutamaan: 'Mendapat tempat terpuji (Maqaman Mahmuda), doa mustajab, dan cahaya di kegelapan kubur.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ سُنَّةَ التَّهَجُّدِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ لِلّٰهِ تَعَالَى',
        latin: "Ushallii sunnatat tahajjudi rak'ataini mustaqbilal qiblati lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat sunnah Tahajjud dua rakaat menghadap kiblat karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Pelaksanaan Sholat Tahajjud',
          description: 'Dikerjakan 2 rakaat salam, 2 rakaat salam. Dianjurkan membaca surat yang panjang dan memperbanyak doa saat sujud terakhir.',
        ),
      ],
      doaTambahan: [
        DoaTambahan(
          title: 'Doa Setelah Sholat Tahajjud',
          arabic: 'اَللّٰهُمَّ لَكَ الْحَمْدُ أَنْتَ قَيِّمُ السَّمٰوَاتِ وَالأَرْضِ وَمَنْ فِيْهِنَّ، وَلَكَ الْحَمْدُ أَنْتَ مَلِكُ السَّمٰوَاتِ وَالأَرْضِ وَمَنْ فِيْهِنَّ، وَلَكَ الْحَمْدُ أَنْتَ نُوْرُ السَّمٰوَاتِ وَالأَرْضِ وَمَنْ فِيْهِنَّ، وَلَكَ الْحَمْدُ أَنْتَ الْحَقُّ وَوَعْدُكَ الْحَقُّ وَلِقَاؤُكَ حَقٌّ وَقَوْلُكَ حَقٌّ وَالْجَنَّةُ حَقٌّ وَالنَّارُ حَقٌّ وَالنَّبِيُّوْنَ حَقٌّ وَمُحَمَّدٌ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ حَقٌّ وَالسَّاعَةُ حَقٌّ...',
          latin: "Allaahumma lakal hamdu anta qayyimus samaawaati wal ardhi wa man fiihinna, wa lakal hamdu anta malikus samaawaati wal ardhi wa man fiihinna...",
          translation: 'Ya Allah, bagi-Mu segala puji, Engkaulah Penegak langit dan bumi serta apa yang ada di dalamnya. Bagi-Mu segala puji, Engkaulah Penguasa langit dan bumi...',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'dhuha',
      title: 'Sholat Dhuha',
      category: 'sunnah',
      subtitle: '2 hingga 8 Rakaat - Sholat pagi pembuka rezeki',
      rakaat: '2 - 8 Rakaat',
      waktu: 'Mulai matahari setinggi tombak (sekitar pk 07.00) sampai menjelang Dzuhur',
      hukum: 'Sunnah Muakkad',
      keutamaan: 'Sebagai sedekah bagi 360 persendian tubuh dan Allah mencukupi kebutuhan rezeki di hari itu.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ سُنَّةَ الضُّحَى رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ لِلّٰهِ تَعَالَى',
        latin: "Ushallii sunnatadh dhuhaa rak'ataini mustaqbilal qiblati lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat sunnah Dhuha dua rakaat menghadap kiblat karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Tata Cara Sholat Dhuha',
          description: 'Dilakukan 2 rakaat. Disunnahkan membaca Surah Asy-Syams pada rakaat pertama dan Surah Adh-Dhuha pada rakaat kedua.',
        ),
      ],
      doaTambahan: [
        DoaTambahan(
          title: 'Doa Sholat Dhuha',
          arabic: 'اَللّٰهُمَّ إِنَّ الضُّحَاءَ ضُحَاؤُكَ وَالْبَهَاءَ بَهَاؤُكَ وَالْجَمَالَ جَمَالُكَ وَالْقُوَّةَ قُوَّتُكَ وَالْقُدْرَةَ قُدْرَتُكَ وَالْعِصْمَةَ عِصْمَتُكَ. اَللّٰهُمَّ إِنْ كَانَ رِزْقِيْ فِي السَّمَاءِ فَأَنْزِلْهُ وَإِنْ كَانَ فِي الأَرْضِ فَأَخْرِجْهُ وَإِنْ كَانَ مُعْسِرًا فَيَسِّرْهُ وَإِنْ كَانَ حَرَامًا فَطَهِّرْهُ وَإِنْ كَانَ بَعِيْدًا فَقَرِّبْهُ بِحَقِّ ضُحَائِكَ وَبَهَائِكَ وَجَمَالِكَ وَقُوَّتِكَ وَقُدْرَتِكَ آتِنِيْ مَا آتَيْتَ عِبَادَكَ الصَّالِحِيْنَ',
          latin: "Allaahumma innadh dhuhaa-a dhuhaa-uka, wal bahaa-a bahaa-uka, wal jamaala jamaaluka, wal quwwata quwwatuka, wal qudrata qudratuka, wal 'ishmata 'ishmatuka. Allaahumma in kaana rizqii fis samaa-i fa anzilhu, wa in kaana fil ardhi fa akhrijhu, wa in kaana mu'siran fa yassirhu...",
          translation: 'Ya Allah, sesungguhnya waktu dhuha adalah waktu dhuha-Mu, keagungan adalah keagungan-Mu, keindahan adalah keindahan-Mu, kekuatan adalah kekuatan-Mu, kekuasaan adalah kekuasaan-Mu, dan penjagaan adalah penjagaan-Mu...',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'witir',
      title: 'Sholat Witir',
      category: 'sunnah',
      subtitle: '1 atau 3 Rakaat - Sholat ganjil penutup malam',
      rakaat: '1 atau 3 Rakaat (Bisa sampai 11 Rakaat)',
      waktu: 'Setelah sholat Isya hingga sebelum waktu Subuh',
      hukum: 'Sunnah Muakkad',
      keutamaan: 'Allah itu Maha Ganjil dan menyukai yang ganjil. Menjadi penutup rangkaian ibadah sholat malam.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ سُنَّةَ الْوِتْرِ ثَلاَثَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ لِلّٰهِ تَعَالَى',
        latin: "Ushallii sunnatal witri tsalaatsa raka'aatin mustaqbilal qiblati lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat sunnah Witir tiga rakaat menghadap kiblat karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Tata Cara Sholat Witir 3 Rakaat',
          description: 'Dapat dilakukan 2 rakaat salam lalu ditambah 1 rakaat salam (lebih utama), atau langsung 3 rakaat dengan satu kali salam. Disunnahkan membaca Al-A\'la pada rakaat 1, Al-Kafirun pada rakaat 2, dan Al-Ikhlas, Al-Falaq, An-Nas pada rakaat 3.',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'istikharah',
      title: 'Sholat Istikharah',
      category: 'sunnah',
      subtitle: '2 Rakaat - Memohon petunjuk keputusan terbaik',
      rakaat: '2 Rakaat',
      waktu: 'Bisa dikerjakan kapan saja di luar waktu terlarang sholat',
      hukum: 'Sunnah',
      keutamaan: 'Mendapat ketenangan hati dan bimbingan Allah atas pilihan perkara hidup.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ سُنَّةَ الاِسْتِخَارَةِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ لِلّٰهِ تَعَالَى',
        latin: "Ushallii sunnatal istikhaarati rak'ataini mustaqbilal qiblati lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat sunnah Istikharah dua rakaat menghadap kiblat karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Tata Cara Sholat Istikharah',
          description: 'Dilakukan 2 rakaat. Setelah salam, membaca puji-pujian kepada Allah, shalawat, lalu membaca doa istikharah sambil menyebutkan perkara yang dihadapi.',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'taubat',
      title: 'Sholat Taubat',
      category: 'sunnah',
      subtitle: '2 Rakaat - Memohon ampunan atas dosa & kesalahan',
      rakaat: '2 Rakaat',
      waktu: 'Kapan saja setelah melakukan perbuatan dosa (utama di malam hari)',
      hukum: 'Sunnah',
      keutamaan: 'Allah mengampuni dosa hamba-Nya yang beristighfar dengan sungguh-sungguh.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ سُنَّةَ التَّوْبَةِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ لِلّٰهِ تَعَالَى',
        latin: "Ushallii sunnatat taubati rak'ataini mustaqbilal qiblati lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat sunnah Taubat dua rakaat menghadap kiblat karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Tata Cara Sholat Taubat',
          description: 'Sholat 2 rakaat dengan penuh penyesalan dan kekhusyukan, diakhiri istighfar dan tekad untuk tidak mengulangi perbuatan maksiat.',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'hajat',
      title: 'Sholat Hajat',
      category: 'sunnah',
      subtitle: '2 hingga 12 Rakaat - Memohon dikabulkannya hajat',
      rakaat: '2 Rakaat (sampai 12 rakaat)',
      waktu: 'Kapan saja terutama di keheningan malam hari',
      hukum: 'Sunnah',
      keutamaan: 'Allah memudahkan urusan dunia dan akhirat bagi hamba yang memohon kepada-Nya.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ سُنَّةَ الْحَاجَةِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ لِلّٰهِ تَعَالَى',
        latin: "Ushallii sunnatal haajati rak'ataini mustaqbilal qiblati lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat sunnah Hajat dua rakaat menghadap kiblat karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Tata Cara Sholat Hajat',
          description: 'Dikerjakan 2 rakaat salam, dilanjutkan dengan membaca istighfar 100x, shalawat 100x, lalu memanjatkan doa hajat spesifik yang diinginkan.',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'jenazah',
      title: 'Sholat Jenazah',
      category: 'sunnah',
      subtitle: '4 Takbir - Tanpa ruku\' & tanpa sujud',
      rakaat: '4 Takbir (Berdiri)',
      waktu: 'Kapan saja setelah jenazah dimandikan dan dikafani',
      hukum: 'Fardhu Kifayah',
      keutamaan: 'Mendapat pahala sebesar dua gunung Uhud (Qirath) bagi yang menyalatkan hingga menguburkan.',
      niatMunfarid: NiatSholat(
        arabic: 'أُصَلِّيْ عَلَى هٰذَا الْمَيِّتِ (الْمَيِّتَةِ) أَرْبَعَ تَكْبِيْرَاتٍ فَرْضَ كِفَايَةٍ لِلّٰهِ تَعَالَى',
        latin: "Ushallii 'alaa haadzal mayyiti (laki-laki) / haadzihil mayyitati (perempuan) arba'a takbiiraatin fardha kifaayatin lillaahi ta'aalaa.",
        translation: 'Saya berniat sholat atas jenazah ini empat takbir fardhu kifayah karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: 'Takbir Pertama (1)',
          description: 'Mengangkat tangan membaca takbir, lalu membaca Surah Al-Fatihah.',
        ),
        StepSholat(
          title: 'Takbir Kedua (2)',
          description: 'Takbir lalu membaca Shalawat Ibrahimiyah kepada Nabi Muhammad SAW.',
        ),
        StepSholat(
          title: 'Takbir Ketiga (3)',
          description: 'Takbir lalu membaca doa ampunan untuk jenazah: "Allaahummaghfir lahu warhamhu..."',
          arabic: 'اَللّٰهُمَّ اغْفِرْ لَهُ (لَهَا) وَارْحَمْهُ وَعَافِهِ وَاعْفُ عَنْهُ',
          latin: "Allaahummaghfir lahu (laki-laki) / lahaa (perempuan) warhamhu wa 'aafihi wa'fu 'anhu.",
          translation: 'Ya Allah, ampunilah dia, rahmatilah dia, selamatkanlah dia dan maafkanlah kesalahannya.',
        ),
        StepSholat(
          title: 'Takbir Keempat (4) & Salam',
          description: 'Takbir membaca doa penutup, lalu mengucap salam ke kanan dan ke kiri.',
        ),
      ],
    ),

    // ==========================================
    // 3. BERSUCI (WUDHU & TAYAMMUM)
    // ==========================================
    ModelTuntunanSholat(
      id: 'wudhu',
      title: 'Tata Cara Berwudhu',
      category: 'bersuci',
      subtitle: 'Panduan rukun, sunnah, & doa setelah wudhu',
      hukum: 'Syarat Sah Sholat (Wajib Bersuci)',
      keutamaan: 'Menggugurkan dosa-dosa dari setiap anggota tubuh yang dibasuh bersama tetesan air wudhu.',
      niatMunfarid: NiatSholat(
        arabic: 'نَوَيْتُ الْوُضُوْءَ لِرَفْعِ الْحَدَثِ الأَصْغَرِ فَرْضًا لِلّٰهِ تَعَالَى',
        latin: "Nawaitul wudhuu-a liraf'il hadatsil ashghari fardhan lillaahi ta'aalaa.",
        translation: 'Saya niat berwudhu untuk menghilangkan hadats kecil fardhu karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: '1. Membaca Basmalah & Mencuci Telapak Tangan',
          description: 'Mencuci kedua telapak tangan hingga sela-sela jari sebanyak 3 kali.',
        ),
        StepSholat(
          title: '2. Berkumur-kumur & Istinsyaq',
          description: 'Berkumur-kumur 3 kali dan menghirup air ke hidung lalu mengeluarkannya 3 kali.',
        ),
        StepSholat(
          title: '3. Membasuh Wajah & Niat',
          description: 'Membasuh seluruh wajah dari tumbuhnya rambut hingga dagu sebanyak 3 kali sambil berniat wudhu dalam hati.',
        ),
        StepSholat(
          title: '4. Membasuh Kedua Tangan Hingga Siku',
          description: 'Membasuh tangan kanan hingga siku 3 kali, lalu tangan kiri 3 kali.',
        ),
        StepSholat(
          title: '5. Mengusap Sebagian Kepala / Rambut',
          description: 'Mengusap kepala dengan air sebanyak 3 kali.',
        ),
        StepSholat(
          title: '6. Membasuh Kedua Telinga',
          description: 'Mengusap daun telinga luar dan dalam dengan air sebanyak 3 kali.',
        ),
        StepSholat(
          title: '7. Membasuh Kedua Kaki Hingga Mata Kaki',
          description: 'Membasuh kaki kanan hingga mata kaki dan sela-sela jari 3 kali, lalu kaki kiri 3 kali.',
        ),
        StepSholat(
          title: '8. Tertib & Berdoa Setelah Wudhu',
          description: 'Melakukan seluruh rukun secara berurutan dan membaca doa setelah wudhu menghadap kiblat.',
        ),
      ],
      doaTambahan: [
        DoaTambahan(
          title: 'Doa Setelah Berwudhu',
          arabic: 'أَشْهَدُ أَنْ لاَ إِلٰهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيْكَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُوْلُهُ. اَللّٰهُمَّ اجْعَلْنِيْ مِنَ التَّوَّابِيْنَ وَاجْعَلْنِيْ مِنَ الْمُتَطَهِّرِيْنَ وَاجْعَلْنِيْ مِنْ عِبَادِكَ الصَّالِحِيْنَ',
          latin: "Asyhadu allaa ilaaha illallaahu wahdahu laa syariika lah, wa asyhadu anna Muhammadan 'abduhu wa rasuuluh. Allaahummaj'alnii minat tawwaabiina waj'alnii minal mutathahhiriina waj'alnii min 'ibaadikash shaalihiin.",
          translation: 'Aku bersaksi tiada Tuhan selain Allah Yang Maha Esa tiada sekutu bagi-Nya, dan aku bersaksi Muhammad adalah hamba dan utusan-Nya. Ya Allah, jadikanlah aku termasuk golongan orang-orang yang bertaubat, jadikanlah aku termasuk golongan orang-orang yang bersuci, dan jadikanlah aku termasuk hamba-hamba-Mu yang shalih.',
        ),
      ],
    ),

    ModelTuntunanSholat(
      id: 'tayammum',
      title: 'Tata Cara Tayammum',
      category: 'bersuci',
      subtitle: 'Bersuci dengan debu suci saat tidak ada air',
      hukum: 'Rukhsah (Keringanan) Pengganti Wudhu / Mandi',
      keutamaan: 'Keringanan dari Allah agar ibadah sholat tetap dapat ditunaikan dalam kondisi darurat.',
      niatMunfarid: NiatSholat(
        arabic: 'نَوَيْتُ التَّيَمُّمَ لاِسْتِبَاحَةِ الصَّلَاةِ فَرْضًا لِلّٰهِ تَعَالَى',
        latin: "Nawaitut tayammuma listibaahatish shalaati fardhan lillaahi ta'aalaa.",
        translation: 'Saya berniat tayammum untuk dapat melaksanakan sholat fardhu karena Allah Ta\'ala.',
      ),
      steps: [
        StepSholat(
          title: '1. Meletakkan Telapak Tangan pada Debu Suci',
          description: 'Menepukkan kedua telapak tangan ke permukaan yang berdebu bersih dan suci, lalu meniupnya perlahan.',
        ),
        StepSholat(
          title: '2. Mengusap Wajah',
          description: 'Mengusapkan debu pada kedua tangan ke seluruh permukaan wajah sambil berniat.',
        ),
        StepSholat(
          title: '3. Mengusap Kedua Tangan Hingga Siku',
          description: 'Menepukkan tangan kembali ke debu di tempat berbeda, lalu mengusapkannya ke tangan kanan hingga siku dan tangan kiri hingga siku.',
        ),
      ],
    ),

    // ==========================================
    // 4. DZIKIR & DOA SESUDAH SHOLAT
    // ==========================================
    ModelTuntunanSholat(
      id: 'dzikir_sholat',
      title: 'Dzikir & Doa Setelah Sholat Fardhu',
      category: 'dzikir',
      subtitle: 'Lengkap Istighfar, Tasbih, Ayat Kursi, & Doa',
      hukum: 'Sunnah Muakkad',
      keutamaan: 'Dzikir setelah sholat fardhu adalah amalan yang sangat dicintai Rasulullah SAW dan menghapus dosa.',
      steps: [
        StepSholat(
          title: '1. Membaca Istighfar (3x)',
          description: 'Memohon ampunan kepada Allah setelah mengucap salam.',
          arabic: 'أَسْتَغْفِرُ اللهَ الْعَظِيْمَ الَّذِيْ لاَ إِلٰهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّوْمُ وَأَتُوْبُ إِلَيْهِ (٣x)',
          latin: "Astaghfirullaahal 'azhiimal ladzii laa ilaaha illaa huwal hayyul qayyuumu wa atuubu ilaih (3x)",
          translation: 'Aku memohon ampun kepada Allah Yang Maha Agung, yang tiada Tuhan selain Dia, Yang Maha Hidup lagi Maha Berdiri Sendiri, dan aku bertaubat kepada-Nya.',
        ),
        StepSholat(
          title: '2. Membaca Doa Keselamatan (Allaahumma Antas Salaam)',
          description: 'Memuji Allah sebagai sumber kedamaian.',
          arabic: 'اَللّٰهُمَّ أَنْتَ السَّلاَمُ وَمِنْكَ السَّلاَمُ تَبَارَكْتَ يَا ذَا الْجَلاَلِ وَالإِكْرَامِ',
          latin: "Allaahumma antas salaam wa minkas salaam tabaarakta yaa dzal jalaali wal ikraam.",
          translation: 'Ya Allah, Engkaulah As-Salam (keselamatan) dan dari-Mu lah datangnya keselamatan, Maha Berkah Engkau wahai Dzat Yang Memiliki Keagungan dan Kemuliaan.',
        ),
        StepSholat(
          title: '3. Membaca Tasbih, Tahmid, & Takbir (masing-masing 33x)',
          description: 'Mengagungkan Allah sebanyak 33 kali.',
          arabic: 'سُبْحَانَ اللهِ (٣٣x)\nاَلْحَمْدُ لِلّٰهِ (٣٣x)\nاللهُ أَكْبَرُ (٣٣x)',
          latin: 'Subhaanallaah (33x)\nAlhamdulillaah (33x)\nAllaahu Akbar (33x)',
          translation: 'Maha Suci Allah (33x), Segala Puji bagi Allah (33x), Allah Maha Besar (33x).',
        ),
        StepSholat(
          title: '4. Membaca Tahlil Penyempurna 100x',
          description: 'Membaca pengesaan Allah di akhir tasbih.',
          arabic: 'لاَ إِلٰهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيْكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ يُحْيِيْ وَيُمِيْتُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيْرٌ',
          latin: "Laa ilaaha illallaahu wahdahu laa syariika lah, lahul mulku wa lahul hamdu yuhyii wa yumiitu wa huwa 'alaa kulli syai-in qadiir.",
          translation: 'Tiada Tuhan selain Allah Yang Maha Esa tiada sekutu bagi-Nya, milik-Nya kerajaan dan milik-Nya segala puji, Yang Menghidupkan dan Mematikan, dan Dia Maha Kuasa atas segala sesuatu.',
        ),
        StepSholat(
          title: '5. Membaca Ayat Kursi',
          description: 'Rasulullah bersabda barangsiapa membaca Ayat Kursi setiap usai sholat wajib, tidak ada yang menghalanginya masuk surga kecuali kematian.',
          arabic: 'اللّٰهُ لَآ اِلٰهَ اِلَّا هُوَ الْحَيُّ الْقَيُّوْمُۚ لَا تَاْخُذُهٗ سِنَةٌ وَّلَا نَوْمٌۗ لَهٗ مَا فِى السَّمٰوٰتِ وَمَا فِى الْاَرْضِۗ مَنْ ذَا الَّذِيْ يَشْفَعُ عِنْدَهٗٓ اِلَّا بِاِذْنِهٖۗ يَعْلَمُ مَا بَيْنَ اَيْدِيْهِمْ وَمَا خَلْفَهُمْۚ وَلَا يُحِيْطُوْنَ بِشَيْءٍ مِّنْ عِلْمِهٖٓ اِلَّا بِمَا شَاۤءَۚ وَسِعَ كُرْسِيُّهُ السَّمٰوٰتِ وَالْاَرْضَۚ وَلَا يَـُٔوْدُهٗ حِفْظُهُمَاۚ وَهُوَ الْعَلِيُّ الْعَظِيْمُ',
          latin: "Allaahu laa ilaaha illaa huwal hayyul qayyuum, laa ta'khudzuhuu sinatuw wa laa naum, lahuu maa fis samaawaati wa maa fil ardh...",
          translation: 'Allah, tidak ada tuhan selain Dia. Yang Mahahidup, Yang terus-menerus mengurus (makhluk-Nya), tidak mengantuk dan tidak tidur. Milik-Nya apa yang ada di langit dan apa yang ada di bumi...',
        ),
      ],
    ),
  ];
}
