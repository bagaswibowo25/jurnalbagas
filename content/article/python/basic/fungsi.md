---
title: "Belajar Python - Fungsi"
date: 2022-02-10T19:13:20+07:00

tags: ['Python','Programming']
author: "Bagas Wibowo"
noSummary: false
featuredImage: "/article/python/basic/function.jpg" 
---

# Pengenalan

Sebelumnya kita sudah sempat mempelajari dasar-dasar dari Python terkait tipe data, kondisional, dan perulangan. Pada kesempatan kali ini saya mencoba ingin membagikan terkait fungsi. Fungsi sederhananya merupakan sekumpulan dari kode blok yang akan berjalan hanya ketika dipanggil. Lalu fungsi juga digunakan untuk kita mengelompokkan kumpulan sintaks yang kita punya sesuai dengan fungsinya masing-masing. Mengapa kita perlu membuat fungsi? Secara default di Python sendiri akan mengeksekusi program secara berurutan baris-perbarisnya. Jika kita memiliki kode yang cukup kompleks maka kita perlu mengelompokkannya kedalam fungsi dan kita dapat memanggilnya kapanpun ketika kita butuhkan.

Lalu bagaimana caranya membuat fungsi, mari kita coba pada contoh berikut:

```py
def fungsi_satu(parameter):
    statement
    return nilai
```

Dari contoh gambaran di atas, ketika ingin membuat fungsi maka kita perlu mendefinisikan fungsi terlebih dahulu dengan `def` dilanjutkan dengan nama fungsi yang akan dibuat. Lalu ada `()` disana kita bisa membuat parameter yang diambil dari argumen yang diberikan ketika kita memanggil fungsi tersebut. Parameter bersifat opsional, kita juga bisa mengosongkannya jika tidak diperlukan. 

Selanjutnya di dalam fungsi kita dapat memasukan statement atau operasi yang ingin kita jalankan. Operasi yang dapat dilakukan beragam, namun alangkah baiknya setiap fungsi memiliki tanggung jawabnya masing-masing, artinya fungsi tersebut hanya melakukan satu tugas saja. Tapi bukan berarti hanya dapat menjalankan satu statement saja, namun lebih kearah memiliki satu peran. Kenapa? karena apabila terjadi perubahan maka akan berdampak kepada struktur lainnya. Maka dari itu kita perlu mendifinisikan dari awal tujuan dari fungsi itu dibuat sesuai dengan kegunaannya.

Mungkin ini menjadi salah satu referensi yang dapat kalian baca terkait bahasan tadi, yaitu terkait **Single Responsibility Priciple**:
- https://medium.com/99ridho/konsep-solid-principle-single-responsibility-principle-254c05591d9d
- https://en.wikipedia.org/wiki/Single-responsibility_principle
  
# Memanggil Fungsi

Oke, selanjutnya kita coba bagaimana cara memanggil fungsi yang sudah kita buat. Disini saya akan mencoba membuat fungsi yang akan menampilkan pesan ucapan salam kepada user.

```py
def salam():
    print("Halo, selamat datang!")

salam()
```

Output:
```
Halo, selamat datang!
```
Untuk memanggil fungsi kita hanya perlu memanggil nama fungsinya saja. Jadi ini sangat memudahkan apabila kita ingin melakukan operasi yang sama berulang kali, kita tidak perlu menuliskan ulang statement, tapi kita tinggal panggil fungsi yang sudah kita buat saja.

# Memanggil Fungsi dengan Argumen

Apabila kita memiliki argumen dan ingin digunakan sebagai parameter fungsi yang sudah kita buat, itu juga dapat kita lakukan. Pada contoh kali ini saya akan mencontohnkan user memasukkan input berupa nama, lalu fungsi tersebut akan mengembalikan pesan ucapan beserta nama user.

```py
def salam(nama_depan,nama_belakang):
    print("Halo, selamat datang!",nama_depan,nama_belakang)

masukkan_nama = input().split()
nama_depan = masukkan_nama[0]
nama_belakang = masukkan_nama[1]

salam(nama_depan,nama_belakang)
```
Input:
```
Bagas Wibowo
```
Output:
```
Halo, selamat datang! Bagas Wibowo
```

