import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/model_mosque.dart';
import 'package:my_quran/Page/Masjid/mosque_detail_modal.dart';
import 'package:my_quran/Provider/Masjid/nearby_mosque_provider.dart';
import 'package:provider/provider.dart';

class NearbyMosquePage extends StatefulWidget {
  const NearbyMosquePage({super.key});

  @override
  State<NearbyMosquePage> createState() => _NearbyMosquePageState();
}

class _NearbyMosquePageState extends State<NearbyMosquePage> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NearbyMosqueProvider>(context, listen: false);
      provider.initLocationAndFetch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _focusOnMosque(ModelMosque mosque, NearbyMosqueProvider provider) {
    provider.setSelectedMosque(mosque);
    provider.setViewMode(true); // Switch to map view
    Future.delayed(const Duration(milliseconds: 150), () {
      _mapController.move(LatLng(mosque.lat, mosque.lng), 16.5);
    });
  }

  void _recenterToUser(NearbyMosqueProvider provider) {
    if (provider.userLat != null && provider.userLng != null) {
      _mapController.move(LatLng(provider.userLat!, provider.userLng!), 15.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Masjid Terdekat",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
        centerTitle: true,
        actions: [
          Consumer<NearbyMosqueProvider>(
            builder: (context, provider, _) {
              return Row(
                children: [
                  // Toggle View Mode Button
                  IconButton(
                    icon: Icon(
                      provider.isMapView
                          ? Icons.view_list_rounded
                          : Icons.map_rounded,
                      color: mainColor,
                    ),
                    tooltip: provider.isMapView
                        ? "Tampilan Daftar"
                        : "Tampilan Peta",
                    onPressed: () => provider.toggleViewMode(),
                  ),
                  // Refresh GPS Location Button
                  IconButton(
                    icon: const Icon(
                      Icons.my_location_rounded,
                      color: mainColor,
                    ),
                    tooltip: "Perbarui Lokasi GPS",
                    onPressed: () =>
                        provider.initLocationAndFetch(forceRefresh: true),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<NearbyMosqueProvider>(
        builder: (context, provider, _) {
          // 1. Permission Denied State
          if (provider.isPermissionDenied) {
            return _buildPermissionDeniedView(provider, isDark);
          }

          // 2. GPS Disabled State
          if (provider.isGpsDisabled) {
            return _buildGpsDisabledView(provider, isDark);
          }

          // 3. Initial Loading Location State
          if (provider.isLoadingLocation && provider.userLat == null) {
            return _buildLoadingView("Mendeteksi koordinat GPS Anda...", isDark);
          }

          return Column(
            children: [
              // Header Controls (Search & Radius)
              _buildHeaderControls(provider, isDark, cardColor),

              // Main Content (List View or Map View)
              Expanded(
                child: provider.isLoadingMosques
                    ? _buildLoadingView(
                        "Mencari masjid dalam radius ${(provider.selectedRadius / 1000).toInt()} km...",
                        isDark,
                      )
                    : provider.isMapView
                        ? _buildMapView(provider, isDark, cardColor)
                        : _buildListView(provider, isDark, cardColor),
              ),
            ],
          );
        },
      ),
    );
  }

  // --- Header Filter & Search Widget ---
  Widget _buildHeaderControls(
    NearbyMosqueProvider provider,
    bool isDark,
    Color cardColor,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: cardColor,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: isDark ? Colors.white : Colors.black87,
              ),
              onChanged: (val) => provider.setSearchQuery(val),
              decoration: InputDecoration(
                hintText: "Cari nama masjid atau musholla...",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isDark ? Colors.white38 : Colors.grey.shade500,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: mainColor,
                  size: 20,
                ),
                suffixIcon: provider.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          provider.setSearchQuery('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Radius Selector Chips
          Row(
            children: [
              Text(
                "Radius:",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white60 : Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: provider.availableRadii.map((radius) {
                      final isSelected = provider.selectedRadius == radius;
                      final km = (radius / 1000).toInt();
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => provider.setRadius(radius),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? mainColor
                                  : (isDark
                                      ? const Color(0xFF2A2A2A)
                                      : const Color(0xFFEFEFEF)),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                "$km km",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark
                                          ? Colors.white70
                                          : Colors.black87),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- List View Mode ---
  Widget _buildListView(
    NearbyMosqueProvider provider,
    bool isDark,
    Color cardColor,
  ) {
    final list = provider.mosques;

    if (list.isEmpty) {
      return _buildEmptyMosquesView(provider, isDark);
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          // Results Count Summary
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ditemukan ${list.length} tempat ibadah",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                Text(
                  "Urut: Terdekat",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: mainColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        final mosque = list[index - 1];
        return _buildMosqueCard(mosque, provider, isDark, cardColor);
      },
    );
  }

  // --- Mosque Card Widget ---
  Widget _buildMosqueCard(
    ModelMosque mosque,
    NearbyMosqueProvider provider,
    bool isDark,
    Color cardColor,
  ) {
    final isMusholla = mosque.type == "Musholla";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => MosqueDetailModal.show(context, mosque, provider),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Icon + Title + Distance
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isMusholla
                              ? [const Color(0xFF00B4DB), const Color(0xFF0083B0)]
                              : [const Color(0xFFB176F2), mainColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.mosque_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Name & Type
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: mainColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  mosque.type,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: mainColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "• ${mosque.directionName}",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            mosque.name,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Distance Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C853).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.near_me_rounded,
                            size: 12,
                            color: Color(0xFF00C853),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            mosque.formattedDistance,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF00C853),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Address
                Text(
                  mosque.address,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDark ? Colors.white60 : Colors.grey.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 12),

                // Action Buttons Row
                Row(
                  children: [
                    // Time estimate chip
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.directions_walk_rounded,
                            size: 14,
                            color: isDark ? Colors.white60 : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              mosque.estimatedWalkingTime,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: isDark
                                    ? Colors.white60
                                    : Colors.grey.shade600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // View on Map Button
                    OutlinedButton.icon(
                      onPressed: () => _focusOnMosque(mosque, provider),
                      icon: const Icon(Icons.map_outlined, size: 14),
                      label: const Text("Peta"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: mainColor,
                        side: BorderSide(color: mainColor.withOpacity(0.4)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Navigation Route Button
                    ElevatedButton.icon(
                      onPressed: () => provider.openNavigation(mosque),
                      icon: const Icon(
                        Icons.directions_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                      label: const Text("Rute"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Interactive Map View Mode (`flutter_map`) ---
  Widget _buildMapView(
    NearbyMosqueProvider provider,
    bool isDark,
    Color cardColor,
  ) {
    final userPos = LatLng(
      provider.userLat ?? -6.175392,
      provider.userLng ?? 106.827153,
    );
    final mosques = provider.mosques;

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: userPos,
            initialZoom: 15.0,
            minZoom: 5.0,
            maxZoom: 18.0,
            onTap: (tapPosition, point) {
              provider.setSelectedMosque(null);
            },
          ),
          children: [
            // OpenStreetMap Standard Tiles
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.my_quran',
            ),

            // Markers Layer
            MarkerLayer(
              markers: [
                // 1. User Position Marker
                Marker(
                  point: userPos,
                  width: 50,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: mainColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // 2. Mosque Markers
                ...mosques.map((m) {
                  final isSelected = provider.selectedMosque?.id == m.id;
                  final isMusholla = m.type == "Musholla";

                  return Marker(
                    point: LatLng(m.lat, m.lng),
                    width: isSelected ? 48 : 38,
                    height: isSelected ? 48 : 38,
                    child: GestureDetector(
                      onTap: () {
                        provider.setSelectedMosque(m);
                        _mapController.move(LatLng(m.lat, m.lng), 16.5);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isMusholla
                                ? [const Color(0xFF00B4DB), const Color(0xFF0083B0)]
                                : [const Color(0xFFB176F2), mainColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? const Color(0xFFFFD700) : Colors.white,
                            width: isSelected ? 3 : 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? const Color(0xFFFFD700).withOpacity(0.5)
                                  : Colors.black38,
                              blurRadius: isSelected ? 8 : 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.mosque_rounded,
                            color: Colors.white,
                            size: isSelected ? 24 : 18,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),

        // Floating Map Controls (Zoom In/Out, Recenter)
        Positioned(
          right: 16,
          top: 16,
          child: Column(
            children: [
              _buildMapActionButton(
                icon: Icons.my_location_rounded,
                tooltip: "Pusatkan Lokasi Saya",
                isDark: isDark,
                cardColor: cardColor,
                onTap: () => _recenterToUser(provider),
              ),
              const SizedBox(height: 8),
              _buildMapActionButton(
                icon: Icons.add_rounded,
                tooltip: "Perbesar",
                isDark: isDark,
                cardColor: cardColor,
                onTap: () {
                  final zoom = _mapController.camera.zoom + 1;
                  _mapController.move(_mapController.camera.center, zoom);
                },
              ),
              const SizedBox(height: 8),
              _buildMapActionButton(
                icon: Icons.remove_rounded,
                tooltip: "Perkecil",
                isDark: isDark,
                cardColor: cardColor,
                onTap: () {
                  final zoom = _mapController.camera.zoom - 1;
                  _mapController.move(_mapController.camera.center, zoom);
                },
              ),
            ],
          ),
        ),

        // Selected Mosque Floating Preview Card
        if (provider.selectedMosque != null)
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: _buildFloatingMosquePreview(
              provider.selectedMosque!,
              provider,
              isDark,
              cardColor,
            ),
          ),
      ],
    );
  }

  Widget _buildMapActionButton({
    required IconData icon,
    required String tooltip,
    required bool isDark,
    required Color cardColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.4)
                : Colors.black.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: mainColor, size: 20),
        tooltip: tooltip,
        onPressed: onTap,
        constraints: const BoxConstraints(minWidth: 42, minHeight: 42),
      ),
    );
  }

  // --- Floating Mosque Preview Card on Map ---
  Widget _buildFloatingMosquePreview(
    ModelMosque mosque,
    NearbyMosqueProvider provider,
    bool isDark,
    Color cardColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.5)
                : Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: mainColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            mosque.type,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: mainColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00C853).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            mosque.formattedDistance,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF00C853),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mosque.name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 20),
                onPressed: () => provider.setSelectedMosque(null),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            mosque.address,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: isDark ? Colors.white60 : Colors.grey.shade600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      MosqueDetailModal.show(context, mosque, provider),
                  icon: const Icon(Icons.info_outline_rounded, size: 14),
                  label: const Text("Detail"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: mainColor,
                    side: BorderSide(color: mainColor.withOpacity(0.4)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => provider.openNavigation(mosque),
                  icon: const Icon(
                    Icons.directions_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                  label: const Text("Rute Arah"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Helper State Views ---

  Widget _buildLoadingView(String message, bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SpinKitFadingCircle(color: mainColor, size: 45),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyMosquesView(NearbyMosqueProvider provider, bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: mainColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mosque_rounded,
                size: 50,
                color: mainColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Tidak Ada Masjid Ditemukan",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              provider.searchQuery.isNotEmpty
                  ? "Tidak ada hasil untuk \"${provider.searchQuery}\". Coba kata kunci lain."
                  : "Tidak ditemukan masjid dalam radius ${(provider.selectedRadius / 1000).toInt()} km. Coba perbesar radius pencarian.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDark ? Colors.white60 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: () {
                provider.setRadius(10000.0); // Expand to 10 km
              },
              icon: const Icon(Icons.radar_rounded, color: Colors.white, size: 16),
              label: const Text("Perbesar Radius ke 10 km"),
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionDeniedView(
    NearbyMosqueProvider provider,
    bool isDark,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_off_rounded,
                size: 50,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Izin Lokasi Diperlukan",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Aplikasi membutuhkan izin akses lokasi untuk mencari masjid dan musholla terdekat di sekitar Anda secara akurat.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDark ? Colors.white60 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () =>
                  provider.initLocationAndFetch(forceRefresh: true),
              icon: const Icon(Icons.check_rounded, color: Colors.white),
              label: const Text("Beri Izin Lokasi"),
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => provider.openAppSettings(),
              child: Text(
                "Buka Pengaturan Aplikasi",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: mainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGpsDisabledView(NearbyMosqueProvider provider, bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.gps_off_rounded,
                size: 50,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Layanan GPS Tidak Aktif",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Mohon aktifkan sensor lokasi (GPS) pada perangkat Anda untuk mendeteksi posisi secara tepat.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDark ? Colors.white60 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => provider.openLocationSettings(),
              icon: const Icon(Icons.settings_rounded, color: Colors.white),
              label: const Text("Aktifkan GPS di Pengaturan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () =>
                  provider.initLocationAndFetch(forceRefresh: true),
              child: Text(
                "Coba Lagi",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: mainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
