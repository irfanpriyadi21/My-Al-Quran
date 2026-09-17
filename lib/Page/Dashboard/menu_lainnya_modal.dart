import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Page/AsmaulHusna/asmaul_husna_page.dart';
import 'package:my_quran/Page/Hijaiyah/belajar_hijaiyah_page.dart';
import 'package:my_quran/Page/Kalender/kalender_hijriah_page.dart';
import 'package:my_quran/Page/KisahNabi/kisah_nabi_page.dart';
import 'package:my_quran/Page/Profile/app_info_page.dart';
import 'package:my_quran/Page/Profile/privacy_policy_page.dart';
import 'package:my_quran/Page/Profile/profile.dart';
import 'package:my_quran/Page/Quotes/quotes_islami_page.dart';
import 'package:my_quran/Page/Shalat/adzan_settings_modal.dart';
import 'package:my_quran/Page/Shalat/tuntunan_sholat_page.dart';
import 'package:my_quran/Page/Sholawat/sholawat_page.dart';
import 'package:my_quran/Page/Tajwid/tajwid_page.dart';
import 'package:my_quran/Page/YasinTahlil/yasin_tahlil_page.dart';
import 'package:my_quran/Provider/app_provider.dart';
import 'package:provider/provider.dart';

class _MoreMenuItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? page;
  final Function(BuildContext context)? action;

  const _MoreMenuItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.page,
    this.action,
  });
}

class MenuLainnyaModal extends StatelessWidget {
  const MenuLainnyaModal({super.key});

  static void show(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => const MenuLainnyaModal(),
    );
  }

  List<_MoreMenuItem> _getMenuItems(AppProvider appProvider) {
    return [
      _MoreMenuItem(
        icon: Icons.history_edu_rounded,
        iconColor: const Color(0xFFE65100),
        title: appProvider.tr('menu_kisah_nabi'),
        page: const KisahNabiPage(),
      ),
      _MoreMenuItem(
        icon: Icons.spellcheck_rounded,
        iconColor: const Color(0xFF00897B),
        title: appProvider.tr('menu_hijaiyah'),
        page: const BelajarHijaiyahPage(),
      ),
      _MoreMenuItem(
        icon: Icons.calendar_month_rounded,
        iconColor: const Color(0xFF673AB7),
        title: appProvider.tr('menu_kalender'),
        page: const KalenderHijriahPage(),
      ),
      _MoreMenuItem(
        icon: Icons.menu_book_rounded,
        iconColor: const Color(0xFF2E7D32),
        title: appProvider.tr('menu_tuntunan_sholat'),
        page: const TuntunanSholatPage(),
      ),
      _MoreMenuItem(
        icon: Icons.record_voice_over_rounded,
        iconColor: const Color(0xFF3F51B5),
        title: appProvider.tr('menu_tajwid'),
        page: const TajwidPage(),
      ),
      _MoreMenuItem(
        icon: Icons.book_outlined,
        iconColor: const Color(0xFFE91E63),
        title: appProvider.tr('menu_yasin_tahlil'),
        page: const YasinTahlilPage(),
      ),
      _MoreMenuItem(
        icon: Icons.favorite_rounded,
        iconColor: const Color(0xFFFF5722),
        title: appProvider.tr('menu_sholawat'),
        page: const SholawatPage(),
      ),
      _MoreMenuItem(
        icon: Icons.format_quote_rounded,
        iconColor: const Color(0xFF8E24AA),
        title: appProvider.tr('menu_quotes'),
        page: const QuotesIslamiPage(),
      ),
      _MoreMenuItem(
        icon: Icons.notifications_active_rounded,
        iconColor: const Color(0xFFFF9800),
        title: appProvider.tr('menu_adzan_settings'),
        action: (ctx) => AdzanSettingsModal.show(ctx),
      ),
      _MoreMenuItem(
        icon: Icons.auto_stories_rounded,
        iconColor: const Color(0xFF00C853),
        title: appProvider.tr('menu_asmaul_husna'),
        page: const AsmaulHusnaPage(),
      ),
      _MoreMenuItem(
        icon: Icons.calculate_rounded,
        iconColor: const Color(0xFF00B0FF),
        title: appProvider.tr('menu_zakat'),
        action: (ctx) => _showZakatCalculatorModal(ctx),
      ),
      _MoreMenuItem(
        icon: Icons.info_outline_rounded,
        iconColor: mainColor,
        title: appProvider.tr('app_info'),
        page: const AppInfoPage(),
      ),
      _MoreMenuItem(
        icon: Icons.privacy_tip_outlined,
        iconColor: const Color(0xFF607D8B),
        title: appProvider.tr('privacy_policy'),
        page: const PrivacyPolicyPage(),
      ),
      _MoreMenuItem(
        icon: Icons.person_rounded,
        iconColor: const Color(0xFF9C27B0),
        title: appProvider.tr('menu_profile_account'),
        page: const Profile(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hijri = HijriCalendar.now();

    return Consumer<AppProvider>(
      builder: (context, appProvider, _) {
        final menuItems = _getMenuItems(appProvider);

        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.88,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 14,
              bottom: MediaQuery.of(context).padding.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle Bar
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

                  // Header Title with close button
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: mainColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.grid_view_rounded,
                          color: mainColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appProvider.tr('more_menus'),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              appProvider.tr('more_menus_subtitle'),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: isDark ? Colors.white60 : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close_rounded,
                          color: isDark ? Colors.white54 : Colors.grey.shade600,
                          size: 22,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Hijri Calendar Quick Banner (Clickable)
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const KalenderHijriahPage()),
                        );
                      },
                      child: Ink(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFB176F2), mainColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: mainColor.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        appProvider.tr('today_hijri_calendar'),
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color:
                                              Colors.white.withValues(alpha: 0.85),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white70,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} H",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Section title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appProvider.tr('menu_list'),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: mainColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "${menuItems.length} ${appProvider.tr('features_count')}",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

              // Grid View for More Menu Items
              Directionality(
                textDirection: TextDirection.ltr,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.76,
                  ),
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return _buildGridMenuItem(
                      context: context,
                      item: item,
                      isDark: isDark,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
      },
    );
  }

  Widget _buildGridMenuItem({
    required BuildContext context,
    required _MoreMenuItem item,
    required bool isDark,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.pop(context);
          if (item.action != null) {
            item.action!(context);
          } else if (item.page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item.page!),
            );
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark
                    ? item.iconColor.withValues(alpha: 0.16)
                    : item.iconColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: item.iconColor
                      .withValues(alpha: isDark ? 0.35 : 0.20),
                  width: 1.2,
                ),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: item.iconColor.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
              ),
              child: Icon(
                item.icon,
                color: item.iconColor,
                size: 26,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white70 : const Color(0xFF424242),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Zakat Calculator Simple Modal ---
  static void _showZakatCalculatorModal(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        double totalZakat = 0;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color:
                            isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    appProvider.tr('zakat_title'),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appProvider.tr('zakat_subtitle'),
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: isDark ? Colors.white60 : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      labelText: appProvider.tr('zakat_input_label'),
                      labelStyle: GoogleFonts.poppins(fontSize: 12),
                      prefixText: "Rp ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (val) {
                      final amount = double.tryParse(
                              val.replaceAll('.', '').replaceAll(',', '')) ??
                          0;
                      setModalState(() {
                        totalZakat = amount * 0.025;
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF282828)
                          : const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appProvider.tr('zakat_obligation'),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: isDark ? Colors.white70 : Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          "Rp ${totalZakat.toStringAsFixed(0)}",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

