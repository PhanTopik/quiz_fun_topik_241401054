import '../Models/question_model.dart';

class SoalData {
  static final List<QuestionModel> flutterQuizQuestions = [
    QuestionModel(
      questionText: 'Apakah widget utama untuk membangun struktur dasar visual dalam Flutter?',
      options: ['Scaffold', 'Container', 'Column', 'SizedBox'],
      correctOptionIndex: 0,
    ),
    QuestionModel(
      questionText: 'Bahasa pemrograman apa yang digunakan oleh framework Flutter?',
      options: ['Python', 'Dart', 'Java', 'C++'],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Widget apa yang digunakan untuk membuat tampilan list yang dapat di-scroll secara efisien?',
      options: ['Column', 'Row', 'ListView.builder', 'Container'],
      correctOptionIndex: 2,
    ),
  ];

  // Diperbarui menjadi 5 soal untuk UTS KPT
  static final List<QuestionModel> kptQuizQuestions = [
    QuestionModel(
      questionText: 'Apa singkatan dari KPT dalam konteks ilmu komputer?',
      options: [
        'Komputasi Paralel dan Terdistribusi',
        'Keamanan Pemrograman Terstruktur',
        'Koneksi Protokol Telegram',
        'Kompilasi Perangkat Terpadu'
      ],
      correctOptionIndex: 0,
    ),
    QuestionModel(
      questionText: 'Manakah arsitektur komputer Flynn yang mengeksekusi satu instruksi pada banyak aliran data?',
      options: ['SISD', 'SIMD', 'MISD', 'MIMD'],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Model sistem terdistribusi di mana klien mengirim permintaan ke server dan menunggu respons disebut...',
      options: ['Peer-to-Peer', 'Client-Server', 'Cluster Computing', 'Grid Computing'],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Apa keuntungan utama dari komputasi paralel?',
      options: [
        'Menghemat kapasitas RAM secara drastis',
        'Menurunkan suhu prosesor',
        'Mempercepat waktu eksekusi program dengan membaginya ke banyak prosesor',
        'Menghilangkan kebutuhan akan jaringan internet'
      ],
      correctOptionIndex: 2,
    ),
    QuestionModel(
      questionText: 'Dalam sistem terdistribusi, tantangan apa yang berkaitan dengan ketidakseragaman waktu pada berbagai node?',
      options: ['Sinkronisasi waktu', 'Kapasitas kabel LAN', 'Warna antarmuka', 'Resolusi layar'],
      correctOptionIndex: 0,
    ),
  ];

  // Kuis Baru: HCI (Dasar-Dasar HCI) - 5 Soal
  static final List<QuestionModel> hciQuizQuestions = [
    QuestionModel(
      questionText: 'Apa kepanjangan dari HCI dalam bidang ilmu komputer?',
      options: [
        'Human Computer Interaction',
        'Hardware Central Interface',
        'Hyper Connection Internet',
        'Human Core Intelligence'
      ],
      correctOptionIndex: 0,
    ),
    QuestionModel(
      questionText: 'Prinsip desain antarmuka di mana pengguna selalu tahu apa yang sedang terjadi pada sistem disebut...',
      options: ['Flexibility', 'Visibility of system status', 'Consistency', 'Error prevention'],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Metode evaluasi HCI yang melibatkan pengguna secara langsung untuk menguji kegunaan sistem dinamakan...',
      options: ['Heuristic Evaluation', 'Cognitive Walkthrough', 'Usability Testing', 'Code Review'],
      correctOptionIndex: 2,
    ),
    QuestionModel(
      questionText: 'Faktor apa yang paling utama diperhatikan dalam perancangan User Experience (UX)?',
      options: [
        'Jumlah baris kode program',
        'Kenyamanan, emosi, dan kemudahan pengguna saat berinteraksi',
        'Kecepatan server basis data backend',
        'Pemilihan jenis lisensi software'
      ],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Manakah hukum dalam HCI yang menyatakan bahwa waktu untuk mencapai target adalah fungsi dari jarak dan ukuran target?',
      options: ['Hukum Moore', 'Hukum Fitts', 'Hukum Amdahl', 'Hukum Metcalfe'],
      correctOptionIndex: 1,
    ),
  ];

