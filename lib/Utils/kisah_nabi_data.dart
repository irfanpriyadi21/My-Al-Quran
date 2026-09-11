class ModelKisahNabi {
  final int number;
  final String name;
  final String arabicName;
  final String era;
  final String age;
  final String place;
  final String kaum;
  final bool isUlulAzmi;
  final List<String> mukjizat;
  final String summary;
  final String story;
  final List<String> hikmah;
  final String quranVerses;
  final int mentionCountInQuran;

  const ModelKisahNabi({
    required this.number,
    required this.name,
    required this.arabicName,
    required this.era,
    required this.age,
    required this.place,
    required this.kaum,
    required this.isUlulAzmi,
    required this.mukjizat,
    required this.summary,
    required this.story,
    required this.hikmah,
    required this.quranVerses,
    required this.mentionCountInQuran,
  });
}

class KisahNabiData {
  static const List<ModelKisahNabi> list = [
    ModelKisahNabi(
      number: 1,
      name: 'Nabi Adam AS',
      arabicName: 'آدَمُ عَلَيْهِ ٱلسَّلَامُ',
      era: '5872 - 4942 SM',
      age: '930 Tahun',
      place: 'Surga lalu diturunkan ke Bumi (Jazirah Arab / India)',
      kaum: 'Bani Adam (Umat Pertama)',
      isUlulAzmi: false,
      mukjizat: [
        'Manusia pertama yang diciptakan langsung oleh Allah dari tanah liat',
        'Diajarkan langsung oleh Allah seluruh nama-nama benda di alam semesta',
        'Malaikat diperintahkan bersujud (penghormatan) kepadanya',
        'Tinggi badan mencapai 60 hasta (sekitar 30 meter)',
      ],
      summary: 'Manusia dan Nabi pertama di muka bumi, bapak umat manusia (Abul Basyar) yang diciptakan Allah dari tanah.',
      story: 'Nabi Adam AS diciptakan oleh Allah SWT dari sari pati tanah liat kering. Allah meniupkan ruh ciptaan-Nya dan mengajarkan kepada Nabi Adam nama-nama segala benda yang belum diketahui oleh para malaikat.\n\n'
          'Ketika para malaikat diperintahkan untuk bersujud hormat kepada Adam, seluruh malaikat taat, kecuali Iblis yang sombong karena merasa dirinya lebih mulia (diciptakan dari api). Iblis pun dikutuk dan diusir dari surga.\n\n'
          'Allah kemudian menciptakan Siti Hawa sebagai pasangan Nabi Adam. Mereka tinggal di surga dengan segala kenikmatan, namun diperingatkan agar tidak mendekati satu pohon terlarang (Khuldi). Iblis yang menyimpan dendam berhasil memperdaya mereka hingga memakan buah pohon tersebut.\n\n'
          'Setelah menyadari kekhilafannya, Nabi Adam dan Hawa bertaubat dengan sungguh-sungguh membaca doa: "Rabbana zhalamna anfusana wa il-lam taghfir lana wa tarhamna lanakuunanna minal khasirin." Allah menerima taubat mereka dan menurunkan keduanya ke bumi untuk menjadi khalifah.',
      hikmah: [
        'Kewajiban segera bertaubat dan mengakui kesalahan ketika berbuat khilaf.',
        'Waspada terhadap tipu daya Iblis yang selalu berusaha menjerumuskan manusia.',
        'Sombong dan iri hati adalah dosa pertama yang mencelakakan Iblis.',
      ],
      quranVerses: 'QS. Al-Baqarah: 30-39, Al-A\'raf: 11-25, Thaha: 115-123',
      mentionCountInQuran: 25,
    ),
    ModelKisahNabi(
      number: 2,
      name: 'Nabi Idris AS',
      arabicName: 'إِدْرِيسُ عَلَيْهِ ٱلسَّلَامُ',
      era: '4533 - 4188 SM',
      age: '345 Tahun',
      place: 'Babilonia (Irak) & Mesir (Memphis)',
      kaum: 'Bani Qabil & Keturunan Adam',
      isUlulAzmi: false,
      mukjizat: [
        'Manusia pertama yang pandai menulis dengan pena (kalam)',
        'Manusia pertama yang pandai menjahit dan mengenakan pakaian berjahit',
        'Menguasai ilmu astronomi, falaq, matematika, dan ilmu perbintangan',
        'Diangkat oleh Allah ke tempat yang tinggi (langit) dalam keadaan hidup',
      ],
      summary: 'Nabi yang sangat tekun belajar, perintis ilmu tulis-menulis dan menjahit pakaian pertama di dunia.',
      story: 'Nabi Idris AS adalah keturunan keenam dari Nabi Adam AS. Nama aslinya adalah Khanukh (Akhnukh), namun dinamai Idris karena ketekunan beliau yang luar biasa dalam mempelajari lembaran-lembaran ajaran Allah (Daras).\n\n'
          'Beliau diutus kepada kaumnya di Babilonia yang saat itu mulai terjerumus dalam penyembahan berhala dan kerusakan moral keturunan Qabil. Beliau berdakwah dengan penuh kesabaran, mengajak mereka kembali bertauhid.\n\n'
          'Nabi Idris dikenal sangat pemberani dalam menegakkan kebenaran hingga dijuluki "Asadul Usud" (Singa dari Segala Singa). Allah menganugerahkan kepadanya kecerdasan luar biasa dalam ilmu hisab, menjahit baju, serta menunggang kuda.\n\n'
          'Karena ketaqwaan dan kesucian jiwanya, Allah mengangkat derajat Nabi Idris ke tempat yang sangat tinggi, sebagaimana difirmankan dalam QS. Maryam ayat 56-57.',
      hikmah: [
        'Pentingnya menuntut ilmu dan mengembangkan keterampilan untuk kemaslahatan umat.',
        'Keberanian dalam menegakkan amar ma\'ruf nahi munkar.',
        'Ketekunan beribadah dan berdzikir mengantarkan pada derajat mulia di sisi Allah.',
      ],
      quranVerses: 'QS. Maryam: 56-57, Al-Anbiya: 85-86',
      mentionCountInQuran: 2,
    ),
    ModelKisahNabi(
      number: 3,
      name: 'Nabi Nuh AS',
      arabicName: 'نُوحٌ عَلَيْهِ ٱلسَّلَامُ',
      era: '3993 - 3043 SM',
      age: '950 Tahun (Masa Dakwah)',
      place: 'Mesopotamia Selatan (Irak)',
      kaum: 'Kaum Nuh (Penyembah Wadd, Suwa\', Yaghuts, Ya\'uq, Nasr)',
      isUlulAzmi: true,
      mukjizat: [
        'Mampu membuat bahtera raksasa (kapal laut) di atas bukit kering atas petunjuk wahyu',
        'Selamat bersama orang beriman dan pasangan hewan dari banjir bandang dahsyat sedunia',
        'Kesabaran dakwah terpanjang selama 950 tahun tanpa lelah',
      ],
      summary: 'Salah satu Rasul Ulul Azmi yang berdakwah selama 950 tahun dan membangun bahtera penyelamat saat banjir besar.',
      story: 'Nabi Nuh AS diutus kepada kaumnya yang telah menyimpang jauh dari tauhid dan menyembah lima berhala utama: Wadd, Suwa\', Yaghuts, Ya\'uq, dan Nasr. Selama 950 tahun, Nabi Nuh berdakwah siang dan malam, sembunyi-sembunyi maupun terang-terangan.\n\n'
          'Namun kaumnya tetap membangkang, mencemooh, dan bahkan menantang datangnya azab Allah. Hanya segelintir orang miskin dan tertindas yang beriman.\n\n'
          'Allah memerintahkan Nabi Nuh membuat bahtera raksasa di atas daratan tinggi. Kaum kafir mengolok-olok beliau yang membuat kapal jauh dari lautan. Ketika bahtera selesai, Allah memancarkan air dari bumi dan mencurahkan hujan lebat dari langit hingga menenggelamkan seluruh daratan.\n\n'
          'Nabi Nuh bersama orang-orang beriman dan sepasang hewan dari tiap jenis selamat di dalam bahtera, sementara kaum kafir termasuk putra kandungnya, Kan\'an, dan istrinya tenggelam dalam banjir bandang.',
      hikmah: [
        'Ketabahan dan keteguhan hati luar biasa dalam memperjuangkan kebenaran.',
        'Hidayah adalah hak prerogatif Allah; ikatan darah tidak menjamin keselamatan tanpa iman.',
        'Kesabaran dan ketaatan mutlak kepada perintah Allah akan membuahkan pertolongan.',
      ],
      quranVerses: 'QS. Nuh: 1-28, Hud: 25-49, Al-Mu\'minun: 23-30, Al-Anbiya: 76-77',
      mentionCountInQuran: 43,
    ),
    ModelKisahNabi(
      number: 4,
      name: 'Nabi Hud AS',
      arabicName: 'هُودٌ عَلَيْهِ ٱلسَّلَامُ',
      era: '2450 - 2320 SM',
      age: '130 Tahun',
      place: 'Al-Ahqaf (Antara Yaman dan Oman)',
      kaum: 'Kaum \'Ad (Pembangun Kota Iram yang bertubuh raksasa)',
      isUlulAzmi: false,
      mukjizat: [
        'Selamat dari terpaan angin badai topan dingin yang mematikan selama 7 malam 8 hari',
        'Mampu mendatangkan hujan atas izin Allah setelah kemarau panjang melanda kaum \'Ad',
        'Keberanian menghadapi kaum \'Ad yang bertubuh kuat dan perkasa tanpa rasa takut',
      ],
      summary: 'Nabi yang diutus kepada kaum \'Ad yang sombong dengan kekuatan fisik dan bangunan megah mereka.',
      story: 'Nabi Hud AS diutus kepada Kaum \'Ad yang mendiami wilayah Al-Ahqaf. Kaum \'Ad dianugerahi tubuh yang sangat tinggi besar, kekuatan fisik luar biasa, serta keahlian membangun istana dan menara megah (Kota Iram).\n\n'
          'Namun kenikmatan tersebut membuat mereka sombong dan berkata: "Siapakah yang lebih besar kekuatannya dari kami?" Mereka menyembah berhala dan menindas kaum yang lemah.\n\n'
          'Nabi Hud menyeru kaumnya untuk menyembah Allah semata dan bersyukur atas limpahan rezeki. Kaum \'Ad menuduh Nabi Hud gila dan menantang azab.\n\n'
          'Allah menimpakan kemarau panjang selama tiga tahun, lalu mengirimkan awan hitam yang mereka kira membawa hujan. Ternyata awan itu membawa angin topan yang sangat dingin dan kencang (Angin Shorshor) selama 7 malam 8 hari berturut-turut, memporak-porandakan mereka seperti pohon-pohon kurma yang tumbang. Nabi Hud dan orang beriman diselamatkan Allah.',
      hikmah: [
        'Kekuatan fisik, teknologi, dan kemewahan materi tidak ada artinya di hadapan murka Allah.',
        'Larangan bersikap sombong dan menindas sesama manusia.',
        'Syukur atas nikmat akan menambah keberkahan, sedangkan kufur nikmat mengundang azab.',
      ],
      quranVerses: 'QS. Hud: 50-60, Al-Ahqaf: 21-26, Al-Haqqah: 6-8, Asy-Syu\'ara: 123-140',
      mentionCountInQuran: 7,
    ),
    ModelKisahNabi(
      number: 5,
      name: 'Nabi Shaleh AS',
      arabicName: 'صَالِحٌ عَلَيْهِ ٱلسَّلَامُ',
      era: '2150 - 2080 SM',
      age: '70 Tahun',
      place: 'Al-Hijr / Mada\'in Saleh (Antara Madinah dan Syam)',
      kaum: 'Kaum Tsamud (Pemahat Gunung & Tebing Batu)',
      isUlulAzmi: false,
      mukjizat: [
        'Mengeluarkan seekor unta betina bunting 10 bulan dari dalam batu karang besar',
        'Air susu unta mukjizat tersebut mencukupi kebutuhan minum seluruh penduduk kota',
        'Selamat dari gempa dan sambaran petir dahsyat yang memusnahkan kaum Tsamud',
      ],
      summary: 'Nabi yang membawa mukjizat unta betina yang keluar dari batu besar untuk membuktikan kekuasaan Allah pada kaum Tsamud.',
      story: 'Nabi Shaleh AS diutus kepada Kaum Tsamud di daerah Al-Hijr. Kaum Tsamud terkenal dengan kepandaiannya memahat bukit-bukit batu menjadi istana dan rumah-rumah yang kokoh dan indah.\n\n'
          'Mereka hidup makmur namun menyembah berhala. Kaum Tsamud meminta bukti nyata kenabian dengan syarat yang mustahil: mengeluarkan seekor unta betina yang sedang bunting dari bongkahan batu karang keras.\n\n'
          'Nabi Shaleh berdoa kepada Allah, dan terbelahlah batu tersebut mengeluarkan unta betina yang sempurna. Nabi Shaleh berpesan agar unta tersebut tidak diganggu dan berbagi giliran air sumur.\n\n'
          'Sembilan orang pembangkang kaum Tsamud yang dipimpin Qudar bin Salif bersekongkol membunuh unta mukjizat tersebut. Tiga hari setelahnya, Allah mengirimkan suara petir menggelegar dan gempa dahsyat (Ash-Shaihah) yang membinasakan seluruh kaum kafir Tsamud di dalam rumah mereka.',
      hikmah: [
        'Larangan merusak perjanjian dan menyakiti makhluk yang dilindungi Allah.',
        'Keserakahan dan kedurhakaan sekelompok kecil dapat mendatangkan bencana bagi masyarakat jika dibiarkan.',
        'Mukjizat adalah bukti kebenaran, bukan sekadar atraksi untuk memuaskan rasa penasaran.',
      ],
      quranVerses: 'QS. Hud: 61-68, Asy-Syu\'ara: 141-159, Al-A\'raf: 73-79, Al-Qamar: 23-32',
      mentionCountInQuran: 9,
    ),
    ModelKisahNabi(
      number: 6,
      name: 'Nabi Ibrahim AS',
      arabicName: 'إِبْرَاهِيمُ عَلَيْهِ ٱلسَّلَامُ',
      era: '1997 - 1822 SM',
      age: '175 Tahun',
      place: 'Ur (Irak), Babilonia, Palestina, Mesir, Makkah',
      kaum: 'Kaum Raja Namrud (Babilonia)',
      isUlulAzmi: true,
      mukjizat: [
        'Tidak terbakar api unggun raksasa Raja Namrud, api menjadi dingin dan menyelamatkan (Bardan wa Salaama)',
        'Membangun kembali Ka\'bah (Baitullah) bersama putranya Nabi Ismail AS',
        'Menghidupkan empat ekor burung yang telah dicincang atas izin Allah',
        'Mengeluarkan sumber mata air Zamzam di lembah padang pasir Makkah yang tandus',
      ],
      summary: 'Bapak para Nabi (Khalilullah & Abul Anbiya) yang gigih melawan kemusyrikan dan menjadi teladan ketaatan mutlak.',
      story: 'Nabi Ibrahim AS lahir di tengah masyarakat penyembah bintang dan berhala di bawah kekuasaan Raja Namrud yang zalim. Sejak belia, beliau menggunakan akal sehat mencari Tuhan sejati hingga menemukan bahwa Allah adalah Pencipta alam semesta.\n\n'
          'Beliau menghancurkan berhala-berhala kaumnya dan menyisakan yang paling besar untuk menyadarkan mereka. Namrud yang murka melemparkan Ibrahim ke kobaran api unggun raksasa, namun Allah berfirman: "Wahai api, jadilah dingin dan penyelamat bagi Ibrahim!"\n\n'
          'Nabi Ibrahim diuji dengan berbagai ujian berat, termasuk meninggalkan Siti Hajar dan Ismail kecil di lembah Makkah yang tandus, serta perintah menyembelih putra kesayangannya Ismail. Karena ketundukan totalnya, Allah mengganti sembelihan itu dengan seekor domba besar (asal-usul ibadah Qurban).\n\n'
          'Bersama Ismail, beliau meninggikan fondasi Ka\'bah dan menyeru seluruh umat manusia untuk menunaikan ibadah Haji.',
      hikmah: [
        'Tauhid yang murni dan keimanan tanpa keraguan kepada Allah SWT.',
        'Keteladanan dalam pengorbanan harta dan jiwa demi ridha Ilahi.',
        'Pentingnya doa untuk keturunan agar menjadi generasi sholeh penegak sholat.',
      ],
      quranVerses: 'QS. Al-Baqarah: 124-132, Ibrahim: 35-41, Asy-Syu\'ara: 69-89, Al-Anbiya: 51-73',
      mentionCountInQuran: 69,
    ),
    ModelKisahNabi(
      number: 7,
      name: 'Nabi Luth AS',
      arabicName: 'لُوطٌ عَلَيْهِ ٱلسَّلَامُ',
      era: '1950 - 1870 SM',
      age: '80 Tahun',
      place: 'Sodom & Gomorah (Laut Mati / Yordania)',
      kaum: 'Kaum Sodom (Pelaku Homoseksual Pertama)',
      isUlulAzmi: false,
      mukjizat: [
        'Diselamatkan bersama pengikut beriman sebelum kota Sodom dijungkirbalikkan',
        'Malaikat berwujud pemuda tampan datang melindunginya dari kepungan kaum Sodom',
      ],
      summary: 'Keponakan Nabi Ibrahim yang diutus untuk memberantas kemaksiatan dan penyimpangan seksual kaum Sodom.',
      story: 'Nabi Luth AS adalah keponakan dari Nabi Ibrahim AS yang berhijrah bersamanya, lalu diutus Allah ke kota Sodom di sekitar Laut Mati. Kaum Sodom melakukan perbuatan keji yang belum pernah dilakukan oleh manusia sebelumnya: menyukai sesama jenis (homoseksual), membegal musafir, dan berbuat maksiat di pertemuan umum.\n\n'
          'Nabi Luth menyeru mereka untuk bertakwa dan meninggalkan perbuatan keji tersebut. Namun mereka mengancam akan mengusir Nabi Luth karena dianggap sok suci.\n\n'
          'Allah mengutus malaikat berwujud pemuda tampan ke rumah Nabi Luth. Kaum Sodom berkerumun hendak berbuat jahat, namun malaikat membutakan mata mereka dan memerintahkan Nabi Luth pergi di waktu malam bersama keluarganya tanpa menoleh ke belakang.\n\n'
          'Menjelang subuh, Allah menjungkirbalikkan negeri Sodom dan menghujani mereka dengan batu belerang yang panas. Istri Nabi Luth yang berkhianat turut binasa bersama kaum kafir.',
      hikmah: [
        'Menjaga kesucian fitrah manusia dan menjauhi segala bentuk penyimpangan moral.',
        'Istri yang tidak beriman tidak akan tertolong oleh keshalihan suaminya di akhirat.',
        'Azab Allah sangat nyata bagi kaum yang melampaui batas dan terang-terangan bermaksiat.',
      ],
      quranVerses: 'QS. Hud: 77-83, Asy-Syu\'ara: 160-175, Al-A\'raf: 80-84, Al-Hijr: 58-77',
      mentionCountInQuran: 27,
    ),
    ModelKisahNabi(
      number: 8,
      name: 'Nabi Ismail AS',
      arabicName: 'إِسْمَاعِيلُ عَلَيْهِ ٱلسَّلَامُ',
      era: '1911 - 1774 SM',
      age: '137 Tahun',
      place: 'Makkah Al-Mukarramah',
      kaum: 'Suku Jurhum & Penduduk Makkah',
      isUlulAzmi: false,
      mukjizat: [
        'Hentakan kakinya saat bayi memancarkan mata air Zamzam yang tidak pernah kering',
        'Rela disembelih demi menjalankan perintah Allah hingga diganti domba surga',
        'Membantu ayahnya Nabi Ibrahim membangun Ka\'bah Baitullah',
        'Nenek moyang dari bangsa Arab Musta\'ribah dan Baginda Nabi Muhammad SAW',
      ],
      summary: 'Putra Nabi Ibrahim yang penuh kesabaran, keikhlasan berkorban, dan menjadi moyang Nabi Muhammad SAW.',
      story: 'Nabi Ismail AS adalah putra pertama Nabi Ibrahim AS dari Siti Hajar. Saat masih bayi, Ismail dan ibunya ditinggalkan di lembah Makkah yang gersang atas perintah wahyu Allah. Ketika air minum habis, Hajar berlari bolak-balik antara bukit Shafa dan Marwah mencari air.\n\n'
          'Allah mengutus Malaikat Jibril menghentakkan tanah di dekat kaki Ismail kecil hingga memancarlah mata air Zamzam yang melimpah dan mengundang kabilah Jurhum untuk menetap di sana.\n\n'
          'Saat beranjak remaja, Nabi Ibrahim bermimpi diperintahkan menyembelih Ismail. Ismail dengan penuh ridha berkata: "Wahai ayahku, kerjakanlah apa yang diperintahkan kepadamu; insya Allah engkau akan mendapatiku termasuk orang-orang yang sabar."\n\n'
          'Ketika pisau telah diletakkan di lehernya, Allah menebusnya dengan seekor sembelihan besar dan memuji keikhlasan mereka berdua.',
      hikmah: [
        'Kepatuhan dan bakti luar biasa anak sholeh kepada orang tua dan perintah Allah.',
        'Tawakal total mendatangkan pertolongan dari arah yang tidak disangka-sangka.',
        'Keikhlasan berkurban menjadi pondasi keberkahan bagi generasi sesudahnya.',
      ],
      quranVerses: 'QS. Ash-Shaffat: 100-111, Maryam: 54-55, Al-Baqarah: 125-129',
      mentionCountInQuran: 12,
    ),
    ModelKisahNabi(
      number: 9,
      name: 'Nabi Ishaq AS',
      arabicName: 'إِسْحَاقُ عَلَيْهِ ٱلسَّلَامُ',
      era: '1897 - 1717 SM',
      age: '180 Tahun',
      place: 'Kanaan (Palestina) & Hebron (Al-Khalil)',
      kaum: 'Penduduk Kanaan & Syam',
      isUlulAzmi: false,
      mukjizat: [
        'Kelahirannya dikabarkan langsung oleh malaikat saat ibunya Sarah sudah tua mandul',
        'Melahirkan garis keturunan para nabi Bani Israil (Ayah Nabi Ya\'qub AS)',
        'Dianugerahi hikmah kenabian, ilmu luas, dan akhlak yang sangat terpuji',
      ],
      summary: 'Putra kedua Nabi Ibrahim dari Siti Sarah, pembawa kabar gembira bagi kaum Kanaan dan ayah dari Nabi Ya\'qub.',
      story: 'Nabi Ishaq AS adalah putra Nabi Ibrahim dari istri pertamanya, Siti Sarah. Kelahirannya merupakan mukjizat kabar gembira yang disampaikan langsung oleh para malaikat tamu Nabi Ibrahim, di saat usia Sarah telah mencapai 90 tahun dan dinyatakan mandul.\n\n'
          'Nabi Ishaq tumbuh menjadi pribadi yang sholeh, lemah lembut, dan penuh hikmah. Beliau melanjutkan risalah dakwah tauhid ayahnya di wilayah Palestina dan Syam.\n\n'
          'Dari pernikahan Nabi Ishaq dengan Rifqah binti Batwil, lahirlah anak kembar yaitu \'Ishu dan Nabi Ya\'qub AS. Dari garis keturunan Nabi Ya\'qub inilah lahir ribuan nabi dan rasul Bani Israil.',
      hikmah: [
        'Tiada yang mustahil bagi kekuasaan Allah jika Dia telah berkehendak.',
        'Kesabaran menanti karunia anak sholeh dengan terus berdoa.',
        'Pentingnya menjaga mata rantai dakwah tauhid dalam keluarga.',
      ],
      quranVerses: 'QS. Hud: 71-73, As-Saffat: 112-113, Maryam: 49-50, Al-Anbiya: 72-73',
      mentionCountInQuran: 17,
    ),
    ModelKisahNabi(
      number: 10,
      name: 'Nabi Ya\'qub AS',
      arabicName: 'يَعْقُوبُ عَلَيْهِ ٱلسَّلَامُ',
      era: '1837 - 1690 SM',
      age: '147 Tahun',
      place: 'Kanaan (Palestina) lalu hijrah ke Mesir',
      kaum: 'Bani Israil (Bani Ya\'qub)',
      isUlulAzmi: false,
      mukjizat: [
        'Memiliki 12 putra yang menjadi cikal bakal 12 suku Bani Israil',
        'Penglihatannya yang buta akibat menangisi kepergian Yusuf pulih kembali berkat gamis Yusuf',
        'Firasat kenabian yang tajam dan kesabaran tanpa batas (Shabr Jamil)',
      ],
      summary: 'Nabi bergelar Israil yang dikaruniai 12 putra dan teladan kesabaran terindah dalam menghadapi cobaan keluarga.',
      story: 'Nabi Ya\'qub AS adalah putra Nabi Ishaq AS. Beliau juga digelari "Israil" (Hamba Allah yang taat). Beliau dikaruniai 12 orang putra, di antaranya Nabi Yusuf dan Bunyamin yang sangat beliau cintai.\n\n'
          'Kecintaan tersebut menimbulkan kecemburuan dari sepuluh saudara lainnya hingga mereka bersekongkol membuang Yusuf ke dalam sumur tua dan mengabarkan kepada sang ayah bahwa Yusuf dimakan serigala.\n\n'
          'Nabi Ya\'qub sangat terpukul dan berduka hingga matanya memutih (buta) karena sering menangis. Namun beliau tetap bersabar dengan penuh keikhlasan (Shabrun Jamiil) dan tidak pernah berputus asa dari rahmat Allah.\n\n'
          'Setelah puluhan tahun terpisah, gamis Nabi Yusuf diusapkan ke wajah Nabi Ya\'qub hingga penglihatannya sembuh total, dan seluruh keluarga berkumpul kembali di Mesir dalam kemuliaan.',
      hikmah: [
        'Kesabaran yang indah (Shabrun Jamil) tanpa berkeluh kesah kepada selain Allah.',
        'Menghindari sikap pilih kasih berlebihan di antara anak-anak untuk mencegah iri dengki.',
        'Keyakinan teguh bahwa pertolongan Allah pasti datang pada waktu yang tepat.',
      ],
      quranVerses: 'QS. Yusuf: 1-101, Al-Baqarah: 132-133, Maryam: 49-50',
      mentionCountInQuran: 16,
    ),
    ModelKisahNabi(
      number: 11,
      name: 'Nabi Yusuf AS',
      arabicName: 'يُوسُفُ عَلَيْهِ ٱلسَّلَامُ',
      era: '1745 - 1635 SM',
      age: '110 Tahun',
      place: 'Palestina lalu Mesir',
      kaum: 'Penduduk Mesir & Bani Israil',
      isUlulAzmi: false,
      mukjizat: [
        'Dianugerahi separuh dari seluruh ketampanan umat manusia di dunia',
        'Kemampuan menakwilkan (menafsirkan) mimpi secara tepat dan akurat',
        'Gamisnya mampu menyembuhkan mata ayahnya Nabi Ya\'qub yang buta',
        'Kecerdasan mengelola lumbung pangan hingga menyelamatkan Mesir dari 7 tahun paceklik',
      ],
      summary: 'Nabi yang berparas rupawan, ahli takwil mimpi, dan teladan kemurnian menjaga kehormatan diri serta memaafkan saudara.',
      story: 'Nabi Yusuf AS bermimpi melihat sebelas bintang, matahari, dan bulan bersujud kepadanya. Karena iri, saudara-saudaranya membuangnya ke dalam sumur, lalu beliau diselamatkan kafilah dagang dan dijual sebagai budak di Mesir kepada seorang pejabat (Al-Aziz).\n\n'
          'Ketika beranjak dewasa dengan ketampanan luar biasa, istri Al-Aziz (Zulaikha) merayunya, namun Yusuf memilih dipenjara bertahun-tahun demi menjaga kesucian dirinya daripada bermaksiat kepada Allah.\n\n'
          'Di penjara, beliau menafsirkan mimpi dua pelayan raja. Saat Raja Mesir bermimpi tentang 7 sapi gemuk dimakan 7 sapi kurus, Yusuf menafsirkannya sebagai tanda datangnya 7 tahun masa subur disusul 7 tahun paceklik hebat.\n\n'
          'Yusuf dibebaskan, namanya direhabilitasi, dan diangkat menjadi Menteri Keuangan Mesir. Ketika saudara-saudaranya datang meminta gandum, Yusuf memaafkan mereka tanpa dendam sedikit pun.',
      hikmah: [
        'Menjaga kesucian dan rasa takut kepada Allah di saat godaan maksiat terbuka lebar.',
        'Memaafkan orang yang pernah berbuat zalim dengan kelapangan dada.',
        'Roda kehidupan berputar; dari budak dan narapidana menjadi pemimpin terhormat.',
      ],
      quranVerses: 'QS. Yusuf: 1-111, Al-An\'am: 84, Ghafir: 34',
      mentionCountInQuran: 27,
    ),
    ModelKisahNabi(
      number: 12,
      name: 'Nabi Ayyub AS',
      arabicName: 'أَيُّوبُ عَلَيْهِ ٱلسَّلَامُ',
      era: '1540 - 1420 SM',
      age: '120 Tahun',
      place: 'Hauran (Dataran Syam / Yordania)',
      kaum: 'Penduduk Hauran & Damaskus',
      isUlulAzmi: false,
      mukjizat: [
        'Hentakan kakinya memancarkan mata air yang menyembuhkan penyakit kulit sekujur tubuhnya',
        'Kesabaran legendaris saat diuji kehilangan seluruh harta, anak, dan kesehatan selama belasan tahun',
        'Allah mengembalikan seluruh kekayaan, keturunan berlipat ganda, dan awan emas',
      ],
      summary: 'Ikon kesabaran sejati (Ayyubiah) yang lulus dari ujian kehilangan harta, anak, dan penyakit berat tanpa mengeluh.',
      story: 'Nabi Ayyub AS awalnya adalah seorang nabi yang kaya raya, memiliki ternak melimpah, tanah luas, anak-anak yang sholeh, dan dermawan menyantuni fakir miskin. Allah mengujinya dengan mencabut seluruh nikmat duniawi tersebut secara bertahap.\n\n'
          'Seluruh hartanya binasa, semua anak-anaknya meninggal dunia tertimpa bangunan, dan beliau ditimpa penyakit kulit parah selama bertahun-tahun hingga dijauhi masyarakat, kecuali istrinya yang setia bernama Rahmah.\n\n'
          'Meskipun demikian, lidah Nabi Ayyub tidak pernah berhenti bertasbih dan bersyukur. Ketika penyakitnya mencapai puncak, beliau berdoa dengan sangat santun: "Rabbi inni massaniyad-dhurru wa anta arhamur-rahimin" (Ya Tuhanku, sesungguhnya aku telah ditimpa penyakit dan Engkau adalah Tuhan Yang Maha Penyayang).\n\n'
          'Allah memerintahkannya menghentakkan kaki ke tanah, memancar air sejuk untuk mandi dan minum, seketika sembuhlah penyakit luar dan dalamnya, serta Allah karuniakan kembali harta dan keturunan berlipat ganda.',
      hikmah: [
        'Kesabaran mutlak dalam menghadapi musibah dan penyakit tanpa menyalahkan takdir.',
        'Harta dan anak adalah titipan Allah yang sewaktu-waktu bisa diambil kembali.',
        'Kesetiaan pasangan hidup dalam suka maupun duka.',
      ],
      quranVerses: 'QS. Al-Anbiya: 83-84, Shad: 41-44, An-Nisa: 163',
      mentionCountInQuran: 4,
    ),
    ModelKisahNabi(
      number: 13,
      name: 'Nabi Syu\'aib AS',
      arabicName: 'شُعَيْبٌ عَلَيْهِ ٱلسَّلَامُ',
      era: '1600 - 1490 SM',
      age: '110 Tahun',
      place: 'Madyan & Aikah (Pesisir Laut Merah)',
      kaum: 'Penduduk Madyan & Ashabul Aikah',
      isUlulAzmi: false,
      mukjizat: [
        'Selamat dari gempa dan naungan awan panas (Adzabuzh-Zhillah) yang memusnahkan kaum Madyan',
        'Dianugerahi kemampuan retorika dan kefasihan bicara luar biasa (Khatibul Anbiya)',
      ],
      summary: 'Juru bicara para Nabi (Khatibul Anbiya) yang gigih memerangi kecurangan timbangan dan perampokan ekonomi.',
      story: 'Nabi Syu\'aib AS diutus kepada Kaum Madyan dan Ashabul Aikah. Mereka adalah pedagang yang gemar berbuat curang dengan mengurangi timbangan, menipu takaran, dan membegal para musafir di jalur perdagangan.\n\n'
          'Nabi Syu\'aib dijuluki "Khatibul Anbiya" karena kepiawaian dan kelembutan bahasanya dalam berkhutbah. Beliau mengingatkan kaumnya bahwa rezeki yang halal dan sedikit jauh lebih berkah daripada harta haram berlimpah.\n\n'
          'Kaum Madyan menolak nasihatnya dengan mengejek: "Apakah sholatmu yang menyuruhmu agar kami meninggalkan apa yang disembah nenek moyang kami?" Mereka bahkan mengancam akan merajam Nabi Syu\'aib.\n\n'
          'Allah menurunkan azab berupa gempa dahsyat (Ar-Rajfah) bagi Madyan dan awan hitam yang memancarkan kilatan api membakar (Adzabuzh Zhillah) bagi kaum Aikah hingga musnah tak bersisa.',
      hikmah: [
        'Kewajiban bersikap jujur dan adil dalam transaksi jual beli dan bisnis.',
        'Kecurangan ekonomi dan korupsi merusak tatanan sosial dan mengundang azab Allah.',
        'Ibadah ritual (sholat) harus tercermin dalam kejujuran etika muamalah sehari-hari.',
      ],
      quranVerses: 'QS. Hud: 84-95, Al-A\'raf: 85-93, Asy-Syu\'ara: 176-190',
      mentionCountInQuran: 11,
    ),
    ModelKisahNabi(
      number: 14,
      name: 'Nabi Musa AS',
      arabicName: 'مُوسَىٰ عَلَيْهِ ٱلسَّلَامُ',
      era: '1527 - 1407 SM',
      age: '120 Tahun',
      place: 'Mesir, Madyan, Gurun Sinai, Palestina',
      kaum: 'Bani Israil & Firaun (Ramses II)',
      isUlulAzmi: true,
      mukjizat: [
        'Tongkat yang dapat berubah menjadi ular besar dan menelan sihir tukang sihir Firaun',
        'Membelah Laut Merah menjadi 12 jalur kering untuk menyelamatkan Bani Israil',
        'Telapak tangan yang memancarkan cahaya putih menyilaukan tanpa cela penyakit',
        'Berbicara langsung dengan Allah di Bukit Tursina (Kalimullah)',
        'Menerima Kitab Taurat dalam bentuk lempengan batu (Alwah)',
      ],
      summary: 'Rasul Ulul Azmi bergelar Kalimullah yang membebaskan Bani Israil dari tirani Firaun dengan mukjizat tongkat pemecah lautan.',
      story: 'Nabi Musa AS lahir saat Firaun mengeluarkan maklumat membunuh setiap bayi laki-laki Bani Israil. Ibunya menghanyutkan Musa kecil ke Sungai Nil di dalam peti, yang kemudian dipungut oleh Asiyah, istri Firaun, dan diasuh di istana.\n\n'
          'Setelah dewasa dan melarikan diri ke Madyan karena insiden pembelaan kaumnya, Musa menikah dengan putri Nabi Syu\'aib. Di Bukit Sinai (Tursina), Allah berbicara langsung kepada Musa dan mengangkatnya sebagai Rasul bersama saudaranya, Nabi Harun AS.\n\n'
          'Musa mendatangi Firaun menuntut pembebasan Bani Israil. Setelah Firaun mengingkari 9 tanda mukjizat (belalang, kutu, katak, air jadi darah, dll.), Musa memimpin Bani Israil eksodus keluar dari Mesir.\n\n'
          'Ketika terdesak di tepi Laut Merah oleh pasukan Firaun, Musa memukulkan tongkatnya ke laut hingga terbelah. Bani Israil menyeberang dengan selamat, sementara Firaun dan pasukannya tenggelam ditelan ombak.',
      hikmah: [
        'Kebenaran pasti akan mengalahkan kezaliman betapapun kuatnya kekuasaan tirani.',
        'Tawakal teguh saat menghadapi jalan buntu akan membukakan keajaiban jalan keluar.',
        'Pemimpin sejati senantiasa berjuang membela hak-hak kaum yang tertindas.',
      ],
      quranVerses: 'QS. Al-Qashash: 3-44, Thaha: 9-98, Al-Baqarah: 49-61, Asy-Syu\'ara: 10-68',
      mentionCountInQuran: 136,
    ),
    ModelKisahNabi(
      number: 15,
      name: 'Nabi Harun AS',
      arabicName: 'هَارُونُ عَلَيْهِ ٱلسَّلَامُ',
      era: '1530 - 1417 SM',
      age: '123 Tahun',
      place: 'Mesir & Padang Tiih (Sinai)',
      kaum: 'Bani Israil & Firaun',
      isUlulAzmi: false,
      mukjizat: [
        'Dianugerahi kefasihan lisan dan diplomasi luar biasa sebagai pendamping dakwah Nabi Musa',
        'Diangkat menjadi nabi berkat doa permohonan Nabi Musa AS',
        'Menjadi wazir (menteri) dan juru bicara utama menghadapi Firaun',
      ],
      summary: 'Kakak kandung Nabi Musa yang sangat fasih lisannya, berhati lembut, dan setia mendampingi dakwah menghadapi Firaun.',
      story: 'Nabi Harun AS adalah kakak kandung dari Nabi Musa AS. Ketika Nabi Musa menerima wahyu di Bukit Tursina, beliau memohon kepada Allah agar mengangkat Harun sebagai nabi pembantunya karena Harun memiliki lisan yang lebih fasih dan pandai berkomunikasi.\n\n'
          'Nabi Harun setia mendampingi Musa berdakwah di hadapan Firaun dan memimpin Bani Israil. Ketika Nabi Musa bermunajat selama 40 hari di Gunung Sinai untuk menerima Taurat, Nabi Harun ditugaskan memimpin kaumnya.\n\n'
          'Namun sebagian Bani Israil dihasut oleh Samiri untuk menyembah patung anak sapi emas. Nabi Harun telah berusaha keras mencegah mereka dengan kelembutan, namun diancam akan dibunuh hingga Musa kembali meluruskan keadaan.',
      hikmah: [
        'Pentingnya kerja sama tim dan pembagian peran dalam mengemban amanah dakwah.',
        'Sifat lemah lembut dan diplomasi santun dalam menyelesaikan konflik internal umat.',
        'Kasih sayang persaudaraan yang saling menguatkan dalam ketaatan.',
      ],
      quranVerses: 'QS. Thaha: 29-36, Al-A\'raf: 142-151, Maryam: 51-53, Al-Furqan: 35',
      mentionCountInQuran: 20,
    ),
    ModelKisahNabi(
      number: 16,
      name: 'Nabi Zulkifli AS',
      arabicName: 'ذُو ٱلْكِفْلِ عَلَيْهِ ٱلسَّلَامُ',
      era: '1500 - 1425 SM',
      age: '75 Tahun',
      place: 'Damaskus (Suriah) & Irak',
      kaum: 'Penduduk Syam & Romawi',
      isUlulAzmi: false,
      mukjizat: [
        'Mampu memegang teguh tiga janji berat: berpuasa di siang hari, sholat di malam hari, dan tidak pernah marah saat mengadili perkara',
        'Kesabaran tingkat tinggi saat digoda Iblis yang menyamar sebagai kakek tua perusak waktu istirahatnya',
      ],
      summary: 'Nabi yang sanggup memenuhi janji menjadi raja yang adil, rajin berpuasa di siang hari, qiyamul lail, dan tidak pernah marah.',
      story: 'Nabi Zulkifli AS (bernama asli Basyar) adalah putra dari Nabi Ayyub AS. Nama "Zulkifli" berarti "orang yang sanggup menyanggupi janji". Julukan ini diperoleh ketika seorang raja tua di Syam mencari penerus tahta dengan syarat: sanggup berpuasa di siang hari, sholat sepanjang malam, dan tidak pernah marah ketika memutuskan perkara.\n\n'
          'Dari seluruh rakyat, hanya Zulkifli muda yang mengangkat tangan dan menyanggupi ketiga syarat berat tersebut. Beliau pun diangkat menjadi raja yang adil dan bijaksana.\n\n'
          'Iblis berusaha keras memancing amarahnya dengan menyamar menjadi kakek miskin yang datang mengganggu waktu tidur siangnya berulang-ulang dengan keluhan palsu. Namun Nabi Zulkifli tetap menyambutnya dengan senyuman dan kesabaran sempurna.',
      hikmah: [
        'Kekuatan menepati janji dan amanah kepemimpinan.',
        'Pengendalian emosi dan hawa nafsu adalah tanda kekuatan jiwa yang sejati.',
        'Keseimbangan antara ibadah ritual malam hari dan pelayanan sosial siang hari.',
      ],
      quranVerses: 'QS. Al-Anbiya: 85-86, Shad: 48',
      mentionCountInQuran: 2,
    ),
    ModelKisahNabi(
      number: 17,
      name: 'Nabi Daud AS',
      arabicName: 'دَاوُۥدُ عَلَيْهِ ٱلسَّلَامُ',
      era: '1060 - 963 SM',
      age: '100 Tahun',
      place: 'Baitul Maqdis (Palestina)',
      kaum: 'Bani Israil',
      isUlulAzmi: false,
      mukjizat: [
        'Menerima Kitab Zabur yang berisi puji-pujian dan hikmah',
        'Dianugerahi suara sangat merdu hingga gunung-gunung dan burung-burung ikut bertasbih bersamanya',
        'Mampu melunakkan besi keras dengan tangan kosong seperti adonan lilin untuk membuat baju zirah',
        'Mengalahkan raja tiran Jalut hanya dengan ketapel saat masih pemuda',
      ],
      summary: 'Raja agung Bani Israil pemilik suara termerdu, pelunak besi, penerima Kitab Zabur, dan teladan puasa Daud.',
      story: 'Nabi Daud AS mengawali kepahlawanannya saat bergabung dalam pasukan Raja Thalut melawan tirani Jalut (Goliath). Dengan ketapel batunya atas pertolongan Allah, Daud berhasil merobohkan Jalut raksasa.\n\n'
          'Setelah itu, Allah menganugerahkan Daud kerajaan dan kenabian. Ketika beliau melantunkan ayat-ayat Zabur, suaranya yang begitu merdu mempesona alam semesta hingga burung-burung berhenti di udara dan bukit-bukit ikut bertasbih bersama beliau.\n\n'
          'Allah juga melunakkan besi bagi Daud tanpa perlu api dan palu, sehingga beliau mampu merajut baju zirah pelindung perang yang fleksibel dan menjualnya untuk nafkah keluarga.\n\n'
          'Nabi Daud dikenal dengan pola ibadahnya yang dicintai Allah: berpuasa selang-seling (sehari puasa, sehari tidak) dan sholat sepertiga malam.',
      hikmah: [
        'Kemenangan bukan ditentukan oleh ukuran fisik, melainkan oleh keimanan dan pertolongan Allah.',
        'Makan dari hasil keringat sendiri dan tidak bergantung pada kas negara.',
        'Melantunkan puji-pujian kepada Allah dengan penuh penghayatan jiwa.',
      ],
      quranVerses: 'QS. Shad: 17-26, Saba: 10-11, Al-Anbiya: 78-80, Al-Baqarah: 251',
      mentionCountInQuran: 16,
    ),
    ModelKisahNabi(
      number: 18,
      name: 'Nabi Sulaiman AS',
      arabicName: 'سُلَيْمَانُ عَلَيْهِ ٱلسَّلَامُ',
      era: '989 - 931 SM',
      age: '58 Tahun',
      place: 'Yerusalem (Palestina) & Yaman (Saba\')',
      kaum: 'Bani Israil & Seluruh Makhluk',
      isUlulAzmi: false,
      mukjizat: [
        'Dianugerahi kerajaan termegah yang tidak pernah dan tidak akan pernah dimiliki manusia lain',
        'Memahami bahasa binatang (burung hud-hud, semut, kuda, dll.)',
        'Mampu menundukkan dan memerintah bangsa jin, setan, dan angin sebagai bala tentara',
        'Mengalirkan tembaga cair dari dalam bumi untuk pembangunan istana kaca megah',
      ],
      summary: 'Raja teragung di muka bumi putra Nabi Daud, penakluk angin dan jin, serta pemaham bahasa seluruh binatang.',
      story: 'Nabi Sulaiman AS mewarisi kenabian dan kerajaan dari ayahnya, Nabi Daud AS. Beliau berdoa kepada Allah agar dianugerahi kerajaan yang tidak tertandingi oleh siapa pun sesudahnya, dan Allah mengabulkan doanya.\n\n'
          'Pasukan Nabi Sulaiman terdiri dari gabungan manusia, jin, dan burung-burung. Angin tunduk berhembus menuruti perintahnya untuk mengangkut pasukan dalam hitungan jam. Beliau mengerti percakapan semut yang memerintahkan koloninya masuk ke sarang agar tidak terinjak.\n\n'
          'Burung Hud-hud mengabarkan adanya Kerajaan Saba\' di Yaman yang dipimpin Ratu Balqis yang menyembah matahari. Nabi Sulaiman mengirim surat dakwah: "Bismillaahir-rahmaanir-rahiim, janganlah kamu bersikap sombong terhadapku dan datanglah kepadaku sebagai orang-orang yang berserah diri."\n\n'
          'Atas izin Allah, singgasana Balqis dipindahkan sekejap mata oleh Ashif bin Barkhiya. Ratu Balqis takjub melihat kemegahan istana kaca dan menyatakan keislamannya.',
      hikmah: [
        'Kekuasaan dan kekayaan mutlak harus menjadi sarana berdakwah dan menebar keadilan.',
        'Rasa syukur yang mendalam atas segala nikmat (Hadza min fadhli Rabbi).',
        'Menyayangi makhluk terkecil (seperti semut) walau berstatus sebagai raja diraja.',
      ],
      quranVerses: 'QS. An-Naml: 15-44, Shad: 30-40, Saba: 12-14, Al-Anbiya: 81-82',
      mentionCountInQuran: 17,
    ),
    ModelKisahNabi(
      number: 19,
      name: 'Nabi Ilyas AS',
      arabicName: 'إِلْيَاسُ عَلَيْهِ ٱلسَّلَامُ',
      era: '910 - 850 SM',
      age: '60 Tahun',
      place: 'Ba\'labak (Lebanon / Syam)',
      kaum: 'Bani Israil penyembah berhala Ba\'al',
      isUlulAzmi: false,
      mukjizat: [
        'Doanya menahan hujan selama 3 tahun hingga kaumnya mengalami kekeringan dahsyat',
        'Menghidupkan kembali anak seorang janda miskin atas izin Allah (yang kelak menjadi Nabi Ilyasa)',
        'Mendatangkan hujan lebat seketika setelah kaumnya bertaubat dari berhala Ba\'al',
      ],
      summary: 'Nabi yang gigih menentang penyembahan berhala patung Ba\'al di kota Ba\'labak Fenisia.',
      story: 'Nabi Ilyas AS diutus kepada Bani Israil di kota Ba\'labak (wilayah Lebanon saat ini). Penduduk kota tersebut menyembah berhala patung emas bernama Ba\'al atas pengaruh raja mereka yang zalim, Ahab, dan istrinya Izebel.\n\n'
          'Nabi Ilyas memperingatkan mereka: "Patutkah kamu menyembah Ba\'al dan meninggalkan Allah sebaik-baik Pencipta?" Namun kaumnya mendustakan dan merencanakan pembunuhan terhadap beliau.\n\n'
          'Nabi Ilyas berdoa kepada Allah hingga turun kemarau panjang tanpa setetes air hujan pun selama 3 tahun. Rakyat menderita kelaparan hebat dan menyadari kelemahan berhala mereka.\n\n'
          'Ketika mereka berjanji akan bertaubat, Nabi Ilyas berdoa memohon hujan dan bumi kembali subur. Namun tak lama setelah nikmat kembali, mereka kembali ingkar hingga azab kehancuran menimpa mereka.',
      hikmah: [
        'Konsistensi menegakkan tauhid meski dimusuhi penguasa tiran.',
        'Kemusyrikan adalah sumber petaka bagi peradaban.',
        'Doa orang yang terzalimi dan tulus diijabah oleh Allah SWT.',
      ],
      quranVerses: 'QS. Ash-Shaffat: 123-132, Al-An\'am: 85',
      mentionCountInQuran: 2,
    ),
    ModelKisahNabi(
      number: 20,
      name: 'Nabi Ilyasa AS',
      arabicName: 'الْيَسَعُ عَلَيْهِ ٱلسَّلَامُ',
      era: '885 - 795 SM',
      age: '90 Tahun',
      place: 'Damaskus & Palestina',
      kaum: 'Bani Israil',
      isUlulAzmi: false,
      mukjizat: [
        'Menyembuhkan berbagai penyakit kronis dan menghidupkan orang mati atas izin Allah',
        'Menyucikan air sumur yang beracun dan asin menjadi air tawar yang menyehatkan',
        'Meneruskan kepemimpinan dakwah Nabi Ilyas AS dengan kedamaian dan kemakmuran',
      ],
      summary: 'Penerus perjuangan dakwah Nabi Ilyas AS yang memimpin Bani Israil menuju masa keemasan penuh berkah.',
      story: 'Nabi Ilyasa AS adalah anak angkat sekaligus murid setia yang selalu mendampingi Nabi Ilyas AS dalam pelarian dakwahnya. Semasa kecil, Ilyasa menderita sakit parah dan disembuhkan oleh Allah melalui doa Nabi Ilyas.\n\n'
          'Setelah Nabi Ilyas wafat, Allah mengangkat Ilyasa menjadi nabi dan rasul untuk memimpin Bani Israil. Beliau memimpin dengan penuh kebijaksanaan, keadilan, dan ketegasan syariat Taurat.\n\n'
          'Selama masa kepemimpinan Nabi Ilyasa, Bani Israil hidup rukun, makmur, dan tenteram dalam naungan ketaatan tauhid. Allah memuji beliau dalam Al-Qur\'an sebagai salah satu hamba pilihan yang terbaik.',
      hikmah: [
        'Pentingnya kaderisasi dan regenerasi kepemimpinan dakwah.',
        'Keteladanan murid yang setia meneruskan cita-cita mulia gurunya.',
        'Ketaatan kolektif masyarakat mengundang keberkahan hidup.',
      ],
      quranVerses: 'QS. Shad: 48, Al-An\'am: 86',
      mentionCountInQuran: 2,
    ),
    ModelKisahNabi(
      number: 21,
      name: 'Nabi Yunus AS',
      arabicName: 'يُونُسُ عَلَيْهِ ٱلسَّلَامُ',
      era: '820 - 750 SM',
      age: '70 Tahun',
      place: 'Ninawa (Mosul / Irak Utara) & Laut Mediterania',
      kaum: 'Penduduk Ninawa (Asyur / Assyria)',
      isUlulAzmi: false,
      mukjizat: [
        'Bertahan hidup berhari-hari di dalam perut ikan paus raksasa (Nun) di kegelapan samudra',
        'Tumbuhnya pohon labu (Yaqthin) yang menaungi dan menyembuhkan tubuhnya saat terdampar di pantai',
        'Seluruh 100.000 lebih kaumnya bertaubat serentak dan beriman kepada Allah',
      ],
      summary: 'Nabi bergelar Dzun-Nun (Pemilik Ikan Paus) pemegang doa tasbih penyelamat di saat kesulitan tergelap.',
      story: 'Nabi Yunus AS diutus kepada penduduk Ninawa yang keras kepala menyembah berhala. Setelah bertahun-tahun berdakwah tanpa hasil, beliau merasa putus asa dan meninggalkan kota dengan rasa marah sebelum ada izin dari Allah.\n\n'
          'Beliau menaiki kapal laut, namun di tengah samudra badai dahsyat mengancam menenggelamkan kapal. Undian diadakan tiga kali untuk menentukan siapa yang harus melompat demi meringankan beban kapal, dan nama Yunus selalu keluar.\n\n'
          'Saat melompat ke laut, seekor ikan paus raksasa menelannya utuh tanpa melukai tulangnya. Di dalam tiga kegelapan (kegelapan malam, kegelapan laut dalam, dan kegelapan perut ikan), Nabi Yunus melantunkan doa taubat yang agung:\n\n'
          '"LAA ILAAHA ILLAA ANTA SUBHAANAKA INNII KUNTU MINAZH-ZHAALIMIIN"\n(Tiada Tuhan selain Engkau, Maha Suci Engkau, sesungguhnya aku termasuk orang-orang yang zalim).\n\n'
          'Allah mengampuninya dan memerintahkan ikan memuntahkannya di tepi pantai. Beliau kembali ke Ninawa dan mendapati 100.000 lebih warganya telah beriman.',
      hikmah: [
        'Larangan berputus asa dan tergesa-gesa dalam menjalankan amanah perjuangan.',
        'Keutamaan doa Nabi Yunus sebagai pembuka jalan keluar dari segala kesempitan hidup.',
        'Pintu taubat selalu terbuka luas bagi siapa pun yang bersungguh-sungguh kembali kepada Allah.',
      ],
      quranVerses: 'QS. Al-Anbiya: 87-88, Yunus: 98, Ash-Shaffat: 139-148, Al-Qalam: 48-50',
      mentionCountInQuran: 4,
    ),
    ModelKisahNabi(
      number: 22,
      name: 'Nabi Zakaria AS',
      arabicName: 'زَكَرِيَّا عَلَيْهِ ٱلسَّلَامُ',
      era: '91 SM - 31 M',
      age: '122 Tahun',
      place: 'Yerusalem (Baitul Maqdis / Palestina)',
      kaum: 'Bani Israil & Pengasuh Maryam binti Imran',
      isUlulAzmi: false,
      mukjizat: [
        'Dikaruniai putra sholeh (Nabi Yahya AS) saat berusia senja dan istrinya mandul',
        'Tanda wahyu tidak bisa berbicara selama 3 hari 3 malam selain dengan isyarat bahasa tubuh',
        'Menjadi pelindung dan saksi mukjizat hidangan buah-buahan surga pada Sayyidah Maryam',
      ],
      summary: 'Ulama suci penjaga Baitul Maqdis, pengasuh ibunda Nabi Isa (Maryam), dan teladan doa tiada henti memohon keturunan.',
      story: 'Nabi Zakaria AS adalah imam besar dan pengurus Baitul Maqdis. Beliau mengasuh keponakannya, Maryam binti Imran, di dalam mihrab khusus. Setiap kali Zakaria masuk ke mihrab, beliau mendapati buah-buahan musim panas di musim dingin, dan sebaliknya. Maryam menjawab bahwa itu adalah rezeki dari Allah.\n\n'
          'Melihat kekuasaan Allah tersebut, timbullah harapan di hati Nabi Zakaria yang telah berusia lanjut dan berambut putih untuk memohon anak penerus dakwah: "Rabbi hab lii min ladunka dzurriyyatan thayyibah, innaka samii\'ud-du\'aa."\n\n'
          'Malaikat Jibril datang mengabarkan bahwa istrinya yang mandul akan melahirkan seorang putra bernama Yahya, nama yang belum pernah diberikan kepada siapa pun sebelumnya.\n\n'
          'Sebagai tanda bukti, lidah Nabi Zakaria tertahan tidak dapat berbicara kepada manusia selama tiga hari dan hanya memperbanyak tasbih.',
      hikmah: [
        'Tidak pernah lelah dan putus asa memanjatkan doa kepada Allah seumur hidup.',
        'Memohon keturunan dengan niat mulia agar menjadi penerus perjuangan agama.',
        'Keikhlasan mengasuh dan mendidik anak yatim mengundang karunia tak terduga.',
      ],
      quranVerses: 'QS. Maryam: 1-15, Ali \'Imran: 37-41, Al-Anbiya: 89-90',
      mentionCountInQuran: 7,
    ),
    ModelKisahNabi(
      number: 23,
      name: 'Nabi Yahya AS',
      arabicName: 'يَحْيَىٰ عَلَيْهِ ٱلسَّلَامُ',
      era: '1 SM - 31 M',
      age: '32 Tahun',
      place: 'Palestina & Yordania',
      kaum: 'Bani Israil',
      isUlulAzmi: false,
      mukjizat: [
        'Dianugerahi hikmah kenabian dan kecerdasan syariat Taurat sejak masih usia anak-anak',
        'Memiliki rasa kasih sayang (Hananan) luar biasa terhadap semua makhluk dan suci dari dosa',
        'Keberanian menegakkan amar ma\'ruf nahi munkar hingga wafat sebagai syahid',
      ],
      summary: 'Putra Nabi Zakaria yang dianugerahi hikmah sejak belia, berakhlak zuhud, penyayang, dan syahid pembela kebenaran.',
      story: 'Nabi Yahya AS lahir sebagai jawaban atas doa ayahnya, Nabi Zakaria AS. Sejak kanak-kanak, beliau tidak tertarik dengan permainan duniawi dan berkata: "Bukan untuk bermain-main aku diciptakan."\n\n'
          'Allah menganugerahkan hikmah dan ilmu pemahaman Taurat yang mendalam kepada Yahya di usia muda. Beliau hidup sangat zuhud di padang gurun, hanya memakan dedaunan dan memakai pakaian wol kasar, serta menangis karena rasa takut kepada Allah.\n\n'
          'Nabi Yahya berdakwah bersama sepupunya, Nabi Isa AS, membimbing Bani Israil kembali kepada ketaatan. Beliau dengan tegas menentang pernikahan terlarang Raja Herodes yang hendak menikahi keponakan/anak tirinya sendiri (Herodias).\n\n'
          'Karena ketegasannya membela syariat, Nabi Yahya ditangkap dan dihukum mati hingga wafat sebagai syahid yang mulia.',
      hikmah: [
        'Menuntut ilmu agama dan menghayati keimanan sejak usia dini.',
        'Keberanian menyuarakan kebenaran di hadapan penguasa yang melanggar hukum Allah.',
        'Gaya hidup zuhud dan sederhana menjauhkan diri dari fitnah keduniawian.',
      ],
      quranVerses: 'QS. Maryam: 12-15, Ali \'Imran: 39, Al-Anbiya: 90',
      mentionCountInQuran: 5,
    ),
    ModelKisahNabi(
      number: 24,
      name: 'Nabi Isa AS',
      arabicName: 'عِيسَىٰ عَلَيْهِ ٱلسَّلَامُ',
      era: '1 M - 33 M',
      age: '33 Tahun (Diangkat ke langit dalam keadaan hidup)',
      place: 'Betlehem, Nazaret, Yerusalem (Palestina)',
      kaum: 'Bani Israil (Penerima Kitab Injil)',
      isUlulAzmi: true,
      mukjizat: [
        'Lahir tanpa ayah dari rahim perawan suci Maryam binti Imran',
        'Mampu berbicara membela kesucian ibunya saat masih bayi di dalam buaian',
        'Membuat burung dari tanah liat lalu meniupnya hingga hidup terbang atas izin Allah',
        'Menyembuhkan orang buta sejak lahir dan penderita kusta (lepra)',
        'Menghidupkan orang yang telah mati atas izin Allah SWT',
        'Menurunkan hidangan makanan lengkap dari surga (Al-Ma\'idah)',
        'Diselamatkan dari penyaliban dan diangkat ke langit oleh Allah SWT',
      ],
      summary: 'Rasul Ulul Azmi penerima Kitab Injil, pembawa kabar kedatangan Nabi Muhammad, dan akan turun kembali di akhir zaman.',
      story: 'Nabi Isa AS dilahirkan oleh Sayyidah Maryam tanpa perantara seorang ayah, melalui tiupan ruh ciptaan Allah lewat Malaikat Jibril. Ketika kaumnya menuduh Maryam berzina, bayi Isa berbicara dari buaian: "Sesungguhnya aku ini hamba Allah, Dia memberiku Kitab (Injil) dan Dia menjadikan aku seorang Nabi."\n\n'
          'Nabi Isa diutus kepada Bani Israil untuk meluruskan ajaran Taurat dan membenarkan hukum-hukumnya. Allah membekalinya mukjizat agung: menyembuhkan penyakit kusta, mencelikkan mata orang buta, menghidupkan orang mati, serta menurunkan hidangan dari langit (Al-Ma\'idah) untuk para pengikut setianya (Hawariyyun).\n\n'
          'Beliau juga menyampaikan kabar gembira tentang kedatangan nabi penutup bernama "Ahmad" (Muhammad SAW).\n\n'
          'Ketika para pemuka Yahudi dan penguasa Romawi bersekongkol membunuhnya, Allah menyerupakan Yudas Iskariot (pengkhianat) dengan wajah Isa untuk disalib, sementara Nabi Isa diangkat oleh Allah ke langit dan akan turun kembali di akhir zaman untuk menegakkan keadilan.',
      hikmah: [
        'Kekuasaan mutlak Allah menciptakan apa pun yang dikehendaki-Nya.',
        'Kasih sayang, kelembutan, dan kerendahan hati dalam berdakwah.',
        'Kepalsuan penyaliban Nabi Isa dan kabar gembira kenabian Nabi Muhammad SAW.',
      ],
      quranVerses: 'QS. Ali \'Imran: 45-59, Maryam: 16-36, Al-Ma\'idah: 110-120, An-Nisa: 157-159',
      mentionCountInQuran: 25,
    ),
    ModelKisahNabi(
      number: 25,
      name: 'Nabi Muhammad SAW',
      arabicName: 'مُحَمَّدٌ صَلَّى ٱللَّٰهُ عَلَيْهِ وَسَلَّمَ',
      era: '571 - 632 M',
      age: '63 Tahun',
      place: 'Makkah Al-Mukarramah & Madinah Al-Munawwarah',
      kaum: 'Seluruh Umat Manusia & Jin (Rahmatan lil \'Alamin)',
      isUlulAzmi: true,
      mukjizat: [
        'Al-Qur\'an Al-Karim sebagai mukjizat abadi sepanjang zaman',
        'Peristiwa Isra\' dan Mi\'raj dari Masjidil Haram ke Masjidil Aqsa hingga Sidratul Muntaha dalam satu malam',
        'Membelah bulan menjadi dua bagian saat ditantang kaum kafir Quraisy',
        'Air memancar dari sela-sela jemari beliau mencukupi wudhu dan minum ribuan sahabat',
        'Makanan sedikit menjadi berlipat ganda mencukupi pasukan Perang Khandaq',
        'Pohon dan pelepah kurma menangis karena rindu pelukan beliau',
        'Mendapat gelar Khatamun Nabiyyin (Penutup Para Nabi) dan Sayyidul Mursalin',
      ],
      summary: 'Khatamun Nabiyyin, pemimpin para nabi dan rasul, pembawa risalah Islam yang menjadi rahmat bagi seluruh alam semesta.',
      story: 'Nabi Muhammad SAW lahir di Makkah pada Tahun Gajah (571 M) dalam keadaan yatim dari pasangan Abdullah dan Aminah. Beliau diasuh oleh kakeknya Abdul Muthalib lalu pamannya Abu Thalib. Sejak muda beliau dikenal dengan gelar "Al-Amin" (Orang yang Sangat Terpercaya).\n\n'
          'Pada usia 40 tahun saat berkhalwat di Gua Hira, Malaikat Jibril turun membawa wahyu pertama: "Iqra\' bismi rabbikalladzii khalaq." Beliau diangkat menjadi Rasulullah untuk seluruh umat manusia.\n\n'
          'Selama 13 tahun di Makkah, beliau berdakwah menanamkan aqidah tauhid menghadapi boikot, siksaan, dan ancaman pembunuhan kafir Quraisy. Allah menghiburnya dengan peristiwa agung Isra\' Mi\'raj dan kewajiban shalat 5 waktu.\n\n'
          'Beliau berhijrah ke Madinah (Yatsrib), mendirikan Masjid Nabawi, mempersaudarakan kaum Muhajirin dan Anshar, menyusun Piagam Madinah, serta memimpin berbagai peristiwa penting hingga Fathu Makkah (Penaklukan Makkah) tanpa pertumpahan darah.\n\n'
          'Beliau wafat di Madinah setelah menyempurnakan risalah Islam yang menjadi cahaya petunjuk hingga akhir zaman.',
      hikmah: [
        'Suri teladan sempurna (Uswatun Hasanah) dalam seluruh aspek kehidupan.',
        'Kasih sayang universal (Rahmatan lil \'Alamin) bahkan kepada musuh yang memusuhi beliau.',
        'Kewajiban mengikuti Sunnah dan mencintai Rasulullah melebihi diri sendiri.',
      ],
      quranVerses: 'QS. Al-Ahzab: 21 & 40, Al-Anbiya: 107, Al-Fath: 28-29, Muhammad: 1-38',
      mentionCountInQuran: 4,
    ),
  ];
}
