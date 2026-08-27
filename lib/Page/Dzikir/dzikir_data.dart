import 'package:my_quran/Model/model_dzikir.dart';

class DzikirData {
  // 1. Preset Lafadz Tasbih Digital
  static const List<ModelTasbihPreset> listTasbihPreset = [
    ModelTasbihPreset(
      id: "t1",
      title: "Tasbih",
      arabic: "سُبْحَانَ اللَّهِ",
      latin: "Subhanallah",
      translation: "Maha Suci Allah",
      defaultTarget: 33,
    ),
    ModelTasbihPreset(
      id: "t2",
      title: "Tahmid",
      arabic: "الْحَمْدُ لِلَّهِ",
      latin: "Alhamdulillah",
      translation: "Segala puji bagi Allah",
      defaultTarget: 33,
    ),
    ModelTasbihPreset(
      id: "t3",
      title: "Takbir",
      arabic: "اللَّهُ أَكْبَرُ",
      latin: "Allahu Akbar",
      translation: "Allah Maha Besar",
      defaultTarget: 33,
    ),
    ModelTasbihPreset(
      id: "t4",
      title: "Tahlil",
      arabic: "لَا إِلٰهَ إِلَّا اللَّهُ",
      latin: "Laa ilaaha illallah",
      translation: "Tiada Tuhan yang berhak disembah selain Allah",
      defaultTarget: 100,
    ),
    ModelTasbihPreset(
      id: "t5",
      title: "Istighfar",
      arabic: "أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ",
      latin: "Astaghfirullahal 'adzim",
      translation: "Aku memohon ampun kepada Allah Yang Maha Agung",
      defaultTarget: 100,
    ),
    ModelTasbihPreset(
      id: "t6",
      title: "Shalawat Nabi",
      arabic: "اللَّهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ",
      latin: "Allahumma sholli 'ala sayyidina Muhammad",
      translation: "Ya Allah, limpahkanlah rahmat kepada junjungan kami Nabi Muhammad",
      defaultTarget: 100,
    ),
    ModelTasbihPreset(
      id: "t7",
      title: "Hauqolah",
      arabic: "لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ",
      latin: "Laa hawla wa laa quwwata illa billah",
      translation: "Tiada daya dan upaya kecuali dengan pertolongan Allah",
      defaultTarget: 33,
    ),
    ModelTasbihPreset(
      id: "t8",
      title: "Tasbih Lengkap",
      arabic: "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ سُبْحَانَ اللَّهِ الْعَظِيمِ",
      latin: "Subhanallahi wa bihamdihi, Subhanallahil 'adzim",
      translation: "Maha Suci Allah dengan segala puji bagi-Nya, Maha Suci Allah Yang Maha Agung",
      defaultTarget: 100,
    ),
  ];

