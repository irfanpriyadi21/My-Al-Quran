class ModelAyatYasin {
  final int number;
  final String arabic;
  final String latin;
  final String translation;

  const ModelAyatYasin({
    required this.number,
    required this.arabic,
    required this.latin,
    required this.translation,
  });
}

class ModelBacaanTahlil {
  final int number;
  final String title;
  final String? pengulangan; // misal: "Dibaca 3x", "Dibaca 33x"
  final String arabic;
  final String latin;
  final String translation;
  final String? keterangan;

  const ModelBacaanTahlil({
    required this.number,
    required this.title,
    this.pengulangan,
    required this.arabic,
    required this.latin,
    required this.translation,
    this.keterangan,
  });
}

class ModelDoaTahlil {
  final String title;
  final String arabic;
  final String latin;
  final String translation;
  final String? keterangan;

  const ModelDoaTahlil({
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
    this.keterangan,
  });
}

class YasinTahlilData {
  // ========================================================
  // 1. SURAT YASIN (83 AYAT LENGKAP)
  // ========================================================
  static const List<ModelAyatYasin> ayatYasin = [
    ModelAyatYasin(
      number: 1,
      arabic: 'يسٓ',
      latin: 'Yaa Siiin.',
      translation: 'Yaa Siiin.',
    ),
    ModelAyatYasin(
      number: 2,
      arabic: 'وَٱلْقُرْءَانِ ٱلْحَكِيمِ',
      latin: 'Wal-qur-aanil-hakiim.',
      translation: 'Demi Al-Qur\'an yang penuh hikmah,',
    ),
    ModelAyatYasin(
      number: 3,
      arabic: 'إِنَّكَ لَمِنَ ٱلْمُرْسَلِينَ',
      latin: 'Innaka laminal-mursaliin.',
      translation: 'Sungguh, engkau (Muhammad) benar-benar salah seorang dari rasul-rasul,',
    ),
    ModelAyatYasin(
      number: 4,
      arabic: 'عَلَىٰ صِرَٰطٍ مُّسْتَقِيمٍ',
      latin: "'Alaa shiraathim mustaqiim.",
      translation: '(yang berada) di atas jalan yang lurus,',
    ),
    ModelAyatYasin(
      number: 5,
      arabic: 'تَنزِيلَ ٱلْعَزِيزِ ٱلرَّحِيمِ',
      latin: 'Tanziilal-\'aziizir-rahiim.',
      translation: '(sebagai wahyu) yang diturunkan oleh (Allah) Yang Mahaperkasa, Maha Penyayang,',
    ),
    ModelAyatYasin(
      number: 6,
      arabic: 'لِتُنذِرَ قَوْمًا مَّآ أُنذِرَ ءَابَآؤُهُمْ فَهُمْ غَٰفِلُونَ',
      latin: 'Litundzira qaumam maa undzira aabaaa-uhum fahum ghaafiluun.',
      translation: 'agar engkau memberi peringatan kepada suatu kaum yang nenek moyangnya belum pernah diberi peringatan, karena itu mereka lalai.',
    ),
    ModelAyatYasin(
      number: 7,
      arabic: 'لَقَدْ حَقَّ ٱلْقَوْلُ عَلَىٰٓ أَكْثَرِهِمْ فَهُمْ لَا يُؤْمِنُونَ',
      latin: "Laqad haqqal-qaulu 'alaaa aktsarihim fahum laa yu'minuun.",
      translation: 'Sungguh, pasti berlaku perkataan (hukuman) terhadap kebanyakan mereka, karena mereka tidak beriman.',
    ),
    ModelAyatYasin(
      number: 8,
      arabic: 'إِنَّا جَعَلْنَا فِىٓ أَعْنَٰقِهِمْ أَغْلَٰلًا فَهِىَ إِلَى ٱلْأَذْقَانِ فَهُم مُّقْمَحُونَ',
      latin: "Innaa ja'alnaa fiii a'naaqihim aghlaalan fahiya ilal-adzqaani fahum muqmahuun.",
      translation: 'Sungguh, Kami telah memasang belenggu di leher mereka, lalu tangan mereka (diangkat) ke dagu, karena itu mereka tertengadah.',
    ),
    ModelAyatYasin(
      number: 9,
      arabic: 'وَجَعَلْنَا مِنۢ بَيْنِ أَيْدِيهِمْ سَدًّا وَمِنْ خَلْفِهِمْ سَدًّا فَأَغْشَيْنَٰهُمْ فَهُمْ لَا يُبْصِرُونَ',
      latin: "Wa ja'alnaa mim baini aidiihim saddaw wa min khalfihim saddan fa-aghsyainaahum fahum laa yubshiruun.",
      translation: 'Dan Kami jadikan di hadapan mereka sekat (dinding) dan di belakang mereka sekat, dan Kami tutup (mata) mereka sehingga mereka tidak dapat melihat.',
    ),
    ModelAyatYasin(
      number: 10,
      arabic: 'وَسَوَآءٌ عَلَيْهِمْ ءَأَنذَرْتَهُمْ أَمْ لَمْ تُنذِرْهُمْ لَا يُؤْمِنُونَ',
      latin: "Wa sawaaa-un 'alaihim a-andzartahum am lam tundzirhum laa yu'minuun.",
      translation: 'Dan sama saja bagi mereka, apakah engkau memberi peringatan kepada mereka atau engkau tidak memberi peringatan kepada mereka, mereka tidak akan beriman juga.',
    ),
    ModelAyatYasin(
      number: 11,
      arabic: 'إِنَّمَا تُنذِرُ مَنِ ٱتَّبَعَ ٱلذِّكْرَ وَخَشِىَ ٱلرَّحْمَٰنَ بِٱلْغَيْبِ ۖ فَبَشِّرْهُ بِمَغْفِرَةٍ وَأَجْرٍ كَرِيمٍ',
      latin: 'Innamaa tundziru manittaba\'adz-dzikra wa khasyiyar-rahmaana bil-ghaib, fabasysyirhu bimaghfiratiw wa ajrin kariim.',
      translation: 'Sesungguhnya engkau hanya memberi peringatan kepada orang-orang yang mau mengikuti peringatan dan yang takut kepada Tuhan Yang Maha Pengasih walaupun mereka tidak melihat-Nya. Maka berilah mereka kabar gembira dengan ampunan dan pahala yang mulia.',
    ),
    ModelAyatYasin(
      number: 12,
      arabic: 'إِنَّا نَحْنُ نُحْىِ ٱلْمَوْتَىٰ وَنَكْتُبُ مَا قَدَّمُوا۟ وَءَاثَٰرَهُمْ ۚ وَكُلَّ شَىْءٍ أَحْصَيْنَٰهُ فِىٓ إِمَامٍ مُّبِينٍ',
      latin: "Innaa nahnu nuhyil-mautaa wa naktubu maa qaddamuu wa aatsaarahum, wa kulla syai-in ahshainaahu fiii imaamim mubiin.",
      translation: 'Sungguh, Kamilah yang menghidupkan orang-orang yang mati, dan Kamilah yang mencatat apa yang telah mereka kerjakan dan bekas-bekas yang mereka tinggalkan. Dan segala sesuatu Kami kumpulkan dalam Kitab yang jelas (Lauh Mahfuzh).',
    ),
    ModelAyatYasin(
      number: 13,
      arabic: 'وَٱضْرِبْ لَهُم مَّثَلًا أَصْحَٰبَ ٱلْقَرْيَةِ إِذْ جَآءَهَا ٱلْمُرْسَلُونَ',
      latin: "Wadhrib lahum matsalan ash-haabal-qaryati idz jaaa-ahal-mursaluun.",
      translation: 'Dan buatlah suatu perumpamaan bagi mereka, yaitu penduduk suatu negeri, ketika utusan-utusan datang kepada mereka;',
    ),
    ModelAyatYasin(
      number: 14,
      arabic: 'إِذْ أَرْسَلْنَآ إِلَيْهِمُ ٱثْنَيْنِ فَكَذَّبُوهُمَا فَعَزَّزْنَا بِثَالِثٍ فَقَالُوٓا۟ إِنَّآ إِلَيْكُم مُّرْسَلُونَ',
      latin: 'Idz arsalnaaa ilaihimutsnaini fakadz-dzabuuhumaa fa\'azzaznaa bitaalitsin faqaaluuu innaaa ilaikum mursaluun.',
      translation: '(yaitu) ketika Kami mengutus kepada mereka dua orang utusan, lalu mereka mendustakan keduanya; kemudian Kami kuatkan dengan (utusan) yang ketiga, maka ketiga (utusan itu) berkata, "Sungguh, kami adalah orang-orang yang diutus kepadamu."',
    ),
    ModelAyatYasin(
      number: 15,
      arabic: 'قَالُوا۟ مَآ أَنتُمْ إِلَّا بَشَرٌ مِّثْلُنَا وَمَآ أَنزَلَ ٱلرَّحْمَٰنُ مِن شَىْءٍ إِنْ أَنتُمْ إِلَّا تَكْذِبُونَ',
      latin: "Qaaluu maaa antum illaa basyarum mitslunaa wa maaa anzalar-rahmaanu min syai-in in antum illaa takdzibuun.",
      translation: 'Mereka (penduduk negeri) menjawab, "Kamu ini hanyalah manusia seperti kami, dan (Allah) Yang Maha Pengasih tidak menurunkan sesuatu apa pun; kamu hanyalah berdusta belaka."',
    ),
    ModelAyatYasin(
      number: 16,
      arabic: 'قَالُوا۟ رَبُّنَا يَعْلَمُ إِنَّآ إِلَيْكُمْ لَمُرْسَلُونَ',
      latin: 'Qaaluu rabbunaa ya\'lamu innaaa ilaikum lamursaluun.',
      translation: 'Mereka berkata, "Tuhan kami mengetahui sesungguhnya kami benar-benar diutus kepadamu."',
    ),
    ModelAyatYasin(
      number: 17,
      arabic: 'وَمَا عَلَيْنَآ إِلَّا ٱلْبَلَٰغُ ٱلْمُبِينُ',
      latin: "Wa maa 'alainaaa illal-balaaghul-mubiin.",
      translation: 'Dan kewajiban kami tidak lain hanyalah menyampaikan (perintah Allah) dengan jelas.',
    ),
    ModelAyatYasin(
      number: 18,
      arabic: 'قَالُوٓا۟ إِنَّا تَطَيَّرْنَا بِكُمْ ۖ لَئِن لَّمْ تَنتَهُوا۟ لَنَرْجُمَنَّكُمْ وَلَيَمَسَّنَّكُم مِّنَّا عَذَابٌ أَلِيمٌ',
      latin: 'Qaaluuu innaa tathayyarnaa bikum, la-il lam tantahuu lanarjumannakum wa layamassannakum minnaa \'adzaabun aliim.',
      translation: 'Mereka menjawab, "Sesungguhnya kami bernasib malang karena kamu. Jika kamu tidak berhenti (menyeru kami), niscaya kami rajam kamu dan kamu pasti akan merasakan siksaan yang pedih dari kami."',
    ),
    ModelAyatYasin(
      number: 19,
      arabic: 'قَالُوا۟ طَٰٓئِرُكُم مَّعَكُمْ ۚ أَئِن ذُكِّرْتُم ۚ بَلْ أَنتُمْ قَوْمٌ مُّسْرِفُونَ',
      latin: "Qaaluu thaaa-irukum ma'akum, a-in dzukkirtum, bal antum qaumum musrifuun.",
      translation: 'Mereka (utusan-utusan) berkata, "Kemalanganmu itu adalah karena dirimu sendiri. Apakah karena kamu diberi peringatan (kamu bernasib malang)? Sebenarnya kamu adalah kaum yang melampaui batas."',
    ),
    ModelAyatYasin(
      number: 20,
      arabic: 'وَجَآءَ مِنْ أَقْصَا ٱلْمَدِينَةِ رَجُلٌ يَسْعَىٰ قَالَ يَٰقَوْمِ ٱتَّبِعُوا۟ ٱلْمُرْسَلِينَ',
      latin: "Wa jaaa-a min aqshal-madiinati rajuluy yas'aa qaala yaa qaumittabi'ul-mursaliin.",
      translation: 'Dan datanglah dari ujung kota, seorang laki-laki (Habib An-Najjar) dengan bergegas dia berkata, "Wahai kaumku! Ikutilah utusan-utusan itu."',
    ),
    ModelAyatYasin(
      number: 21,
      arabic: 'ٱتَّبِعُوا۟ مَن لَّا يَسْـَٔلُكُمْ أَجْرًا وَهُم مُّهْتَدُونَ',
      latin: "Ittabi'uu mal laa yas-alukum ajraw wahum muhtaduun.",
      translation: 'Ikutilah orang yang tidak meminta imbalan kepadamu; dan mereka adalah orang-orang yang mendapat petunjuk.',
    ),
    ModelAyatYasin(
      number: 22,
      arabic: 'وَمَا لِىَ لَآ أَعْبُدُ ٱلَّذِى فَطَرَنِى وَإِلَيْهِ تُرْجَعُونَ',
      latin: "Wa maa liya laaa a'budul-ladzii fatharanii wa ilaihi turja'uun.",
      translation: 'Dan tidak ada alasan bagiku untuk tidak menyembah (Allah) yang telah menciptakanku dan hanya kepada-Nyalah kamu akan dikembalikan.',
    ),
    ModelAyatYasin(
      number: 23,
      arabic: 'ءَأَتَّخِذُ مِن دُونِهِۦٓ ءَالِهَةً إِن يُرِدْنِ ٱلرَّحْمَٰنُ بِضُرٍّ لَّا تُغْنِ عَنِّى شَفَٰعَتُهُمْ شَيْـًٔا وَلَا يُنقِذُونِ',
      latin: "A-attakhidzu min duunihiii aalihatan iy yuridnir-rahmaanu bidhurril laa tughni 'annii syafaa'atuhum syai-aw wa laa yunqidzuun.",
      translation: 'Mengapa aku akan menyembah tuhan-tuhan selain-Nya? Jika (Allah) Yang Maha Pengasih menghendaki bencana terhadapku, niscaya pertolongan mereka tidak berguna sedikit pun bagiku dan mereka tidak dapat menyelamatkanku.',
    ),
    ModelAyatYasin(
      number: 24,
      arabic: 'إِنِّىٓ إِذًا لَّفِى ضَلَٰلٍ مُّبِينٍ',
      latin: 'Inniii idzal lafii dhalaalim mubiin.',
      translation: 'Sesungguhnya jika aku (berbuat demikian), pasti aku berada dalam kesesatan yang nyata.',
    ),
    ModelAyatYasin(
      number: 25,
      arabic: 'إِنِّىٓ ءَامَنتُ بِرَبِّكُمْ فَٱسْمَعُونِ',
      latin: "Inniii aamantu birabbikum fasma'uun.",
      translation: 'Sesungguhnya aku telah beriman kepada Tuhanmu; maka dengarkanlah (pengakuan keimanan)-ku.',
    ),
    ModelAyatYasin(
      number: 26,
      arabic: 'قِيلَ ٱدْخُلِ ٱلْجَنَّةَ ۖ قَالَ يَٰلَيْتَ قَوْمِى يَعْلَمُونَ',
      latin: "Qiiladkhulil-jannah, qaala yaa laita qaumii ya'lamuun.",
      translation: 'Dikatakan (kepadanya), "Masuklah ke surga." Dia berkata, "Alangkah baiknya sekiranya kaumku mengetahui,',
    ),
    ModelAyatYasin(
      number: 27,
      arabic: 'بِمَا غَفَرَ لِى رَبِّى وَجَعَلَنِى مِنَ ٱلْمُكْرَمِينَ',
      latin: "Bimaa ghafara lii rabbii wa ja'alanii minal-mukramiin.",
      translation: 'apa yang menyebabkan Tuhanku memberi ampunan kepadaku dan menjadikan aku termasuk orang-orang yang dimuliakan."',
    ),
    ModelAyatYasin(
      number: 28,
      arabic: 'وَمَآ أَنزَلْنَا عَلَىٰ قَوْمِهِۦ مِنۢ بَعْدِهِۦ مِن جُندٍ مِّنَ ٱلسَّمَآءِ وَمَا كُنَّا مُنزِلِينَ',
      latin: "Wa maaa anzalnaa 'alaa qaumihii mim ba'dihii min jundim minas-samaaa-i wa maa kunnaa munziliin.",
      translation: 'Dan setelah dia (meninggal), Kami tidak menurunkan suatu pasukan pun dari langit kepada kaumnya, dan Kami tidak perlu menurunkannya.',
    ),
    ModelAyatYasin(
      number: 29,
      arabic: 'إِن كَانَتْ إِلَّا صَيْحَةً وَٰحِدَةً فَإِذَا هُمْ خَٰمِدُونَ',
      latin: 'In kaanat illaa shaihataw waahidatan fa-idzaa hum khaamiduun.',
      translation: 'Tidak ada siksaan bagi mereka melainkan hanya satu teriakan (yang dahsyat); maka seketika itu mereka mati (padam bagaikan api).',
    ),
    ModelAyatYasin(
      number: 30,
      arabic: 'يَٰحَسْرَةً عَلَى ٱلْعِبَادِ ۚ مَا يَأْتِيهِم مِّن رَّسُولٍ إِلَّا كَانُوا۟ بِهِۦ يَسْتَهْزِءُونَ',
      latin: "Yaa hasratan 'alal-'ibaad, maa ya'tiihim mir rasuulin illaa kaanuu bihii yastahzi-uun.",
      translation: 'Alangkah besarnya penyesalan bagi hamba-hamba itu! Setiap datang seorang rasul kepada mereka, mereka selalu memperolok-olokkannya.',
    ),
    ModelAyatYasin(
      number: 31,
      arabic: 'أَلَمْ يَرَوْا۟ كَمْ أَهْلَكْنَا قَبْلَهُم مِّنَ ٱلْقُرُونِ أَنَّهُمْ إِلَيْهِمْ لَا يَرْجِعُونَ',
      latin: 'Alam yarau kam ahlaknaa qablahum minal-quruuni annahum ilaihim laa yarji\'uun.',
      translation: 'Tidakkah mereka mengetahui berapa banyak umat-umat sebelum mereka yang telah Kami binasakan, bahwa mereka (yang telah binasa itu) tidak akan kembali kepada mereka?',
    ),
    ModelAyatYasin(
      number: 32,
      arabic: 'وَإِن كُلٌّ لَّمَّا جَمِيعٌ لَّدَيْنَا مُحْضَرُونَ',
      latin: 'Wa in kullul lammaa jamii\'ul ladainaa muhdharuun.',
      translation: 'Dan setiap (umat), semuanya akan dihadapkan bersama-sama kepada Kami.',
    ),
    ModelAyatYasin(
      number: 33,
      arabic: 'وَءَايَةٌ لَّهُمُ ٱلْأَرْضُ ٱلْمَيْتَةُ أَحْيَيْنَٰهَا وَأَخْرَجْنَا مِنْهَا حَبًّا فَمِنْهُ يَأْكُلُونَ',
      latin: "Wa aayatul lahumul-ardhul-maitatu ahyainaahaa wa akhrajnaa minhaa habban faminhu ya'kuluun.",
      translation: 'Dan suatu tanda (kekuasaan Allah) bagi mereka adalah bumi yang mati (tandus). Kami hidupkan bumi itu dan Kami keluarkan darinya biji-bijian, maka dari biji-bijian itu mereka makan.',
    ),
    ModelAyatYasin(
      number: 34,
      arabic: 'وَجَعَلْنَا فِيهَا جَنَّٰتٍ مِّن نَّخِيلٍ وَأَعْنَٰبٍ وَفَجَّرْنَا فِيهَا مِنَ ٱلْعُيُونِ',
      latin: "Wa ja'alnaa fiihaa jannaatim min nakhiiliw wa a'naabiw wa fajjarnaa fiihaa minal-'uyuun.",
      translation: 'Dan Kami jadikan padanya kebun-kebun kurma dan anggur dan Kami pancarkan padanya beberapa mata air,',
    ),
    ModelAyatYasin(
      number: 35,
      arabic: 'لِيَأْكُلُوا۟ مِن ثَمَرِهِۦ وَمَا عَمِلَتْهُ أَيْدِيهِمْ ۖ أَفَلَا يَشْكُرُونَ',
      latin: "Liya'kuluu min tsamarihii wa maa 'amilat-hu aidiihim, afalaa yasykuruun.",
      translation: 'agar mereka dapat makan dari buahnya, dan dari apa yang diusahakan oleh tangan mereka. Maka mengapakah mereka tidak bersyukur?',
    ),
    ModelAyatYasin(
      number: 36,
      arabic: 'سُبْحَٰنَ ٱلَّذِى خَلَقَ ٱلْأَزْوَٰجَ كُلَّهَا مِمَّا تُنۢبِتُ ٱلْأَرْضُ وَمِنْ أَنفُسِهِمْ وَمِمَّا لَا يَعْلَمُونَ',
      latin: "Subhaanal-ladzii khalaqal-azwaaja kullahaa mimmaa tumbitul-ardhu wa min anfusihim wa mimmaa laa ya'lamuun.",
      translation: 'Mahasuci (Allah) yang telah menciptakan semuanya berpasang-pasangan, baik dari apa yang ditumbuhkan oleh bumi dan dari diri mereka sendiri, maupun dari apa yang tidak mereka ketahui.',
    ),
    ModelAyatYasin(
      number: 37,
      arabic: 'وَءَايَةٌ لَّهُمُ ٱلَّيْلُ نَسْلَخُ مِنْهُ ٱلنَّهَارَ فَإِذَا هُم مُّظْلِمُونَ',
      latin: 'Wa aayatul lahumul-lailu naslakhu minhun-nahaara fa-idzaa hum muzhlimuun.',
      translation: 'Dan suatu tanda (kebesaran Allah) bagi mereka adalah malam; Kami tanggalkan siang dari (malam) itu, maka seketika itu mereka (berada dalam) kegelapan,',
    ),
    ModelAyatYasin(
      number: 38,
      arabic: 'وَٱلشَّمْسُ تَجْرِى لِمُسْتَقَرٍّ لَّهَا ۚ ذَٰلِكَ تَقْدِيرُ ٱلْعَزِيزِ ٱلْعَلِيمِ',
      latin: 'Wasy-syamsu tajrii limustaqarril lahaa, dzaalika taqdiirul-\'aziizil-\'aliim.',
      translation: 'dan matahari berjalan di tempat peredarannya. Demikianlah ketetapan (Allah) Yang Mahaperkasa, Maha Mengetahui.',
    ),
    ModelAyatYasin(
      number: 39,
      arabic: 'وَٱلْقَمَرَ قَدَّرْنَٰهُ مَنَازِلَ حَتَّىٰ عَادَ كَٱلْعُرْجُونِ ٱلْقَدِيمِ',
      latin: "Wal-qamara qaddarnaahu manaazila hattaa 'aada kal-'urjuunil-qadiim.",
      translation: 'Dan telah Kami tetapkan tempat peredaran bagi bulan, sehingga (setelah dia sampai ke tempat peredaran yang terakhir) kembalilah dia seperti bentuk tandan yang tua.',
    ),
    ModelAyatYasin(
      number: 40,
      arabic: 'لَا ٱلشَّمْسُ يَنۢبَغِى لَهَآ أَن تُدْرِكَ ٱلْقَمَرَ وَلَا ٱلَّيْلُ سَابِقُ ٱلنَّهَارِ ۚ وَكُلٌّ فِى فَلَكٍ يَسْبَحُونَ',
      latin: 'Lasy-syamsu yambaghii lahaaa an tudrikal-qamara wa lal-lailu saabiqun-nahaar, wa kullun fii falakiy yasbahuun.',
      translation: 'Tidaklah mungkin bagi matahari mengejar bulan dan malam pun tidak dapat mendahului siang. Masing-masing beredar pada garis edarnya.',
    ),
    ModelAyatYasin(
      number: 41,
      arabic: 'وَءَايَةٌ لَّهُمْ أَنَّا حَمَلْنَا ذُرِّيَّتَهُمْ فِى ٱلْفُلْكِ ٱلْمَشْحُونِ',
      latin: 'Wa aayatul lahum annaa hamalnaa dzurriyyatahum fil-fulkil-masyhuun.',
      translation: 'Dan suatu tanda (kebesaran Allah) bagi mereka adalah bahwa Kami mengangkut keturunan mereka dalam kapal yang penuh muatan,',
    ),
    ModelAyatYasin(
      number: 42,
      arabic: 'وَخَلَقْنَا لَهُم مِّن مِّثْلِهِۦ مَا يَرْكَبُونَ',
      latin: 'Wa khalaqnaa lahum mim mitslihii maa yarkabuun.',
      translation: 'dan Kami ciptakan (juga) untuk mereka (angkutan lain) seperti kapal itu apa yang mereka kendarai.',
    ),
    ModelAyatYasin(
      number: 43,
      arabic: 'وَإِن نَّشَأْ نُغْرِقْهُمْ فَلَا صَرِيخَ لَهُمْ وَلَا هُمْ يُنقَذُونَ',
      latin: 'Wa in nasya\' nughriqhum falaa shariikha lahum wa laa hum yunqadzuun.',
      translation: 'Dan jika Kami menghendaki, Kami tenggelamkan mereka, maka tidak ada penolong bagi mereka dan tidak (pula) mereka diselamatkan,',
    ),
    ModelAyatYasin(
      number: 44,
      arabic: 'إِلَّا رَحْمَةً مِّنَّا وَمَتَٰعًا إِلَىٰ حِينٍ',
      latin: "Illaa rahmatam minnaa wa mataa'an ilaa hiin.",
      translation: 'melainkan (Kami selamatkan mereka) karena rahmat yang besar dari Kami dan untuk memberi kesenangan hidup sampai suatu saat.',
    ),
    ModelAyatYasin(
      number: 45,
      arabic: 'وَإِذَا قِيلَ لَهُمُ ٱتَّقُوا۟ مَا بَيْنَ أَيْدِيكُمْ وَمَا خَلْفَكُمْ لَعَلَّكُمْ تُرْحَمُونَ',
      latin: "Wa idzaa qiila lahumuttaquu maa baina aidiikum wa maa khalfakum la'allakum turhamuun.",
      translation: 'Dan apabila dikatakan kepada mereka, "Takutlah kamu akan siksa yang ada di hadapanmu dan siksa yang ada di belakangmu, agar kamu mendapat rahmat."',
    ),
    ModelAyatYasin(
      number: 46,
      arabic: 'وَمَا تَأْتِيهِم مِّنْ ءَايَةٍ مِّنْ ءَايَٰتِ رَبِّهِمْ إِلَّا كَانُوا۟ عَنْهَا مُعْرِضِينَ',
      latin: "Wa maa ta'tiihim min aayatim min aayaati rabbihim illaa kaanuu 'anhaa mu'ridhiin.",
      translation: 'Dan setiap kali suatu tanda dari tanda-tanda (kebesaran) Tuhan datang kepada mereka, mereka selalu berpaling darinya.',
    ),
    ModelAyatYasin(
      number: 47,
      arabic: 'وَإِذَا قِيلَ لَهُمْ أَنفِقُوا۟ مِمَّا رَزَقَكُمُ ٱللَّهُ قَالَ ٱلَّذِينَ كَفَرُوا۟ لِلَّذِينَ ءَامَنُوٓا۟ أَنُطْعِمُ مَن لَّوْ يَشَآءُ ٱللَّهُ أَطْعَمَهُۥٓ إِنْ أَنتُمْ إِلَّا فِى ضَلَٰلٍ مُّبِينٍ',
      latin: 'Wa idzaa qiila lahum anfiquu mimmaa razaqakumullaahu qaalal-ladziina kafaruu lil-ladziina aamanuu anuth\'imu mal lau yasyaaa-ullaahu ath\'amahuuu in antum illaa fii dhalaalim mubiin.',
      translation: 'Dan apabila dikatakan kepada mereka, "Infakkanlah sebagian rezeki yang diberikan Allah kepadamu," orang-orang yang kafir itu berkata kepada orang-orang yang beriman, "Apakah pantas kami memberi makan kepada orang-orang yang jika Allah menghendaki Dia akan memberinya makan? Kamu benar-benar dalam kesesatan yang nyata."',
    ),
    ModelAyatYasin(
      number: 48,
      arabic: 'وَيَقُولُونَ مَتَىٰ هَٰذَا ٱلْوَعْدُ إِن كُنتُمْ صَٰدِقِينَ',
      latin: 'Wa yaquuluuna mataa haadzal-wa\'du in kuntum shaadiqiin.',
      translation: 'Dan mereka berkata, "Kapankah (terjadinya) janji (hari berbangkit) ini, jika kamu orang-orang yang benar?"',
    ),
    ModelAyatYasin(
      number: 49,
      arabic: 'مَا يَنظُرُونَ إِلَّا صَيْحَةً وَٰحِدَةً تَأْخُذُهُمْ وَهُمْ يَخِصِّمُونَ',
      latin: "Maa yanzhuruuna illaa shaihataw waahidatan ta'khudzuhum wa hum yakhish-shimuun.",
      translation: 'Mereka tidak menunggu melainkan satu teriakan saja yang akan membinasakan mereka ketika mereka sedang bertengkar.',
    ),
    ModelAyatYasin(
      number: 50,
      arabic: 'فَلَا يَسْتَطِيعُونَ تَوْصِيَةً وَلَآ إِلَىٰٓ أَهْلِهِمْ يَرْجِعُونَ',
      latin: "Falaa yastathii'uuna taushiyataw wa laaa ilaaa ahlihim yarji'uun.",
      translation: 'Maka mereka tidak mampu membuat suatu wasiat pun dan tidak (pula) dapat kembali kepada keluarganya.',
    ),
    ModelAyatYasin(
      number: 51,
      arabic: 'وَنُفِخَ فِى ٱلصُّورِ فَإِذَا هُم مِّنَ ٱلْأَجْدَاثِ إِلَىٰ رَبِّهِمْ يَنسِلُونَ',
      latin: 'Wa nufikha fish-shuuri fa-idzaa hum minal-ajdaatsi ilaa rabbihim yansiluun.',
      translation: 'Lalu ditiuplah sangkakala, maka seketika itu mereka keluar dari kuburnya (dalam keadaan hidup), menuju kepada Tuhannya.',
    ),
    ModelAyatYasin(
      number: 52,
      arabic: 'قَالُوا۟ يَٰوَيْلَنَا مَنۢ بَعَثَنَا مِن مَّرْقَدِنَا ۜ ۗ هَٰذَا مَا وَعَدَ ٱلرَّحْمَٰنُ وَصَدَقَ ٱلْمُرْسَلُونَ',
      latin: 'Qaaluu yaa wailanaa mam ba\'atsanaa mim marqadinaa, haadzaa maa wa\'adar-rahmaanu wa shadaqal-mursaluun.',
      translation: 'Mereka berkata, "Celakalah kami! Siapakah yang membangkitkan kami dari tempat tidur kami (kubur)?" Inilah yang dijanjikan (Allah) Yang Maha Pengasih dan benarlah rasul-rasul(-Nya).',
    ),
    ModelAyatYasin(
      number: 53,
      arabic: 'إِن كَانَتْ إِلَّا صَيْحَةً وَٰحِدَةً فَإِذَا هُمْ جَمِيعٌ لَّدَيْنَا مُحْضَرُونَ',
      latin: 'In kaanat illaa shaihataw waahidatan fa-idzaa hum jamii\'ul ladainaa muhdharuun.',
      translation: 'Teriakan itu hanya sekali saja, maka seketika itu mereka semua dihadapkan kepada Kami (untuk dihisab).',
    ),
    ModelAyatYasin(
      number: 54,
      arabic: 'فَٱلْيَوْمَ لَا تُظْلَمُ نَفْسٌ شَيْـًٔا وَلَا تُجْزَوْنَ إِلَّا مَا كُنتُمْ تَعْمَلُونَ',
      latin: "Fal-yauma laa tuzhlamu nafsun syai-aw wa laa tujzauna illaa maa kuntum ta'maluun.",
      translation: 'Maka pada hari itu tidak ada seorang pun yang dirugikan sedikit pun dan kamu tidak akan diberi balasan, kecuali sesuai dengan apa yang telah kamu kerjakan.',
    ),
    ModelAyatYasin(
      number: 55,
      arabic: 'إِنَّ أَصْحَٰبَ ٱلْجَنَّةِ ٱلْيَوْمَ فِى شُغُلٍ فَٰكِهُونَ',
      latin: 'Inna ash-haabal-jannatil-yauma fii syughulin faakihuun.',
      translation: 'Sesungguhnya penghuni surga pada hari itu bersenang-senang dalam kesibukan (mereka).',
    ),
    ModelAyatYasin(
      number: 56,
      arabic: 'هُمْ وَأَزْوَٰجُهُمْ فِى ظِلَٰلٍ عَلَى ٱلْأَرَآئِكِ مُتَّكِـُٔونَ',
      latin: "Hum wa azwaajuhum fii zhilaalin 'alal-araaa-iki muttaki-uun.",
      translation: 'Mereka dan pasangan-pasangannya berada dalam tempat yang teduh, bersandar di atas dipan-dipan.',
    ),
    ModelAyatYasin(
      number: 57,
      arabic: 'لَهُمْ فِيهَا فَٰكِهَةٌ وَلَهُم مَّا يَدَّعُونَ',
      latin: 'Lahum fiihaa faakihatuw wa lahum maa yadda\'uun.',
      translation: 'Di surga itu mereka memperoleh buah-buahan dan memperoleh apa saja yang mereka inginkan.',
    ),
    ModelAyatYasin(
      number: 58,
      arabic: 'سَلَٰمٌ قَوْلًا مِّن رَّبٍّ رَّحِيمٍ',
      latin: 'Salaamun qaulam mir rabbir rahiim.',
      translation: '(Kepada mereka dikatakan), "Salam," sebagai ucapan selamat dari Tuhan Yang Maha Penyayang.',
    ),
    ModelAyatYasin(
      number: 59,
      arabic: 'وَٱمْتَٰزُوا۟ ٱلْيَوْمَ أَيُّهَا ٱلْمُجْرِمُونَ',
      latin: "Wamtaazul-yauma ayyuhal-mujrimuun.",
      translation: 'Dan (dikatakan kepada orang-orang kafir), "Berpisahlah kamu (dari orang-orang mukmin) pada hari ini, wahai orang-orang yang berdosa!',
    ),
    ModelAyatYasin(
      number: 60,
      arabic: 'أَلَمْ أَعْهَدْ إِلَيْكُمْ يَٰبَنِىٓ ءَادَمَ أَن لَّا تَعْبُدُوا۟ ٱلشَّيْطَٰنَ ۖ إِنَّهُۥ لَكُمْ عَدُوٌّ مُّبِينٌ',
      latin: "Alam a'had ilaikum yaa baniii aadama al laa ta'budusy-syaithaan, innahuu lakum 'aduwwum mubiin.",
      translation: 'Bukankah Aku telah memerintahkan kepadamu wahai anak cucu Adam agar kamu tidak menyembah setan? Sungguh, setan itu musuh yang nyata bagi kamu,',
    ),
    ModelAyatYasin(
      number: 61,
      arabic: 'وَأَنِ ٱعْبُدُونِى ۚ هَٰذَا صِرَٰطٌ مُّسْتَقِيمٌ',
      latin: "Wa ani'buduunii, haadzaa shiraathum mustaqiim.",
      translation: 'dan hendaklah kamu menyembah-Ku. Inilah jalan yang lurus."',
    ),
    ModelAyatYasin(
      number: 62,
      arabic: 'وَلَقَدْ أَضَلَّ مِنكُمْ جِبِلًّا كَثِيرًا ۖ أَفَلَمْ تَكُونُوا۟ تَعْقِلُونَ',
      latin: "Wa laqad adhalla minkum jibillan katsiiraa, afalam takuunuu ta'qiluun.",
      translation: 'Dan sungguh, ia (setan itu) telah menyesatkan sebagian besar di antara kamu. Maka apakah kamu tidak mengerti?',
    ),
    ModelAyatYasin(
      number: 63,
      arabic: 'هَٰذِهِۦ جَهَنَّمُ ٱلَّتِى كُنتُمْ تُوعَدُونَ',
      latin: 'Haadzihii jahannamul-latii kuntum tuu\'aduun.',
      translation: 'Inilah (neraka) Jahanam yang dahulu telah diperingatkan kepadamu.',
    ),
    ModelAyatYasin(
      number: 64,
      arabic: 'ٱصْلَوْهَا ٱلْيَوْمَ بِمَا كُنتُمْ تَكْفُرُونَ',
      latin: 'Ishlauhal-yauma bimaa kuntum takfuruun.',
      translation: 'Masuklah ke dalamnya pada hari ini karena dahulu kamu mengingkarinya.',
    ),
    ModelAyatYasin(
      number: 65,
      arabic: 'ٱلْيَوْمَ نَخْتِمُ عَلَىٰٓ أَفْوَٰهِهِمْ وَتُكَلِّمُنَآ أَيْدِيهِمْ وَتَشْهَدُ أَرْجُلُهُم بِمَا كَانُوا۟ يَكْسِبُونَ',
      latin: "Al-yauma nakhtimu 'alaaa afwaahihim wa tukallimunaaa aidiihim wa tasyhadu arjuluhum bimaa kaanuu yaksibuun.",
      translation: 'Pada hari ini Kami tutup mulut mereka; tangan mereka akan berkata kepada Kami dan kaki mereka akan memberi kesaksian terhadap apa yang dahulu mereka kerjakan.',
    ),
    ModelAyatYasin(
      number: 66,
      arabic: 'وَلَوْ نَشَآءُ لَطَمَسْنَا عَلَىٰٓ أَعْيُنِهِمْ فَٱسْتَبَقُوا۟ ٱلصِّرَٰطَ فَأَنَّىٰ يُبْصِرُونَ',
      latin: "Walau nasyaaa-u lathamasnaa 'alaaa a'yunihim fastabaqush-shiraatha fa-annaa yubshiruun.",
      translation: 'Dan jika Kami menghendaki, pastilah Kami hapuskan penglihatan mata mereka; sehingga mereka berlomba-lomba (mencari) jalan. Maka bagaimana mungkin mereka dapat melihat?',
    ),
    ModelAyatYasin(
      number: 67,
      arabic: 'وَلَوْ نَشَآءُ لَمَسَخْنَٰهُمْ عَلَىٰ مَكَانَتِهِمْ فَمَا ٱسْتَطَٰعُوا۟ مُضِيًّا وَلَا يَرْجِعُونَ',
      latin: "Walau nasyaaa-u lamasakhnaahum 'alaa makaanatihim famastathaa'uu mudhiyyaw wa laa yarji'uun.",
      translation: 'Dan jika Kami menghendaki, pastilah Kami ubah bentuk mereka di tempat mereka berada; sehingga mereka tidak sanggup berjalan lagi dan juga tidak sanggup kembali.',
    ),
    ModelAyatYasin(
      number: 68,
      arabic: 'وَمَن نُّعَمِّرْهُ نُنَكِّسْهُ فِى ٱلْخَلْقِ ۖ أَفَلَا يَعْقِلُونَ',
      latin: "Wa man nu'ammirhu nunakkis-hu fil-khalq, afalaa ya'qiluun.",
      translation: 'Dan barangsiapa Kami panjangkan umurnya niscaya Kami kembalikan dia kepada awal kejadian(nya). Maka apakah mereka tidak mengerti?',
    ),
    ModelAyatYasin(
      number: 69,
      arabic: 'وَمَا عَلَّمْنَٰهُ ٱلشِّعْرَ وَمَا يَنۢبَغِى لَهُۥٓ ۚ إِنْ هُوَ إِلَّا ذِكْرٌ وَقُرْءَانٌ مُّبِينٌ',
      latin: "Wa maa 'allamnaahusy-syi'ra wa maa yambaghii lah, in huwa illaa dzikruw wa qur-aanum mubiin.",
      translation: 'Dan Kami tidak mengajarkan syair kepadanya (Muhammad) dan bersyair itu tidaklah pantas baginya. Al-Qur\'an itu tidak lain hanyalah pelajaran dan Kitab yang jelas,',
    ),
    ModelAyatYasin(
      number: 70,
      arabic: 'لِّيُنذِرَ مَن كَانَ حَيًّا وَيَحِقَّ ٱلْقَوْلُ عَلَى ٱلْكَٰفِرِينَ',
      latin: "Liyundzira man kaana hayyaw wa yahiqqal-qaulu 'alal-kaafiriin.",
      translation: 'agar dia (Muhammad) memberi peringatan kepada orang-orang yang hidup (hatinya) dan agar pasti ketetapan (azab) terhadap orang-orang kafir.',
    ),
    ModelAyatYasin(
      number: 71,
      arabic: 'أَوَلَمْ يَرَوْا۟ أَنَّا خَلَقْنَا لَهُم مِّمَّا عَمِلَتْ أَيْدِينَآ أَنْعَٰمًا فَهُمْ لَهَا مَٰلِكُونَ',
      latin: "Awalam yarau annaa khalaqnaa lahum mimmaa 'amilat aidiinaaa an'aaman fahum lahaa maalikuun.",
      translation: 'Dan tidakkah mereka melihat bahwa Kami telah menciptakan hewan ternak untuk mereka yaitu sebagian dari apa yang telah Kami ciptakan dengan kekuasaan Kami, lalu mereka menguasainya?',
    ),
    ModelAyatYasin(
      number: 72,
      arabic: 'وَذَلَّلْنَٰهَا لَهُمْ فَمِنْهَا رَكُوبُهُمْ وَمِنْهَا يَأْكُلُونَ',
      latin: "Wa dzallalnaahaa lahum faminhaa rokuubuhum wa minhaa ya'kuluun.",
      translation: 'Dan Kami menundukkannya (hewan-hewan itu) untuk mereka; lalu sebagiannya menjadi tunggangan mereka dan sebagiannya mereka makan.',
    ),
    ModelAyatYasin(
      number: 73,
      arabic: 'وَلَهُمْ فِيهَا مَنَٰفِعُ وَمَشَارِبُ ۖ أَفَلَا يَشْكُرُونَ',
      latin: 'Wa lahum fiihaa manaafi\'u wa masyaarib, afalaa yasykuruun.',
      translation: 'Dan mereka memperoleh berbagai manfaat dan minuman padanya. Maka mengapa mereka tidak bersyukur?',
    ),
    ModelAyatYasin(
      number: 74,
      arabic: 'وَٱتَّخَذُوا۟ مِن دُونِ ٱللَّهِ ءَالِهَةً لَّعَلَّهُمْ يُنصَرُونَ',
      latin: "Wattakhadzuu min duunillaahi aalihatal la'allahum yunsharuun.",
      translation: 'Dan mereka mengambil sesembahan selain Allah agar mereka mendapat pertolongan.',
    ),
    ModelAyatYasin(
      number: 75,
      arabic: 'لَا يَسْتَطِيعُونَ نَصْرَهُمْ وَهُمْ لَهُمْ جُندٌ مُّحْضَرُونَ',
      latin: 'Laa yastathii\'uuna nashrahum wa hum lahum jundum muhdharuun.',
      translation: 'Sesembahan itu tidak mampu menolong mereka; padahal sesembahan itu menjadi tentara yang disiapkan untuk menjaga mereka.',
    ),
    ModelAyatYasin(
      number: 76,
      arabic: 'فَلَا يَحْزُنكَ قَوْلُهُمْ ۘ إِنَّا نَعْلَمُ مَا يُسِرُّونَ وَمَا يُعْلِنُونَ',
      latin: "Falaa yahzunka qauluhum, innaa na'lamu maa yusirruuna wa maa yu'linuun.",
      translation: 'Maka jangan sampai ucapan mereka membuat engkau (Muhammad) bersedih hati. Sungguh, Kami mengetahui apa yang mereka rahasiakan dan apa yang mereka nyatakan.',
    ),
    ModelAyatYasin(
      number: 77,
      arabic: 'أَوَلَمْ يَرَ ٱلْإِنسَٰنُ أَنَّا خَلَقْنَٰهُ مِن نُّطْفَةٍ فَإِذَا هُوَ خَصِيمٌ مُّبِينٌ',
      latin: "Awalam yaral-insaanu annaa khalaqnaahu min nuthfatin fa-idzaa huwa khashiimum mubiin.",
      translation: 'Dan tidakkah manusia memperhatikan bahwa Kami menciptakannya dari setetes mani, ternyata dia menjadi musuh yang nyata!',
    ),
    ModelAyatYasin(
      number: 78,
      arabic: 'وَضَرَبَ لَنَا مَثَلًا وَنَسِىَ خَلْقَهُۥ ۖ قَالَ مَن يُحْىِ ٱلْعِظَٰمَ وَهِىَ رَمِيمٌ',
      latin: "Wa dharaba lanaa matsalaw wa nasiya khalqah, qaala may yuhyil-'izhaama wa hiya ramiim.",
      translation: 'Dan dia membuat perumpamaan bagi Kami dan melupakan asal kejadiannya; dia berkata, "Siapakah yang dapat menghidupkan tulang-belulang yang telah hancur luluh?"',
    ),
    ModelAyatYasin(
      number: 79,
      arabic: 'قُلْ يُحْيِيهَا ٱلَّذِىٓ أَنشَأَهَآ أَوَّلَ مَرَّةٍ ۖ وَهُوَ بِكُلِّ خَلْقٍ عَلِيمٌ',
      latin: "Qul yuhyiihal-ladziii ansya-ahaaa awwala marrah, wa huwa bikulli khalqin 'aliim.",
      translation: 'Katakanlah (Muhammad), "Yang akan menghidupkannya ialah (Allah) yang menciptakannya pertama kali. Dan Dia Maha Mengetahui tentang segala makhluk,',
    ),
    ModelAyatYasin(
      number: 80,
      arabic: 'ٱلَّذِى جَعَلَ لَكُم مِّنَ ٱلشَّجَرِ ٱلْأَخْضَرِ نَارًا فَإِذَآ أَنتُم مِّنْهُ تُوقِدُونَ',
      latin: "Al-ladzii ja'ala lakum minasy-syajaril-akhdhari naaran fa-idzaaa antum minhu tuuqiduun.",
      translation: 'yaitu (Allah) yang menjadikan api untukmu dari kayu yang hijau, maka seketika itu kamu menyalakan (api) dari kayu itu."',
    ),
    ModelAyatYasin(
      number: 81,
      arabic: 'أَوَلَيْسَ ٱلَّذِى خَلَقَ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضَ بِقَٰدِرٍ عَلَىٰٓ أَن يَخْلُقَ مِثْلَهُم ۚ بَلَىٰ وَهُوَ ٱلْخَلَّٰقُ ٱلْعَلِيمُ',
      latin: "Awa laisal-ladzii khalaqas-samaawaati wal-ardha biqaadirin 'alaaa ay yakhluqa mitslahum, balaa wa huwal-khallaaqul-'aliim.",
      translation: 'Dan bukankah (Allah) yang menciptakan langit dan bumi, berkuasa menciptakan kembali jasad-jasad mereka yang serupa itu? Benar, dan Dia Maha Pencipta, Maha Mengetahui.',
    ),
    ModelAyatYasin(
      number: 82,
      arabic: 'إِنَّمَآ أَمْرُهُۥٓ إِذَآ أَرَادَ شَيْـًٔا أَن يَقُولَ لَهُۥ كُن فَيَكُونُ',
      latin: "Innamaaa amruhuuu idzaaa araada syai-an ay yaquula lahuu kun fayakuun.",
      translation: 'Sesungguhnya urusan-Nya apabila Dia menghendaki sesuatu hanyalah berkata kepadanya, "Jadilah!" Maka jadilah sesuatu itu.',
    ),
    ModelAyatYasin(
      number: 83,
      arabic: 'فَسُبْحَٰنَ ٱلَّذِى بِيَدِهِۦ مَلَكُوتُ كُلِّ شَىْءٍ وَإِلَيْهِ تُرْجَعُونَ',
      latin: "Fa subhaanal-ladzii biyadihii malakuutu kulli syai-iw wa ilaihi turja'uun.",
      translation: 'Maka Mahasuci (Allah) yang di tangan-Nya kekuasaan atas segala sesuatu dan kepada-Nyalah kamu dikembalikan.',
    ),
  ];

