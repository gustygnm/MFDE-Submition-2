# Aplikasi DITONTON

[![Codemagic build status](https://api.codemagic.io/apps/61ec0f62298f33aad588b3d5/61ec0f62298f33aad588b3d4/status_badge.svg)](https://codemagic.io/apps/61ec0f62298f33aad588b3d5/61ec0f62298f33aad588b3d4/latest_build)

## Proyek Akhir Membuat Aplikasi Siap Rilis
Selamat! Akhirnya Anda telah sampai di penghujung pembelajaran. Sejauh ini Anda telah:

  * Mengetahui teknik modularisasi untuk memecah aplikasi menjadi beberapa modul yang saling terhubung.
  * Mengetahui konsep reactive programming dan penerapan data stream pada pengembangan aplikasi Flutter.
  * Mengetahui bagaimana mengimplementasikan state management menggunakan BLoC.
  * Mengintegrasikan proyek aplikasi dengan layanan continuous integration.
  * Mengerti apa saja yang perlu diperhatikan dan dipersiapkan sebelum merilis aplikasi.

Untuk lulus dari kelas ini, ada tugas yang harus Anda kerjakan yaitu menyiapkan dan memastikan aplikasi Ditonton telah benar-benar siap dan stabil untuk dirilis ke pengguna.


## Kriteria Submission

Terdapat beberapa kriteria utama yang harus Anda penuhi untuk mengembangkan aplikasi Ditonton kali ini.

**Menerapkan Continuous Integration**
  * Menjalankan pengujian aplikasi secara otomatis. Semua pengujian harus tetap terpenuhi dan mempertahankan fitur dari submission sebelumnya.
  * Dijalankan setiap ada push kode terbaru ke dalam repository.
  * Anda perlu mengunggah kode ke dalam GitHub repository milik Anda sendiri lalu mencantumkan tautannya sebagai catatan (pastikan repository yang digunakan adalah repository public).
  * Menampilkan build status badge pada berkas readme repository GitHub. (Contoh dengan [Codemagic](https://docs.codemagic.io/yaml-publishing/status-badges/)).
  * Melampirkan screenchot salah satu build dari CI service.
  * Anda bebas menggunakan layanan CI apa pun untuk submission.

**Menggunakan Library BLoC**
  * Melakukan migrasi state management yang sebelumnya menggunakan provider menjadi BLoC.

**Menerapkan SSL Pinning**
  * Memasang sertifikat SSL pada aplikasi sebagai lapisan keamanan tambahan untuk mengakses data dari API.


**Integrasi dengan Firebase Analytics & Crashlytics**
  * Memastikan developer tetap mendapat feedback dari pengguna, khususnya terkait stabilitas dan laporan eror. 
  * Ditunjukkan dengan screenshot halaman Analytics dan Crashlytics.