  // 2. Kumpulan Dzikir Pagi Sesuai Sunnah
  static const List<ModelDzikir> listDzikirPagi = [
    ModelDzikir(
      id: "dp1",
      title: "Membaca Ayat Kursi",
      arabic:
          "اللَّهُ لَا إِلٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ",
      latin:
          "Allahu laa ilaaha illaa Huwal Hayyul Qayyum, laa ta'khudzuhu sinatuw-wa laa nawm, lahu maa fis-samawaati wa maa fil-ardh, man dzalladzii yasyfa'u 'indahu illaa bi-idznih, ya'lamu maa bayna aydiihim wa maa khalfahum, wa laa yuhiithuuna bisyay-im-min 'ilmihii illaa bimaa syaa', wasi'a kursiyyuhus-samawaati wal-ardh, wa laa ya'uuduhu hifdzuhumaa wa Huwal 'Aliyyul 'Adziim.",
      translation:
          "Allah, tidak ada Tuhan (yang berhak disembah) melainkan Dia Yang Hidup kekal lagi terus menerus mengurus (makhluk-Nya); tidak mengantuk dan tidak tidur. Kepunyaan-Nya apa yang di langit dan di bumi. Tiada yang dapat memberi syafa'at di sisi Allah tanpa izin-Nya? Allah mengetahui apa-apa yang di hadapan mereka dan di belakang mereka, dan mereka tidak mengetahui apa-apa dari ilmu Allah melainkan apa yang dikehendaki-Nya. Kursi Allah meliputi langit dan bumi. Dan Allah tidak merasa berat memelihara keduanya, dan Allah Maha Tinggi lagi Maha Besar.",
      repeatCount: 1,
      fadhilah: "Barangsiapa membacanya di pagi hari, ia akan dilindungi dari gangguan jin dan setan hingga petang hari.",
      riwayat: "HR. Al-Hakim (1/562), Shahih At-Targhib no. 655",
    ),
    ModelDzikir(
      id: "dp2",
      title: "Membaca Surat Al-Ikhlas, Al-Falaq, & An-Naas",
      arabic:
          "قُلْ هُوَ اللَّهُ أَحَدٌ ۞ اللَّهُ الصَّمَدُ ۞ لَمْ يَلِدْ وَلَمْ يُولَدْ ۞ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ\n\nقُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۞ مِن شَرِّ مَا خَلَقَ ۞ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ۞ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ۞ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ\n\nقُلْ أَعُوذُ بِرَبِّ النَّاسِ ۞ مَلِكِ النَّاسِ ۞ إِلَٰهِ النَّاسِ ۞ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۞ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ۞ مِنَ الْجِنَّةِ وَالنَّاسِ",
      latin:
          "Qul Huwallahu Ahad... (Al-Ikhlas)\nQul A'uudzu bi Rabbil Falaq... (Al-Falaq)\nQul A'uudzu bi Rabbin Naas... (An-Naas)",
      translation:
          "Membaca Surat Al-Ikhlas, Surat Al-Falaq, dan Surat An-Naas masing-masing sebanyak 3 kali.",
      repeatCount: 3,
      fadhilah: "Mencukupkan bagimu dari segala kejahatan dan marabahaya dari pagi hingga petang.",
      riwayat: "HR. Abu Dawud no. 5082, Tirmidzi no. 3575, shahih",
    ),
    ModelDzikir(
      id: "dp3",
      title: "Menyambut Pagi (Ashbahna wa Ashbahal Mulku)",
      arabic:
          "أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هٰذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هٰذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ",
      latin:
          "Ashbahnaa wa ashbahal mulku lillaahi walhamdu lillaah, laa ilaaha illallaahu wahdahu laa syariika lah, lahul mulku wa lahul hamdu wa Huwa 'alaa kulli syay-in qadiir. Rabbi as-aluka khayra maa fii haadzal yawmi wa khayra maa ba'dahu, wa a'uudzu bika min syarri maa fii haadzal yawmi wa syarri maa ba'dahu, Rabbi a'uudzu bika minal kasali wa suu-il kibari, Rabbi a'uudzu bika min 'adzaabin fin-naari wa 'adzaabin fil qabr.",
      translation:
          "Kami telah memasuki waktu pagi dan kerajaan hanya milik Allah, segala puji bagi Allah. Tidak ada Tuhan yang berhak disembah selain Allah Yang Maha Esa, tiada sekutu bagi-Nya. Bagi-Nya kerajaan dan bagi-Nya pujian. Dan Dia Maha Kuasa atas segala sesuatu. Wahai Tuhanku, aku memohon kepada-Mu kebaikan hari ini dan kebaikan sesudahnya. Aku berlindung kepada-Mu dari keburukan hari ini dan keburukan sesudahnya. Wahai Tuhanku, aku berlindung kepada-Mu dari kemalasan dan keburukan di hari tua. Wahai Tuhanku, aku berlindung kepada-Mu dari siksa di neraka dan siksa di kubur.",
      repeatCount: 1,
      fadhilah: "Doa memohon perlindungan sepanjang hari dan meminta kebaikan di dunia serta akhirat.",
      riwayat: "HR. Muslim no. 2723",
    ),
    ModelDzikir(
      id: "dp4",
      title: "Sayyidul Istighfar",
      arabic:
          "اللَّهُمَّ أَنْتَ رَبِّي لَا إِلٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ",
      latin:
          "Allahumma Anta Rabbii laa ilaaha illaa Anta, khalaqtanii wa ana 'abduka, wa ana 'alaa 'ahdika wa wa'dika mastatha'tu, a'uudzu bika min syarri maa shana'tu, abuu-u laka bini'matika 'alayya, wa abuu-u bidzanbii faghfir lii fa-innahu laa yaghfirudz-dzunuuba illaa Anta.",
      translation:
          "Ya Allah, Engkau adalah Tuhanku, tidak ada Tuhan yang berhak disembah selain Engkau. Engkau yang menciptakan aku dan aku adalah hamba-Mu. Aku menetapi perjanjian-Mu dan janji-Mu sesuai dengan kemampuanku. Aku berlindung kepada-Mu dari keburukan apa yang telah aku perbuat. Aku mengakui nikmat-Mu kepadaku dan aku mengakui dosaku kepada-Mu, maka ampunilah aku, sesungguhnya tidak ada yang dapat mengampuni dosa selain Engkau.",
      repeatCount: 1,
      fadhilah: "Barangsiapa membacanya di pagi hari dengan penuh keyakinan, lalu meninggal pada hari itu sebelum petang, niscaya ia termasuk penghuni surga.",
      riwayat: "HR. Bukhari no. 6306",
    ),
    ModelDzikir(
      id: "dp5",
      title: "Doa Perlindungan dari Segala Mara Bahaya",
      arabic:
          "بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ",
      latin:
          "Bismillaahilladzii laa yadhurru ma'asmihii syay-un fil ardhi wa laa fis-samaa-i wa Huwas-Samii'ul 'Aliim.",
      translation:
          "Dengan nama Allah yang bersama nama-Nya tidak ada sesuatu pun di bumi maupun di langit yang dapat mendatangkan mudharat/bahaya, dan Dia Maha Mendengar lagi Maha Mengetahui.",
      repeatCount: 3,
      fadhilah: "Barangsiapa membacanya 3 kali di pagi hari, tidak akan ada marabahaya atau racun yang mencelakainya hingga petang.",
      riwayat: "HR. Abu Dawud no. 5088, Tirmidzi no. 3388, shahih",
    ),
    ModelDzikir(
      id: "dp6",
      title: "Keridhaan Iman (Rodhitu Billah)",
      arabic:
          "رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا",
      latin:
          "Radhiitu billaahi Rabbaa, wa bil Islaami diinaa, wa bi Muhammadin shallallaahu 'alayhi wa sallama Nabiyyaa.",
      translation:
          "Aku ridha Allah sebagai Tuhanku, Islam sebagai agamaku, dan Nabi Muhammad shallallahu 'alaihi wa sallam sebagai Nabiku.",
      repeatCount: 3,
      fadhilah: "Wajib bagi Allah untuk meridhai dan membahagiakan orang yang membacanya pada hari kiamat.",
      riwayat: "HR. Abu Dawud no. 5072, Tirmidzi no. 3389, hasan",
    ),
    ModelDzikir(
      id: "dp7",
      title: "Memohon Kesehatan & Perlindungan",
      arabic:
          "اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلٰهَ إِلَّا أَنْتَ. اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلٰهَ إِلَّا أَنْتَ",
      latin:
          "Allahumma 'aafinii fii badanii, Allahumma 'aafinii fii sam'ii, Allahumma 'aafinii fii basharii, laa ilaaha illaa Anta. Allahumma innii a'uudzu bika minal kufri wal faqr, wa a'uudzu bika min 'adzaabil qabr, laa ilaaha illaa Anta.",
      translation:
          "Ya Allah, berikanlah kesehatan pada badanku. Ya Allah, berikanlah kesehatan pada pendengaranku. Ya Allah, berikanlah kesehatan pada penglihatanku, tiada Tuhan selain Engkau. Ya Allah, sesungguhnya aku berlindung kepada-Mu dari kekafiran dan kefakiran. Dan aku berlindung kepada-Mu dari siksa kubur, tiada Tuhan selain Engkau.",
      repeatCount: 3,
      fadhilah: "Doa memohon keselamatan fisik, pendengaran, penglihatan, serta keselamatan akidah dari kefakiran.",
      riwayat: "HR. Abu Dawud no. 5090, hasan",
    ),
    ModelDzikir(
      id: "dp8",
      title: "Tasbih Penghapus Dosa 100x",
      arabic: "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ",
      latin: "Subhaanallaahi wa bihamdih.",
      translation: "Maha Suci Allah dan segala puji bagi-Nya.",
      repeatCount: 100,
      fadhilah: "Dosa-dosanya akan diampuni meskipun sebanyak buih di lautan.",
      riwayat: "HR. Muslim no. 2692, Bukhari no. 6405",
    ),
  ];

