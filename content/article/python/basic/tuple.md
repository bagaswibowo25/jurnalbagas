---
title: "Belajar Python - Tuple"
date: 2022-02-10T23:21:35+07:00

tags: ['Python','Programming']
author: "Bagas Wibowo"
noSummary: false
featuredImage: "/article/python/basic/tuple.jpg" 
---

# Pengenalan

Tuple merupakan salah satu dari jenis tipe data collection yang ada di Python. Sebelumnya kita sudah bahas terka [List](../list), bagi kamu ingin mengetahui terkait list bisa baca pada artikel sebelumnya. Tuple hampir serupa dengan list namun memiliki karakteristik sebagai berikut:
- Ordered
- Unchangeable
- Allow Duplicates
  
Tuple memiliki operasi atau fungsi yang lebih sedikit dibandingkan tipe data collection lainnya. Memiliki sifat yang mirip seperti list, tuple biasanya digunakan ketika data tersebut ingin dibuat persistent sehingga tidak dapat diubah-ubah kembali.

```py
>>> print(dir(tuple()))
['__add__', '__class__', '__contains__', '__delattr__', 
'__dir__', '__doc__', '__eq__', '__format__', '__ge__', 
'__getattribute__', '__getitem__', '__getnewargs__', 
'__gt__', '__hash__', '__init__', '__init_subclass__', 
'__iter__', '__le__', '__len__', '__lt__', '__mul__', 
'__ne__', '__new__', '__reduce__', '__reduce_ex__', 
'__repr__', '__rmul__', '__setattr__', '__sizeof__', 
'__str__', '__subclasshook__', 'count', 'index']
>>> 
```
Fungsi bawaan yang dapat digunakan, seperti `count()` dan `index()`. Untuk itu mari kita coba.

# Menggunakan Count

Fungsi `count()` pada tuple digunakan untuk jumlah banyaknya elemen yang muncul dari satu set tuple. Contohnya sebagai berikut:

```py
tuple1 = ('abc','cbd','abc','abb')
tuple1.count('abc')
```
Output
```
2
```
Atau
```py
tuple1 = ('abc','cbd','abc','abb')
tuple1.count(tuple1[0])
```
Output
```
2
```

Kedua cara `count()` di atas menghasilkan output yang sama, tetapi menggunakan cara yang berbeda. Cara pertama kita memasukkan string atau karakter dari elemen, maka akan menghitung jumlah elemen yang sama sesuai dengan string atau karakter yang diminta dan ini bersifat *case sensitive*.

# Menggunakan Index

Fungsi `index()` pada tuple digunakan untuk mencari indeks dari sebuah string atau karakter. Apabila terdapat lebih dari satu elemen yang sama, maka akan menghasilkan output indeks pertama yang ditemukan. Contohnya sebagai berikut:

```py
tuple1 = ('abc','cbd','abc','abb')
tuple1.index('abc')
```
Output
```
0
```
Dari contoh di atas terdapat elemen `abc` pada indeks ke-0 dan ke-2. Namun output dari hasil pencarian indeks dari `abc` adalah 0 karena pertama ditemukan pada indeks 0.

# Membuat Tuple

Tuple dapat dibuat dengan kita mendefinisikan value dalam `()` atau kita juga dapat membuatnya dengan mengonversi tipe data lain menjadi tuple. Contohnya sebagai berikut:

```py
tuple1 = ('hello','world')
print(tuple1)
```
Output
```
('hello','world')
```
Atau kita dapat membuat tuple dari tipe data lain, misalnya list.

```py
list1 = ['hello','world']
print('List:')
print(list1)
list_to_tuple = tuple(list1)
print('Tuple:')
print(list_to_tuple)
```
Output
```
List:
['hello', 'world']
Tuple:
('hello','world')
```

Setelah data dikonversi menjadi tuple, data tersebut akan menjadi immutable, sehingga bila kita ingin memodifikasi isi datanya kita perlu mengoversi menjadi bentuk lainnya, misal list. Karena tidak bisa diubah, maka kita hanya dapat me-replace tuple yang sudah ada apabila ingin mengubah elemen yang ada didalamnya. Contohnya sebagai berikut:
```py
tuple1 = (1,2,3)
print(tuple1)
tuple1 = (1,2,3,4)
print(tuple1)
```
Output
```
(1,2,3)
(1,2,3,4)
```
Dari contoh diatas terlihat sedikit kurang efisien, karena apabila kita ingin mengubah isi elemen dari tuple perlu mereplace keseluruhan isi dari elemen tersebut. Alternatifnya kita dapat mengonversi terlebih dahulu menjadi list agar dapat memodifikasinya sebagaimana list, setelah itu kita dapat mengembalikannya sebagai tuple.

# Modifikasi Tuple

Untuk melakukan modifikasi tuple kita dapat melakukan konversi terlebih dahulu menjadi tipe data list, setelah itu kita dapat melakukan seluruh fungsi list pada seluruh elemen tuple sebelumnya. Contohnya sebagai berikut:

```py
tuple1 = (1,2,3)
tuple1 = list(tuple1)
tuple1.append(4)
tuple1.remove(2)
tuple1 = tuple(tuple1)
print(tuple1)
```
Output
```
(1,3,4)
```

# Menggabungkan Tuple

Selain kedua operasi diatas kita juga dapat menggabungkan beberapa tuple sekaligus. Mari kita coba.

```py
tuple1 = (1,2,3)
tuple2 = (4,5,6)
tuple3 = (7,8,9)
tuple1 = tuple1+tuple2+tuple3
print(tuple1)
```
Output
```
(1,2,3,4,5,6,7,8,9)
```
Dari contoh diatas elemen pada tuple1 merupakan gabungan dari ketiga tuple dan elemen aslinya digantikan oleh hasil penggabungan tadi.

# Kesimpulan

Tuple merupakan salah satu tipe data collection pada Python, tipe data ini sangat berguna apabila kita ingin menyimpan sekumpulan data kedalam elemen-elemen dan *immutable*. Jika ingin melakukan perubahan data kalian dapat me-replace atau mengubah terlebih dahulu tuple tersebut menjadi tipe data lainnya.

Sekian bahasan kali ini tentang tuple. Sampai ketemu lagi pada kesempatan berikutnya. Apabila ada kiritk, saran, ataupun masukan dapat menghubungi saya melalui halaman kontak diatas yaa. Terima kasih.