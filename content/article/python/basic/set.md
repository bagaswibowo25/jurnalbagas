---
title: "Belajar Python - Set"
date: 2022-02-10T21:22:46+07:00

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

Untuk menggabungkan elemen antar set dapat menggunakan fungsi `union()`. Data yang akan digabungkan akan bersifat unik dan tidak ada duplikat di dalamnya. Mari kita coba.
```py
set1 = {1,2,3,4}
set2 = {4,5,6,7}
set_union = set1.union(set2)
print(set_union)
```
Output
```
{1,2,3,4,5,6,7}
```
Dari hasil diatas, operasi `union()` akan menggabungkan elemen-elemen dari kedua set dan apabila terdapat elemen yang sama maka tidak akan dimasukkan kembali, pada contoh diatas adalah elemen `4` karena sudah ada di set1 maka `4` yang ada di set2 tidak masuk kedalam elemen `set_union`.

# Membandingkan Set

Set memiliki kemampuan untuk membandingkan data dari salah satu set terhadap set lainnya. Fungsi ini dapat berguna untuk melihat item apa saja yang hanya ada di elemen set utama yang dilakukan perbadingan terhadap set lainnya. Untuk melakukan perbandingan ini dapat menggunakan fungsi `difference()` atau `difference_update()`. Mari kita coba.
```py
set1 = {'aa','ab','ac'}
set2 = {'ab','bb','cb'}
print(set1.difference(set2))
```
Output
```
{'aa','ac'}
```
Dari output diatas kita dapat melihat item yang hanya ada di `set1` terhadap `set2` adalah `{'aa','ac'}` apabila kita lakukan sebaliknya maka hasilnya sebagai berikut:

```py
set1 = {'aa','ab','ac'}
set2 = {'ab','bb','cb'}
print(set2.difference(set1))
```
Output
```
{'bb','cb'}
```
Fungsi `difference()` akan menghasilkan output secara temporary, atau kita dapat menyimpannya kedalam variabel lain. Semisal kita ingin melakukan update terhadap set yang sudah ada maka dapat menggunakan `difference_update()`. Mari kita coba.

```py
set1 = {'aa','ab','ac'}
set2 = {'ab','bb','cb'}
set1.difference(set2)
print(set1)
```
Output
```
{'aa','ac'}
```
Dari contoh diatas nilai pada set1 akan diupdate. Fungsi perbandingan lainnya, yaitu `symmetric_difference()`. Hampir mirip dengan fungsi `difference()`, perbedaannya pada `symmetric_difference()` akan menampilkan perbedaan pada kedua set, data yang hanya ada pada kedua elemen akan ditampilkan. Mari kita coba.

```py
set1 = {'aa','ab','ac'}
set2 = {'ab','bb','cb'}
print(set2.symmetric_difference(set1))
```
Output
```
{'aa','cb','ac','bb'}
```
Dari hasil diatas dapat dilihat kalau output dari `symmetric_difference()` adalah item-item dari kedua set yang unik yang hanya terdapat pada masing-masing set. Untuk melakukan update pada set tertentu dapat menggunakan `smmetric_difference_update()` sama seperti sebelumnya.

Selanjutnya ada salah satu cara lagi untuk membandingkan kedua set untuk mencari nilai yang identik dari kedua set, yaitu dengan menggunakan fungsi `intersection()`. Fungsi ini akan mengembalikan nilai item-item unik satu set terhadap beberapa set lainnya. Mari kita coba

```py
set1 = {'aa','ab','ac'}
set2 = {'ab','bb','cb'}
set3 = {'ab','cc','ac'}
print(set1.intersection(set2,set3))
```
Output
```
{'ab'}
```
Pada contoh di atas terdapat 3 set, setiap set memiliki data yang beririsan dengan set lainnya. Jika kita melakukan perbandingan `set1` terhadap `set2` dan `set3`, maka nilai yang dikembalikan adalah `{'ab'}`, karena `{'ab'}` terdapat di ketiga set tersebut. Lain ceritanya jika kita membandingkan antara `set1` dengan `set3` saja maka hasilnya sebagai berikut:
```py
set1 = {'aa','ab','ac'}
set2 = {'ab','bb','cb'}
set3 = {'ab','cc','ac'}
print(set1.intersection(set3))
```
Output
```
{'ac', 'ab'}
```
Sama seperti perbandingan lainnya, kita dapat melakukan update terhadap nilai dari sebuah set secara langsung dengan menggunakan fungsi `intersection_update()`.

# Kesimpulan

Tipe data Set sangat berguna untuk membentuk sebuah himpunan yang didalamnya hanya terdapat nilai unik, sehingga tidak ada data yang duplikat, lalu kita dapat melakukan perbandingan antar set untuk melihat perbedaan dan persamaan elemen dari kedua atau lebih set. Sekian bahasan kali ini tentang set. Sampai ketemu lagi pada kesempatan berikutnya. Apabila ada kiritk, saran, ataupun masukan dapat menghubungi saya melalui halaman kontak diatas yaa. Terima kasih.