Jumlah argumen yang diberikan harus sama dengan jumlah parameter yang disediakan oleh fungsi. Pada contoh diatas fungsi menyediakan 2 parameter, maka kita hanya dapat memberikan 2 argumen pada saat memanggil fungsi tersebut. Apabila kita memiliki beberapa argumen kita dapat menggunakan `*args` atau **arbitrary argument**. 

```py
def buah(*nama_buah):
    print('Buah pertama adalah',nama_buah[0])

buah("Anggur","Pisang","Jeruk")
```
Output:
```
Buah pertama adalah Anggur
```
Dengan menggunakan `*args` kita dapat memanggil argumen berdasarkan indeksnya. Karena kumpulan argumen tersebut disimpan sebagai tuple.

# Menggunakan Keyword Argument

Argumen ini akan menyimpan sebuah value kedalam sebuah variabel yang akan menjadi key dari value tersebut. Pada contoh sebelumnya kita memasukkan data secara langsung tanpa menggunakan key, dengan menggunakan key, kita dapat lebih spesifik untuk menentukkan argumen yang akan diproses oleh fungsi

```py
def kendaraan(nama_kendaraan,warna,kecepatan):
    print("Kendaraan yang digunakan adalah ",nama_kendaraan,". Memiliki warna ",warna," dan kecepatan ",kecepatan,sep="")

kendaraan(warna="Merah",kecepatan="80 KM/H",nama_kendaraan="Bus")
```
Output:
```
Kendaraan yang digunakan adalah Bus. Memiliki warna Merah dan kecepatan 80 KM/H
```

# Menggunakan Arbitrary Keyword Argument

Argumen ini sama seperti arbitrary argumen sebelumnya, namun perbedaannya untuk mengakses itemnya kita menggunakan sebuah key bukan sebuah nomor indeks. Contoh penggunaannya sebagai berikut:

```py
def halo(**nama):
    print("Halo",nama["nama_depan"],nama["nama_belakang"])
halo(nama_depan="Bagas", nama_belakang="Wibowo")
```

# Mengembalikan nilai dengan return

Umumnya fungsi akan mengembalikan nilai, karena jika tidak mengembalikan nilai maka nilai yang dikembalikan adalah **None** atau **Null**.
```py
def addition(a,b):
    result = a+b
    return result
print(addition(5,10))
```
Output:
```
15
```
Dari contoh diatas, fungsi yang dibuat adalah untuk melakukan penjumlahan dari `a + b` dan operasi tersebut disimpan di dalam variabel result. Maka jika ingin mendapatkan hasil dari result perlu dikembalikan nilai dari variabel result tersebut.

# Nilai Parameter Default

Apabila kita membuat fungsi dan tersedia parameter, maka kita wajib memberikan argumen ketika memanggil sebuah fungsi, namun apabila kita tidak ingin memberikan argumen, kita dapat membuat nilai parameter default yang akan menjadi nilai default dari variabel. Contoh penggunaannya adalah sebagai berikut:

```py
def pesan(ucapan="Halo Semua"):
    return ucapan
print(pesan())
print(pesan(ucapan='Halo Kawan'))
```
Output:
```
Halo Semua
Halo Kawan
```
# Fungsi Bawaan

Python juga memiliki beberapa fungsi bawaan, untuk itu fungsi bawaan dapat kita pergunakan sesuai dengan kebutuhan seperti pada tabel berikut:

# Builtin Function

