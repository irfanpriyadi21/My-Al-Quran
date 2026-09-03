import 'package:my_quran/Model/ModelDetailArtikel.dart';
import 'package:my_quran/Model/ModelListArtikel.dart' as list_model;

class DefaultArticlesData {
  static final List<Map<String, dynamic>> rawArticles = [
    {
      "id": "keutamaan-membaca-alquran",
      "title": "Keutamaan dan Pahala Membaca Al-Qur'an Setiap Hari",
      "author": "Redaksi Islami",
      "author_link": "",
      "date": "03 September 2026",
      "date_time": "2026-09-03",
      "thumbnail":
          "https://images.unsplash.com/photo-1609599006353-e629aaabfeae?auto=format&fit=crop&w=800&q=80",
      "type": "Nasehat",
      "categories": [
        {"name": "Al-Qur'an", "url": ""},
        {"name": "Ibadah", "url": ""}
      ],
      "content_html": """
        <p>Membaca Al-Qur'an adalah salah satu amalan paling mulia di sisi Allah SWT. Setiap huruf yang dibaca mengandung sepuluh kebaikan sebagaimana sabda Rasulullah SAW:</p>
        <blockquote><em>"Barangsiapa yang membaca satu huruf dari Kitabullah, maka baginya satu kebaikan, dan satu kebaikan dilipatgandakan menjadi sepuluh kali lipat semisalnya."</em> (HR. Tirmidzi)</blockquote>
        <h3>1. Memberi Syafa'at di Hari Kiamat</h3>
        <p>Al-Qur'an akan datang pada hari kiamat sebagai pemberi syafa'at bagi orang-orang yang senantiasa membacanya di dunia. Rasulullah SAW bersabda:</p>
        <p><em>"Bacalah Al-Qur'an, sesungguhnya ia akan datang pada hari kiamat sebagai pemberi syafa'at bagi para pembacanya."</em> (HR. Muslim)</p>
        <h3>2. Menentramkan Hati dan Jiwa</h3>
        <p>Di tengah kesibukan dan kegelisahan hidup, membaca dan merenungi ayat-ayat suci Al-Qur'an adalah obat penenang hati yang paling utama.</p>
        <p>Sebagaimana firman Allah SWT: <strong>"Ingatlah, hanya dengan mengingat Allah hati menjadi tenteram."</strong> (QS. Ar-Ra'd: 28)</p>
        <h3>3. Diangkat Derajatnya oleh Allah</h3>
        <p>Allah SWT akan mengangkat derajat suatu kaum dengan Al-Qur'an ini dan merendahkan kaum yang lain jika meninggalkannya.</p>
      """
    },
    {
      "id": "keutamaan-shalat-berjamaah",
      "title": "Fadhilah Shalat Berjamaah dan Adab di Masjid",
      "author": "Ustadz Abdullah",
      "author_link": "",
      "date": "01 September 2026",
      "date_time": "2026-09-01",
      "thumbnail":
          "https://images.unsplash.com/photo-1564769625905-50e93615e769?auto=format&fit=crop&w=800&q=80",
      "type": "Fikih & Ibadah",
      "categories": [
        {"name": "Shalat", "url": ""},
        {"name": "Masjid", "url": ""}
      ],
      "content_html": """
        <p>Shalat fardhu berjamaah di masjid memiliki keutamaan yang sangat besar dibandingkan shalat sendirian di rumah, khususnya bagi kaum laki-laki.</p>
        <h3>Pahala 27 Derajat</h3>
        <p>Rasulullah SAW bersabda: <em>"Shalat berjamaah lebih utama daripada shalat sendirian sebanyak dua puluh tujuh derajat."</em> (HR. Bukhari & Muslim)</p>
        <h3>Adab Ketika Menuju ke Masjid</h3>
        <ul>
          <li>Berwudhu dengan sempurna dari rumah.</li>
          <li>Berjalan dengan tenang dan tidak tergesa-gesa.</li>
          <li>Membaca doa masuk masjid dengan mendahulukan kaki kanan.</li>
          <li>Melaksanakan shalat sunnah Tahiyyatul Masjid 2 rakaat.</li>
        </ul>
      """
    },
    {
      "id": "adab-berdoa-yang-mustajab",
      "title": "Rahasia dan Waktu-Waktu Mustajab untuk Berdoa",
      "author": "Tim Dakwah",
      "author_link": "",
      "date": "28 Agustus 2026",
      "date_time": "2026-08-28",
      "thumbnail":
          "https://images.unsplash.com/photo-1591604466107-ec97de577aff?auto=format&fit=crop&w=800&q=80",
      "type": "Doa & Dzikir",
      "categories": [
        {"name": "Doa", "url": ""},
        {"name": "Adab", "url": ""}
      ],
      "content_html": """
        <p>Doa adalah senjata bagi orang-orang yang beriman (*silahul mukmin*). Agar doa kita lebih didengar dan dikabulkan oleh Allah SWT, kita perlu memperhatikan adab dan waktu-waktu terbaik untuk memanjatkan doa.</p>
        <h3>Waktu-Waktu yang Sangat Mustajab:</h3>
        <ul>
          <li><strong>Antara Adzan dan Iqamah:</strong> Doa pada waktu ini tidak tertolak sebagaimana sabda Rasulullah SAW.</li>
          <li><strong>Sepertiga Malam Terakhir:</strong> Saat Allah SWT turun ke langit dunia dan mengabulkan permintaan hamba-Nya.</li>
          <li><strong>Saat Sujud dalam Shalat:</strong> Posisi terdekat seorang hamba dengan Tuhannya.</li>
          <li><strong>Ketika Turun Hujan:</strong> Waktu diturunkannya rahmat dan berkah dari langit.</li>
          <li><strong>Hari Jumat setelah Ashar hingga Maghrib:</strong> Terdapat satu waktu saat doa pasti diijabah.</li>
        </ul>
      """
    },
    {
      "id": "tips-istiqamah-dalam-kebaikan",
      "title": "Tips Menjaga Keistiqamahan Ibadah dalam Kehidupan Sehari-hari",
      "author": "Konsultasi Syariah",
      "author_link": "",
      "date": "24 Agustus 2026",
      "date_time": "2026-08-24",
      "thumbnail":
          "https://images.unsplash.com/photo-1542816417-0983c9c9ad53?auto=format&fit=crop&w=800&q=80",
      "type": "Nasehat",
      "categories": [
        {"name": "Akhlak", "url": ""},
        {"name": "Tazkiyatun Nafs", "url": ""}
      ],
      "content_html": """
        <p>Istiqamah adalah amalan yang dicintai Allah SWT meskipun jumlah amalannya sedikit. Rasulullah SAW bersabda:</p>
        <blockquote><em>"Amalan yang paling dicintai oleh Allah adalah amalan yang berkelanjutan (kontinu) walaupun sedikit."</em> (HR. Muslim)</blockquote>
        <h3>Langkah Praktis Menjaga Istiqamah:</h3>
        <p>1. <strong>Niat yang Ikhlas:</strong> Pastikan setiap amalan semata-mata mengharap ridha Allah.</p>
        <p>2. <strong>Mulai dari yang Ringan:</strong> Buat target harian yang realistis, misalnya membaca 1 halaman Al-Qur'an setiap selesai shalat Subuh.</p>
        <p>3. <strong>Mencari Lingkungan yang Saleh:</strong> Berkumpul dengan teman-teman yang saling mengingatkan dalam kebaikan.</p>
        <p>4. <strong>Senantiasa Berdoa:</strong> Memohon ketetapan hati kepada Allah dengan doa: <em>"Yaa Muqallibal qulub, tsabbit qalbi 'ala diinik."</em></p>
      """
    }
  ];

  static List<list_model.ModelListArtikel> getListArtikel() {
    return rawArticles.map((json) {
      return list_model.ModelListArtikel(
        id: json['id'],
        title: json['title'],
        date: json['date'],
        dateTime: json['date_time'],
        thumbnail: json['thumbnail'],
        type: json['type'],
        categories: (json['categories'] as List<dynamic>?)
            ?.map((c) => list_model.Categories(name: c['name'], url: c['url']))
            .toList(),
      );
    }).toList();
  }

  static ModelDetailArtikel getDetailArtikel(String id) {
    final found = rawArticles.firstWhere(
      (item) => item['id'] == id,
      orElse: () => rawArticles.first,
    );

    return ModelDetailArtikel(
      success: true,
      message: "success",
      data: Data(
        id: found['id'],
        title: found['title'],
        author: found['author'],
        authorLink: found['author_link'],
        date: found['date'],
        dateTime: found['date_time'],
        thumbnail: found['thumbnail'],
        contentHtml: found['content_html'],
        type: found['type'],
        categories: (found['categories'] as List<dynamic>?)
            ?.map((c) => Categories(name: c['name'], url: c['url']))
            .toList(),
      ),
    );
  }
}
