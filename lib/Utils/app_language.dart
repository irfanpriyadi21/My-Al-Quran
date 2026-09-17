class AppLanguageItem {
  final String code;
  final String name;
  final String nativeName;
  final String description;
  final String flag;

  const AppLanguageItem({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.description,
    required this.flag,
  });
}

class AppLanguage {
  static const List<AppLanguageItem> supportedLanguages = [
    AppLanguageItem(
      code: 'id',
      name: 'Bahasa Indonesia',
      nativeName: 'Bahasa Indonesia',
      description: 'Bahasa utama aplikasi',
      flag: '🇮🇩',
    ),
    AppLanguageItem(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      description: 'Application language in English',
      flag: '🇬🇧',
    ),
    AppLanguageItem(
      code: 'ar',
      name: 'Bahasa Arab',
      nativeName: 'العربية',
      description: 'اللغة العربية للتطبيق',
      flag: '🇸🇦',
    ),
  ];

  static AppLanguageItem getLanguageItem(String code) {
    return supportedLanguages.firstWhere(
      (lang) => lang.code == code,
      orElse: () => supportedLanguages.first,
    );
  }

  static String getLanguageName(String code) {
    return getLanguageItem(code).name;
  }

  static String getLanguageNativeName(String code) {
    return getLanguageItem(code).nativeName;
  }