  // ========================================================
  // 2. SUSUNAN BACAAN TAHLIL LENGKAP
  // ========================================================
  static const List<ModelBacaanTahlil> bacaanTahlil = [
    ModelBacaanTahlil(
      number: 1,
      title: 'Pengantar Hadharah Al-Fatihah',
      arabic: 'إِلَى حَضْرَةِ النَّبِيِّ الْمُصْطَفَى مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ وَآلِهِ وَأَزْوَاجِهِ وَذُرِّيَّاتِهِ وَأَهْلِ بَيْتِهِ الْكِرَامِ، شَيْءٌ لِلّٰهِ لَهُمُ الْفَاتِحَةُ...',
      latin: 'Ilaa hadhratin-nabiyyil-musthafaa Muhammadin shallallaahu \'alaihi wa sallam wa aalihii wa azwaajihii wa dzurriyyatihii wa ahli baitihil-kiraam, syai-un lillaahi lahumul-faatihah...',
      translation: 'Kepada yang mulia Nabi terpilih Muhammad SAW, segenap keluarga, istri-istri, keturunan, dan ahli baitnya yang mulia, segala sesuatu milik Allah, bagi mereka Al-Fatihah.',
      keterangan: 'Lalu membaca Surat Al-Fatihah 1x.',
    ),
    ModelBacaanTahlil(
      number: 2,
      title: 'Hadharah Para Nabi, Sahabat, & Syuhada',
      arabic: 'ثُمَّ إِلَى حَضَرَاتِ إِخْوَانِهِ مِنَ الْأَنْبِيَاءِ وَالْمُرْسَلِينَ وَالْأَوْلِيَاءِ وَالشُّهَدَاءِ وَالصَّالِحِينَ وَالصَّحَابَةِ وَالتَّابِعِينَ وَالْعُلَمَاءِ الْعَامِلِينَ وَالْمُصَنِّفِينَ الْمُخْلِصِينَ وَجَمِيعِ الْمَلَائِكَةِ الْمُقَرَّبِينَ، خُصُوصًا سَيِّدِنَا الشَّيْخِ عَبْدِ الْقَادِرِ الْجَيْلَانِيِّ، الْفَاتِحَةُ...',
      latin: 'Tsumma ilaa hadharaati ikhwaanihii minal-ambiyaa-i wal-mursaliin wal-auliyaa-i wasy-syuhadaa-i wash-shaalihiin wash-shahaabati wat-taabi\'iin wal-\'ulamaa-il-\'aamiliin wal-mushannifiinal-mukhlishiin wa jamii\'il-malaa-ikatil-muqarrabiin, khushuushan sayyidinas-Syaikh \'Abdul Qaadir Al-Jailaanii, Al-Faatihah...',
      translation: 'Kemudian kepada para saudaranya dari kalangan nabi, rasul, wali, syuhada, orang-orang saleh, sahabat, tabi\'in, ulama yang mengamalkan ilmunya, para pengarang yang ikhlas, dan segenap malaikat muqarrabin, terkhusus Syaikh Abdul Qadir Jailani, Al-Fatihah.',
      keterangan: 'Membaca Surat Al-Fatihah 1x.',
    ),
    ModelBacaanTahlil(
      number: 3,
      title: 'Khususan Ahli Kubur (Almarhum / Almarhumah)',
      arabic: 'ثُمَّ إِلَى جَمِيعِ أَهْلِ الْقُبُورِ مِنَ الْمُسْلِمِينَ وَالْمُسْلِمَاتِ وَالْمُؤْمِنِينَ وَالْمُؤْمِنَاتِ مِنْ مَشَارِقِ الْأَرْضِ إِلَى مَغَارِبِهَا بَرِّهَا وَبَحْرِهَا، خُصُوصًا آبَاءَنَا وَأُمَّهَاتِنَا وَأَجْدَادَنَا وَجَدَّاتِنَا، وَخُصُوصًا مَنِ اجْتَمَعْنَا هٰهُنَا بِسَبَبِهِ وَلِأَجْلِهِ، الْفَاتِحَةُ...',
      latin: 'Tsumma ilaa jamii\'i ahlil-qubuuri minal-muslimiina wal-muslimaati wal-mu\'miniina wal-mu\'minaati mim masyaariqil-ardhi ilaa maghaaribihaa barrihaa wa bahrihaa, khushuushan aabaa-anaa wa ummahaatinaa wa ajdaadanaa wa jaddaatinaa, wa khushuushan manij-tama\'naa haahunaa bisababihii wa li-ajlihii, Al-Faatihah...',
      translation: 'Kemudian kepada seluruh ahli kubur kaum muslimin-muslimat, mukminin-mukminat dari timur hingga barat bumi, darat maupun laut, terkhusus ayah ibu kami, kakek nenek kami, dan terkhusus almarhum/almarhumah yang menjadi sebab kami berkumpul di sini, Al-Fatihah.',
      keterangan: 'Membaca Surat Al-Fatihah 1x.',
    ),
    ModelBacaanTahlil(
      number: 4,
      title: 'Surat Al-Ikhlas',
      pengulangan: 'Dibaca 3x',
      arabic: 'قُلْ هُوَ اللّٰهُ أَحَدٌ ۚ اللّٰهُ الصَّمَدُ ۚ لَمْ يَلِدْ وَلَمْ يُوْلَدْ ۚ وَلَمْ يَكُنْ لَّهُۥ كُفُوًا أَحَدٌ',
      latin: 'Qul huwallaahu ahad. Allaahush-shamad. Lam yalid wa lam yuulad. Wa lam yakul lahuu kufuwan ahad.',
      translation: 'Katakanlah (Muhammad), "Dialah Allah, Yang Maha Esa. Allah tempat meminta segala sesuatu. (Allah) tidak beranak dan tidak pula diperanakkan. Dan tidak ada sesuatu yang setara dengan Dia."',
    ),
    ModelBacaanTahlil(
      number: 5,
      title: 'Tahlil & Takbir Pendek',
      arabic: 'لَا إِلٰهَ إِلَّا اللّٰهُ وَاللّٰهُ أَكْبَرُ وَلِلّٰهِ الْحَمْدُ',
      latin: 'Laa ilaaha illallaahu wallaahu akbar wa lillaahil-hamd.',
      translation: 'Tiada Tuhan selain Allah, Allah Mahabesar, dan bagi Allah segala puji.',
    ),
    ModelBacaanTahlil(
      number: 6,
      title: 'Surat Al-Falaq',
      arabic: 'قُلْ أَعُوْذُ بِرَبِّ الْفَلَقِ ۙ مِنْ شَرِّ مَا خَلَقَ ۙ وَمِنْ شَرِّ غَاسِقٍ إِذَا وَقَبَ ۙ وَمِنْ شَرِّ النَّفّٰثٰتِ فِى الْعُقَدِ ۙ وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ',
      latin: 'Qul a\'uudzu birabbil-falaq. Min syarri maa khalaq. Wa min syarri ghaasiqin idzaa waqab. Wa min syarrin-naffaatsaati fil-\'uqad. Wa min syarri haasidin idzaa hasad.',
      translation: 'Katakanlah, "Aku berlindung kepada Tuhan yang menguasai subuh (fajar), dari kejahatan (makhluk yang) Dia ciptakan, dari kejahatan malam apabila telah gelap gulita, dari kejahatan wanita-wanita penyihir yang meniup pada buhul-buhul (talinya), dan dari kejahatan orang yang dengki apabila dia dengki."',
    ),
    ModelBacaanTahlil(
      number: 7,
      title: 'Tahlil & Takbir Pendek',
      arabic: 'لَا إِلٰهَ إِلَّا اللّٰهُ وَاللّٰهُ أَكْبَرُ وَلِلّٰهِ الْحَمْدُ',
      latin: 'Laa ilaaha illallaahu wallaahu akbar wa lillaahil-hamd.',
      translation: 'Tiada Tuhan selain Allah, Allah Mahabesar, dan bagi Allah segala puji.',
    ),
    ModelBacaanTahlil(
      number: 8,
      title: 'Surat An-Nas',
      arabic: 'قُلْ أَعُوْذُ بِرَبِّ النَّاسِ ۙ مَلِكِ النَّاسِ ۙ إِلٰهِ النَّاسِ ۙ مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۙ الَّذِى يُوَسْوِسُ فِى صُدُوْرِ النَّاسِ ۙ مِنَ الْجِنَّةِ وَالنَّاسِ',
      latin: 'Qul a\'uudzu birabbin-naas. Malikin-naas. Ilaahin-naas. Min syarril-waswaasil-khannaas. Al-ladzii yuwaswisu fii shuduurin-naas. Minal-jinnati wan-naas.',
      translation: 'Katakanlah, "Aku berlindung kepada Tuhannya manusia, Raja manusia, Sembahan manusia, dari kejahatan (bisikan) setan yang bersembunyi, yang membisikkan (kejahatan) ke dalam dada manusia, dari (golongan) jin dan manusia."',
    ),
    ModelBacaanTahlil(
      number: 9,
      title: 'Awal Surat Al-Baqarah (Ayat 1-5)',
      arabic: 'الٓمٓ ۚ ذَٰلِكَ الْكِتٰبُ لَا رَيْبَ ۛ فِيْهِ ۛ هُدًى لِّلْمُتَّقِيْنَ ۙ الَّذِيْنَ يُؤْمِنُوْنَ بِالْغَيْبِ وَيُقِيْمُوْنَ الصَّلٰوةَ وَمِمَّا رَزَقْنٰهُمْ يُنْفِقُوْنَ ۙ وَالَّذِيْنَ يُؤْمِنُوْنَ بِمَآ أُنْزِلَ إِلَيْكَ وَمَآ أُنْزِلَ مِنْ قَبْلِكَ وَبِالْآخِرَةِ هُمْ يُوْقِنُوْنَ ۗ أُولٰٓئِكَ عَلَىٰ هُدًى مِّنْ رَّبِّهِمْ ۖ وَأُولٰٓئِكَ هُمُ الْمُفْلِحُوْنَ',
      latin: 'Alif Laaam Miiim. Dzaalikal-kitaabu laa raiba fiih, hudal lil-muttaqiin. Al-ladziina yu\'minuuna bil-ghaibi wa yuqiimuunash-shalaata wa mimmaa razaqnaahum yunfiquun. Wal-ladziina yu\'minuuna bimaaa unzila ilaika wa maaa unzila min qablika wa bil-aakhirati hum yuuqinuun. Ulaaa-ika \'alaa hudam mir rabbihim wa ulaaa-ika humul-muflihuun.',
      translation: 'Alif Lam Mim. Kitab (Al-Qur\'an) ini tidak ada keraguan padanya; petunjuk bagi mereka yang bertakwa, (yaitu) mereka yang beriman kepada yang gaib, mendirikan shalat, dan menginfakkan sebagian rezeki yang Kami berikan kepada mereka. Dan mereka yang beriman kepada (Al-Qur\'an) yang diturunkan kepadamu (Muhammad) dan kitab-kitab yang telah diturunkan sebelum engkau, serta mereka yakin akan adanya akhirat. Merekalah yang mendapat petunjuk dari Tuhannya, dan mereka itulah orang-orang yang beruntung.',
    ),
    ModelBacaanTahlil(
      number: 10,
      title: 'Ayat Kursi (Surat Al-Baqarah: 255)',
      arabic: 'اللّٰهُ لَآ إِلٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّوْمُ ۚ لَا تَأْخُذُهُۥ سِنَةٌ وَّلَا نَوْمٌ ۚ لَّهُۥ مَا فِى السَّمٰوٰتِ وَمَا فِى الْأَرْضِ ۗ مَنْ ذَا الَّذِى يَشْفَعُ عِنْدَهُۥٓ إِلَّا بِإِذْنِهِۦ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيْهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيْطُوْنَ بِشَىْءٍ مِّنْ عِلْمِهِۦٓ إِلَّا بِمَا شَآءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمٰوٰتِ وَالْأَرْضَ ۖ وَلَا يَـُٔوْدُهُۥ حِفْظُهُمَا ۚ وَهُوَ الْعَلِىُّ الْعَظِيْمُ',
      latin: 'Allaahu laaa ilaaha illaa huwal-hayyul-qayyuum, laa ta\'khudzuhuu sinatuw wa laa naum, lahuu maa fis-samaawaati wa maa fil-ardh, man dzal-ladzii yasyfa\'u \'indahuuu illaa bi-idznih, ya\'lamu maa baina aidiihim wa maa khalfahum, wa laa yuhiithuuna bisyai-im min \'ilmihiii illaa bimaa syaaa\', wasi\'a kursiyyuhus-samaawaati wal-ardh, wa laa ya-uuduhuu hifzhuhumaa, wa huwal-\'aliyyul-\'azhiim.',
      translation: 'Allah, tidak ada tuhan selain Dia. Yang Mahahidup, Yang terus-menerus mengurus (makhluk-Nya), tidak mengantuk dan tidak tidur. Milik-Nya apa yang ada di langit dan apa yang ada di bumi. Siapakah yang dapat memberi syafaat di sisi-Nya tanpa izin-Nya? Dia mengetahui apa yang ada di hadapan mereka dan apa yang ada di belakang mereka, dan mereka tidak mengetahui sesuatu apa pun tentang ilmu-Nya melainkan apa yang Dia kehendaki. Kursi-Nya (ilmu dan kekuasaan-Nya) meliputi langit dan bumi. Dan Dia tidak merasa berat memelihara keduanya, dan Dia Mahatinggi, Mahabesar.',
    ),
    ModelBacaanTahlil(
      number: 11,
      title: 'Akhir Surat Al-Baqarah (Ayat 284-286)',
      arabic: 'لِّلّٰهِ مَا فِى السَّمٰوٰتِ وَمَا فِى الْأَرْضِ ۗ وَإِنْ تُبْدُوْا مَا فِىٓ أَنْفُسِكُمْ أَوْ تُخْفُوْهُ يُحَاسِبْكُمْ بِهِ اللّٰهُ ۖ فَيَغْفِرُ لِمَنْ يَّشَآءُ وَيُعَذِّبُ مَنْ يَّشَآءُ ۗ وَاللّٰهُ عَلَىٰ كُلِّ شَىْءٍ قَدِيْرٌ ۞ آمَنَ الرَّسُوْلُ بِمَآ أُنْزِلَ إِلَيْهِ مِنْ رَّبِّهِۦ وَالْمُؤْمِنُوْنَ ۚ كُلٌّ آمَنَ بِاللّٰهِ وَمَلٰٓئِكَتِهِۦ وَكُتُبِهِۦ وَرُسُلِهِۦ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِّنْ رُّسُلِهِۦ ۚ وَقَالُوْا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيْرُ ۞ لَا يُكَلِّفُ اللّٰهُ نَفْسًا إِلَّا وُسْعَهَا ۚ لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ ۗ رَبَّنَا لَا تُؤَاخِذْنَآ إِنْ نَّسِيْنَآ أَوْ أَخْطَأْنَا ۚ رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَآ إِصْرًا كَمَا حَمَلْتَهُۥ عَلَى الَّذِيْنَ مِنْ قَبْلِنَا ۚ رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِۦ ۖ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَآ ۚ أَنتَ مَوْلٰنَا فَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرِيْنَ',
      latin: 'Lillaahi maa fis-samaawaati wa maa fil-ardh... Aamanar-rasuulu bimaaa unzila ilaihi mir rabbihii wal-mu\'minuun... Laa yukallifullaahu nafsan illaa wus\'ahaa... Wa\'fu \'annaa waghfir lanaa warhamnaa, anta maulaanaa fanshurnaa \'alal-qaumil-kaafiriin.',
      translation: 'Milik Allah-lah apa yang ada di langit dan di bumi... Rasul (Muhammad) beriman kepada apa yang diturunkan kepadanya dari Tuhannya, demikian pula orang-orang yang beriman... Ya Tuhan kami, janganlah Engkau bebankan kepada kami apa yang tak sanggup kami memikulnya. Maafkanlah kami, ampunilah kami, dan rahmatilah kami. Engkaulah Pelindung kami, maka tolonglah kami menghadapi kaum yang kafir.',
    ),
    ModelBacaanTahlil(
      number: 12,
      title: 'Permohonan Rahmat & Ampunan',
      pengulangan: 'Dibaca 3x',
      arabic: 'وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَآ، أَنْتَ مَوْلٰنَا فَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرِيْنَ',
      latin: "Wa'fu 'annaa waghfir lanaa warhamnaa, anta maulaanaa fanshurnaa 'alal-qaumil-kaafiriin.",
      translation: 'Maafkanlah kami, ampunilah kami, dan rahmatilah kami. Engkaulah Penolong kami, maka tolonglah kami atas orang-orang kafir.',
    ),
    ModelBacaanTahlil(
      number: 13,
      title: 'Istighfar Agung',
      pengulangan: 'Dibaca 3x',
      arabic: 'أَسْتَغْفِرُ اللّٰهَ الْعَظِيْمَ',
      latin: "Astaghfirullaahal-'azhiim.",
      translation: 'Aku memohon ampunan kepada Allah Yang Maha Agung.',
    ),
    ModelBacaanTahlil(
      number: 14,
      title: 'Kalimat Tahlil (Afkhaludz Dzikri)',
      pengulangan: 'Dibaca 33x / 100x',
      arabic: 'أَفْضَلُ الذِّكْرِ فَاعْلَمْ أَنَّهُ: لَا إِلٰهَ إِلَّا اللّٰهُ',
      latin: 'Afdhaludz-dzikri fa\'lam annahu: Laa ilaaha illallaah.',
      translation: 'Ketahuilah bahwa dzikir yang paling utama adalah: Tiada Tuhan selain Allah.',
    ),
    ModelBacaanTahlil(
      number: 15,
      title: 'Penutup Tahlil & Kalimat Tauhid',
      arabic: 'لَا إِلٰهَ إِلَّا اللّٰهُ مُحَمَّدٌ رَّسُوْلُ اللّٰهِ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، كَلِمَةُ حَقٍّ عَلَيْهَا نَحْيَا وَعَلَيْهَا نَمُوْتُ وَبِهَا نُبْعَثُ إِنْ شَآءَ اللّٰهُ تَعَالَى مِنَ الْآمِنِيْنَ',
      latin: 'Laa ilaaha illallaahu Muhammadur rasuulullaahi shallallaahu \'alaihi wa sallam, kalimatu haqqin \'alaihaa nahyaa wa \'alaihaa namuutu wa bihaa nub\'atsu in syaaa-allaahu ta\'aalaa minal-aaminiin.',
      translation: 'Tiada Tuhan selain Allah, Nabi Muhammad utusan Allah SAW. Kalimat kebenaran yang di atasnya kami hidup, kami mati, dan kelak kami dibangkitkan insya Allah termasuk orang-orang yang aman.',
    ),
    ModelBacaanTahlil(
      number: 16,
      title: 'Shalawat atas Nabi Muhammad SAW',
      pengulangan: 'Dibaca 3x',
      arabic: 'اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ، اَللّٰهُمَّ صَلِّ عَلَيْهِ وَسَلِّمْ',
      latin: 'Allaahumma shalli \'alaa sayyidinaa Muhammad, Allaahumma shalli \'alaihi wa sallim.',
      translation: 'Ya Allah, limpahkanlah rahmat kepada junjungan kami Nabi Muhammad. Ya Allah, limpahkanlah rahmat dan kesejahteraan kepadanya.',
    ),
    ModelBacaanTahlil(
      number: 17,
      title: 'Tasbih & Tahmid',
      pengulangan: 'Dibaca 33x',
      arabic: 'سُبْحَانَ اللّٰهِ وَبِحَمْدِهِۦ، سُبْحَانَ اللّٰهِ الْعَظِيْمِ',
      latin: 'Subhaanallaahi wa bihamdihii, Subhaanallaahil-\'azhiim.',
      translation: 'Mahasuci Allah dengan segala puji-Nya, Mahasuci Allah Yang Maha Agung.',
    ),
    ModelBacaanTahlil(
      number: 18,
      title: 'Penutup Shalawat & Al-Fatihah',
      arabic: 'اَللّٰهُمَّ صَلِّ عَلَى حَبِيْبِكَ سَيِّدِنَا مُحَمَّدٍ وَآلِهِۦ وَصَحْبِهِۦ وَسَلِّمْ، أَجْمَعِيْنَ. الْفَاتِحَةُ...',
      latin: 'Allaahumma shalli \'alaa habiibika sayyidinaa Muhammadin wa aalihii wa shahbihii wa sallim, ajma\'iin. Al-Faatihah...',
      translation: 'Ya Allah, limpahkanlah shalawat dan salam kepada kekasih-Mu junjungan kami Nabi Muhammad beserta seluruh keluarga dan para sahabatnya. Al-Fatihah...',
      keterangan: 'Membaca Surat Al-Fatihah 1x sebelum melanjutkan ke Doa Tahlil.',
    ),
  ];