  // 3. Kumpulan Dzikir Petang Sesuai Sunnah
  static const List<ModelDzikir> listDzikirPetang = [
    ModelDzikir(
      id: "ds1",
      title: "Membaca Ayat Kursi",
      arabic:
          "اللَّهُ لَا إِلٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ",
      latin:
          "Allahu laa ilaaha illaa Huwal Hayyul Qayyum, laa ta'khudzuhu sinatuw-wa laa nawm, lahu maa fis-samawaati wa maa fil-ardh...",
      translation:
          "Allah, tidak ada Tuhan (yang berhak disembah) melainkan Dia Yang Hidup kekal lagi terus menerus mengurus (makhluk-Nya)...",
      repeatCount: 1,
      fadhilah: "Barangsiapa membacanya di waktu petang, ia akan dilindungi dari gangguan jin dan setan hingga pagi hari.",
      riwayat: "HR. Al-Hakim (1/562), Shahih At-Targhib no. 655",
    ),
    ModelDzikir(
      id: "ds2",
      title: "Membaca Surat Al-Ikhlas, Al-Falaq, & An-Naas",
      arabic:
          "قُلْ هُوَ اللَّهُ أَحَدٌ ۞ اللَّهُ الصَّمَدُ ۞ لَمْ يَلِدْ وَلَمْ يُولَدْ ۞ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ\n\nقُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۞ مِن شَرِّ مَا خَلَقَ ۞ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ۞ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ۞ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ\n\nقُلْ أَعُوذُ بِرَبِّ النَّاسِ ۞ مَلِكِ النَّاسِ ۞ إِلَٰهِ النَّاسِ ۞ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۞ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ۞ مِنَ الْجِنَّةِ وَالنَّاسِ",
      latin:
          "Qul Huwallahu Ahad (3x)\nQul A'uudzu bi Rabbil Falaq (3x)\nQul A'uudzu bi Rabbin Naas (3x)",
      translation:
          "Membaca Surat Al-Ikhlas, Al-Falaq, dan An-Naas masing-masing sebanyak 3 kali.",
      repeatCount: 3,
      fadhilah: "Akan mencukupkan bagimu dari segala kejahatan di malam hari.",
      riwayat: "HR. Abu Dawud no. 5082, Tirmidzi no. 3575",
    ),
    ModelDzikir(
      id: "ds3",
      title: "Menyambut Petang (Amsaina wa Amsal Mulku)",
      arabic:
          "أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هٰذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هٰذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ",
      latin:
          "Amsaynaa wa amsal mulku lillaahi walhamdu lillaah, laa ilaaha illallaahu wahdahu laa syariika lah, lahul mulku wa lahul hamdu wa Huwa 'alaa kulli syay-in qadiir. Rabbi as-aluka khayra maa fii haadzihil laylati wa khayra maa ba'dahaa, wa a'uudzu bika min syarri maa fii haadzihil laylati wa syarri maa ba'dahaa, Rabbi a'uudzu bika minal kasali wa suu-il kibari, Rabbi a'uudzu bika min 'adzaabin fin-naari wa 'adzaabin fil qabr.",
      translation:
          "Kami telah memasuki waktu petang dan kerajaan hanya milik Allah, segala puji bagi Allah. Tidak ada Tuhan selain Allah semata, tiada sekutu bagi-Nya. Bagi-Nya kerajaan dan pujian, dan Dia Maha Kuasa atas segala sesuatu. Wahai Tuhanku, aku memohon kebaikan malam ini dan kebaikan sesudahnya, dan aku berlindung dari keburukan malam ini dan sesudahnya...",
      repeatCount: 1,
      fadhilah: "Doa perlindungan sepanjang malam dari mara bahaya, kemalasan, dan siksa kubur.",
      riwayat: "HR. Muslim no. 2723",
    ),
    ModelDzikir(
      id: "ds4",
      title: "Sayyidul Istighfar",
      arabic:
          "اللَّهُمَّ أَنْتَ رَبِّي لَا إِلٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ",
      latin:
          "Allahumma Anta Rabbii laa ilaaha illaa Anta, khalaqtanii wa ana 'abduka, wa ana 'alaa 'ahdika wa wa'dika mastatha'tu...",
      translation:
          "Ya Allah, Engkau adalah Tuhanku, tidak ada Tuhan yang berhak disembah selain Engkau. Engkau yang menciptakan aku dan aku adalah hamba-Mu...",
      repeatCount: 1,
      fadhilah: "Barangsiapa membacanya di waktu sore dengan yakin, lalu meninggal pada malam itu, maka ia termasuk penghuni surga.",
      riwayat: "HR. Bukhari no. 6306",
    ),
    ModelDzikir(
      id: "ds5",
      title: "Perlindungan Kalimat Allah yang Sempurna",
      arabic: "أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ",
      latin: "A'uudzu bikalimaatillaahit-taammaati min syarri maa khalaq.",
      translation: "Aku berlindung dengan kalimat-kalimat Allah yang sempurna dari kejahatan makhluk yang Dia ciptakan.",
      repeatCount: 3,
      fadhilah: "Barangsiapa mengucapkannya 3 kali saat sore, tidak akan ada sengatan binatang berbisa/marabahaya yang membahayakannya malam itu.",
      riwayat: "HR. Muslim no. 2709",
    ),
    ModelDzikir(
      id: "ds6",
      title: "Doa Perlindungan dari Segala Bahaya",
      arabic:
          "بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ",
      latin:
          "Bismillaahilladzii laa yadhurru ma'asmihii syay-un fil ardhi wa laa fis-samaa-i wa Huwas-Samii'ul 'Aliim.",
      translation:
          "Dengan nama Allah yang bersama nama-Nya tidak ada sesuatu pun di bumi maupun di langit yang dapat mendatangkan mudharat, dan Dia Maha Mendengar lagi Maha Mengetahui.",
      repeatCount: 3,
      fadhilah: "Tidak akan tertimpa bencana mendadak hingga pagi hari.",
      riwayat: "HR. Abu Dawud no. 5088",
    ),
  ];

