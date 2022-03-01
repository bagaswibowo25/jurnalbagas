---
title: "Belajar Python - Kondisional"
date: 2021-11-01T18:10:14+01:00

tags: ['Python','Programming']
author: "Bagas Wibowo"
noSummary: false
featuredImage: "/article/python/basic/choose_the_way.jpg" 
---

# Pengenalan

Ketika kita ingin pergi ke suatu tempat atau ingin melakukan sesuatu, pasti kita akan membuat sebuah keputusan dan pertimbangan. Keputusan yang kita ambil akan menghasilkan apa yang kita tuju. Sama seperti program, kita akan membuat logika tentang bagaimana proses pengambilan keputusan jika terjadi kondisi tertentu, nah itulah yang dimaksud dengan kondisional.

Lalu apa saja yang bisa kita lakukan dengan kondisional di Python? Oke kita coba bahas satu-persatu.

Pada Python program akan dieksekusi berurutan, baris-perbaris. Maka setiap sintaks yang kita masukkan akan dieksekusi dari atas kebawah berurutan.

Pada operasi pengondisian ini menggunakan tipe data boolean yang hanya menghasilkan dua nilai, yaitu `True` dan `False`. Dari kedua hasil nilai tersebut kita bisa memutuskan kepada program untuk melakukan aksi apa jika bernilai `True` atau sebaliknya.

Pengondisian tersebut salah satunya dengan melakukan operasi boolean seperti pada tabel berikut:

| Logical Condition | Symbol |
----------|--------|
| Equals  | a == b |
|Not Equals| a != b |
|Less than | a < b |
|Less than or equal to | a <= b |
|Greater than | a > b |
|Greater than or equal to| a >= b |

# Kondisi - If

Pada contoh pertama kita akan mencoba kondisi `If`. `If` digunakan ketika kita ingin membuat program mengeksekusi sebuah kondisi, namun apabila tidak sesuai dengan kondisi maka program akan melanjutkan baris kode selanjutnya. Contohnya sebagai berikut:

```py
a = 123
if isinstance(a,int):
    print("Nilai dari variabel a adalah angka",a)

print("Bukan Angka")
```

Maka output yang dihasilkan apabila nilainya `True` adalah:

```
Nilai dari variabel a adalah angka 123
Bukan Angka
```
```py
a = "123"
if isinstance(a,int):
    print("Nilai dari variabel a adalah angka",a)

print("Bukan Angka")
```
Output yang dihasilkan apabila nilainya `False` adalah:
```
Bukan Angka
```
Dari contoh diatas, Python akan melakukan eksekusi sintaks yang ada di dalam blok `if` dan langsung melanjutkan ke sintaks pada baris berikutnya apabila nilai dari kondisi tersebut `True`. Apabila nilai yang dihasilkan `False` maka sintaks yang ada didalam baris kode akan dilewati dan langsung ke baris berikutnya yang ada di luar blok `if`. Untuk menentukan jangkauan dari sintaks tersebut (scope) pada Python menggunakan indentasi atau menjorok kedalam, kita perlu memerhatikan indentasi pada Python, karena apabila terdapat indentasi yang tidak sesuai, program yang dijalankan akan terjadi error atau kesalahan logika.

# Kondisi If - Else

Kondisi selanjutnya, yaitu `if-else` dimana kondisi ini memiliki alternatif fungsi ketika gagal menjalankan kondisi `if`. Contohnya sebagai berikut:

```py
a = 123
if isinstance(a,int):
    print("Nilai dari variabel a adalah angka",a)
else:
    print("Bukan Angka")
```

Pada contoh diatas perintah `print("Bukan Angka")` sebelummya akan tetap dieksekusi walaupun nilai dari kondisi adalah `True`. Tetapi apabila kita menggunakan `else` dan perintah tersebut dimasukkan ke dalam blok `else` maka sintaks tersebut hanya akan dieksekusi bila kondisi bernilai `False`. Contoh lainnya misalkan kita ingin mengetahui apakah bilangan tersebut ganjil atau genap.

```py
angka = int(input())

if angka % 2 == 0:
    print(angka,"adalah genap")
else:
    print(angka,"adalah ganjil")
```

Input:
```
2
5
```
Output:
```
2 adalah ganjil
5 adalah
```

# Kondisi If-Elif-Else

Kondisi ini kita butuhkan ketika kita ingin menjalankan beberapa kondisi sekaligus dan apabila kondisi pertama masih belum sesuai maka akan mencoba untuk mencari kondisi selanjutnya sampai kondisi terakhir `else`. Contohnya semisal kita ingin membuat beberapa nilai dari rentang nilai tertentu.

```
Jika nilai 90 - 100 = A
Jika nilai 70 - 89 = B
Jika nilai 60 - 79 = C
Jika nilai < 60 = D
```

```py
nilai = int(input())

if nilai >= 90:
    print("Nilai kamu adalah A")
elif nilai >= 70:
    print("Nilai kamu adalah B")
elif nilai >= 60:
    print("Nilai kamu adalah C")
elif nilai < 60:
    print("Nilai kamu adalah D")
```
Input:
```
75
96
80
50
```
Output:
```
Nilai kamu adalah B
Nilai kamu adalah A
Nilai kamu adalah B
Nilai kamu adalah D
```
Hal lain yang perlu diperhatikan juga adalah urutan kondisi, karena apabila salah dalam mengurutkan kondisi maka output yang dihasilkan bisa tidak sesuai dengan yang kita inginkan.
