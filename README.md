### Assignment 6

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