  // 4. Kumpulan Dzikir Setelah Shalat Fardhu
  static const List<ModelDzikir> listDzikirSetelahShalat = [
    ModelDzikir(
      id: "dsh1",
      title: "Istighfar 3x & Doa Keselamatan",
      arabic:
          "أَسْتَغْفِرُ اللَّهَ (٣×)\n\nاللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ، تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ",
      latin:
          "Astaghfirullaah (3x).\n\nAllahumma Antas-Salaamu wa minkas-salaamu, tabaarakta yaa Dzal Jalaali wal Ikraam.",
      translation:
          "Aku memohon ampun kepada Allah (3 kali).\n\nYa Allah, Engkau Mahasejahtera, dari-Mu lah kesejahteraan, Maha Berkah Engkau wahai Tuhan Pemilik Keagungan dan Kemuliaan.",
      repeatCount: 1,
      fadhilah: "Dibaca langsung sesudah salam dalam shalat fardhu.",
      riwayat: "HR. Muslim no. 591",
    ),
    ModelDzikir(
      id: "dsh2",
      title: "Dzikir Tauhid & Ketundukan",
      arabic:
          "لَا إِلٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، اللَّهُمَّ لَا مَانِعَ لِمَا أَعْطَيْتَ، وَلَا مُعْطِيَ لِمَا مَنَعْتَ، وَلَا يَنْفَعُ ذَا الْجَدِّ مِنْكَ الْجَدُّ",
      latin:
          "Laa ilaaha illallaahu wahdahu laa syariika lah, lahul mulku wa lahul hamdu wa Huwa 'alaa kulli syay-in qadiir. Allahumma laa maani'a limaa a'thayta, wa laa mu'thiya limaa mana'ta, wa laa yanfa'u dzal jaddi minkal jaddu.",
      translation:
          "Tiada Tuhan selain Allah Yang Maha Esa, tiada sekutu bagi-Nya. Milik-Nya kerajaan dan milik-Nya segala pujian, dan Dia Maha Kuasa atas segala sesuatu. Ya Allah, tidak ada yang dapat mencegah apa yang Engkau beri, dan tidak ada yang dapat memberi apa yang Engkau cegah, serta tidak berguna kekayaan bagi orang yang memilikinya dari siksa-Mu.",
      repeatCount: 1,
      fadhilah: "Sunnah dibaca oleh Rasulullah SAW setelah selesai shalat fardhu.",
      riwayat: "HR. Bukhari no. 844, Muslim no. 593",
    ),
    ModelDzikir(
      id: "dsh3",
      title: "Tasbih (33x)",
      arabic: "سُبْحَانَ اللَّهِ",
      latin: "Subhanallah",
      translation: "Maha Suci Allah",
      repeatCount: 33,
      fadhilah: "Bagian dari tasbih ba'da shalat yang menghapus dosa.",
      riwayat: "HR. Muslim no. 597",
    ),
    ModelDzikir(
      id: "dsh4",
      title: "Tahmid (33x)",
      arabic: "الْحَمْدُ لِلَّهِ",
      latin: "Alhamdulillah",
      translation: "Segala puji bagi Allah",
      repeatCount: 33,
      fadhilah: "Memenuhi timbangan amal kebaikan.",
      riwayat: "HR. Muslim no. 597",
    ),
    ModelDzikir(
      id: "dsh5",
      title: "Takbir (33x)",
      arabic: "اللَّهُ أَكْبَرُ",
      latin: "Allahu Akbar",
      translation: "Allah Maha Besar",
      repeatCount: 33,
      fadhilah: "Mengagungkan kebesaran Allah SWT.",
      riwayat: "HR. Muslim no. 597",
    ),
    ModelDzikir(
      id: "dsh6",
      title: "Penyempurna Hitungan ke-100",
      arabic:
          "لَا إِلٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ",
      latin:
          "Laa ilaaha illallaahu wahdahu laa syariika lah, lahul mulku wa lahul hamdu wa Huwa 'alaa kulli syay-in qadiir.",
      translation:
          "Tiada Tuhan selain Allah Yang Maha Esa, tiada sekutu bagi-Nya. Milik-Nya kerajaan dan milik-Nya segala pujian, dan Dia Maha Kuasa atas segala sesuatu.",
      repeatCount: 1,
      fadhilah: "Siapa yang membacanya menggenapkan 100 tasbih, diampuni kesalahan-kesalahannya walau sebanyak buih di lautan.",
      riwayat: "HR. Muslim no. 597",
    ),
    ModelDzikir(
      id: "dsh7",
      title: "Membaca Ayat Kursi",
      arabic:
          "اللَّهُ لَا إِلٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ...",
      latin:
          "Allahu laa ilaaha illaa Huwal Hayyul Qayyum...",
      translation:
          "Allah, tidak ada Tuhan (yang berhak disembah) melainkan Dia Yang Hidup kekal lagi terus menerus mengurus (makhluk-Nya)...",
      repeatCount: 1,
      fadhilah: "Barangsiapa membaca Ayat Kursi setiap selesai shalat fardhu, tidak ada yang menghalanginya masuk surga selain kematian.",
      riwayat: "HR. An-Nasa'i dalam Al-Kubra no. 9928, Shahih Al-Jami' no. 6464",
    ),
  ];
}
