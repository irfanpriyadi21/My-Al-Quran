import 'package:my_quran/Model/model_hadits_item.dart';
import 'package:my_quran/Model/model_hadits_perawi.dart';

class DefaultHaditsData {
  static List<ModelHaditsPerawi> getPerawiList() {
    return [
      ModelHaditsPerawi(name: "Bukhari", slug: "bukhari", total: 6638),
      ModelHaditsPerawi(name: "Muslim", slug: "muslim", total: 4930),
      ModelHaditsPerawi(name: "Abu Dawud", slug: "abu-dawud", total: 4419),
      ModelHaditsPerawi(name: "Tirmidzi", slug: "tirmidzi", total: 3625),
      ModelHaditsPerawi(name: "Nasai", slug: "nasai", total: 5364),
      ModelHaditsPerawi(name: "Ibnu Majah", slug: "ibnu-majah", total: 4285),
      ModelHaditsPerawi(name: "Ahmad", slug: "ahmad", total: 4305),
      ModelHaditsPerawi(name: "Malik", slug: "malik", total: 1587),
      ModelHaditsPerawi(name: "Darimi", slug: "darimi", total: 2949),
    ];
  }

  static List<ModelHaditsItem> getHaditsBySlug(String slug) {
    final lowerSlug = slug.toLowerCase().trim();
    if (_fallbackHaditsMap.containsKey(lowerSlug)) {
      return _fallbackHaditsMap[lowerSlug]!;
    }
    // Return standard selected hadiths if slug not found
    return _fallbackHaditsMap['bukhari'] ?? [];
  }

  static ModelHaditsItem? getHaditsByNumber(String slug, int number) {
    final list = getHaditsBySlug(slug);
    try {
      return list.firstWhere((item) => item.number == number);
    } catch (_) {
      return null;
    }
  }

