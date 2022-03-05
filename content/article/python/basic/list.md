---
title: "Belajar Python - List"
date: 2022-02-10T21:18:30+07:00

tags: ['Python','Programming']
author: "Bagas Wibowo"
noSummary: false
featuredImage: "/article/python/basic/list.jpg" 
---

# Pengenalan

List merupakan salah satu dari 4 built-in tipe data pada Python yang digunakan untuk menyimpan sekumpulan data. List bekerja layaknya array. Jika kalian pernah mencoba array maka list pun serupa. Namun ada beberapa perbedaan antara list dan array secara umum, seperti list tidak didefinisikan alokasi jumlahnya diawal, sedangkan array kita perlu menentukan besarnya diawal. Lalu perbedaan lainnya, seperti array umumnya hanya bisa menampung satu tipe data yang sama, sedangkan list bisa menampung beragam data sekaligus. Berikut sifat list pada Python yang kita jumpai:
- Berurutan
- Dapat berubah isinya
- Beragam jenis nilai
- Data item diperbolehkan duplikat

Sebelumnya tanpa kita mendefiniskan list, variabel yang mengandung string dapat kita akses indeksnya satu persatu. Seperti contoh berikut
```py
string = "Hello"
print(string[0])
```
Output:
```
H
```

Tetapi kita penasaran kan, lalu tipe data yang digunakan itu apa sih? Mari kita coba
```py
string = "Hello"
string_1 = string[0]
print(string_1)
```
Output:
```
<class 'str'>
```
Yak, dari hasil percobaan tersebut, tipe datanya tetap string, namun kita dapat mengakses elemen dari string tersebut seperti kita mengakses array.

# Mengakses list

Untuk mengakses caranya cukup mudah, jika ingin mengetahui seluruh element kita hanya perlu memanggil list tersebut.
```py
list1 = [4,5,6,1,2,3]
print(list1)
```
Output:
```
[4,5,6,1,2,3]
```
```py
list1 = [4,5,6,1,2,3]
print(list1[0])
```
Output:
```
4
```
Kita dapat mengakses nilai list dengan menentukan indeks dari list yang dituju. Jika ingin mengetahui indeks dari nilai yang dicari dapat dilakukan dengan cara berikut:
```py
list1 = [4,5,6,1,2,3]
print(list1.index(4))
```
Output:
```
0
```
Selain cara diatas kita juga bisa menggunakan looping untuk menampilkan setiap elemen pada list. Contohnya sebagai berikut:
```py
list1 = [4,5,6,1,2,3]
for i in list1:
    print(i)
```
Output:
```
4
5
6
1
2
3
```
Jika ingin mengeluarkan nilai elemen dalam satu baris tanpa `[]`. Dapat menggunakan cara sebagai berikut:
```py
list1 = [4,5,6,1,2,3]
print(*list1)
```
Output:
```
4 5 6 1 2 3
```
`*` asterisk berfungsi untuk membongkar perulangan ke dalam argumen disaat kita memanggil suatu fungsi. Maka dari itu hasil yang ditampilkan mirip dengan perulangan namun dalam satu baris.

Atau kita juga dapat mengubah sekumpulan elemen tersebut menjadi satu kumpulan karakter yang dijadikan string. Hal tersebut dapat dilakukan sebagai berikut:
```py
list1 = [4,5,6,1,2,3]
string_ints = [str(i) for i in list1]
string = ','.join(string_ints)
print(string)
```
Dengan cara di atas kita mengubah elemen dalam *list1* menjadi string lalu kita menggabungkan kumpulan string tersebut dengan fungsi `join()`.

Selain itu kita juga dapat melakukan hal sebaliknya, yaitu mengubah string kedalam list. Kita dapat melakukannya dengan cara sebagai berikut:
```py
string = "Hello"
string_list = [str(i) for i in string]
print(string_list)
```

Selain itu kita juga dapat mengakses list dengan rentang indeks tertentu, istilah ini biasa disebut slicing. Untuk mengindikasikan sebuah interval kita bisa menggunakan `[<start>:<stop>]` untuk mengakses sebuah indeks. Oiya dalam melakukan pengindeksan kita dapat melakukan secara positif atau negatif. Positif artinya kita mulai dari indeks kiri sampai kanan, sedangkan negatif artinya kita mulai dari indeks kanan sampai kiri. Contohnya sebagai berikut:

```py
list1 = [4,5,6,1,2,3]
print(list1[-1])
```
Output:
```
3
```
```py
list1 = [4,5,6,1,2,3]
print(list1[0:6])
```
Output:
```
[4, 5, 6, 1, 2, 3]
```
```py
list1 = [4,5,6,1,2,3]
print(list1[-6:-1])
```
Output:
```
[4, 5, 6, 1, 2]
```
Contoh lainnya kita dapat menambahkan `:` pada saat melakukan slicing untuk menentukan lompatan indeks yang dilakukan. Contohnya sebagai berikut:
```py
list1 = [4,5,6,1,2,3]
print(list1[0:6:2])
```
Output:
```
[4, 6, 2]
```
Jika ingin membalik urutannya kita dapat menggunakan step negatif indeks. Contohnya sebagai berikut:
```py
list1 = [4,5,6,1,2,3]
print(list1[6::-1])
```
Atau
```py
list1 = [4,5,6,1,2,3]
print(list1[::-1])
```
Output:
```
[3, 2, 1, 6, 5, 4]
```
# Mengubah List

