### Assignment 7

1. Widget Tree & Hubungan Parent-Child
    a. Widget Tree: Konsep di mana antarmuka (UI) Flutter disusun secara hierarkis menyerupai pohon, dari widget utama (paling luar) bercabang ke widget-widget anak di dalamnya.
    b. Hubungan Parent-Child: Widget induk (parent) bertindak sebagai wadah atau pengatur tata letak yang membungkus widget anak (child atau children). Data dan instruksi tata letak mengalir dari atas (induk) ke bawah (anak).

2. Daftar Widget di Proyek Portofolio & Fungsinya
    a. MaterialApp: Sebagai kerangka dasar aplikasi dengan gaya Material Design.
    b. Scaffold: Menyediakan kerangka visual standar halaman (seperti AppBar dan body).
    c. AppBar: Menampilkan bilah judul di bagian atas layar.
    d. Padding: Memberikan jarak ruang (padding) di sekeliling widget anaknya.
    e. Column: Menyusun widget-widget anaknya secara vertikal (ke bawah).
    f. Row: Menyusun widget-widget anaknya secara horizontal (ke samping).
    g. SingleChildScrollView: Membuat konten di dalamnya bisa digulir (scroll) jika melebihi ukuran layar.
    h. Card: Menampilkan wadah dengan efek bayangan (elevasi) agar tampak seperti kartu.
    i. Container: Kotak serbaguna untuk mengatur ukuran, warna latar, dan margin.
    j. Text: Menampilkan teks di layar.
    k. GridView.count: Menampilkan daftar item dalam bentuk grid (tata letak kisi/kolom).
    l. Material & InkWell: Memberikan efek visual sentuhan (ripple effect) saat tombol/kartu ditekan.
    m. Icon: Menampilkan ikon grafis.

3. Fungsi MaterialApp & Alasan Menjadi Root Widget
    a. Fungsi: Mengatur konfigurasi global aplikasi seperti judul aplikasi (title), tema warna (theme), dan halaman utama (home).
    b. Alasan sebagai Root: Karena MaterialApp menyediakan fondasi sistem desain (Material Design) dan navigasi dasar yang wajib ada agar seluruh widget turunan di bawahnya dapat merender komponen visual dengan benar.

4. Perbedaan StatelessWidget vs StatefulWidget
    a. StatelessWidget: Bersifat statis (tidak berubah). Tampilan tidak akan berubah dinamis setelah dirender karena tidak menyimpan data state lokal.
    b. StatefulWidget: Bersifat dinamis (bisa berubah). Dapat menyimpan dan memperbarui data state sehingga UI bisa ikut berubah saat ada interaksi pengguna (misal: tombol counter bertambah).
    c. Kapan dipilih:
        1. Gunakan Stateless untuk tampilan yang tetap/statis (seperti halaman portofolio kita, teks, kartu identitas).
        2. Gunakan Stateful jika halaman butuh mengubah data/tampilan secara interaktif (seperti form input, keranjang belanja, tombol like).

5. Apa itu BuildContext & Peran di Metode Build
    a. BuildContext: Sebuah objek yang memegang informasi mengenai lokasi sebuah widget di dalam widget tree.
    b. Mengapa penting? Digunakan untuk mencari posisi widget, mengakses data tema (Theme.of(context)), atau menampilkan elemen interaktif seperti SnackBar (ScaffoldMessenger.of(context)).
    c. Penggunaan di build: Diteruskan sebagai parameter (Widget build(Context context)) agar Flutter tahu di bagian pohon mana widget tersebut harus dirender.

6. Hot Reload vs Hot Restart
    a. Hot Reload: Memasukkan perubahan kode baru ke dalam mesin yang sedang berjalan secara instan tanpa kehilangan status aplikasi (state saat ini tetap aman).
    b. Hot Restart: Memuat ulang seluruh aplikasi dari awal dan menghapus status aplikasi yang sedang berjalan.
    c. Kapan harus Hot Restart / Full Restart?
    Kita tidak bisa mengandalkan hot reload saat mengubah struktur kode yang mendasar, seperti:
        1. Mengubah fungsi main() atau inisialisasi awal.
        2. Menambah/mengubah aset gambar atau font.
        3. Mengubah struktur atau tipe data global/state utama aplikasi.

### AI Disclosure

Dalam pengerjaan portofolio mobile ini, saya menggunakan bantuan AI sebagai sarana pembelajaran, teman diskusi, dan alat bantu *debugging*.

Alat yang digunakan: Gemini
Bagian yang dibantu: 
    1. Membantu memahami konsep dasar struktur proyek Flutter, pemisahan menu.dart dari main.dart, serta penggunaan widget StatelessWidget.
    2. Membantu merancang komponen antarmuka seperti InfoCard, model ItemHomepage, dan styling tombol ItemCard dengan warna unik serta interaksi SnackBar.
    3. Membantu menyelesaikan kendala saat terjadi error, typo, atau memastikan kode lolos analisis flutter analyze.
Refleksi Pengembangan: AI saya gunakan untuk mempercepat proses *troubleshooting* dan membantu saya untuk memahami implementasi tata letak widget di Flutter. Ke depannya, saya ingin terus melatih kemandirian dalam merancang antarmuka aplikasi seluler yang responsif serta memperdalam logika pemrograman Dart secara mandiri.

### Assignment 8 