  static final Map<String, List<ModelHaditsItem>> _fallbackHaditsMap = {
    'bukhari': [
      ModelHaditsItem(
        number: 1,
        arab:
            "حَدَّثَنَا الْحُمَيْدِيُّ عَبْدُ اللَّهِ بْنُ الزُّبَيْرِ قَالَ حَدَّثَنَا سُفْيَانُ قَالَ حَدَّثَنَا يَحْيَى بْنُ سَعِيدٍ الْأَنْصَارِيُّ قَالَ أَخْبَرَنِي مُحَمَّدُ بْنُ إِبْرَاهِيمَ التَّيْمِيُّ أَنَّهُ سَمِعَ عَلْقَمَةَ بْنَ وَقَّاصٍ اللَّيْثِيَّ يَقُولُ سَمِعْتُ عُمَرَ بْنَ الْخَطَّابِ رَضِيَ اللَّهُ عَنْهُ عَلَى الْمِنْبَرِ قَالَ سَمِعْتُ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ يَقُولُ إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى فَمَنْ كَانَتْ هِجْرَتُهُ إِلَى دُنْيَا يُصِيبُهَا أَوْ إِلَى امْرَأَةٍ يَنْكِحُهَا فَهِجْرَتُهُ إِلَى مَا هَاجَرَ إِلَيْهِ",
        translation:
            "Telah menceritakan kepada kami Al Humaidi Abdullah bin Az Zubair dia berkata, Telah menceritakan kepada kami Sufyan yang berkata, bahwa Telah menceritakan kepada kami Yahya bin Sa'id Al Anshari berkata, telah mengabarkan kepadaku Muhammad bin Ibrahim At Taimi, bahwa dia pernah mendengar Alqamah bin Waqqash Al Laitsi berkata; saya pernah mendengar Umar bin Al Khaththab radliallahu 'anhu diatas mimbar berkata; saya mendengar Rasulullah shallallahu 'alaihi wasallam bersabda: 'Semua perbuatan tergantung niatnya, dan (balasan) bagi tiap-tiap orang (sesuai) apa yang diniatkan; Barangsiapa hijrahnya karena dunia atau karena wanita yang ingin dinikahinya, maka hijrahnya itu ke mana ia berhijrah.'",
      ),
      ModelHaditsItem(
        number: 2,
        arab:
            "حَدَّثَنَا عَبْدُ اللَّهِ بْنُ يُوسُفَ قَالَ أَخْبَرَنَا مَالِكٌ عَنْ هِشَامِ بْنِ عُرْوَةَ عَنْ أَبِيهِ عَنْ عَائِشَةَ أُمِّ الْمُؤْمِنِينَ رَضِيَ اللَّهُ عَنْهَا أَنَّ الْحَارِثَ بْنَ هِشَامٍ رَضِيَ اللَّهُ عَنْهُ سَأَلَ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ فَقَالَ يَا رَسُولَ اللَّهِ كَيْفَ يَأْتِيكَ الْوَحْيُ فَقَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ أَحْيَانًا يَأْتِينِي مِثْلَ صَلْصَلَةِ الْجَرَسِ وَهُوَ أَشَدُّهُ عَلَيَّ فَيُفْصَمُ عَنِّي وَقَدْ وَعَيْتُ عَنْهُ مَا قَالَ وَأَحْيَانًا يَتَمَثَّلُ لِي الْمَلَكُ رَجُلًا فَيُكَلِّمُنِي فَأَعِي مَا يَقُولُ",
        translation:
            "Telah menceritakan kepada kami Abdullah bin Yusuf berkata, telah mengabarkan kepada kami Malik dari Hisyam bin Urwah dari bapaknya dari Aisyah Ummul Mukminin bahwa Al Harits bin Hisyam bertanya kepada Rasulullah shallallahu 'alaihi wasallam: 'Wahai Rasulullah, bagaimanakah wahyu turun kepadamu?' Rasulullah shallallahu 'alaihi wasallam menjawab: 'Terkadang wahyu itu datang kepadaku seperti gemerincing lonceng, dan itulah yang paling berat bagiku. Lalu terputus dariku dan aku telah menghafal apa yang disampaikannya. Dan terkadang malaikat menjelma kepadaku sebagai seorang laki-laki lalu berbicara kepadaku, maka aku memahami apa yang dikatakannya.'",
      ),
      ModelHaditsItem(
        number: 3,
        arab:
            "حَدَّثَنَا يَحْيَى بْنُ بُكَيْرٍ قَالَ حَدَّثَنَا اللَّيْثُ عَنْ عُقَيْلٍ عَنْ ابْنِ شِهَابٍ عَنْ عُرْوَةَ بْنِ الزُّبَيْرِ عَنْ عَائِشَةَ أُمِّ الْمُؤْمِنِينَ أَنَّهَا قَالَتْ أَوَّلُ مَا بُدِئَ بِهِ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ مِنْ الْوَحْيِ الرُّؤْيَا الصَّالِحَةُ فِي النَّوْمِ فَكَانَ لَا يَرَى رُؤْيَا إِلَّا جَاءَتْ مِثْلَ فَلَقِ الصُّبْحِ ثُمَّ حُبِّبَ إِلَيْهِ الْخَلَاءُ وَكَانَ يَخْلُو بِغَارِ حِرَاءٍ فَيَتَحَنَّثُ فِيهِ",
        translation:
            "Telah menceritakan kepada kami Yahya bin Bukair berkata, Telah menceritakan kepada kami Al Laits dari 'Uqail dari Ibnu Syihab dari 'Urwah bin Az Zubair dari Aisyah Ummul Mukminin bahwa dia berkata; Permulaan wahyu yang datang kepada Rasulullah shallallahu 'alaihi wasallam adalah mimpi yang benar dalam tidur. Beliau tidak bermimpi melainkan datang seperti terangnya fajar subuh. Kemudian timbul rasa cinta untuk menyendiri, lalu beliau menyendiri di Gua Hira untuk beribadah di dalamnya beberapa malam.",
      ),
      ModelHaditsItem(
        number: 8,
        arab:
            "حَدَّثَنَا عُبَيْدُ اللَّهِ بْنُ مُوسَى قَالَ أَخْبَرَنَا حَنْظَلَةُ بْنُ أَبِي سُفْيَانَ عَنْ عِكْرِمَةَ بْنِ خَالِدٍ عَنْ ابْنِ عُمَرَ رَضِيَ اللَّهُ عَنْهُمَا قَالَ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ بُنِيَ الْإِسْلَامُ عَلَى خَمْسٍ شَهَادَةِ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَأَنَّ مُحَمَّدًا رَسُولُ اللَّهِ وَإِقَامِ الصَّلَاةِ وَإِيتَاءِ الزَّكَاةِ وَالْحَجِّ وَصَوْمِ رَمَضَانَ",
        translation:
            "Telah menceritakan kepada kami Ubaidullah bin Musa berkata, telah mengabarkan kepada kami Hanzhalah bin Abu Sufyan dari Ikrimah bin Khalid dari Ibnu Umar radliallahu 'anhuma berkata, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Islam dibangun di atas lima perkara: bersaksi bahwa tidak ada tuhan selain Allah dan bahwa Muhammad adalah utusan Allah, mendirikan shalat, menunaikan zakat, menunaikan haji, dan berpuasa Ramadhan.'",
      ),
      ModelHaditsItem(
        number: 9,
        arab:
            "حَدَّثَنَا عَبْدُ اللَّهِ بْنُ مُحَمَّدٍ قَالَ حَدَّثَنَا أَبُو عَامِرٍ الْعَقَدِيُّ قَالَ حَدَّثَنَا سُلَيْمَانُ بْنُ بِلَالٍ عَنْ عَبْدِ اللَّهِ بْنِ دِينَارٍ عَنْ أَبِي صَالِحٍ عَنْ أَبِي هُرَيْرَةَ رَضِيَ اللَّهُ عَنْهُ عَنْ النَّبِيِّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ قَالَ الْإِيمَانُ بِضْعٌ وَسِتُّونَ شُعْبَةً وَالْحَيَاءُ شُعْبَةٌ مِنْ الْإِيمَانِ",
        translation:
            "Telah menceritakan kepada kami Abdullah bin Muhammad berkata, telah menceritakan kepada kami Abu Amir Al Aqadi berkata, telah menceritakan kepada kami Sulaiman bin Bilal dari Abdullah bin Dinar dari Abu Shalih dari Abu Hurairah radliallahu 'anhu, dari Nabi shallallahu 'alaihi wasallam bersabda: 'Iman itu ada enam puluh lebih cabang, dan rasa malu adalah salah satu cabang dari iman.'",
      ),
      ModelHaditsItem(
        number: 10,
        arab:
            "حَدَّثَنَا سَعِيدُ بْنُ يَحْيَى بْنِ سَعِيدٍ الْقُرَشِيُّ قَالَ حَدَّثَنَا أَبِي قَالَ حَدَّثَنَا أَبُو بُرْدَةَ بْنُ عَبْدِ اللَّهِ بْنِ أَبِي بُرْدَةَ عَنْ أَبِي بُرْدَةَ عَنْ أَبِي مُوسَى رَضِيَ اللَّهُ عَنْهُ قَالَ قَالُوا يَا رَسُولَ اللَّهِ أَيُّ الْإِسْلَامِ أَفْضَلُ قَالَ مَنْ سَلِمَ الْمُسْلِمُونَ مِنْ لِسَانِهِ وَيَدِهِ",
        translation:
            "Telah menceritakan kepada kami Sa'id bin Yahya bin Sa'id Al Qurasyi berkata, telah menceritakan kepada kami ayahku berkata, telah menceritakan kepada kami Abu Burdah bin Abdullah bin Abu Burdah dari Abu Burdah dari Abu Musa radliallahu 'anhu berkata: Para sahabat bertanya: 'Wahai Rasulullah, Islam manakah yang paling utama?' Beliau menjawab: 'Orang yang kaum muslimin selamat dari lisan dan tangannya.'",
      ),
      ModelHaditsItem(
        number: 13,
        arab:
            "حَدَّثَنَا مُسَدَّدٌ قَالَ حَدَّثَنَا يَحْيَى عَنْ شُعْبَةَ عَنْ قَتَادَةَ عَنْ أَنَسٍ رَضِيَ اللَّهُ عَنْهُ عَنْ النَّبِيِّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ قَالَ لَا يُؤْمِنُ أَحَدُكُمْ حَتَّى يُحِبَّ لِأَخِيهِ مَا يُحِبُّ لِنَفْسِهِ",
        translation:
            "Telah menceritakan kepada kami Musaddad berkata, telah menceritakan kepada kami Yahya dari Syu'bah dari Qatadah dari Anas radliallahu 'anhu dari Nabi shallallahu 'alaihi wasallam bersabda: 'Tidak beriman (dengan sempurna) salah seorang di antara kalian hingga ia mencintai untuk saudaranya apa yang ia cintai untuk dirinya sendiri.'",
      ),
      ModelHaditsItem(
        number: 6018,
        arab:
            "حَدَّثَنَا قُتَيْبَةُ بْنُ سَعِيدٍ حَدَّثَنَا أَبُو الْأَحْوَصِ عَنْ أَبِي حَصِينٍ عَنْ أَبِي صَالِحٍ عَنْ أَبِي هُرَيْرَةَ قَالَ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ مَنْ كَانَ يُؤْمِنُ بِاللَّهِ وَالْيَوْمِ الْآخِرِ فَلَا يُؤْذِ جَارَهُ وَمَنْ كَانَ يُؤْمِنُ بِاللَّهِ وَالْيَوْمِ الْآخِرِ فَلْيُكْرِمْ ضَيْفَهُ وَمَنْ كَانَ يُؤْمِنُ بِاللَّهِ وَالْيَوْمِ الْآخِرِ فَلْيَقُلْ خَيْرًا أَوْ لِيَصْمُتْ",
        translation:
            "Telah menceritakan kepada kami Qutaibah bin Sa'id, telah menceritakan kepada kami Abu Al Ahwash dari Abu Hashin dari Abu Shalih dari Abu Hurairah berkata, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Barangsiapa beriman kepada Allah dan hari akhir janganlah ia menyakiti tetangganya, dan barangsiapa beriman kepada Allah dan hari akhir hendaklah ia memuliakan tamunya, dan barangsiapa beriman kepada Allah dan hari akhir hendaklah ia berkata yang baik atau diam.'",
      ),
    ],
    'muslim': [
      ModelHaditsItem(
        number: 1,
        arab:
            "حَدَّثَنِي أَبُو خَيْثَمَةَ زُهَيْرُ بْنُ حَرْبٍ حَدَّثَنَا وَكِيعٌ عَنْ كَهْمَسٍ عَنْ عَبْدِ اللَّهِ بْنِ بُرَيْدَةَ عَنْ يَحْيَى بْنِ يَعْمَرَ ح و حَدَّثَنَا عُبَيْدُ اللَّهِ بْنُ مُعَاذٍ الْعَنْبَرِيُّ حَدَّثَنَا أَبِي حَدَّثَنَا كَهْمَسٌ عَنْ ابْنِ بُرَيْدَةَ عَنْ يَحْيَى بْنِ يَعْمَرَ قَالَ كَانَ أَوَّلَ مَنْ قَالَ فِي الْقَدَرِ بِالْبَصْرَةِ مَعْبَدٌ الْجُهَنِيُّ... عَنْ عُمَرَ بْنِ الْخَطَّابِ قَالَ بَيْنَمَا نَحْنُ عِنْدَ رَسُولِ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ ذَاتَ يَوْمٍ إِذْ طَلَعَ عَلَيْنَا رَجُلٌ شَدِيدُ بَيَاضِ الثِّيَابِ شَدِيدُ سَوَادِ الشَّعَرِ لَا يُرَى عَلَيْهِ أَثَرُ السَّفَرِ وَلَا يَعْرِفُهُ مِنَّا أَحَدٌ حَتَّى جَلَسَ إِلَى النَّبِيِّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ فَأَسْنَدَ رُكْبَتَيْهِ إِلَى رُكْبَتَيْهِ وَوَضَعَ كَفَّيْهِ عَلَى فَخِذَيْهِ وَقَالَ يَا مُحَمَّدُ أَخْبِرْنِي عَنْ الْإِسْلَامِ...",
        translation:
            "Telah menceritakan kepadaku Abu Khaitsamah Zuhair bin Harb, telah menceritakan kepada kami Waki' dari Kahmas dari Abdullah bin Buraidah dari Yahya bin Ya'mar... dari Umar bin Al-Khaththab berkata: 'Ketika kami sedang duduk bersama Rasulullah shallallahu 'alaihi wasallam suatu hari, tiba-tiba muncul seorang laki-laki yang berpakaian sangat putih dan berambut sangat hitam, tidak tampak tanda bekas perjalanan dan tidak seorang pun dari kami mengenalnya. Ia duduk di hadapan Nabi shallallahu 'alaihi wasallam seraya menyandarkan kedua lututnya pada kedua lutut beliau dan meletakkan kedua telapak tangannya di atas kedua paha beliau, lalu berkata: Wahai Muhammad, beritahukanlah kepadaku tentang Islam...' (Hadits Jibril tentang Islam, Iman, dan Ihsan).",
      ),
      ModelHaditsItem(
        number: 2564,
        arab:
            "حَدَّثَنَا يَحْيَى بْنُ يَحْيَى التَّمِيمِيُّ وَأَبُو بَكْرِ بْنُ أَبِي شَيْبَةَ وَمُحَمَّدُ بْنُ الْعَلَاءِ الْهَمْدَانِيُّ وَاللَّفْظُ لِيَحْيَى قَالَ يَحْيَى أَخْبَرَنَا و قَالَ الْآخَرَانِ حَدَّثَنَا أَبُو مُعَاوِيَةَ عَنْ الْأَعْمَشِ عَنْ أَبِي صَالِحٍ عَنْ أَبِي هُرَيْرَةَ قَالَ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ مَنْ نَفَّسَ عَنْ مُؤْمِنٍ كُرْبَةً مِنْ كُرَبِ الدُّنْيَا نَفَّسَ اللَّهُ عَنْهُ كُرْبَةً مِنْ كُرَبِ يَوْمِ الْقِيَامَةِ وَمَنْ يَسَّرَ عَلَى مُعْسِرٍ يَسَّرَ اللَّهُ عَلَيْهِ فِي الدُّنْيَا وَالْآخِرَةِ وَمَنْ سَتَرَ مُسْلِمًا سَتَرَهُ اللَّهُ فِي الدُّنْيَا وَالْآخِرَةِ وَاللَّهُ فِي عَوْنِ الْعَبْدِ مَا كَانَ الْعَبْدُ فِي عَوْنِ أَخِيهِ",
        translation:
            "Telah menceritakan kepada kami Yahya bin Yahya At Tamimi dari Abu Hurairah berkata, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Barangsiapa melepaskan kesusahan seorang mukmin dari kesusahan dunia, niscaya Allah melepaskan kesusahannya di hari kiamat. Barangsiapa memudahkan orang yang kesulitan, niscaya Allah memudahkan urusannya di dunia dan akhirat. Barangsiapa menutupi aib seorang muslim, niscaya Allah menutupi aibnya di dunia dan akhirat. Dan Allah senantiasa menolong hamba-Nya selama hamba tersebut menolong saudaranya.'",
      ),
      ModelHaditsItem(
        number: 2699,
        arab:
            "حَدَّثَنَا نَصْرُ بْنُ عَلِيٍّ الْجَهْضَمِيُّ حَدَّثَنَا عَبْدُ اللَّهِ بْنُ دَاوُدَ عَنْ عَاصِمِ بْنِ رَجَاءِ بْنِ حَيْوَةَ عَنْ قَيْسِ بْنِ كَثِيرٍ قَالَ قَدِمَ رَجُلٌ مِنْ الْمَدِينَةِ عَلَى أَبِي الدَّرْدَاءِ... قَالَ سَمِعْتُ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ يَقُولُ مَنْ سَلَكَ طَرِيقًا يَلْتَمِسُ فِيهِ عِلْمًا سَهَّلَ اللَّهُ لَهُ طَرِيقًا إِلَى الْجَنَّةِ",
        translation:
            "Dari Abu Hurairah radliallahu 'anhu, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Barangsiapa menempuh suatu jalan untuk mencari ilmu, maka Allah akan memudahkan baginya jalan menuju surga.'",
      ),
      ModelHaditsItem(
        number: 2865,
        arab:
            "حَدَّثَنَا قُتَيْبَةُ بْنُ سَعِيدٍ حَدَّثَنَا عَبْدُ الْعَزِيزِ يَعْنِي الدَّرَاوَرْدِيَّ عَنْ الْعَلَاءِ عَنْ أَبِيهِ عَنْ أَبِي هُرَيْرَةَ قَالَ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ الدُّنْيَا سِجْنُ الْمُؤْمِنِ وَجَنَّةُ الْكَافِرِ",
        translation:
            "Telah menceritakan kepada kami Qutaibah bin Sa'id dari Abu Hurairah berkata, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Dunia adalah penjara bagi orang mukmin dan surga bagi orang kafir.'",
      ),
    ],
    'abu-dawud': [
      ModelHaditsItem(
        number: 4946,
        arab:
            "حَدَّثَنَا مُسَدَّدٌ حَدَّثَنَا يَحْيَى عَنْ سُفْيَانَ حَدَّثَنِي مَنْصُورٌ عَنْ هِلَالِ بْنِ يَسَافٍ عَنْ أَبِي عُبَيْدَةَ عَنْ عَائِشَةَ قَالَتْ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ إِنَّ مِنْ أَكْمَلِ الْمُؤْمِنِينَ إِيمَانًا أَحْسَنُهُمْ خُلُقًا وَأَلْطَفُهُمْ بِأَهْلِهِ",
        translation:
            "Dari Aisyah radhiallahu 'anha, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Sesungguhnya orang mukmin yang paling sempurna imannya adalah yang paling baik akhlaknya dan yang paling lemah lembut terhadap keluarganya.'",
      ),
      ModelHaditsItem(
        number: 4951,
        arab:
            "حَدَّثَنَا ابْنُ أَبِي خَلَفٍ وَمُحَمَّدُ بْنُ الْمُتَوَكِّلِ الْعَسْقَلَانِيُّ حَدَّثَنَا سُفْيَانُ عَنْ عَمْرٍو عَنْ أَبِي قَابُوسَ عَنْ عَبْدِ اللَّهِ بْنِ عَمْرٍو يَبْلُغُ بِهِ النَّبِيَّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ الرَّاحِمُونَ يَرْحَمُهُمْ الرَّحْمَنُ ارْحَمُوا أَهْلَ الْأَرْضِ يَرْحَمْكُمْ مَنْ فِي السَّمَاءِ",
        translation:
            "Dari Abdullah bin Amr dari Nabi shallallahu 'alaihi wasallam bersabda: 'Orang-orang yang penyayang akan disayang oleh Allah Yang Maha Penyayang. Sayangilah penduduk bumi, niscaya kalian akan disayangi oleh Dzat yang ada di langit.'",
      ),
    ],
    'tirmidzi': [
      ModelHaditsItem(
        number: 1987,
        arab:
            "حَدَّثَنَا مَحْمُودُ بْنُ غَيْلَانَ حَدَّثَنَا أَبُو أَحْمَدَ الزُّبَيْرِيُّ حَدَّثَنَا سُفْيَانُ عَنْ عَلْقَمَةَ بْنِ مَرْثَدٍ عَنْ سُلَيْمَانَ بْنِ بُرَيْدَةَ عَنْ أَبِيهِ قَالَ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ اتَّقِ اللَّهِ حَيْثُمَا كُنْتَ وَأَتْبِعْ السَّيِّئَةَ الْحَسَنَةَ تَمْحُهَا وَخَالِقِ النَّاسَ بِخُلُقٍ حَسَنٍ",
        translation:
            "Dari Abu Dzar dan Mu'adz bin Jabal, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Bertakwalah kepada Allah di mana pun engkau berada, ikutilah perbuatan buruk dengan perbuatan baik niscaya kebaikan itu akan menghapusnya, dan bergaullah dengan sesama manusia dengan akhlak yang baik.'",
      ),
      ModelHaditsItem(
        number: 2518,
        arab:
            "حَدَّثَنَا مَحْمُودُ بْنُ غَيْلَانَ حَدَّثَنَا وَكِيعٌ حَدَّثَنَا سُفْيَانُ عَنْ حَبِيبِ بْنِ أَبِي ثَابِتٍ عَنْ أَبِي وَائِلٍ عَنْ عَمْرِو بْنِ شُرَحْبِيلَ عَنْ عَبْدِ اللَّهِ قَالَ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ دَعْ مَا يَرِيبُكَ إِلَى مَا لَا يَرِيبُكَ",
        translation:
            "Dari Al-Hasan bin Ali radhiallahu 'anhuma berkata, aku menghafal dari Rasulullah shallallahu 'alaihi wasallam sabda beliau: 'Tinggalkanlah apa yang meragukanmu menuju apa yang tidak meragukanmu.'",
      ),
    ],
    'nasai': [
      ModelHaditsItem(
        number: 1,
        arab:
            "أَخْبَرَنَا قُتَيْبَةُ بْنُ سَعِيدٍ قَالَ حَدَّثَنَا سُفْيَانُ عَنْ يَحْيَى بْنِ سَعِيدٍ عَنْ مُحَمَّدِ بْنِ إِبْرَاهِيمَ التَّيْمِيِّ عَنْ عَلْقَمَةَ بْنِ وَقَّاصٍ اللَّيْثِيِّ قَالَ سَمِعْتُ عُمَرَ بْنَ الْخَطَّابِ يَقُولُ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ إِنَّمَا الْأَعْمَالُ بِالنِّيَّةِ",
        translation:
            "Dari Umar bin Al-Khaththab radhiallahu 'anhu berkata, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Sesungguhnya setiap amalan itu bergantung kepada niatnya.'",
      ),
      ModelHaditsItem(
        number: 5005,
        arab:
            "أَخْبَرَنَا مُحَمَّدُ بْنُ عَبْدِ اللَّهِ بْنِ يَزِيدَ الْمُقْرِئُ قَالَ حَدَّثَنَا سُفْيَانُ عَنْ الزُّهْرِيِّ عَنْ سَعِيدٍ عَنْ أَبِي هُرَيْرَةَ عَنْ النَّبِيِّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ قَالَ مَنْ لَا يَرْحَمُ لَا يُرْحَمُ",
        translation:
            "Dari Abu Hurairah radhiallahu 'anhu, Nabi shallallahu 'alaihi wasallam bersabda: 'Barangsiapa tidak menyayangi maka ia tidak akan disayangi.'",
      ),
    ],
    'ibnu-majah': [
      ModelHaditsItem(
        number: 224,
        arab:
            "حَدَّثَنَا هِشَامُ بْنُ عَمَّارٍ حَدَّثَنَا حَفْصُ بْنُ سُلَيْمَانَ حَدَّثَنَا كَثِيرُ بْنُ شِنْظِيرٍ عَنْ مُحَمَّدِ بْنِ سِيرِينَ عَنْ أَنَسِ بْنِ مَالِكٍ قَالَ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ طَلَبُ الْعِلْمِ فَرِيضَةٌ عَلَى كُلِّ مُسْلِمٍ",
        translation:
            "Dari Anas bin Malik radhiallahu 'anhu berkata, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Menuntut ilmu itu wajib bagi setiap muslim.'",
      ),
      ModelHaditsItem(
        number: 4102,
        arab:
            "حَدَّثَنَا أَبُو عُبَيْدَةَ بْنُ أَبِي السَّفَرِ حَدَّثَنَا إِسْحَقُ بْنُ مَنْصُورٍ حَدَّثَنَا هُرَيْمُ بْنُ سُفْيَانَ عَنْ مُجَالِدٍ عَنْ أَبِي الْوَدَّاكِ عَنْ أَبِي سَعِيدٍ الْخُدْرِيِّ قَالَ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ ازْهَدْ فِي الدُّنْيَا يُحِبَّكَ اللَّهُ وَازْهَدْ فِيمَا فِي أَيْدِي النَّاسِ يُحِبَّكَ النَّاسُ",
        translation:
            "Dari Sahl bin Sa'ad As-Sa'idi radhiallahu 'anhu berkata, datang seorang laki-laki kepada Nabi shallallahu 'alaihi wasallam lalu berkata: 'Wahai Rasulullah, tunjukkanlah kepadaku suatu amalan yang apabila aku amalkan niscaya aku dicintai Allah dan dicintai manusia.' Beliau bersabda: 'Zuhudlah terhadap dunia niscaya Allah mencintaimu, dan zuhudlah terhadap apa yang ada di tangan manusia niscaya mereka mencintaimu.'",
      ),
    ],
    'ahmad': [
      ModelHaditsItem(
        number: 1,
        arab:
            "حَدَّثَنَا عَبْدُ اللَّهِ حَدَّثَنِي أَبِي حَدَّثَنَا يَحْيَى بْنُ سَعِيدٍ عَنْ شُعْبَةَ قَالَ حَدَّثَنِي خُبَيْبُ بْنُ عَبْدِ الرَّحْمَنِ عَنْ حَفْصِ بْنِ عَاصِمٍ عَنْ أَبِي هُرَيْرَةَ أَنَّ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ قَالَ كَفَى بِالْمَرْءِ كَذِبًا أَنْ يُحَدِّثَ بِكُلِّ مَا سَمِعَ",
        translation:
            "Dari Abu Hurairah radhiallahu 'anhu, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Cukuplah seseorang dianggap berdusta apabila ia menceritakan setiap apa yang ia dengar.'",
      ),
    ],
    'malik': [
      ModelHaditsItem(
        number: 1,
        arab:
            "حَدَّثَنِي يَحْيَى عَنْ مَالِك عَنْ ابْنِ شِهَابٍ عَنْ أَنَسِ بْنِ مَالِكٍ أَنَّ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ قَالَ تَرَكْتُ فِيكُمْ أَمْرَيْنِ لَنْ تَضِلُّوا مَا تَمَسَّكْتُمْ بِهِمَا كِتَابَ اللَّهِ وَسُنَّةَ نَبِيِّهِ",
        translation:
            "Dari Malik bin Anas berkata, sampai kepadanya bahwa Rasulullah shallallahu 'alaihi wasallam bersabda: 'Aku tinggalkan kepada kalian dua perkara yang kalian tidak akan tersesat selama berpegang teguh kepada keduanya: Kitab Allah (Al-Quran) dan Sunnah Nabi-Nya.'",
      ),
    ],
    'darimi': [
      ModelHaditsItem(
        number: 1,
        arab:
            "أَخْبَرَنَا عَبْدُ اللَّهِ بْنُ صَالِحٍ حَدَّثَنِي اللَّيْثُ حَدَّثَنِي يُونُسُ عَنْ ابْنِ شِهَابٍ عَنْ أَنَسٍ رَضِيَ اللَّهُ عَنْهُ قَالَ قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ يَسِّرُوا وَلَا تُعَسِّرُوا وَبَشِّرُوا وَلَا تُنَفِّرُوا",
        translation:
            "Dari Anas bin Malik radhiallahu 'anhu berkata, Rasulullah shallallahu 'alaihi wasallam bersabda: 'Permudahlah dan jangan mempersulit, berikanlah kabar gembira dan jangan membuat orang lari menjauh.'",
      ),
    ],
  };
}