  static final Map<String, Map<String, String>> _translations = {
    'id': {
      // Profile
      'profile': 'Profile',
      'user_default': 'Pengguna',
      'app_info': 'Tentang Aplikasi',
      'privacy_policy': 'Privacy Policy',
      'dark_mode': 'Dark Mode',
      'language_settings': 'Pengaturan Bahasa',
      'language_subtitle': 'Pilih bahasa tampilan aplikasi',
      'logout': 'Logout',
      'logout_confirm': 'Apakah Anda Yakin Ingin Logout ?',
      'yes': 'Oke!',
      'cancel': 'Cancel',
      'select_language': 'Pilih Bahasa',
      'language_changed_toast': 'Bahasa berhasil diubah ke',
      'save_and_close': 'Selesai & Simpan',

      // Navigation
      'nav_dashboard': 'Dashboard',
      'nav_profile': 'Profile',

      // Dashboard Header & Content
      'greeting_hi': 'Hi,',
      'app_title': 'My Alquran Mobile App',
      'read_quran_easily': 'Baca Al-Quran Dengan Mudah',
      'menu': 'Menu',
      'islamic_quotes': 'Kata Mutiara Islami',
      'islamic_news': 'Berita & Informasi Islam',
      'view_all': 'Lihat Semua',

      // Main Menus
      'menu_alquran': 'Al-Quran',
      'menu_doa': 'Doa Harian',
      'menu_kiblat': 'Kiblat',
      'menu_hadits': 'Hadits',
      'menu_shalat': 'Jadwal Shalat',
      'menu_dzikir': 'Dzikir',
      'menu_masjid': 'Masjid Terdekat',
      'menu_other': 'Lainnya',

      // Menu Lainnya Modal
      'more_menus': 'Menu Lainnya',
      'more_menus_subtitle': 'Fitur tambahan & perlengkapan ibadah',
      'today_hijri_calendar': 'Kalender Hijriyah Hari Ini',
      'menu_list': 'Daftar Menu',
      'features_count': 'Fitur',
      'menu_kisah_nabi': 'Kisah 25 Nabi',
      'menu_hijaiyah': 'Huruf Hijaiyah',
      'menu_kalender': 'Kalender Hijriah',
      'menu_tuntunan_sholat': 'Tuntunan Sholat',
      'menu_tajwid': 'Ilmu Tajwid',
      'menu_yasin_tahlil': 'Yasin & Tahlil',
      'menu_sholawat': 'Kumpulan Shalawat',
      'menu_quotes': 'Quotes Islami',
      'menu_adzan_settings': 'Pengaturan Adzan',
      'menu_asmaul_husna': '99 Asmaul Husna',
      'menu_zakat': 'Kalkulator Zakat',
      'menu_profile_account': 'Profil & Akun',

      // Doa Harian Page
      'doa_copied': 'Doa berhasil disalin ke clipboard',
      'doa_search_hint': 'Cari doa harian (contoh: makan, tidur)...',
      'doa_not_found': 'Doa tidak ditemukan',
      'doa_available': 'Doa Tersedia',
      'doa_banner_title': 'Doa Sehari-hari',
      'doa_banner_sub': 'Kumpulan Doa Pilihan',
      'try_again': 'Coba Lagi',

      // Hadits Pages
      'hadits_title': 'Kitab Hadits',
      'hadits_banner_sub': 'Kutubut Tis\'ah',
      'hadits_banner_title': '9 Kitab Hadits',
      'hadits_total_count': 'Total Hadits',
      'hadits_top_narrators': '9 Perawi Terkemuka',
      'hadits_search_narrator_hint': 'Cari nama perawi hadits (contoh: Bukhari, Muslim)...',
      'hadits_not_found': 'Kitab hadits tidak ditemukan',
      'hadits_item_not_found': 'Hadits tidak ditemukan',
      'hadits_search_number_hint': 'Cari nomor hadits atau kata kunci...',
      'hadits_number_label': 'Hadits No.',
      'hadits_meaning': 'Artinya:',
      'hadits_copied': 'Hadits berhasil disalin ke clipboard',
      'hadits_share_footer': '(Dibagikan dari Aplikasi My Alquran Mobile App)',
      'offline_mode_badge': 'Mode Offline',
    },
    'en': {
      // Profile
      'profile': 'Profile',
      'user_default': 'User',
      'app_info': 'About Application',
      'privacy_policy': 'Privacy Policy',
      'dark_mode': 'Dark Mode',
      'language_settings': 'Language Settings',
      'language_subtitle': 'Choose app display language',
      'logout': 'Logout',
      'logout_confirm': 'Are you sure you want to log out?',
      'yes': 'OK!',
      'cancel': 'Cancel',
      'select_language': 'Select Language',
      'language_changed_toast': 'Language successfully changed to',
      'save_and_close': 'Save & Close',

      // Navigation
      'nav_dashboard': 'Dashboard',
      'nav_profile': 'Profile',

      // Dashboard Header & Content
      'greeting_hi': 'Hi,',
      'app_title': 'My Alquran Mobile App',
      'read_quran_easily': 'Read Al-Quran with Ease',
      'menu': 'Menu',
      'islamic_quotes': 'Islamic Quotes',
      'islamic_news': 'Islamic News & Info',
      'view_all': 'View All',

      // Main Menus
      'menu_alquran': 'Al-Quran',
      'menu_doa': 'Daily Prayers',
      'menu_kiblat': 'Qibla',
      'menu_hadits': 'Hadith',
      'menu_shalat': 'Prayer Times',
      'menu_dzikir': 'Dhikr',
      'menu_masjid': 'Nearby Mosque',
      'menu_other': 'More',

      // Menu Lainnya Modal
      'more_menus': 'More Menus',
      'more_menus_subtitle': 'Additional features & worship utilities',
      'today_hijri_calendar': 'Today\'s Hijri Calendar',
      'menu_list': 'Menu List',
      'features_count': 'Features',
      'menu_kisah_nabi': '25 Prophets Stories',
      'menu_hijaiyah': 'Hijaiyah Letters',
      'menu_kalender': 'Hijri Calendar',
      'menu_tuntunan_sholat': 'Prayer Guide',
      'menu_tajwid': 'Tajweed Rules',
      'menu_yasin_tahlil': 'Yasin & Tahlil',
      'menu_sholawat': 'Shalawat Collection',
      'menu_quotes': 'Islamic Quotes',
      'menu_adzan_settings': 'Adhan Settings',
      'menu_asmaul_husna': '99 Asmaul Husna',
      'menu_zakat': 'Zakat Calculator',
      'menu_profile_account': 'Profile & Account',

      // Zakat modal
      'zakat_title': 'Zakat Maal Calculator (2.5%)',
      'zakat_subtitle': 'Zakat nisab is equivalent to 85 grams of gold per year.',
      'zakat_input_label': 'Total Assets / Savings (Rp)',
      'zakat_obligation': 'Zakat Obligation (2.5%):',

      // Doa Harian Page
      'doa_copied': 'Prayer copied to clipboard',
      'doa_search_hint': 'Search daily prayers...',
      'doa_not_found': 'Prayer not found',
      'doa_available': 'Prayers Available',
      'doa_banner_title': 'Daily Prayers',
      'doa_banner_sub': 'Selected Collection of Prayers',
      'try_again': 'Try Again',

      // Hadits Pages
      'hadits_title': 'Hadith Books',
      'hadits_banner_sub': 'Kutubut Tis\'ah',
      'hadits_banner_title': '9 Hadith Books',
      'hadits_total_count': 'Total Hadiths',
      'hadits_top_narrators': '9 Prominent Narrators',
      'hadits_search_narrator_hint': 'Search narrator (e.g. Bukhari, Muslim)...',
      'hadits_not_found': 'Hadith book not found',
      'hadits_item_not_found': 'Hadith not found',
      'hadits_search_number_hint': 'Search hadith number or keyword...',
      'hadits_number_label': 'Hadith No.',
      'hadits_meaning': 'Meaning:',
      'hadits_copied': 'Hadith copied to clipboard',
      'hadits_share_footer': '(Shared from My Alquran Mobile App)',
      'offline_mode_badge': 'Offline Mode',
    },
    'ar': {
      // Profile
      'profile': 'الملف الشخصي',
      'user_default': 'المستخدم',
      'app_info': 'عن التطبيق',
      'privacy_policy': 'سياسة الخصوصية',
      'dark_mode': 'الوضع الداكن',
      'language_settings': 'إعدادات اللغة',
      'language_subtitle': 'اختر لغة عرض التطبيق',
      'logout': 'تسجيل الخروج',
      'logout_confirm': 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
      'yes': 'نعم!',
      'cancel': 'إلغاء',
      'select_language': 'اختر اللغة',
      'language_changed_toast': 'تم تغيير اللغة بنجاح إلى',
      'save_and_close': 'حفظ وإغلاق',

      // Navigation
      'nav_dashboard': 'الرئيسية',
      'nav_profile': 'الملف الشخصي',

      // Dashboard Header & Content
      'greeting_hi': 'مرحباً،',
      'app_title': 'تطبيق القرآن الكريم',
      'read_quran_easily': 'اقرأ القرآن الكريم بكل سهولة',
      'menu': 'القائمة',
      'islamic_quotes': 'حكم واقتباسات إسلامية',
      'islamic_news': 'الأخبار والمعلومات الإسلامية',
      'view_all': 'عرض الكل',

      // Main Menus
      'menu_alquran': 'القرآن الكريم',
      'menu_doa': 'الأدعية اليومية',
      'menu_kiblat': 'اتجاه القبلة',
      'menu_hadits': 'الحديث النبوي',
      'menu_shalat': 'مواقيت الصلاة',
      'menu_dzikir': 'الأذكار والتسبيح',
      'menu_masjid': 'المساجد القريبة',
      'menu_other': 'المزيد',

      // Menu Lainnya Modal
      'more_menus': 'المزيد من القوائم',
      'more_menus_subtitle': 'خدمات وأدوات إسلامية إضافية',
      'today_hijri_calendar': 'التقويم الهجري اليوم',
      'menu_list': 'قائمة الميزات',
      'features_count': 'ميزات',
      'menu_kisah_nabi': 'قصص الأنبياء',
      'menu_hijaiyah': 'الحروف الهجائية',
      'menu_kalender': 'التقويم الهجري',
      'menu_tuntunan_sholat': 'دليل الصلاة',
      'menu_tajwid': 'أحكام التجويد',
      'menu_yasin_tahlil': 'يس والتهليل',
      'menu_sholawat': 'مجموعة الصلوات',
      'menu_quotes': 'اقتباسات إسلامية',
      'menu_adzan_settings': 'إعدادات الأذان',
      'menu_asmaul_husna': 'أسماء الله الحسنى',
      'menu_zakat': 'حاسبة الزكاة',
      'menu_profile_account': 'الملف والحساب',

      // Zakat modal
      'zakat_title': 'حاسبة زكاة المال (2.5%)',
      'zakat_subtitle': 'نصاب الزكاة يعادل 85 غراماً من الذهب سنوياً.',
      'zakat_input_label': 'إجمالي الأموال والمدخرات',
      'zakat_obligation': 'مقدار الزكاة الواجبة (2.5%):',

      // Doa Harian Page
      'doa_copied': 'تم نسخ الدعاء إلى الحافظة',
      'doa_search_hint': 'ابحث في الأدعية اليومية...',
      'doa_not_found': 'لم يتم العثور على الدعاء',
      'doa_available': 'دعاء متوفر',
      'doa_banner_title': 'الأدعية اليومية',
      'doa_banner_sub': 'مجموعة الأدعية المختارة',
      'try_again': 'إعادة المحاولة',

      // Hadits Pages
      'hadits_title': 'كتب الحديث النبوي',
      'hadits_banner_sub': 'الكتب التسعة',
      'hadits_banner_title': '٩ كتب حديث معتمدة',
      'hadits_total_count': 'إجمالي الأحاديث',
      'hadits_top_narrators': '٩ رواة معتمدين',
      'hadits_search_narrator_hint': 'ابحث عن الراوي (مثل: البخاري، مسلم)...',
      'hadits_not_found': 'لم يتم العثور على كتاب الحديث',
      'hadits_item_not_found': 'لم يتم العثور على الحديث',
      'hadits_search_number_hint': 'ابحث برقم الحديث أو الكلمات...',
      'hadits_number_label': 'حديث رقم',
      'hadits_meaning': 'المعنى والترجمة:',
      'hadits_copied': 'تم نسخ الحديث إلى الحافظة',
      'hadits_share_footer': '(تمت المشاركة من تطبيق القرآن الكريم)',
      'offline_mode_badge': 'الوضع غير المتصل',
    },
  };

  static String getText(String key, String languageCode) {
    final langMap = _translations[languageCode] ?? _translations['id']!;
    return langMap[key] ?? _translations['id']?[key] ?? key;
  }
}