  // ========================================================
  // 3. DOA TAHLIL (DOA ARWAH & KESELAMATAN)
  // ========================================================
  static const ModelDoaTahlil doaTahlil = ModelDoaTahlil(
    title: 'Doa Tahlil Lengkap (Doa Arwah)',
    arabic: '''أَعُوْذُ بِاللّٰهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ. بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ.
الْحَمْدُ لِلّٰهِ رَبِّ الْعَالَمِيْنَ، حَمْدَ الشَّاكِرِيْنَ حَمْدَ النَّاعِمِيْنَ، حَمْدًا يُّوَافِيْ نِعَمَهُۥ وَيُكَافِئُ مَزِيْدَهُۥ، يَا رَبَّنَا لَكَ الْحَمْدُ كَمَا يَنْبَغِيْ لِجَلَالِ وَجْهِكَ الْكَرِيْمِ وَعَظِيْمِ سُلْطَانِكَ.

اَللّٰهُمَّ صَلِّ وَسَلِّمْ عَلَى سَيِّدِنَا مُحَمَّدٍ وَعَلَى آلِ سَيِّدِنَا مُحَمَّدٍ.

اَللّٰهُمَّ تَقَبَّلْ وَأَوْصِلْ ثَوَابَ مَا قَرَأْنَاهُ مِنْ سُوْرَةِ يٰسٓ، وَمَا تَلَوْنَاهُ مِنَ الْقُرْآنِ الْعَظِيْمِ، وَمَا هَلَّلْنَا، وَمَا سَبَّحْنَا، وَمَا اسْتَغْفَرْنَا، وَمَا صَلَّيْنَا عَلَى سَيِّدِنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، هَدِيَّةً وَّاصِلَةً، وَرَحْمَةً نَّازِلَةً، وَبَرَكَةً شَامِلَةً، إِلَى حَضْرَةِ حَبِيْبِنَا وَشَفِيْعِنَا وَقُرَّةِ أَعْيُنِنَا سَيِّدِنَا وَمَوْلَانَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَإِلَى جَمِيْعِ إِخْوَانِهِ مِنَ الْأَنْبِيَاءِ وَالْمُرْسَلِيْنَ، وَالْأَوْلِيَاءِ وَالشُّهَدَاءِ وَالصَّالِحِيْنَ، وَالصَّحَابَةِ وَالتَّابِعِيْنَ، وَالْعُلَمَاءِ الْعَامِلِيْنَ، وَالْمُصَنِّفِيْنَ الْمُخْلِصِيْنَ، وَجَمِيْعِ الْمُجَاهِدِيْنَ فِيْ سَبِيْلِ اللّٰهِ رَبِّ الْعَالَمِيْنَ، وَالْمَلَائِكَةِ الْمُقَرَّبِيْنَ.

ثُمَّ إِلَى جَمِيْعِ أَهْلِ الْقُبُوْرِ مِنَ الْمُسْلِمِيْنَ وَالْمُسْلِمَاتِ، وَالْمُؤْمِنِيْنَ وَالْمُؤْمِنَاتِ، مِنْ مَشَارِقِ الْأَرْضِ إِلَى مَغَارِبِهَا بَرِّهَا وَبَحْرِهَا، خُصُوْصًا آبَاءَنَا وَأُمَّهَاتِنَا وَأَجْدَادَنَا وَجَدَّاتِنَا، وَنَخُصُّ خُصُوْصًا إِلَى مَنِ اجْتَمَعْنَا هٰهُنَا بِسَبَبِهِۦ وَلِأَجْلِهِۦ (فُلَان بْن فُلَان / فُلَانَة بِنْت فُلَان).

اَللّٰهُمَّ اغْفِرْ لَهُمْ وَارْحَمْهُمْ وَعَافِهِمْ وَاعْفُ عَنْهُمْ.
اَللّٰهُمَّ أَنْزِلِ الرَّحْمَةَ وَالْمَغْفِرَةَ عَلَى أَهْلِ الْقُبُوْرِ مِنْ أَهْلِ لَا إِلٰهَ إِلَّا اللّٰهُ مُحَمَّدٌ رَّسُوْلُ اللّٰهِ.
اَللّٰهُمَّ أَرِنَا الْحَقَّ حَقًّا وَّارْزُقْنَا اتِّبَاعَهُۥ، وَأَرِنَا الْبَاطِلَ بَاطِلًا وَّارْزُقْنَا اجْتِنَابَهُۥ.

رَبَّنَا آتِنَا فِى الدُّنْيَا حَسَنَةً وَّفِى الْآخِرَةِ حَسَنَةً وَّقِنَا عَذَابَ النَّارِ.
سُبْحَانَ رَبِّكَ رَبِّ الْعِزَّةِ عَمَّا يَصِفُوْنَ، وَسَلَامٌ عَلَى الْمُرْسَلِيْنَ، وَالْحَمْدُ لِلّٰهِ رَبِّ الْعَالَمِيْنَ. الْفَاتِحَةُ...''',
    latin: '''A'uudzu billaahi minasy-syaithaanir-rajiim. Bismillaahir-rahmaanir-rahiim.
Alhamdulillaahi rabbil-'aalamiin, hamdasy-syaakiriin hamdan-naa'imiin, hamday yuwaafii ni'amahuu wa yukaafi-u maziidah, yaa rabbanaa lakal-hamdu kamaa yambaghii lijalaali wajhikal-kariimi wa 'azhiimi sulthaanik.

Allaahumma shalli wa sallim 'alaa sayyidinaa Muhammadin wa 'alaa aali sayyidinaa Muhammad.

Allaahumma taqabbal wa aushil tsawaaba maa qara'naahu min suurati yaasiin, wa maa talaunaahu minal-qur-aanil-'azhiim, wa maa hallalnaa, wa maa sabbahnaa, wa mastaghfarnaa, wa maa shallainaa 'alaa sayyidinaa Muhammadin shallallaahu 'alaihi wa sallam, hadiyyataw waashilatan, wa rahmatan naazilatan, wa barakatan syaamilatan, ilaa hadhrati habiibinaa wa syafii'inaa wa qurrati a'yuninaa sayyidinaa wa maulaanaa Muhammadin shallallaahu 'alaihi wa sallam, wa ilaa jamii'i ikhwaanihii minal-ambiyaa-i wal-mursaliin, wal-auliyaa-i wasy-syuhadaa-i wash-shaalihiin, wash-shahaabati wat-taabi'iin, wal-'ulamaa-il-'aamiliin, wal-mushannifiinal-mukhlishiin, wa jamii'il-mujaahidiina fii sabiilillaahi rabbil-'aalamiin, wal-malaa-ikatil-muqarrabiin.

Tsumma ilaa jamii'i ahlil-qubuuri minal-muslimiina wal-muslimaati, wal-mu'miniina wal-mu'minaati, mim masyaariqil-ardhi ilaa maghaaribihaa barrihaa wa bahrihaa, khushuushan aabaa-anaa wa ummahaatinaa wa ajdaadanaa wa jaddaatinaa, wa nakhushshu khushuushan ilaa manij-tama'naa haahunaa bisababihii wa li-ajlihii (sebut nama almarhum/almarhumah).

Allaahummaghfir lahum warhamhum wa 'aafihim wa'fu 'anhum.
Allaahumma anzilir-rahmata wal-maghfirata 'alaa ahlil-qubuuri min ahli laa ilaaha illallaahu Muhammadur rasuulullaah.
Allaahumma arinal-haqqa haqqaw warzuqnattibaa'ahu, wa arinal-baathila baathilaw warzuqnaj-tinaabah.

Rabbanaa aatinaa fid-dunyaa hasanataw wa fil-aakhirati hasanataw wa qinaa 'adzaaban-naar.
Subhaana rabbika rabbil-'izzati 'ammaa yashifuun, wa salaamun 'alal-mursaliin, wal-hamdu lillaahi rabbil-'aalamiin. Al-Faatihah...''',
    translation: '''Aku berlindung kepada Allah dari godaan setan yang terkutuk. Dengan menyebut nama Allah Yang Maha Pengasih lagi Maha Penyayang.
Segala puji bagi Allah Tuhan semesta alam, pujian orang-orang yang bersyukur, pujian orang yang memperoleh kenikmatan, pujian yang sepadan dengan nikmat-Nya dan menjamin tambahannya. Wahai Tuhan kami, hanya bagi-Mu segala puji sebagaimana layaknya keagungan Dzat-Mu yang mulia dan kebesaran kekuasaan-Mu.

Ya Allah, limpahkanlah rahmat dan kesejahteraan kepada junjungan kami Nabi Muhammad beserta keluarganya.

Ya Allah, terimalah dan sampaikanlah pahala bacaan Surat Yasin yang telah kami baca, ayat-ayat Al-Qur'an yang agung, tahlil yang kami kumandangkan, tasbih yang kami sucikan, istighfar kami, dan shalawat kami kepada junjungan kami Nabi Muhammad SAW, sebagai hadiah yang sampai, rahmat yang turun, dan berkah yang melimpah kepada junjungan kami Nabi Muhammad SAW, kepada segenap nabi, rasul, wali, syuhada, orang saleh, sahabat, tabi'in, ulama, dan malaikat muqarrabin.

Kemudian kepada seluruh ahli kubur kaum muslimin dan muslimat, mukminin dan mukminat, dari timur hingga barat bumi, terkhusus ayah ibu kami, kakek nenek kami, dan terkhusus almarhum/almarhumah yang menjadi sebab kami berkumpul di sini.

Ya Allah, ampunilah mereka, rahmatilah mereka, selamatkanlah mereka, dan maafkanlah kesalahan mereka.
Ya Allah, turunkanlah rahmat dan ampunan kepada para penghuni kubur dari kalangan ahli Laa ilaaha illallaah Muhammadur Rasuulullaah.
Ya Allah, tunjukkanlah kepada kami kebenaran sebagai kebenaran dan anugerahilah kami kemampuan untuk mengikutinya, serta tunjukkanlah kepada kami kebatilan sebagai kebatilan dan anugerahilah kami kemampuan untuk menjauhinya.

Wahai Tuhan kami, berilah kami kebaikan di dunia dan kebaikan di akhirat, dan lindungilah kami dari siksa api neraka.
Mahasuci Tuhanmu, Tuhan Pemilik Kemuliaan dari apa yang mereka sifatkan, salam sejahtera bagi para rasul, dan segala puji bagi Allah Tuhan semesta alam. Al-Fatihah...''',
    keterangan: 'Dibaca setelah selesai membaca susunan bacaan tahlil.',
  );

