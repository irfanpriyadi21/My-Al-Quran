class ModelSholawat {
  final String id;
  final String title;
  final String category; // 'matsurah', 'hajat_rezeki', 'kesehatan_hati', 'perlindungan', 'maulid'
  final String subtitle;
  final String keutamaan;
  final String arabic;
  final String latin;
  final String translation;
  final String? anjuranBaca; // misal: "Dibaca 11x / 41x setelah sholat", "100x setiap hari"
  final String? sejarah;

  const ModelSholawat({
    required this.id,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.keutamaan,
    required this.arabic,
    required this.latin,
    required this.translation,
    this.anjuranBaca,
    this.sejarah,
  });
}

class SholawatData {
  static const List<ModelSholawat> list = [
    // 1. SHOLAWAT IBRAHIMIYYAH
    ModelSholawat(
      id: 'ibrahimiyyah',
      title: 'Shalawat Ibrahimiyyah',
      category: 'matsurah',
      subtitle: 'Shalawat paling utama diajarkan langsung oleh Rasulullah SAW',
      keutamaan: 'Shalawat paling afdhal dan shahih yang dibaca di setiap tasyahud akhir sholat fardhu. Diriwayatkan oleh Imam Bukhari dan Muslim.',
      anjuranBaca: 'Dibaca setiap tasyahud akhir dalam sholat dan wirid harian',
      sejarah: 'Diajarkan langsung oleh Nabi Muhammad SAW ketika para sahabat bertanya bagaimana cara bershalawat kepada beliau.',
      arabic: 'اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ وَعَلَى آلِ سَيِّدِنَا مُحَمَّدٍ، كَمَا صَلَّيْتَ عَلَى سَيِّدِنَا إِبْرَاهِيْمَ وَعَلَى آلِ سَيِّدِنَا إِبْرَاهِيْمَ، وَبَارِكْ عَلَى سَيِّدِنَا مُحَمَّدٍ وَعَلَى آلِ سَيِّدِنَا مُحَمَّدٍ، كَمَا بَارَكْتَ عَلَى سَيِّدِنَا إِبْرَاهِيْمَ وَعَلَى آلِ سَيِّدِنَا إِبْرَاهِيْمَ، فِيْ الْعَالَمِيْنَ إِنَّكَ حَمِيْدٌ مَّجِيْدٌ',
      latin: "Allaahumma shalli 'alaa sayyidinaa Muhammadin wa 'alaa aali sayyidinaa Muhammad, kamaa shallaita 'alaa sayyidinaa Ibraahiima wa 'alaa aali sayyidinaa Ibraahiim, wa baarik 'alaa sayyidinaa Muhammadin wa 'alaa aali sayyidinaa Muhammad, kamaa baarakta 'alaa sayyidinaa Ibraahiima wa 'alaa aali sayyidinaa Ibraahiim, fil-'aalamiina innaka hamiidum majiid.",
      translation: 'Ya Allah, limpahkanlah rahmat kepada junjungan kami Nabi Muhammad dan kepada keluarga junjungan kami Nabi Muhammad, sebagaimana Engkau telah melimpahkan rahmat kepada Nabi Ibrahim dan keluarganya. Dan berkahilah Nabi Muhammad dan keluarganya, sebagaimana Engkau telah memberkahi Nabi Ibrahim dan keluarganya. Di seluruh alam semesta, sesungguhnya Engkau Maha Terpuji lagi Maha Mulia.',
    ),

    // 2. SHOLAWAT NARIYAH (TAFRIJIYYAH)
    ModelSholawat(
      id: 'nariyah',
      title: 'Shalawat Nariyah (Tafrijiyyah)',
      category: 'hajat_rezeki',
      subtitle: 'Shalawat pembuka rezeki & pengurai kesulitan besar',
      keutamaan: 'Dikenal sebagai shalawat Tafrijiyyah (pelepas kesempitan). Dipercaya dapat melapangkan rezeki, mengabulkan hajat mendesak, dan menghilangkan kesedihan mendalam.',
      anjuranBaca: 'Dibaca 11x setelah sholat fardhu, atau 4444x saat hajat sangat besar',
      sejarah: 'Disusun oleh Syaikh Ahmad At-Tazi Al-Maghribi dari Maroko.',
      arabic: 'اَللّٰهُمَّ صَلِّ صَلَاةً كَامِلَةً وَسَلِّمْ سَلَامًا تَامًّا عَلَى سَيِّدِنَا مُحَمَّدٍ الَّذِيْ تَنْحَلُّ بِهِ الْعُقَدُ، وَتَنْفَرِجُ بِهِ الْكُرَبُ، وَتُقْضَى بِهِ الْحَوَائِجُ، وَتُنَالُ بِهِ الرَّغَائِبُ وَحُسْنُ الْخَوَاتِمِ، وَيُسْتَسْقَى الْغَمَامُ بِوَجْهِهِ الْكَرِيْمِ، وَعَلَى آلِهِ وَصَحْبِهِ فِيْ كُلِّ لَمْحَةٍ وَنَفَسٍ بِعَدَدِ كُلِّ مَعْلُوْمٍ لَّكَ',
      latin: "Allaahumma shalli shalaatan kaamilataw wa sallim salaaman taamman 'alaa sayyidinaa Muhammadinil-ladzii tanhallu bihil-'uqad, wa tanfariju bihil-kurab, wa tuqdhaa bihil-hawaa-ij, wa tunaalu bihir-raghaa-ibu wa husnul-khawaatim, wa yustasqal-ghamaamu biwajhihil-kariim, wa 'alaa aalihii wa shahbihii fii kulli lamhatiw wa nafasim bi'adadi kulli ma'luumil lak.",
      translation: 'Ya Allah, limpahkanlah shalawat yang sempurna dan keselamatan yang paripurna kepada junjungan kami Nabi Muhammad, yang dengan perantaraannya terlepas segala ikatan (kesulitan), terurai segala bencana, terpenuhi segala hajat, tercapai segala keinginan dan husnul khatimah, serta dicurahkan air hujan berkat wajahnya yang mulia. Dan limpahkanlah pula kepada keluarga dan para sahabatnya di setiap kedipan mata dan hembusan nafas sebanyak hitungan segala yang Engkau ketahui.',
    ),

    // 3. SHOLAWAT THIBBIL QULUB (SYIFA)
    ModelSholawat(
      id: 'thibbil_qulub',
      title: 'Shalawat Thibbil Qulub (Syifa)',
      category: 'kesehatan_hati',
      subtitle: 'Obat penawar hati, jasmani, & ketenangan batin',
      keutamaan: 'Shalawat penyembuh dan penentram jiwa. Sangat baik diamalkan saat sedang sakit jasmani maupun mengalami kecemasan, gelisah, dan stres mental.',
      anjuranBaca: 'Dibaca 7x, 11x, atau 33x saat tubuh kurang sehat atau sesudah sholat',
      arabic: 'اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ طِبِّ الْقُلُوْبِ وَدَوَائِهَا، وَعَافِيَةِ الْأَبْدَانِ وَشِفَائِهَا، وَنُوْرِ الْأَبْصَارِ وَضِيَائِهَا، وَعَلَى آلِهِ وَصَحْبِهِ وَسَلِّمْ',
      latin: "Allaahumma shalli 'alaa sayyidinaa Muhammadin thibbil-quluubi wa dawaa-ihaa, wa 'aafiyatil-abdaani wa syifaa-ihaa, wa nuuril-abshaari wa dhiyaa-ihaa, wa 'alaa aalihii wa shahbihii wa sallim.",
      translation: 'Ya Allah, limpahkanlah rahmat kepada junjungan kami Nabi Muhammad sebagai obat hati dan penyembuhnya, penyehat badan dan kesembuhannya, cahaya penglihatan dan pancaran sinarnya, serta limpahkanlah keselamatan kepada keluarga dan para sahabatnya.',
    ),

    // 4. SHOLAWAT MUNJIYAT (PENYELAMAT)
    ModelSholawat(
      id: 'munjiyat',
      title: 'Shalawat Munjiyat',
      category: 'perlindungan',
      subtitle: 'Shalawat penyelamat dari marabahaya & musibah',
      keutamaan: 'Menyelamatkan pengamalnya dari segala ketakutan, badai kesulitan, mengangkat derajat di sisi Allah, dan mengabulkan segala cita-cita mulia.',
      anjuranBaca: 'Dibaca 11x atau 41x setelah sholat Subuh dan Maghrib',
      sejarah: 'Diterima oleh Syaikh Musa Adh-Dharir ketika kapalnya di lautan hampir tenggelam diterjang badai dahsyat.',
      arabic: 'اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ صَلَاةً تُنْجِيْنَا بِهَا مِنْ جَمِيْعِ الْأَهْوَالِ وَالْآفَاتِ، وَتَقْضِيْ لَنَا بِهَا جَمِيْعَ الْحَاجَاتِ، وَتُطَهِّرُنَا بِهَا مِنْ جَمِيْعِ السَّيِّئَاتِ، وَتَرْفَعُنَا بِهَا عِنْدَكَ أَعْلَى الدَّرَجَاتِ، وَتُبَلِّغُنَا بِهَا أَقْصَى الْغَايَاتِ مِنْ جَمِيْعِ الْخَيْرَاتِ فِيْ الْحَيَاةِ وَبَعْدَ الْمَمَاتِ',
      latin: "Allaahumma shalli 'alaa sayyidinaa Muhammadin shalaatan tunjiinaa bihaa min jamii'il-ahwaali wal-aafaat, wa taqdhii lanaa bihaa jamii'al-haajaat, wa tuthahhirunaa bihaa min jamii'is-sayyi-aat, wa tarfa'unaa bihaa 'indaka a'lad-darajaat, wa tuballighunaa bihaa aqshal-ghaayaat min jamii'il-khairaati fil-hayaati wa ba'dal-mamaat.",
      translation: 'Ya Allah, limpahkanlah rahmat kepada junjungan kami Nabi Muhammad, rahmat yang dengannya Engkau menyelamatkan kami dari segala bencana dan marabahaya, Engkau tunaikan segala hajat kami, Engkau bersihkan kami dari segala keburukan, Engkau tinggikan derajat kami di sisi-Mu ke derajat yang paling mulia, dan Engkau sampaikan kami kepada puncak segala tujuan kebaikan semasa hidup maupun sesudah wafat.',
    ),

    // 5. SHOLAWAT JIBRIL
    ModelSholawat(
      id: 'jibril',
      title: 'Shalawat Jibril',
      category: 'hajat_rezeki',
      subtitle: 'Shalawat ringkas penarik rezeki barakah & cinta Nabi',
      keutamaan: 'Shalawat yang paling sering dibaca para wali dan ulama untuk menarik rezeki dari segala penjuru, melunasi hutang, dan mendatangkan mahabbah (rasa cinta).',
      anjuranBaca: 'Dibaca 100x hingga 1.000x setiap hari secara istiqomah',
      sejarah: 'Pertama kali dilafadzkan oleh Malaikat Jibril AS kepada Nabi Adam AS sebagai mahar meminang Siti Hawa.',
      arabic: 'صَلَّى اللّٰهُ عَلَى مُحَمَّدٍ',
      latin: "Shallallaahu 'alaa Muhammad.",
      translation: 'Semoga Allah melimpahkan rahmat kepada Nabi Muhammad.',
    ),

    // 6. SHOLAWAT FATIH
    ModelSholawat(
      id: 'fatih',
      title: 'Shalawat Al-Fatih',
      category: 'hajat_rezeki',
      subtitle: 'Shalawat pembuka pintu kebaikan, rahmat, & hikmah',
      keutamaan: 'Membuka segala pintu kebaikan yang terkunci, menolong kebenaran dengan kebenaran, dan menunjukkan jalan yang lurus.',
      anjuranBaca: 'Dibaca minimal 1x - 11x setiap hari setelah sholat fardhu',
      sejarah: 'Disusun oleh Syaikh Muhammad Al-Bakri Al-Mishri.',
      arabic: 'اَللّٰهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ عَلَى سَيِّدِنَا مُحَمَّدٍ الْفَاتِحِ لِمَا أُغْلِقَ، وَالْخَاتِمِ لِمَا سَبَقَ، نَاصِرِ الْحَقِّ بِالْحَقِّ، وَالْهَادِيْ إِلَى صِرَاطِكَ الْمُسْتَقِيْمِ، وَعَلَى آلِهِ حَقَّ قَدْرِهِۦ وَمِقْدَارِهِ الْعَظِيْمِ',
      latin: "Allaahumma shalli wa sallim wa baarik 'alaa sayyidinaa Muhammadinil-faatihi limaa ughliq, wal-khaatimi limaa sabaq, naashiril-haqqi bil-haqq, wal-haadii ilaa shiraatikal-mustaqiim, wa 'alaa aalihii haqqa qadrihii wa miqdaarihil-'azhiim.",
      translation: 'Ya Allah, limpahkanlah rahmat, keselamatan, dan keberkahan kepada junjungan kami Nabi Muhammad, pembuka apa yang terkunci, penutup para nabi terdahulu, pembela kebenaran dengan kebenaran, dan penunjuk jalan-Mu yang lurus. Serta kepada keluarganya dengan penghormatan yang sepadan dengan kedudukan dan martabatnya yang agung.',
    ),

    // 7. SHOLAWAT ASYGHIL
    ModelSholawat(
      id: 'asyghil',
      title: 'Shalawat Asyghil',
      category: 'perlindungan',
      subtitle: 'Perlindungan dari orang zalim & keselamatan umat',
      keutamaan: 'Memohon perlindungan Allah dari kezaliman para perusak dan keselamatan bagi kaum mukminin di masa penuh fitnah.',
      anjuranBaca: 'Dibaca 3x atau 7x setiap selesai sholat fardhu atau saat situasi genting',
      sejarah: 'Diijazahkan oleh Imam Ja\'far Ash-Shadiq di masa pergolakan politik Bani Umayyah & Abbasiyah.',
      arabic: 'اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ، وَأَشْغِلِ الظَّالِمِيْنَ بِالظَّالِمِيْنَ، وَأَخْرِجْنَا مِنْ بَيْنِهِمْ سَالِمِيْنَ، وَعَلَى آلِهِ وَصَحْبِهِ أَجْمَعِيْنَ',
      latin: "Allaahumma shalli 'alaa sayyidinaa Muhammad, wa asyghilizh-zhaalimiina bizh-zhaalimiin, wa akhrijnaa mim bainihim saalimiin, wa 'alaa aalihii wa shahbihii ajma'iin.",
      translation: 'Ya Allah, limpahkanlah rahmat kepada junjungan kami Nabi Muhammad. Dan sibukkanlah orang-orang yang zalim dengan orang-orang zalim lainnya, serta selamatkanlah kami keluar dari kalangan mereka dalam keadaan selamat sejahtera, beserta seluruh keluarga dan para sahabatnya.',
    ),

    // 8. SHOLAWAT BADAR
    ModelSholawat(
      id: 'badar',
      title: 'Shalawat Badar',
      category: 'perlindungan',
      subtitle: 'Shalawat perjuangan berkah para syuhada perang Badar',
      keutamaan: 'Menghilangkan kesusahan, menghindarkan dari bala musibah, dan mendapatkan berkah syafaat Ahlul Badar.',
      anjuranBaca: 'Dibaca dalam majelis dzikir, pembuka acara, atau saat menghadapi ujian',
      sejarah: 'Dikarang oleh ulama Indonesia KH. Ali Manshur Banyuwangi tahun 1960-an.',
      arabic: 'صَلَاةُ اللّٰهِ سَلَامُ اللّٰهِ ۞ عَلَى طٰهَ رَسُوْلِ اللّٰهِ\nصَلَاةُ اللّٰهِ سَلَامُ اللّٰهِ ۞ عَلَى يٰسٓ حَبِيْبِ اللّٰهِ\nتَوَسَّلْنَا بِبِسْمِ اللّٰهِ ۞ وَبِالْهَادِيْ رَسُوْلِ اللّٰهِ\nوَكُلِّ مُجَاهِدٍ لِلّٰهِ ۞ بِأَهْلِ الْبَدْرِ يَا أَللّٰهُ',
      latin: "Shalaatullaah salaamullaah, 'alaa Thaahaa Rasuulillaah.\nShalaatullaah salaamullaah, 'alaa Yaasiin Habiibillaah.\nTawassalnaa bibismillaah, wa bil-Haadii Rasuulillaah.\nWa kulli mujaahidil lillaah, bi-ahlil-Badri yaa Allaah.",
      translation: 'Rahmat dan keselamatan Allah semoga tercurah kepada Nabi Thaha (Muhammad) utusan Allah. Rahmat dan keselamatan Allah semoga tercurah kepada Nabi Yasin kekasih Allah. Kami bertawassul dengan bismillah dan dengan petunjuk utusan Allah, serta setiap pejuang di jalan Allah berkat para syuhada perang Badar ya Allah.',
    ),

    // 9. SHOLAWAT BUSYRO
    ModelSholawat(
      id: 'busyro',
      title: 'Shalawat Busyro (Kabar Gembira)',
      category: 'kesehatan_hati',
      subtitle: 'Mendatangkan kegembiraan, ketenangan hidup, & kelapangan',
      keutamaan: 'Mendatangkan kabar gembira (busyra) dalam hidup, keturunan shalih/shalihah, kebahagiaan dunia akhirat.',
      anjuranBaca: 'Dibaca 41x setiap sesudah sholat Subuh',
      sejarah: 'Diijazahkan oleh Rasulullah SAW melalui mimpi Habib Hasan bin Ahmad Baharun.',
      arabic: 'اَللّٰهُمَّ صَلِّ وَسَلِّمْ عَلَى سَيِّدِنَا مُحَمَّدٍ صَاحِبِ الْبُشْرَى، صَلَاةً تُبَشِّرُنَا بِهَا وَأَهْلَنَا وَأَوْلَادَنَا وَجَمِيْعَ مَشَايِخِنَا وَمُعَلِّمِيْنَا وَطَلَبَتَنَا وَطَالِبَاتِنَا، مِنْ يَوْمِنَا هٰذَا إِلَى يَوْمِ الْآخِرَةِ',
      latin: "Allaahumma shalli wa sallim 'alaa sayyidinaa Muhammadin shaahibil-busyraa, shalaatan tubasysyirunaa bihaa wa ahlanaa wa aulaadanaa wa jamii'a masyaayikhinaa wa mu'allimiinaa wa thalabatanaa wa thaalibaatinaa, miy yauminaa haadzaa ilaa yaumil-aakhirah.",
      translation: 'Ya Allah, limpahkanlah shalawat dan keselamatan kepada junjungan kami Nabi Muhammad pembawa kabar gembira, rahmat yang menggembirakan kami dengannya beserta keluarga kami, anak-anak kami, para guru kami, para pendidik kami, serta murid-murid kami laki-laki dan perempuan, dari hari ini hingga hari kiamat kelak.',
    ),

    // 10. SHOLAWAT NURIDZ-DZAT
    ModelSholawat(
      id: 'nuridz_dzat',
      title: 'Shalawat Nuridz-Dzat',
      category: 'kesehatan_hati',
      subtitle: 'Penerang hati & pembuka rahasia-rahasia batin',
      keutamaan: 'Menerangi hati yang gelap, menjauhkan dari mara bahaya dan fitnah, serta mendekatkan diri kepada Allah SWT.',
      anjuranBaca: 'Dibaca 3x atau 21x setiap selesai sholat',
      sejarah: 'Disusun oleh Syaikh Abul Hasan Asy-Syadzili rahimahullah.',
      arabic: 'اَللّٰهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ عَلَى سَيِّدِنَا مُحَمَّدٍ النُّوْرِ الذَّاتِيِّ وَالسِّرِّ السَّارِيْ فِيْ سَائِرِ الْأَسْمَاءِ وَالصِّفَاتِ، وَعَلَى آلِهِ وَصَحْبِهِ وَسَلِّمْ',
      latin: "Allaahumma shalli wa sallim wa baarik 'alaa sayyidinaa Muhammadinin-nuuridz-dzaatii was-sirris-saarii fii saa-iril-asmaaa-i wash-shifaat, wa 'alaa aalihii wa shahbihii wa sallim.",
      translation: 'Ya Allah, limpahkanlah shalawat, salam, dan berkah kepada junjungan kami Nabi Muhammad, cahaya Dzat dan rahasia yang mengalir pada seluruh nama dan sifat-sifat-Nya, serta limpahkanlah kepada keluarga dan para sahabatnya.',
    ),

    // 11. SHOLAWAT UMMI (JUM'AT SORE)
    ModelSholawat(
      id: 'ummi',
      title: 'Shalawat Ummi',
      category: 'matsurah',
      subtitle: 'Amalan istimewa di hari Jum\'at pengampun dosa 80 tahun',
      keutamaan: 'Barangsiapa membaca shalawat ini 80 kali pada hari Jum\'at (terutama ba\'da Ashar), Allah mengampuni dosanya selama 80 tahun dan dicatat ibadah 80 tahun (HR. Thabrani & Baihaqi).',
      anjuranBaca: 'Dibaca 80x pada hari Jum\'at setelah sholat Ashar sebelum beranjak',
      arabic: 'اَللّٰهُمَّ صَلِّ عَلَى مُحَمَّدٍ عَبْدِكَ وَنَبِيِّكَ وَرَسُوْلِكَ النَّبِيِّ الْأُمِّيِّ، وَعَلَى آلِهِ وَصَحْبِهِ وَسَلِّمْ تَسْلِيْمًا',
      latin: "Allaahumma shalli 'alaa Muhammadin 'abdika wa nabiyyika wa rasuulikan-nabiyyil-ummiyyi, wa 'alaa aalihii wa shahbihii wa sallim tasliimaa.",
      translation: 'Ya Allah, limpahkanlah rahmat kepada Nabi Muhammad hamba-Mu, Nabi-Mu, dan Rasul-Mu yang ummi, serta limpahkanlah kepada keluarga dan para sahabatnya keselamatan yang sebesar-besarnya.',
    ),

    // 12. SHOLAWAT MAHALLUL QIYAM
    ModelSholawat(
      id: 'mahallul_qiyam',
      title: 'Shalawat Mahallul Qiyam',
      category: 'maulid',
      subtitle: 'Bait salam puji-pujian kerinduan kepada Rasulullah SAW',
      keutamaan: 'Dibaca saat berdiri (*Mahallul Qiyam*) pada pembacaan Maulid Simtudduror, Diba\', Al-Barzanji, dan Dhiyaul Lami\' untuk menyambut kehadiran ruhaniyah Baginda Nabi SAW.',
      anjuranBaca: 'Dibaca saat perayaan Maulid Nabi dan majelis shalawat',
      arabic: 'يَا نَبِي سَلَامٌ عَلَيْكَ ۞ يَا رَسُوْل سَلَامٌ عَلَيْكَ\nيَا حَبِيْب سَلَامٌ عَلَيْكَ ۞ صَلَوَاتُ اللّٰهِ عَلَيْكَ\nأَشْرَقَ الْبَدْرُ عَلَيْنَا ۞ فَاخْتَفَتْ مِنْهُ الْبُدُوْرُ\nمِثْلَ حُسْنِكْ مَا رَأَيْنَا ۞ قَطُّ يَا وَجْهَ السُّرُوْرِ\nأَنْتَ شَمْسٌ أَنْتَ بَدْرٌ ۞ أَنْتَ نُوْرٌ فَوْقَ نُوْرٍ\nأَنْتَ إِكْسِيْرٌ وَغَالِيْ ۞ أَنْتَ مِصْبَاحُ الصُّدُوْرِ',
      latin: "Yaa Nabii salaam 'alaika ۞ Yaa Rasuul salaam 'alaika\nYaa Habiib salaam 'alaika ۞ Sholawaatullaah 'alaika\nAsyraqal-badru 'alainaa ۞ Fakhtafat minhul-buduuru\nMitsla husnik maa ra-ainaa ۞ Qatthu yaa wajhas-suruuri\nAnta syamsun anta badrun ۞ Anta nuurun fauqa nuurin\nAnta iksiiruw wa ghaalii ۞ Anta mishbaahush-shuduuri.",
      translation: 'Wahai Nabi, salam sejahtera untukmu. Wahai Rasul, salam sejahtera untukmu. Wahai Kekasih, salam sejahtera untukmu. Shalawat Allah semoga tercurah untukmu. Telah terbit purnama di atas kami, hingga tenggelamlah semua purnama lainnya. Wajah seindah dirimu belum pernah kami lihat, wahai pemilik wajah penuh kegembiraan. Engkaulah mentari, engkaulah purnama, engkaulah cahaya di atas cahaya. Engkaulah permata yang tiada ternilai, engkaulah pelita penerang di dalam dada.',
    ),
  ];
}
