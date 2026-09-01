import 'package:my_quran/Model/model_quotes_islami.dart';

class QuotesIslamiData {
  static const List<Map<String, String>> categories = [
    {"id": "all", "name": "Semua", "icon": "auto_awesome"},
    {"id": "motivasi", "name": "Motivasi & Hijrah", "icon": "trending_up"},
    {"id": "sabar", "name": "Sabar & Ujian", "icon": "shield_outlined"},
    {"id": "syukur", "name": "Syukur & Rezeki", "icon": "favorite_border"},
    {"id": "doa", "name": "Doa & Taubat", "icon": "volunteer_activism"},
    {"id": "sahabat", "name": "Sahabat & Ulama", "icon": "menu_book"},
    {"id": "cinta", "name": "Cinta & Keluarga", "icon": "people_outline"},
  ];

  static ModelQuotesIslami getQuoteOfTheDay() {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    final index = dayOfYear % list.length;
    return list[index];
  }

  static const List<ModelQuotesIslami> list = [
    // MOTIVASI & HIJRAH
    ModelQuotesIslami(
      id: "mot-1",
      quote:
          "Jangan pernah menyerah ketika doamu belum terkabul. Jika kamu mampu bersabar, Allah mampu memberikan lebih dari apa yang kamu minta.",
      arabic: "إِنَّ مَعَ الْعُسْرِ يُسْرًا",
      source: "QS. Al-Insyirah: 6",
      category: "motivasi",
      categoryName: "Motivasi & Hijrah",
      gradientColors: [0xFF7B3FE4, 0xFF9543FF],
    ),
    ModelQuotesIslami(
      id: "mot-2",
      quote:
          "Dunia ini hanya tiga hari: Hari kemarin yang telah berlalu bersama apa yang ada padanya; Hari esok yang mungkin tak kan kau jumpai; Dan hari ini yang menjadi milikmu, maka beramallah di dalamnya.",
      source: "Hasan Al-Basri",
      category: "motivasi",
      categoryName: "Motivasi & Hijrah",
      gradientColors: [0xFF6A11CB, 0xFF2575FC],
    ),
    ModelQuotesIslami(
      id: "mot-3",
      quote:
          "Barangsiapa yang menempuh suatu jalan untuk mencari ilmu, maka Allah akan memudahkan baginya jalan menuju surga.",
      arabic: "مَنْ سَلَكَ طَرِيقًا يَلْتَمِسُ فِيهِ عِلْمًا سَهَّلَ اللَّهُ لَهُ بِهِ طَرِيقًا إِلَى الْجَنَّةِ",
      source: "HR. Muslim no. 2699",
      category: "motivasi",
      categoryName: "Motivasi & Hijrah",
      gradientColors: [0xFF4A00E0, 0xFF8E2DE2],
    ),
    ModelQuotesIslami(
      id: "mot-4",
      quote:
          "Hijrah bukan tentang menjadi lebih baik dari orang lain, melainkan tentang menjadi lebih baik dari dirimu yang kemarin di hadapan Allah.",
      source: "Kutipan Mutiara",
      category: "motivasi",
      categoryName: "Motivasi & Hijrah",
      gradientColors: [0xFF11998E, 0xFF38EF7D],
    ),
    ModelQuotesIslami(
      id: "mot-5",
      quote:
          "Amalan yang paling dicintai oleh Allah adalah amalan yang kontinu (berkelanjutan) meskipun sedikit.",
      arabic: "أَحَبُّ الأَعْمَالِ إِلَى اللَّهِ أَدْوَمُهَا وَإِنْ قَلَّ",
      source: "HR. Bukhari & Muslim",
      category: "motivasi",
      categoryName: "Motivasi & Hijrah",
      gradientColors: [0xFFF857A6, 0xFFFF5858],
    ),
    ModelQuotesIslami(
      id: "mot-6",
      quote:
          "Kebaikan yang engkau tanam hari ini, kelak akan menjadi peneduh di saat terik hari pembalasan.",
      source: "Ibnu Qayyim Al-Jauziyyah",
      category: "motivasi",
      categoryName: "Motivasi & Hijrah",
      gradientColors: [0xFF5B86E5, 0xFF36D1DC],
    ),

    // SABAR & UJIAN
    ModelQuotesIslami(
      id: "sab-1",
      quote:
          "Allah tidak membebani seseorang melainkan sesuai dengan kesanggupannya.",
      arabic: "لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا",
      source: "QS. Al-Baqarah: 286",
      category: "sabar",
      categoryName: "Sabar & Ujian",
      gradientColors: [0xFF0052D4, 0xFF4364F7],
    ),
    ModelQuotesIslami(
      id: "sab-2",
      quote:
          "Kesabaran itu ada dua macam: sabar atas sesuatu yang tidak kau sukai dan sabar menahan diri dari apa yang kau sukai tapi dilarang.",
      source: "Ali bin Abi Thalib",
      category: "sabar",
      categoryName: "Sabar & Ujian",
      gradientColors: [0xFF7F00FF, 0xFFE100FF],
    ),
    ModelQuotesIslami(
      id: "sab-3",
      quote:
          "Boleh jadi kamu membenci sesuatu, padahal ia amat baik bagimu, dan boleh jadi kamu menyukai sesuatu, padahal ia amat buruk bagimu. Allah mengetahui, sedang kamu tidak mengetahui.",
      arabic: "وَعَسَىٰ أَن تَكْرَهُوا شَيْئًا وَهُوَ خَيْرٌ لَّكُمْ",
      source: "QS. Al-Baqarah: 216",
      category: "sabar",
      categoryName: "Sabar & Ujian",
      gradientColors: [0xFF2C3E50, 0xFF3498DB],
    ),
    ModelQuotesIslami(
      id: "sab-4",
      quote:
          "Ketahuilah bahwa kemenangan bersama kesabaran, kelapangan bersama kesempitan, dan bersama kesulitan ada kemudahan.",
      arabic: "وَاعْلَمْ أَنَّ النَّصْرَ مَعَ الصَّبْرِ، وَأَنَّ الْفَرَجَ مَعَ الْكَرْبِ",
      source: "HR. Ahmad & Tirmidzi",
      category: "sabar",
      categoryName: "Sabar & Ujian",
      gradientColors: [0xFF134E5E, 0xFF71B280],
    ),
    ModelQuotesIslami(
      id: "sab-5",
      quote:
          "Jangan bersedih atas apa yang telah pergi darimu, karena jika Allah menakdirkannya untukmu, ia takkan pernah menjadi milik orang lain.",
      source: "Imam Syafi'i",
      category: "sabar",
      categoryName: "Sabar & Ujian",
      gradientColors: [0xFF654EA3, 0xFFEAAFC8],
    ),
    ModelQuotesIslami(
      id: "sab-6",
      quote:
          "Bila takdir tidak berjalan sesuai rencanamu, ingatlah bahwa takdir Allah selalu berjalan dengan hikmah terindah untukmu.",
      source: "Umar bin Khattab",
      category: "sabar",
      categoryName: "Sabar & Ujian",
      gradientColors: [0xFF4568DC, 0xFFB06AB3],
    ),

    // SYUKUR & REZEKI
    ModelQuotesIslami(
      id: "syu-1",
      quote:
          "Sesungguhnya jika kamu bersyukur, pasti Kami akan menambah (nikmat) kepadamu, dan jika kamu mengingkari (nikmat-Ku), maka sesungguhnya azab-Ku sangat pedih.",
      arabic: "لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ",
      source: "QS. Ibrahim: 7",
      category: "syukur",
      categoryName: "Syukur & Rezeki",
      gradientColors: [0xFF0BA360, 0xFF3CBA92],
    ),
    ModelQuotesIslami(
      id: "syu-2",
      quote:
          "Bukan harta melimpah yang membuat seseorang kaya, tetapi hati yang selalu merasa cukup (qana'ah) itulah kekayaan sejati.",
      arabic: "لَيْسَ الْغِنَى عَنْ كَثْرَةِ الْعَرَضِ، وَلَكِنَّ الْغِنَى غِنَى النَّفْسِ",
      source: "HR. Bukhari no. 6446",
      category: "syukur",
      categoryName: "Syukur & Rezeki",
      gradientColors: [0xFFF2994A, 0xFFF2C94C],
    ),
    ModelQuotesIslami(
      id: "syu-3",
      quote:
          "Barangsiapa bertakwa kepada Allah niscaya Dia akan membukakan jalan keluar baginya, dan memberinya rezeki dari arah yang tiada disangka-sangkanya.",
      arabic: "وَمَن يَتَّقِ اللَّهَ يَجْعَل لَّهُ مَخْرَجًا وَيَرْزُقْهُ مِنْ حَيْثُ لَا يَحْتَسِبُ",
      source: "QS. At-Talaq: 2-3",
      category: "syukur",
      categoryName: "Syukur & Rezeki",
      gradientColors: [0xFF3A7BD5, 0xFF3A6073],
    ),
    ModelQuotesIslami(
      id: "syu-4",
      quote:
          "Lihatlah kepada orang yang berada di bawahmu dalam urusan dunia, dan jangan melihat kepada orang yang berada di atasmu, agar engkau tidak meremehkan nikmat Allah kepadamu.",
      arabic: "انْظُرُوا إِلَى مَنْ أَسْفَلَ مِنْكُمْ وَلاَ تَنْظُرُوا إِلَى مَنْ هُوَ فَوْقَكُمْ",
      source: "HR. Muslim no. 2963",
      category: "syukur",
      categoryName: "Syukur & Rezeki",
      gradientColors: [0xFF1D976C, 0xFF93F9B9],
    ),
    ModelQuotesIslami(
      id: "syu-5",
      quote:
          "Rezeki yang telah ditetapkan untukmu tidak akan pernah tertukar atau diambil oleh orang lain. Tenangkan hatimu, berikhtiar dan bertawakallah.",
      source: "Hasan Al-Basri",
      category: "syukur",
      categoryName: "Syukur & Rezeki",
      gradientColors: [0xFF4E54C8, 0xFF8F94FB],
    ),

    // DOA & TAUBAT
    ModelQuotesIslami(
      id: "doa-1",
      quote:
          "Berdoalah kepada-Ku, niscaya akan Kuperkenankan bagimu.",
      arabic: "ادْعُونِي أَسْتَجِبْ لَكُمْ",
      source: "QS. Ghafir: 60",
      category: "doa",
      categoryName: "Doa & Taubat",
      gradientColors: [0xFF7F00FF, 0xFFE100FF],
    ),
    ModelQuotesIslami(
      id: "doa-2",
      quote:
          "Aku tidak pernah mengkhawatirkan apakah doaku akan dikabulkan atau tidak, karena yang aku khawatirkan adalah jika aku tidak diberi hidayah untuk berdoa.",
      source: "Umar bin Khattab",
      category: "doa",
      categoryName: "Doa & Taubat",
      gradientColors: [0xFF8A2387, 0xFFE94057],
    ),
    ModelQuotesIslami(
      id: "doa-3",
      quote:
          "Katakanlah: 'Hai hamba-hamba-Ku yang melampaui batas terhadap diri mereka sendiri, janganlah kamu berputus asa dari rahmat Allah. Sesungguhnya Allah mengampuni dosa-dosa semuanya.'",
      arabic: "قُلْ يَا عِبَادِيَ الَّذِينَ أَسْرَفُوا عَلَىٰ أَنفُسِهِمْ لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ",
      source: "QS. Az-Zumar: 53",
      category: "doa",
      categoryName: "Doa & Taubat",
      gradientColors: [0xFF2B5876, 0xFF4E4376],
    ),
    ModelQuotesIslami(
      id: "doa-4",
      quote:
          "Doa adalah senjata orang mukmin, tiang agama, dan cahaya langit serta bumi.",
      arabic: "الدُّعَاءُ سِلاَحُ الْمُؤْمِنِ وَعِمَادُ الدِّينِ وَنُورُ السَّمَاوَاتِ وَالأَرْضِ",
      source: "HR. Al-Hakim",
      category: "doa",
      categoryName: "Doa & Taubat",
      gradientColors: [0xFF3E5151, 0xFFDECBA4],
    ),
    ModelQuotesIslami(
      id: "doa-5",
      quote:
          "Air mata penyesalan orang yang bertaubat lebih dicintai Allah daripada tasbih orang yang sombong dengan amalnya.",
      source: "Ibnu Qayyim Al-Jauziyyah",
      category: "doa",
      categoryName: "Doa & Taubat",
      gradientColors: [0xFF1A2980, 0xFF26D0CE],
    ),

    // MUTIARA SAHABAT & ULAMA
    ModelQuotesIslami(
      id: "sah-1",
      quote:
          "Orang yang paling berakal adalah orang yang paling banyak mengingat kematian dan paling siap menghadapinya.",
      source: "Ali bin Abi Thalib",
      category: "sahabat",
      categoryName: "Sahabat & Ulama",
      gradientColors: [0xFF654EA3, 0xFFEAAFC8],
    ),
    ModelQuotesIslami(
      id: "sah-2",
      quote:
          "Kejujuran adalah amanah terbesar, dan kedustaan adalah pengkhianatan terbesar.",
      source: "Abu Bakar Ash-Shiddiq",
      category: "sahabat",
      categoryName: "Sahabat & Ulama",
      gradientColors: [0xFF085078, 0xFF85D8CE],
    ),
    ModelQuotesIslami(
      id: "sah-3",
      quote:
          "Bila lisanmu terjaga dari membicarakan aib orang lain, Allah akan menjaga aibmu di hadapan seluruh makhluk di hari kiamat.",
      source: "Utsman bin Affan",
      category: "sahabat",
      categoryName: "Sahabat & Ulama",
      gradientColors: [0xFF200122, 0xFF6F0000],
    ),
    ModelQuotesIslami(
      id: "sah-4",
      quote:
          "Bila kau tidak tahan dengan lelahnya belajar, maka kau harus siap menanggung perihnya kebodohan.",
      source: "Imam Syafi'i",
      category: "sahabat",
      categoryName: "Sahabat & Ulama",
      gradientColors: [0xFF5C258D, 0xFF4389A2],
    ),
    ModelQuotesIslami(
      id: "sah-5",
      quote:
          "Hati yang bersih ibarat cermin yang jernih, mampu memantulkan cahaya kebenaran ilahi tanpa terdistorsi.",
      source: "Imam Al-Ghazali",
      category: "sahabat",
      categoryName: "Sahabat & Ulama",
      gradientColors: [0xFF0F2027, 0xFF203A43],
    ),
    ModelQuotesIslami(
      id: "sah-6",
      quote:
          "Hisablah dirimu sendiri sebelum kalian dihisab, dan timbanglah amal perbuatanmu sebelum kelak ditimbang.",
      source: "Umar bin Khattab",
      category: "sahabat",
      categoryName: "Sahabat & Ulama",
      gradientColors: [0xFF3A1C71, 0xFFD76D77],
    ),
    ModelQuotesIslami(
      id: "sah-7",
      quote:
          "Jangan menjelaskan tentang dirimu kepada siapa pun, karena yang menyukaimu tidak butuh itu, dan yang membencimu tidak percaya itu.",
      source: "Ali bin Abi Thalib",
      category: "sahabat",
      categoryName: "Sahabat & Ulama",
      gradientColors: [0xFF7B3FE4, 0xFF9543FF],
    ),

    // CINTA & KELUARGA
    ModelQuotesIslami(
      id: "cin-1",
      quote:
          "Ridha Allah terletak pada ridha kedua orang tua, dan murka Allah terletak pada kemurkaan kedua orang tua.",
      arabic: "رِضَى الرَّبِّ فِي رِضَى الْوَالِدَيْنِ، وَسَخَطُ الرَّبِّ فِي سَخَطِ الْوَالِدَيْنِ",
      source: "HR. Tirmidzi no. 1899",
      category: "cinta",
      categoryName: "Cinta & Keluarga",
      gradientColors: [0xFFD31027, 0xFFEA384D],
    ),
    ModelQuotesIslami(
      id: "cin-2",
      quote:
          "Sebaik-baik kalian adalah orang yang paling baik terhadap keluarganya, dan aku adalah orang yang paling baik terhadap keluargaku.",
      arabic: "خَيْرُكُمْ خَيْرُكُمْ لأَهْلِهِ وَأَنَا خَيْرُكُمْ لأَهْلِي",
      source: "HR. Tirmidzi no. 3895",
      category: "cinta",
      categoryName: "Cinta & Keluarga",
      gradientColors: [0xFFCC95C0, 0xFF7AA1D2],
    ),
    ModelQuotesIslami(
      id: "cin-3",
      quote:
          "Cinta yang paling sejati adalah cinta yang membawa kita semakin dekat kepada Allah dan mempertemukan kembali di surga-Nya.",
      source: "Kutipan Mutiara",
      category: "cinta",
      categoryName: "Cinta & Keluarga",
      gradientColors: [0xFFEE9CA7, 0xFFFFDDE1],
    ),
    ModelQuotesIslami(
      id: "cin-4",
      quote:
          "Dan di antara tanda-tanda kekuasaan-Nya ialah Dia menciptakan untukmu pasangan-pasangan dari jenismu sendiri, supaya kamu cenderung dan merasa tenteram kepadanya, dan dijadikan-Nya di antaramu rasa kasih dan sayang.",
      arabic: "وَمِنْ آيَاتِهِ أَنْ خَلَقَ لَكُم مِّنْ أَنفُسِكُمْ أَزْوَاجًا لِّتَسْكُنُوا إِلَيْهَا وَجَعَلَ بَيْنَكُم مَّوَدَّةً وَرَحْمَةً",
      source: "QS. Ar-Rum: 21",
      category: "cinta",
      categoryName: "Cinta & Keluarga",
      gradientColors: [0xFFDA22FF, 0xFF9733EE],
    ),
    ModelQuotesIslami(
      id: "cin-5",
      quote:
          "Hormatilah ibumu, lalu ibumu, lalu ibumu, kemudian ayahmu. Surga berada di bawah telapak kaki ibu.",
      source: "Mutiara Hadits",
      category: "cinta",
      categoryName: "Cinta & Keluarga",
      gradientColors: [0xFFFF5E3A, 0xFFFF2A68],
    ),
  ];
}