  // Kuis Baru: Business Intelligence (Penerapan Warehouse ke Organisasi) - 5 Soal
  static final List<QuestionModel> biQuizQuestions = [
    QuestionModel(
      questionText: 'Apa fungsi utama dari sebuah Data Warehouse dalam organisasi?',
      options: [
        'Tempat penyimpanan file multimedia sementara',
        'Penyimpanan data terpusat yang dioptimalkan untuk analisis dan pelaporan bisnis',
        'Aplikasi chat internal karyawan',
        'Sistem operasi server utama'
      ],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Proses mengekstrak, mengubah, dan memuat data dari berbagai sumber ke data warehouse dikenal dengan istilah...',
      options: ['CRUD', 'ETL (Extract, Transform, Load)', 'TCP/IP', 'OOP'],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Dalam perancangan data warehouse, skema manakah yang memiliki tabel fakta di tengah yang dikelilingi oleh tabel dimensi?',
      options: ['Star Schema', 'Flat Schema', 'Binary Schema', 'Linear Schema'],
      correctOptionIndex: 0,
    ),
    QuestionModel(
      questionText: 'Apa manfaat strategis penerapan data warehouse bagi organisasi bisnis?',
      options: [
        'Memperlambat proses pengambilan keputusan',
        'Menyediakan data historis yang konsisten untuk mendukung keputusan bisnis yang akurat',
        'Menghapuskan kebutuhan analisis manusia secara total',
        'Menurunkan jumlah pelanggan'
      ],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Apa perbedaan mendasar antara Operational Database (OLTP) dan Data Warehouse (OLAP)?',
      options: [
        'OLTP untuk transaksi harian, sedangkan OLAP untuk analisis data historis',
        'OLTP hanya untuk grafik, OLAP untuk teks',
        'Tidak ada perbedaan sama sekali',
        'OLTP dikelola oleh AI, OLAP dikelola oleh manusia'
      ],
      correctOptionIndex: 0,
    ),
  ];

  // Kuis Baru: Kriptografi (Algoritma Enkripsi Plaintext) - 5 Soal
  static final List<QuestionModel> cryptoQuizQuestions = [
    QuestionModel(
      questionText: 'Apa istilah untuk data asli atau pesan yang belum dienkripsi?',
      options: ['Ciphertext', 'Plaintext', 'Hash text', 'Source code'],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Manakah yang termasuk ke dalam contoh algoritma enkripsi simetris (Symmetric Cryptography)?',
      options: ['RSA', 'AES (Advanced Encryption Standard)', 'Diffie-Hellman', 'ECC'],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Apa nama hasil dari proses enkripsi yang mengubah plaintext menjadi data yang tidak dapat dibaca?',
      options: ['Plaintext', 'Ciphertext', 'Metadata', 'Script'],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Apa karakteristik utama dari algoritma kriptografi Asimetris?',
      options: [
        'Hanya menggunakan satu kunci yang sama untuk enkripsi dan dekripsi',
        'Menggunakan sepasang kunci: Kunci Publik (Public Key) dan Kunci Privat (Private Key)',
        'Tidak memerlukan kunci sama sekali',
        'Hanya bisa digunakan untuk data berukuran dibawah 1 KB'
      ],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Metode klasik substitusi sederhana di mana setiap huruf pada plaintext digeser sejauh beberapa langkah tertentu disebut...',
      options: ['RSA Cipher', 'AES Cipher', 'Caesar Cipher', 'MD5 Hash'],
      correctOptionIndex: 2,
    ),
  ];

  static List<QuestionModel> getSoalByQuizId(String quizId) {
    switch (quizId) {
      case '1':
        return flutterQuizQuestions;
      case '2':
        return kptQuizQuestions;
      case '3':
        return hciQuizQuestions;
      case '4':
        return biQuizQuestions;
      case '5':
        return cryptoQuizQuestions;
      default:
        return [];
    }
  }
}