| **Function**   | **Description**                                                                               |
| -------------- | --------------------------------------------------------------------------------------------- |
| abs()          | Returns the absolute value of a number                                                        |
| all()          | Returns True if all items in an iterable object are true                                      |
| any()          | Returns True if any item in an iterable object is true                                        |
| ascii()        | Returns a readable version of an object. Replaces none-ascii characters with escape character |
| bin()          | Returns the binary version of a number                                                        |
| bool()         | Returns the boolean value of the specified object                                             |
| bytearray()    | Returns an array of bytes                                                                     |
| bytes()        | Returns a bytes object                                                                        |
| callable()     | Returns True if the specified object is callable, otherwise False                             |
| chr()          | Returns a character from the specified Unicode code.                                          |
| classmethod()  | Converts a method into a class method                                                         |
| compile()      | Returns the specified source as an object, ready to be executed                               |
| complex()      | Returns a complex number                                                                      |
| delattr()      | Deletes the specified attribute (property or method) from the specified object                |
| dict()         | Returns a dictionary (Array)                                                                  |
| dir()          | Returns a list of the specified object's properties and methods                               |
| divmod()       | Returns the quotient and the remainder when argument1 is divided by argument2                 |
| enumerate()    | Takes a collection (e.g. a tuple) and returns it as an enumerate object                       |
| eval()         | Evaluates and executes an expression                                                          |
| exec()         | Executes the specified code (or object)                                                       |
| filter()       | Use a filter function to exclude items in an iterable object                                  |
| float()        | Returns a floating point number                                                               |
| format()       | Formats a specified value                                                                     |
| frozenset()    | Returns a frozenset object                                                                    |
| getattr()      | Returns the value of the specified attribute (property or method)                             |
| globals()      | Returns the current global symbol table as a dictionary                                       |
| hasattr()      | Returns True if the specified object has the specified attribute (property/method)            |
| hash()         | Returns the hash value of a specified object                                                  |
| help()         | Executes the built-in help system                                                             |
| hex()          | Converts a number into a hexadecimal value                                                    |
| id()           | Returns the id of an object                                                                   |
| input()        | Allowing user input                                                                           |
| int()          | Returns an integer number                                                                     |
| isinstance()   | Returns True if a specified object is an instance of a specified object                       |
| issubclass()   | Returns True if a specified class is a subclass of a specified object                         |
| iter()         | Returns an iterator object                                                                    |
| len()          | Returns the length of an object                                                               |
| list()         | Returns a list                                                                                |
| locals()       | Returns an updated dictionary of the current local symbol table                               |
| map()          | Returns the specified iterator with the specified function applied to each item               |
| max()          | Returns the largest item in an iterable                                                       |
| memoryview()   | Returns a memory view object                                                                  |
| min()          | Returns the smallest item in an iterable                                                      |
| next()         | Returns the next item in an iterable                                                          |
| object()       | Returns a new object                                                                          |
| oct()          | Converts a number into an octal                                                               |
| open()         | Opens a file and returns a file object                                                        |
| ord()          | Convert an integer representing the Unicode of the specified character                        |
| pow()          | Returns the value of x to the power of y                                                      |
| print()        | Prints to the standard output device                                                          |
| property()     | Gets, sets, deletes a property                                                                |
| range()        | Returns a sequence of numbers, starting from 0 and increments by 1 (by default)               |
| repr()         | Returns a readable version of an object                                                       |
| reversed()     | Returns a reversed iterator                                                                   |
| round()        | Rounds a numbers                                                                              |
| set()          | Returns a new set object                                                                      |
| setattr()      | Sets an attribute (property/method) of an object                                              |
| slice()        | Returns a slice object                                                                        |
| sorted()       | Returns a sorted list                                                                         |
| staticmethod() | Converts a method into a static method                                                        |
| str()          | Returns a string object                                                                       |
| sum()          | Sums the items of an iterator                                                                 |
| super()        | Returns an object that represents the parent class                                            |
| tuple()        | Returns a tuple                                                                               |
| type()         | Returns the type of an object                                                                 |
| vars()         | Returns the \_\_dict\_\_ property of an object                                                |
| zip()          | Returns an iterator, from two or more iterators                                               

# Kesimpulan

Fungsi sesuai namanya akan memberikan sebuah fungsi jika dipanggil. Fungsi dapat dipanggil kapan saja jika kita butuhkan. Kita dapat membuat beragam operasi dalam satu fungsi, tetapi baiknya fungsi hanya memiliki satu kegunaan dan tanggung jawab agar jika terdapat perubahan tidak memiliki dampak yang besar bagi keseluruhan kode.

Sekian artikel terkait fungsi yang dapat saya sampaikan. Semoga dari apa yang sudah saya jelaskan dapat dipahami dan bermanfaat. Sampai jumpa pada kesempatan berikutnya. Apabila ada kritik, saran, dan masukkan dapat mengunjungi sosial media saya yang ada di kontak. Terima kasih.