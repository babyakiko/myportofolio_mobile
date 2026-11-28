# MyPortfolio Mobile

[![CI](https://github.com/babyakiko/myportofolio_mobile/actions/workflows/main.yaml/badge.svg)](https://github.com/babyakiko/myportofolio_mobile/actions/workflows/main.yaml)

Aplikasi portofolio seluler berbasis Flutter yang terintegrasi dengan backend Django REST Framework.

| Informasi | Detail |
| :--- | :--- |
| **Nama** | Baby Akiko Gracia |
| **NPM** | 2506625224 |
| **Kelas** | PBP C |
| **Repositori Backend Django** | [github.com/babyakiko/myportofolio](https://github.com/babyakiko/myportofolio) |
| **URL Backend Deploy (PWS)** | [baby-akiko-myportofolio.pws.cs.ui.ac.id](https://baby-akiko-myportofolio.pws.cs.ui.ac.id) |

### Daftar Isi
- [Instruksi Setup & Menjalankan Aplikasi](#instruksi-setup--menjalankan-aplikasi)
- [Assignment 7](#assignment-7)
- [Assignment 8](#assignment-8)
- [Assignment 9](#assignment-9)

---

## Instruksi Setup & Menjalankan Aplikasi

1. **Clone repositori dan pasang dependensi**
   ```bash
   git clone https://github.com/babyakiko/myportofolio_mobile.git
   cd myportofolio_mobile
   flutter pub get
   ```

2. **Generate kode serialisasi JSON (`*.g.dart`)**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Jalankan aplikasi sesuai target platform (`--dart-define=API_BASE_URL`)**
   - **Terhadap server Django yang sudah di-deploy (PWS):**
     ```bash
     flutter run --dart-define=API_BASE_URL=https://baby-akiko-myportofolio.pws.cs.ui.ac.id
     ```
   - **Django lokal + Emulator Android** (default `http://10.0.2.2:8000`):
     ```bash
     flutter run
     ```
   - **Django lokal + Chrome / Flutter Web:**
     ```bash
     flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
     ```
   - **Django lokal + Perangkat Android fisik (USB Debugging):**
     ```bash
     adb reverse tcp:8000 tcp:8000
     flutter run --dart-define=API_BASE_URL=http://localhost:8000
     ```

4. **Pemeriksaan format, analisis statis, dan pengujian**
   ```bash
   dart format lib test
   flutter analyze lib test
   flutter test
   ```

5. **Endpoint API yang digunakan**
   - `GET /api/v1/projects/` (publik) & `POST /api/v1/projects/` (`Authorization: Token <key>`)
   - `GET /api/v1/experiences/` (publik) & `POST /api/v1/experiences/` (`Authorization: Token <key>`)
   - `POST /api/v1/auth/token/` & `POST /api/v1/auth/logout/`

---

## Assignment 7

1. **Widget Tree & Hubungan Parent-Child**
   - **a. Widget Tree:** Konsep di mana antarmuka (UI) Flutter disusun secara hierarkis menyerupai pohon, dari widget utama (paling luar) bercabang ke widget-widget anak di dalamnya.
   - **b. Hubungan Parent-Child:** Widget induk (parent) bertindak sebagai wadah atau pengatur tata letak yang membungkus widget anak (child atau children). Data dan instruksi tata letak mengalir dari atas (induk) ke bawah (anak).

2. **Daftar Widget di Proyek Portofolio & Fungsinya**
   - **a. MaterialApp:** Sebagai kerangka dasar aplikasi dengan gaya Material Design.
   - **b. Scaffold:** Menyediakan kerangka visual standar halaman (seperti AppBar dan body).
   - **c. AppBar:** Menampilkan bilah judul di bagian atas layar.
   - **d. Padding:** Memberikan jarak ruang (padding) di sekeliling widget anaknya.
   - **e. Column:** Menyusun widget-widget anaknya secara vertikal (ke bawah).
   - **f. Row:** Menyusun widget-widget anaknya secara horizontal (ke samping).
   - **g. SingleChildScrollView:** Membuat konten di dalamnya bisa digulir (scroll) jika melebihi ukuran layar.
   - **h. Card:** Menampilkan wadah dengan efek bayangan (elevasi) agar tampak seperti kartu.
   - **i. Container:** Kotak serbaguna untuk mengatur ukuran, warna latar, dan margin.
   - **j. Text:** Menampilkan teks di layar.
   - **k. GridView.count:** Menampilkan daftar item dalam bentuk grid (tata letak kisi/kolom).
   - **l. Material & InkWell:** Memberikan efek visual sentuhan (ripple effect) saat tombol/kartu ditekan.
   - **m. Icon:** Menampilkan ikon grafis.

3. **Fungsi MaterialApp & Alasan Menjadi Root Widget**
   - **a. Fungsi:** Mengatur konfigurasi global aplikasi seperti judul aplikasi (title), tema warna (theme), dan halaman utama (home).
   - **b. Alasan sebagai Root:** Karena MaterialApp menyediakan fondasi sistem desain (Material Design) dan navigasi dasar yang wajib ada agar seluruh widget turunan di bawahnya dapat merender komponen visual dengan benar.

4. **Perbedaan StatelessWidget vs StatefulWidget**
   - **a. StatelessWidget:** Bersifat statis (tidak berubah). Tampilan tidak akan berubah dinamis setelah dirender karena tidak menyimpan data state lokal.
   - **b. StatefulWidget:** Bersifat dinamis (bisa berubah). Dapat menyimpan dan memperbarui data state sehingga UI bisa ikut berubah saat ada interaksi pengguna (misal: tombol counter bertambah).
   - **c. Kapan dipilih:**
     1. Gunakan Stateless untuk tampilan yang tetap/statis (seperti halaman portofolio kita, teks, kartu identitas).
     2. Gunakan Stateful jika halaman butuh mengubah data/tampilan secara interaktif (seperti form input, keranjang belanja, tombol like).

5. **Apa itu BuildContext & Peran di Metode Build**
   - **a. BuildContext:** Sebuah objek yang memegang informasi mengenai lokasi sebuah widget di dalam widget tree.
   - **b. Mengapa penting?** Digunakan untuk mencari posisi widget, mengakses data tema (`Theme.of(context)`), atau menampilkan elemen interaktif seperti SnackBar (`ScaffoldMessenger.of(context)`).
   - **c. Penggunaan di build:** Diteruskan sebagai parameter (`Widget build(BuildContext context)`) agar Flutter tahu di bagian pohon mana widget tersebut harus dirender.

6. **Hot Reload vs Hot Restart**
   - **a. Hot Reload:** Memasukkan perubahan kode baru ke dalam mesin yang sedang berjalan secara instan tanpa kehilangan status aplikasi (state saat ini tetap aman).
   - **b. Hot Restart:** Memuat ulang seluruh aplikasi dari awal dan menghapus status aplikasi yang sedang berjalan.
   - **c. Kapan harus Hot Restart / Full Restart?** Kita tidak bisa mengandalkan hot reload saat mengubah struktur kode yang mendasar, seperti:
     1. Mengubah fungsi `main()` atau inisialisasi awal.
     2. Menambah/mengubah aset gambar atau font.
     3. Mengubah struktur atau tipe data global/state utama aplikasi.

### AI Disclosure

Dalam pengerjaan portofolio mobile ini, saya menggunakan bantuan AI sebagai sarana pembelajaran, teman diskusi, dan alat bantu *debugging*.

- **Alat yang digunakan:** Gemini
- **Bagian yang dibantu:**
  1. Membantu memahami konsep dasar struktur proyek Flutter, pemisahan `menu.dart` dari `main.dart`, serta penggunaan widget `StatelessWidget`.
  2. Membantu merancang komponen antarmuka seperti `InfoCard`, model `ItemHomepage`, dan styling tombol `ItemCard` dengan warna unik serta interaksi `SnackBar`.
  3. Membantu menyelesaikan kendala saat terjadi error, typo, atau memastikan kode lolos analisis `flutter analyze`.
- **Refleksi Pengembangan:** AI saya gunakan untuk mempercepat proses *troubleshooting* dan membantu saya untuk memahami implementasi tata letak widget di Flutter. Ke depannya, saya ingin terus melatih kemandirian dalam merancang antarmuka aplikasi seluler yang responsif serta memperdalam logika pemrograman Dart secara mandiri.

---

## Assignment 8

1. **Perbedaan Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop()**
   - **a. Navigator.push():** Mendorong rute halaman baru ke puncak tumpukan navigasi (stack) di atas halaman saat ini, sementara halaman sebelumnya tetap ada di bawah sehingga pengguna bisa kembali menggunakan tombol kembali bawaan perangkat/browser atau `Navigator.pop()`.
   - **b. Navigator.pushReplacement():** Mengganti rute halaman aktif saat ini dengan rute baru di puncak tumpukan tanpa menumpuk riwayat halaman sebelumnya.
   - **c. Navigator.pop():** Menutup atau menghapus rute paling atas dari tumpukan navigasi untuk kembali ke layar sebelumnya, atau menutup dialog/modal aktif seperti `AlertDialog`.
   - **d. Penggunaan pada proyek:**
     1. Membuka formulir dari kartu aksi: Menggunakan `Navigator.push()` agar halaman utama tetap tersimpan di stack dan pengguna dapat kembali dengan tombol kembali bawaan perangkat/browser.
     2. Opsi Home di drawer: Menggunakan `Navigator.pushReplacement()` untuk mengganti halaman aktif ke `MyHomePage`, sekaligus memudahkan pengujian alur kembali ke halaman utama saat aplikasi dijalankan di Chrome.

2. **Peran Scaffold, AppBar, dan Drawer serta Konsistensi Warna Tema**
   - **a. Scaffold:** Menyediakan kerangka dasar halaman Material (seperti `appBar`, `drawer`, dan `body`) agar struktur antarhalaman konsisten.
   - **b. AppBar:** Menampilkan bilah judul dan tombol/ikon navigasi di bagian atas layar secara seragam.
   - **c. Drawer:** Menyediakan menu navigasi samping yang dapat digunakan kembali di berbagai halaman (seperti Home, Add Project, dan Add Experience melalui `LeftDrawer`).
   - **d. Contoh penggunaan warna tema portofolio:** Menggunakan warna tema/aksen yang konsisten lintas halaman (misalnya penggunaan warna tema utama / aksen seperti indigo pada header Drawer dan skema warna antarmuka di `MyHomePage` maupun `ExperienceFormPage`) agar identitas visual aplikasi tetap seragam.

3. **Tata Letak Formulir, Widget Pengatur Jarak, dan Widget Penggulir**
   - **a. Alasan pemilihan tata letak:** Formulir disusun menggunakan `Form` yang membungkus `SingleChildScrollView` dan `Column` (`crossAxisAlignment: CrossAxisAlignment.start`) agar input tersusun vertikal dari atas ke bawah dan mudah dikelola status validasinya.
   - **b. Peran widget penggulir (`SingleChildScrollView`):** Memungkinkan seluruh isi formulir digulir ketika tinggi layar terbatas—seperti pada layar ponsel yang sempit atau saat papan ketik (keyboard) muncul—sehingga kolom bawah dan tombol Simpan/Save tetap dapat dijangkau.
   - **c. Peran widget pengatur jarak (`Padding` dan `SizedBox`):** Memberikan ruang pemisah antar-field dan tombol agar tata letak tidak berdempetan serta nyaman ditekan saat papan ketik tampil.

4. **Peran GlobalKey\<FormState\>, validator, dan validate() serta Batasan Jenis Input / Papan Ketik**
   - **a. GlobalKey\<FormState\>:** Mengaitkan kunci unik ke state internal widget `Form` agar kode di luar `Form` (seperti `onPressed` tombol Simpan/Save) dapat memanggil fungsi validasi dan reset form.
   - **b. validator:** Menentukan aturan validasi per field yang mengembalikan pesan error jika input tidak memenuhi syarat, atau mengembalikan `null` jika input valid.
   - **c. validate():** Menjalankan seluruh validator pada field di dalam `Form` saat tombol Simpan/Save ditekan dan mengembalikan `true` hanya jika semua field lolos validasi.
   - **d. Contoh nilai yang ditolak & batasan jenis input/papan ketik:**
     1. Contoh nilai yang ditolak: Input berisi spasi saja (`"   "`) pada field wajib (seperti Title atau Description), atau URL tidak valid pada kolom Thumbnail.
     2. Mengapa jenis input / papan ketik saja belum cukup: Mengatur jenis input atau tata letak papan ketik (seperti `TextInputType.url` atau `TextInputType.datetime`) hanya membantu menampilkan tombol papan ketik yang sesuai, tetapi tidak mencegah pengguna mengetik/menempelkan teks bebas, mengosongkan kolom, atau memasukkan nilai yang melanggar aturan model.

### AI Disclosure

Dalam pengerjaan tugas ini, saya menggunakan bantuan AI sebagai sarana pembelajaran, teman diskusi, dan alat bantu *debugging*.

- **Alat yang digunakan:** Gemini
- **Bagian yang dibantu:**
  1. Membantu merancang struktur halaman formulir baru (`ExperienceFormPage`), integrasi navigasi pada kartu aksi dan drawer, serta penerapan tata letak responsif dengan `LayoutBuilder`.
  2. Membantu menyusun aturan validasi input, dialog ringkasan data dengan `AlertDialog`, serta draf jawaban pertanyaan reflektif untuk `README.md`.
  3. Membantu mengecek alur pengujian di Chrome, merapikan kode, dan memastikan proyek berjalan bersih saat dianalisis dengan `flutter analyze`.
- **Refleksi Pengembangan:** AI saya gunakan untuk mempercepat proses *troubleshooting* serta membantu memahami alur navigasi, validasi formulir, dan tata letak responsif di Flutter. Ke depannya, saya ingin terus melatih kemandirian dalam merancang validasi data yang sesuai model serta menguji tata letak di berbagai ukuran layar secara mandiri.

---

## Assignment 9

1. **Alasan Menggunakan `@JsonSerializable(fieldRename: FieldRename.snake)` & `@JsonKey(includeToJson: false)` Dibandingkan `Map<String, dynamic>` Mentah**
   - **a. `@JsonSerializable(fieldRename: FieldRename.snake)`:** Memetakan atribut `camelCase` pada Dart (seperti `startedAt`, `endedAt`, `isOngoing`, `starCount`) ke kunci JSON `snake_case` milik serializer Django (`started_at`, `ended_at`, `is_ongoing`, `star_count`) secara otomatis dan konsisten dengan pemeriksaan tipe saat kompilasi, sehingga widget tidak perlu merakit atau membaca kunci string `Map` secara manual.
   - **b. `@JsonKey(includeToJson: false)`:** Mengecualikan field yang nilainya ditetapkan oleh server (seperti `id` UUID, `started_at`, `is_ongoing`, dan `star_count`) agar tidak ikut terkirim di dalam body permintaan `POST` saat membuat entri baru.
   - **c. Contoh bug yang berhasil dicegah pada model `Experience`:**
     1. Pada backend Django, kolom `thumbnail` boleh bernilai `null` di database. Jika widget langsung melakukan casting `map['thumbnail'] as String`, aplikasi akan crash dengan error `TypeError: type 'Null' is not a subtype of type 'String'`. Dengan `@JsonKey(defaultValue: '')` pada model `Experience`, nilai `null` otomatis diubah menjadi string kosong `''`.
     2. Menghindari kesalahan penulisan kunci manual seperti mengirim `'endedAt'` alih-alih `'ended_at'` pada `Map` mentah yang akan diabaikan diam-diam oleh DRF.

2. **Alasan Menginisialisasi `Future` di `initState()` dan Melempar `ApiException` pada `ApiClient`**
   - **a. Inisialisasi `Future` di `initState()` vs `build()`:** Metode `build()` di Flutter dapat dipanggil berulang kali saat layar diperbarui (misalnya ketika muncul keyboard, animasi navigasi, atau perubahan state pada `Provider`). Jika pemanggilan HTTP ditaruh di dalam `build()`, aplikasi akan mengirim request jaringan berulang-ulang setiap kali widget dibangun ulang. Menyimpan `Future` di `initState()` memastikan pengambilan data hanya berjalan sekali saat layar dibuka dan hanya diulang saat pengguna menarik `RefreshIndicator` atau menekan tombol **Retry**.
   - **b. Melempar `ApiException` vs mengembalikan `null`:**
     1. Pada `FutureBuilder`, exception yang dilempar otomatis masuk ke `snapshot.hasError`, sehingga layar daftar dapat membedakan antara kondisi gagal memuat jaringan/server (menampilkan pesan error dan tombol **Retry**) dengan kondisi sukses namun datanya masih kosong (`[]`).
     2. `ApiException` menyimpan `statusCode` sehingga pemanggil seperti `ExperienceFormPage` dapat menangani tiap kasus secara tepat—contohnya menghapus sesi (`logout`) dan meminta login ulang khusus saat menerima status `401 Unauthorized`, atau menampilkan `SnackBar` untuk error lainnya.

3. **Perbandingan `SessionAuthentication` (Django) vs `TokenAuthentication` (DRF)**
   - **a. Perbedaan cara kerja:**
     1. `SessionAuthentication`: Menyimpan sesi login melalui cookie (`sessionid`) yang dikirim otomatis oleh browser di setiap request, sehingga wajib dilengkapi validasi token CSRF untuk mencegah serangan *Cross-Site Request Forgery*.
     2. `TokenAuthentication`: Menggunakan string token yang disimpan oleh aplikasi klien (`AuthState`) dan dikirim secara eksplisit melalui header `Authorization: Token <key>`. Karena tidak bergantung pada pengiriman cookie otomatis browser, skema ini tidak memerlukan token CSRF.
   - **b. Mengapa aplikasi mobile memakai `TokenAuthentication` tetapi `SessionAuthentication` tetap diaktifkan di Django:**
     1. Aplikasi Flutter di Android maupun Flutter Web (yang berjalan di port/origin berbeda dari Django) jauh lebih mudah dan stabil mengelola header `Authorization: Token` ketimbang mengelola cookie lintas-origin serta token CSRF.
     2. `SessionAuthentication` tetap diaktifkan di backend Django agar fitur-fitur pada halaman web portofolio sebelumnya (seperti login web, form modal AJAX, fitur *star*, dan Django Admin) tetap berfungsi normal di browser.

4. **Peran Job `build` & `build_apk` di GitHub Actions serta Alasan `*.g.dart` Masuk `.gitignore`**
   - **a. Job `build` (`very_good_workflows`):** Berperan sebagai tahap *Continuous Integration* (CI) untuk menjaga kualitas kode pada setiap `push` dan `pull_request`. Di balik layar, job ini menjalankan `flutter pub get`, perintah setup `build_runner`, pemeriksaan kerapian kode (`dart format --set-exit-if-changed`), analisis statis (`flutter analyze`), serta eksekusi seluruh pengujian beserta cakupan (`flutter test --coverage`).
   - **b. Job `build_apk`:** Berperan sebagai tahap *Continuous Delivery* (CD) yang hanya dijalankan setelah job `build` berhasil (`needs: build`). Job ini meng-generate ulang berkas `*.g.dart`, membangun APK rilis Android (`flutter build apk --release`), lalu mengunggah `app-release.apk` sebagai artefak `app-release-apk` agar dapat langsung diunduh dari GitHub Actions.
   - **c. Mengapa berkas `*.g.dart` dimasukkan ke `.gitignore`:** Karena berkas `*.g.dart` adalah kode hasil generasi otomatis dari kelas model sumber (`project.dart` dan `experience.dart`). Menyimpannya di Git dapat memicu konflik *merge*, mengotori riwayat commit, dan berisiko tidak sinkron jika model diubah tanpa menjalankan `build_runner`. Dengan memasukkannya ke `.gitignore` dan men-generate ulang lewat `build_runner` saat CI berjalan, kode sumber tetap bersih dan hasil serialisasi selalu sesuai dengan model terbaru.

### AI Disclosure

Dalam pengerjaan tugas ini, saya menggunakan bantuan AI sebagai sarana pembelajaran, teman diskusi, dan alat bantu *debugging*.

- **Alat yang digunakan:** Gemini
- **Bagian yang dibantu:**
  1. Membantu menyesuaikan model `@JsonSerializable` (`Project` dan `Experience`) dengan serializer DRF di backend Django, serta mengimplementasikan `ApiClient`, `AuthState`, dan `ensureLoggedIn`.
  2. Membantu membangun `ExperienceListScreen` dan `ExperienceDetailScreen` menggunakan `FutureBuilder` & `RefreshIndicator`, serta menghubungkan `ExperienceFormPage` ke endpoint `POST` terautentikasi dengan penanganan error `401`.
  3. Membantu mengonfigurasi workflow GitHub Actions CI/CD (`very_good_workflows` dan `build_apk`), menyelesaikan kendala format serta versi Gradle di CI, dan merapikan dokumentasi serta draf jawaban pertanyaan reflektif pada `README.md`.
- **Refleksi Pengembangan:** AI saya gunakan untuk mempercepat proses *troubleshooting* dan membantu saya memahami alur pemanggilan HTTP, autentikasi token dengan `Provider`, serta pipeline CI/CD di Flutter. Ke depannya, saya ingin terus melatih kemandirian dalam mengintegrasikan aplikasi mobile dengan REST API dan menulis pengujian otomatis secara mandiri.