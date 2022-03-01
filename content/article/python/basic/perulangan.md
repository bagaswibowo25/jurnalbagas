---
title: "Belajar Python - Perulangan"
date: 2022-02-09T19:22:24+07:00

tags: ['Python','Programming']
author: "Bagas Wibowo"
noSummary: false
featuredImage: "/article/python/basic/loop.jpg" 
---

# Pengenalan

Perulangan merupakan salah satu teknik untuk melakukan pengulangan dari urutan instruksi atau statement sampai dengan kondisi yang diinginkan tercapai. Perulangan memiliki beberapa kegunaan yang biasa digunakan, seperti mencari nilai dari himpunan, menampilkan hasil sebanyak perulangan, melakukan penjumlahan, dan lainnya. Nah selain itu, pada Python sendiri ada 2 teknik perulangan yang dapat digunakan, yaitu `while` dan `for`. Mungkin umumnya ada jenis perulangan lain, seperti `do...while...` dan bisa juga menggunakan teknik rekursif atau memanggil fungsinya sendiri. Pada kesempatan kali ini, saya mencoba untuk share 2 teknik yang umum digunakan, yaitu `while` dan `for`.

# Perulangan While

Perulangan while erat kaitannya juga dengan pengondisian karena ketika kita ingin menjalankan statement di dalam while maka kondisi harus terpenuhi, apabila kondisi tidak terpenuhi maka perulangan tidak akan dijalankan. Contohnya sebagai berikut:

Case:

1. User diminta untuk melakukan input string
2. Program akan mengecek apakah string yang dimasukkan akan cocok dengan nilai pada variabel `kata`.
3. Apabila cocok maka program akan lanjut
4. Apabila tidak cocok maka user harus memasukkan ulang string


```py
kata = "Hello"
inp_str = input()
while inp_str != kata:
    print("Kata tidak cocok, silahkan coba lagi!")
    inp_str = input()
else:
    print("Kata cocok!Silahkan lanjut")
```

Input:
```
a
Hello
```
Output:
```
Kata tidak cocok, silahkan coba lagi!
Kata cocok!Silahkan lanjut
```

Dari contoh diatas program akan terus melakukan perulangan hingga nilai yang dimasukkan oleh user sesuai dengan variabel `kata`. Jika sesuai perulangan akan berhenti. Pada perulangan `while` jumlah perulangan yang dilakukan bergantung pada kondisi, dia akan berhenti jika kondisi bernilai `False` dan akan terus berulang apabila kondisinya `True`. Apabila terus bernilai `True` maka program perlu dihentikan secara paksa atau akan terjadi ketakterbatasan perulangan. Kita dapat membatasinya dengan memberikan kondisi tertentu, misal jika telah melebihi 3 perulangan maka akan berhenti `while i < 4`. Atau kita bisa menggunakan statement `break` apabila ingin mencari satu nilai dari sekumpulan nilai. Contohnya sebagai berikut:

```py
kata = input()
huruf = input()
i = 0
while i < len(kata):
    if kata[i] == huruf:
        print(f"Terdapat huruf {huruf} di indeks ke",i)
        i += 1
        break
    else:
        i += 1
else:
    print("Huruf tidak ditemukkan")
```
Input:
```
Kata: Book
Huruf: o
```
Output:
```
Terdapat huruf o di indeks ke 1
```

Perulangan akan berhenti setelah statement bernilai `True` dieksekusi. Apabila tidak ada statement `break` maka perulangan akan berlanjut hingga jumlah kondisi perulangan terpenuhi, yaitu nilai `i < len(kata)`. Mari kita coba hilangkan `break`.

```py
kata = input()
huruf = input()
i = 0
while i < len(kata):
    if kata[i] == huruf:
        print(f"Terdapat huruf {huruf} di indeks ke",i)
        i += 1
    else:
        i += 1
else:
    print("Huruf tidak ditemukkan")
```
Input:
```
Kata: Book
Huruf: o
```
Output:
```
Terdapat huruf o di indeks ke 1
Terdapat huruf o di indeks ke 2
Huruf tidak ditemukkan
```
Program akan terus melakukan perulangan hingga nilai `False` tercapai. Apabila nilai terus bernilai `True` maka akan terus diulang sampai kondisinya tercapai atau selesai.

# Perulangan For

Perulangan for umum digunakan apabila kita telah mengetahui rentang perulangan yang akan dilakukan, kita sudah punya estimasi kapan perulangan itu berjalan dan perulangan ini sedikit berbeda dengan `while` karena perulangan ini tidak menggunakan pengondisian untuk menjalankan statement yang ada di dalam perulangan, tetapi menggunakan rentang. Selama masih ada dalam rentang perulangan maka akan terus terjadi perulangan. Supaya lebih mudah memahaminya, kita dapat melihat contoh sebagai berikut:

1. User memasukkan beberapa nilai integer secara acak
2. Program akan mencari nilai terkecil dari sekumpulan nilai integer acak tersebut
   
```py
user_input = list(map(int, input().split()))
min_val = user_input[0]
for i in range(len(user_input)):
    if user_input[i] < min_val:
        min_val = user_input[i]
    else:
        continue
print(min_val)
```

Input:
```
2 4 5 6 3 1
7 10 20 11
```

Output:
```
1
7
```

Sekian bahasan kali ini tentang perulangan. Sampai ketemu lagi pada kesempatan berikutnya. Apabila ada kiritk, saran, ataupun masukan dapat menghubungi saya melalui halaman kontak diatas yaa. Terima kasih.