  // ========================================================
  // 4. DOA & ADAB ZIARAH KUBUR
  // ========================================================
  static const List<ModelDoaTahlil> doaZiarahKubur = [
    ModelDoaTahlil(
      title: 'Salam Saat Memasuki Area Pemakaman',
      arabic: 'اَلسَّلَامُ عَلَيْكُمْ دَارَ قَوْمٍ مُّؤْمِنِيْنَ، وَإِنَّآ إِنْ شَآءَ اللّٰهُ بِكُمْ لَاحِقُوْنَ، نَسْأَلُ اللّٰهَ لَنَا وَلَكُمُ الْعَافِيَةَ',
      latin: "As-salaamu 'alaikum daara qaumim mu'miniin, wa innaaa in syaaa-allaahu bikum laahiquun, nas-alullaaha lanaa wa lakumul-'aafiyah.",
      translation: 'Semoga keselamatan tercurah kepada kalian wahai penghuni tempat kaum mukminin. Dan sungguh kami insya Allah akan menyusul kalian. Kami memohon keselamatan kepada Allah untuk kami dan kalian.',
      keterangan: 'HR. Muslim & Ibnu Majah. Diucapkan saat menginjakkan kaki atau melewati area pemakaman.',
    ),
    ModelDoaTahlil(
      title: 'Doa Memohon Ampunan untuk Ahli Kubur',
      arabic: 'اَللّٰهُمَّ اغْفِرْ لَهُ وَارْحَمْهُ وَعَافِهِ وَاعْفُ عَنْهُ، وَأَكْرِمْ نُزُلَهُۥ وَوَسِّعْ مَدْخَلَهُۥ، وَاغْسِلْهُ بِالْمَاءِ وَالثَّلْجِ وَالْبَرَدِ، وَنَقِّهِۦ مِنَ الْخَطَايَا كَمَا يُنَقَّى الثَّوْبُ الْأَبْيَضُ مِنَ الدَّنَسِ',
      latin: "Allaahummaghfir lahuu warhamhu wa 'aafihii wa'fu 'anhu, wa akrim nuzulahuu wa wassi' madkhalahuu, waghsilhu bil-maa-i wats-tsalji wal-barad, wa naqqihii minal-khathaayaa kamaa yunaqqats-tsaubul-abyadhu minad-danas.",
      translation: 'Ya Allah, ampunilah dia, berilah rahmat kepadanya, selamatkanlah dia dan maafkanlah kesalahannya. Muliakanlah tempat persinggahannya, luaskanlah kuburnya, sucikanlah dia dengan air, salju, dan embun, serta bersihkanlah dia dari dosa-dosa sebagaimana pakaian putih dibersihkan dari kotoran.',
      keterangan: 'Bisa diganti "lahum / lahaa" sesuai almarhum laki-laki / perempuan / jamak.',
    ),
    ModelDoaTahlil(
      title: 'Adab-Adab dalam Ziarah Kubur',
      arabic: 'آدَابُ زِيَارَةِ الْقُبُوْرِ',
      latin: 'Adaab Ziyaaratil-Qubuur',
      translation: '''1. Niatkan ziarah kubur untuk mengingat kematian dan akhirat serta mendoakan almarhum.
2. Mengucapkan salam ketika memasuki area kuburan.
3. Berwudhu terlebih dahulu sebelum ziarah (disunnahkan).
4. Tidak duduk atau menginjak di atas pusara makam.
5. Menghadap kiblat saat berdoa memohonkan ampunan bagi ahli kubur.
6. Membaca ayat Al-Qur'an (Surat Yasin / Al-Fatihah / Al-Ikhlas) dan menghadiahkan pahalanya.
7. Menjaga ketenangan, tidak meratap, berteriak, atau berbicara kotor.''',
      keterangan: 'Sesuai tuntunan sunnah Nabi Muhammad SAW.',
    ),
  ];
}
