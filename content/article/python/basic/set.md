---
title: "Belajar Python - Set"
date: 2022-02-10T21:18:30+07:00

tags: ['Python','Programming']
author: "Bagas Wibowo"
noSummary: false
featuredImage: "/article/python/basic/set.jpg" 
---

# Pengenalan

Set merupakan salah satu tipe data lainnya untuk collection pada Python. Set memiliki karakteristik sebagai berikut:

- Unordered
- Mutable
- Duplicates Not Allowed

Sama seperti tipe data sebelumnya yang sudah sempat dibahas, yaitu [List](../list) dan [Tuple](../tuple). Set memiliki karakteristik sendiri, yaitu tidak adanya indeks sehingga tidak berurut dan tidak duplikat.

Set bisa digunakan untuk menghilangkan duplikat data pada sebuah collection. Set dibentuk dengan `{}` dan terdapat banyak operasi yang dapat dilakukan dalam set, antara lain sebagai berikut:

| Operasi | Deskripsi |
|---------|-----------|
|union() | Menggabungkan dua atau lebih beberapa set menjadi satu dan setiap elemen yang ada didalamnya unik |
| intersection() | Berfungsi untuk menampilkan elemen yang beririsan pada dua atau lebih beberapa set |
| difference() | Berfungsi untuk menampilkan elemen yang hanya ada di salah satu set terhadap set lainnya |
| symmetric_difference | Berfungsi untuk menampilkan elemen unik yang hanya ada dikedua set yang dibandingkan |

# Membuat Set

Set dapat dibuat dengan konstruktor `set()` atau `{}`. Data yang diubah menjadi set maka elemen yang ada di dalamnya menjadi tidak berurut dan unik, apabila terdapat elemen yang sama sebelumnya maka akan dihapus pada saat diubah menjadi tipe data set. Untuk itu mari kita coba.

```py
set1 = {1,2,3}
print(set1)
set1 = {1,2,3,3}
print(set1)
```
Output
```
{1,2,3}
{1,2,3}
```
```py
list1 = [1,2,3,3]
print(list1)
list1 = set(list1)
print(list1)
```
Output:
```
[1,2,3,3]
{1,2,3}
```

# Menggabungkan Set

Untuk menggabungkan elemen antar set dapat menggunakan fungsi `union()`. Data yang akan digabungkan akan bersifat unik dan tidak ada duplikat