Sesuai dengan sifat list, yaitu mutable jadi elemen yang ada di list dapat diubah atau ditambah. Untuk memodifikasi isi dari list kita dapat menggunakan beberapa fungsi, seperti `append()`, `insert()`, `extend()`, `zip()`, `remove()`, dan `pop()`. Mari kita coba

1. Menambah elemen list

Untuk menambah elemen list kita dapat menggunakan fungsi `.append()` atau melakukan addition untuk menggabungkan list. Contohnya sebagai berikut:
   ```py
   list1 = [1,2,3,4,5]
   list1.append(6)
   print(list1)
   ```

   Output:
   ```
   [1, 2, 3, 4, 5, 6]
   ```
   Secara default data akan dimasukkan dibagian akhir dari elemen. Jika kita ingin memasukkan data pada specific indeks atau diawal index, maka kita dapat menggunakan fungsi `insert()`. Contohnya sebagai berikut:
   ```py
   list1 = [1,2,3,4,5]
   list1.insert(0,6)
   print(list1)
   ```

   Output:
   ```
   [6, 1, 2, 3, 4, 5]
   ```
2. Menghapus elemen list
   
Selanjutnya kita juga dapat menghapus elemen dari sebuah list dengan indeks menggunakan fungsi `remove()` atau kita dapat menghapusnya dengan cara menghapus elemen paling akhir dengan fungsi `pop()`. Berikut adalah contohnya:
   ```py
   list1 = [4,5,6,1,2,3]
   list1.remove(list1[0])
   print(list1)
   ```
   Atau
   ```py
   list1 = [4,5,6,1,2,3]
   list1.remove(4)
   print(list1)
   ```
   Output:
   ```
   [5, 6, 1, 2, 3]
   ```
   ```py
   list1 = [4,5,6,1,2,3]
   list1.pop()
   print(list1)
   ```
   ```
   [4, 5, 6, 1, 2]
   ```

3. Menggabungkan elemen list
   
Untuk melakukan penggabungan elemen antar list ada beragam cara yang dapat dilakukan, seperti menggunakan `extend()`, `+`, dan `append()`. Mari kita coba.

   ```py
   list1 = [4,5,6,1,2,3]
   list2 = [7,8,9]
   list1.extend(list2)
   print(list1)
   ```
   Output:
   ```
   [4, 5, 6, 1, 2, 3, 7, 8, 9]
   ```
   ```py
   list1 = [4,5,6,1,2,3]
   list2 = [7,8,9]
   merge = list1+list2
   print(merge)
   ```
   Output:
   ```
   [4, 5, 6, 1, 2, 3, 7, 8, 9]
   ```
   ```py
   list1 = [4,5,6,1,2,3]
   list2 = [7,8,9]
   for i in list2:
       list1.append(i)
   print(list1)
   ```
   Output:
   ```
   [4, 5, 6, 1, 2, 3, 7, 8, 9]
   ```
   Nah ketiga cara diatas dapat kita gunakan untuk menggabungkan 2 list menjadi satu list. Menurut saya pribadi cara paling mudah adalah menggunakan operator `+` karena lebih sederhana dan tidak merubah nilai asli dari list yang lain. Contoh kasus lain, kita dapat menggunakan `zip()` untuk menggabungkan antar elemen list. Contohnya sebagai berikut:
   ```py
   list1 = ["M", "na", "i", "Ba"]
   list2 = ["y", "me", "s", "gas"]
   conct = [i+j for i, j in zip(list1,list2)]
   print(conct)
   ```
   Output:
   ```
   ['My', 'name', 'is', 'Bagas']
   ```

# Mengurutkan list

Sebuah list acak dapat kita lakukan pengurutan baik itu secara ascending atau descending. Untuk melakukan pengurutan kita dapat menggunakan fungsi `sort()` atau `sorted()`. Mari kita coba

1. Mengurutkan secara ascending
   ```py
   list1 = [4,5,6,1,2,3]
   list1.sort()
   print(list1)
   ```
   Output:
   ```
   [6, 5, 4, 3, 2, 1]
   ```
   Atau
   ```py
   list1 = [4,5,6,1,2,3]
   sorted_list = sorted(list1)
   print(sorted_list)
   ```
   Output:
   ```
   [6, 5, 4, 3, 2, 1]
   ```
   Keduanya menghasilkan output yang sama, hanya saja caranya yang berbeda. Cara `sort()` langsung mengubah nilai asli dari list1, sedangkan `sorted()` akan menyimpan nilai di variabel yang lain.

2. Mengurutkan secara descending
   ```py
   list1 = [4,5,6,1,2,3]
   list1.sort()
   print(list1[::-1])
   ```
   Atau
   ```py
   list1 = [4,5,6,1,2,3]
   sorted_list = sorted(list1)
   sorted_list.reverse()
   ```
   Sama seperti cara-cara sebelumnya, untuk melakukan sorting secara descending, kita perlu mengurutkannya terlebih dahulu, setelah itu baru kita lakukan `reverse()` atau negatif indeks

# Kesimpulan

Tipe data list sangat berguna bagi kalian yang ingin mengelompokkan data kedalam satu variabel dan melakukan modifikasi terhadap sekumpulan data tersebut karena list merupakanan tipe data collection yang mudah untuk dipahami dan fleksibel.

Sekian bahasan kali ini tentang list. Sampai ketemu lagi pada kesempatan berikutnya. Apabila ada kiritk, saran, ataupun masukan dapat menghubungi saya melalui halaman kontak diatas yaa. Terima kasih.