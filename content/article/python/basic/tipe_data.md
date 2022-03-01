---
title: "Belajar Python - Tipe Data"
date: 2022-02-09T18:10:14+07:00

tags: ['Python','Programming']
author: "Bagas Wibowo"
noSummary: false
featuredImage: "/article/python/basic/data_type.jpg" 
---
# Pengenalan

Tipe data merupakan konsep yang cukup penting pada Python dan juga bahasa pemrograman lainnya. Pada Python, setiap nilai pasti memiliki tipe datanya tersendiri. Kegunaan dari tipe data ini untuk menglasifikasikan item data atau untuk menyimpan nilai kedalam suatu kategori data. Ini bertujuan untuk agar kita dapat mengetahui kegunaan dari item data tersebut dan operasi apa saja yang dapat dilakukan dengan tipe data tersebut.

Sebagai contoh, kita memiliki nilai integer `123`. Nilai tersebut dapat memiliki nilai yang berbeda apabila kita menggunakan tipe data yang lain, semisal ```string``` untuk nilai `123`. Untuk ujicoba mari kita lakukan skenario berikut:

```py
a = 123
b = 456
hasil = str(a)+str(b)
print(hasil)
```
Output:
```
123456
```

Maka hasil yang dikeluarkan adalah penggabungan antara nilai dari variable `a` dan `b` sebagai `string` bukan sebagai `integer`. Apabila operasi penjumlahan dengan menggunakan tipe data integer maka hasil yang dikeluarkan seperti berikut:

```py
a = 123
b = 456
hasil = a+b
print(hasil)
```
Output:
```
579
```

Dari hasil operasi penjumlahan maka nilai yang dikembalikan adalah integer pula, karena proses pada saat melakukan operasi penjumlahan tipe data yang digunakan adalah integer.

# Validasi Tipe Data

Untuk kalian yang penasaran dan ingin memastikan tipe data yang digunakan oleh sebuah variabel, maka kita dapat menggunakan fungsi `type()` yang dengan fungsi ini kita dapat mengetahui tipe data yang digunakan oleh variabel yang kita buat. 

```py
a = 123
b = '123'
print(type(a))
print(type(b))
```
Output:
```
<class 'int'>
<class 'str'>
```

Dari hasil output diatas kita dapat melihat bahwa walaupun sekilas variabel `a` dan `b` memiliki nilai yang sama, akan tetapi keduanya menggunakan tipe data yang berbeda.

Lalu apakah tipe data dapat diubah-ubah? Jawabannya, iya tipe data dapat diubah sesuai dengan bentuk yang kita inginkan. Seperti contoh berikut:

```py
user_input = input()
try:
    print(int(user_input))
except:
    print("Data yang anda masukkan salah! Masukkan angka")
```

Dari contoh diatas input dari user akan dikonversi menjadi integer dan apabila user memasukkan data selain integer maka akan ditolak.

# Macam-macam Tipe Data

Pada python ada beragam tipe data yang penting dan umum digunakan. Tipe data tersebut merupakan built-in dari Python, seperti string, integer, float, list, dictionary, dan lainnya. Untuk lengkapnya ada pada tabel berikut:

|Data Type | Type |
|----------|------|
|Text Type |str   |
|Numeric Types|	int, float, complex |
|Sequence Types|	list, tuple, range |
|Mapping Type |	dict |
|Set Types|	set, frozenset|
|Boolean Type|	bool |
|Binary Types|	bytes, bytearray, memoryview |

# Kesimpulan

Setelah membaca artikel ini, kalian dapat mempelajari beragam tipe data bawaan dan penting pada Python yang dapat kita gunakan. Lalu kita dapat memilih tipe data berdasarkan kegunaan dan operasi yang akan kita lakukan menyesuaikan tipe data yang dipilih. Saya harap sedikit cerita ini dapat membantu teman-teman dapat mengetahui dan memahami tentang tipe data pada Python.

Sampai jumpa pada artikel berikutnya, apabila ada kiritk, saran, ataupun masukan dapat menghubungi saya melalui halaman kontak diatas yaa. Terima kasih.