1. Perbedaan Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop()
    a. Navigator.push(): Mendorong rute halaman baru ke puncak tumpukan navigasi (stack) di atas halaman saat ini, sementara halaman sebelumnya tetap ada di bawah sehingga pengguna bisa kembali menggunakan tombol kembali bawaan perangkat/browser atau Navigator.pop().
    b. Navigator.pushReplacement(): Mengganti rute halaman aktif saat ini dengan rute baru di puncak tumpukan tanpa menumpuk riwayat halaman sebelumnya.
    c. Navigator.pop(): Menutup atau menghapus rute paling atas dari tumpukan navigasi untuk kembali ke layar sebelumnya, atau menutup dialog/modal aktif seperti AlertDialog.
    d. Penggunaan pada proyek:
        1. Membuka formulir dari kartu aksi: Menggunakan Navigator.push() agar halaman utama tetap tersimpan di stack dan pengguna dapat kembali dengan tombol kembali bawaan perangkat/browser.
        2. Opsi Home di drawer: Menggunakan Navigator.pushReplacement() untuk mengganti halaman aktif ke MyHomePage, sekaligus memudahkan pengujian alur kembali ke halaman utama saat aplikasi dijalankan di Chrome.

2. Peran Scaffold, AppBar, dan Drawer serta Konsistensi Warna Tema
    a. Scaffold: Menyediakan kerangka dasar halaman Material (seperti appBar, drawer, dan body) agar struktur antarhalaman konsisten.
    b. AppBar: Menampilkan bilah judul dan tombol/ikon navigasi di bagian atas layar secara seragam.
    c. Drawer: Menyediakan menu navigasi samping yang dapat digunakan kembali di berbagai halaman (seperti Home, Add Project, dan Add Experience melalui LeftDrawer).
    d. Contoh penggunaan warna tema portofolio: Menggunakan warna tema/aksen yang konsisten lintas halaman (misalnya penggunaan warna tema utama / aksen seperti indigo pada header Drawer dan skema warna antarmuka di MyHomePage maupun ExperienceFormPage) agar identitas visual aplikasi tetap seragam.

3. Tata Letak Formulir, Widget Pengatur Jarak, dan Widget Penggulir
    a. Alasan pemilihan tata letak: Formulir disusun menggunakan Form yang membungkus SingleChildScrollView dan Column (crossAxisAlignment: CrossAxisAlignment.start) agar input tersusun vertikal dari atas ke bawah dan mudah dikelola status validasinya.
    b. Peran widget penggulir (SingleChildScrollView): Memungkinkan seluruh isi formulir digulir ketika tinggi layar terbatas—seperti pada layar ponsel yang sempit atau saat papan ketik (keyboard) muncul—sehingga kolom bawah dan tombol Simpan/Save tetap dapat dijangkau.
    c. Peran widget pengatur jarak (Padding dan SizedBox): Memberikan ruang pemisah antar-field dan tombol agar tata letak tidak berdempetan serta nyaman ditekan saat papan ketik tampil.

4. Peran GlobalKey<FormState>, validator, dan validate() serta Batasan Jenis Input / Papan Ketik
    a. GlobalKey<FormState>: Mengaitkan kunci unik ke state internal widget Form agar kode di luar Form (seperti onPressed tombol Simpan/Save) dapat memanggil fungsi validasi dan reset form.
    b. validator: Menentukan aturan validasi per field yang mengembalikan pesan error jika input tidak memenuhi syarat, atau mengembalikan null jika input valid.
    c. validate(): Menjalankan seluruh validator pada field di dalam Form saat tombol Simpan/Save ditekan dan mengembalikan true hanya jika semua field lolos validasi.
    d. Contoh nilai yang ditolak & batasan jenis input/papan ketik:
        1. Contoh nilai yang ditolak: Input berisi spasi saja ("   ") pada field wajib (seperti Title atau Description), atau URL tidak valid pada kolom Thumbnail.
        2. Mengapa jenis input / papan ketik saja belum cukup: Mengatur jenis input atau tata letak papan ketik (seperti TextInputType.url atau TextInputType.datetime) hanya membantu menampilkan tombol papan ketik yang sesuai, tetapi tidak mencegah pengguna mengetik/menempelkan teks bebas, mengosongkan kolom, atau memasukkan nilai yang melanggar aturan model.

### AI Disclosure

Dalam pengerjaan tugas ini, saya menggunakan bantuan AI sebagai sarana pembelajaran, teman diskusi, dan alat bantu *debugging*.

Alat yang digunakan: Gemini
Bagian yang dibantu: 
    1. Membantu merancang struktur halaman formulir baru (ExperienceFormPage), integrasi navigasi pada kartu aksi dan drawer, serta penerapan tata letak responsif dengan LayoutBuilder.
    2. Membantu menyusun aturan validasi input, dialog ringkasan data dengan AlertDialog, serta draf jawaban pertanyaan reflektif untuk README.md.
    3. Membantu mengecek alur pengujian di Chrome, merapikan kode, dan memastikan proyek berjalan bersih saat dianalisis dengan flutter analyze.
Refleksi Pengembangan: AI saya gunakan untuk mempercepat proses *troubleshooting* serta membantu memahami alur navigasi, validasi formulir, dan tata letak responsif di Flutter. Ke depannya, saya ingin terus melatih kemandirian dalam merancang validasi data yang sesuai model serta menguji tata letak di berbagai ukuran layar secara mandiri.