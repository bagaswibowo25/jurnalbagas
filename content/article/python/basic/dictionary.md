---
title: "Belajar Python - Dictionary"
date: 2022-03-07T19:24:46+07:00

tags: ['Python','Programming']
author: "Bagas Wibowo"
noSummary: false
featuredImage: "/article/python/basic/dict.jpg" 
---

# Pengenalan

Dictionary merupakan salah satu tipe data collection yang ada di Python. Sebelumnya kita sudah membahas 3 dari 4 tipe data collection yang ada di Python, yaitu [list](../list), [tuple](../tuple), dan [set](../set). Dictionary memiliki karakteristik sebagai berikut:
- Ordered
- Changeable
- Duplicates Not Allowed
Yang membedakan tipe data dictionary dengan lainnya adalah, tipe data ini menggunakan konsep `key:value` untuk menyimpan data tiap elemennya. Dictionary dapat dibuat dengan memasukan `key:value` kedalam `{}` dan pemisahan antara key dan value menggunakan tanda `:`. Selain memiliki karakteristik diatas ada beberapa ketentuan dari dictionary sebagai berikut:
- Kunci (key) harus berupa elemen tunggal.
- Nilai (values) dapat berisi string, list, tuple, set, dan lainnya.

# Membuat Dictionary

Sebuah dictionary dapat dibentuk menggunakan `{key:value}`, setiap elemen key harus bersifat unik ya. Untuk itu mari kita coba.

```py
dict1 = {'f_name':'Bagas','l_name':'Wibowo'}
print(dict1)
```
Output
```
{'f_name': 'Bagas', 'l_name': 'Wibowo'}
```

Dari hasil diatas ktia bisa melihat output yang dihasilkan adalah output dari dictionary diatas adalah key beserta value dari keynya. Apabila kita ingin mengetahui key yang terdapat pada dictionary dapat menggunakan `dict.keys()` dan untuk menampilkan value saja yang ada pada dictionary tersebut dapat menggunakan `dict.values()`

```py
dict1 = {'f_name':'Bagas','l_name':'Wibowo'}
print(dict1.keys())
```
Output
```
dict_keys(['f_name', 'l_name'])
```
```py
dict1 = {'f_name':'Bagas','l_name':'Wibowo'}
print(dict1.values())
```
Output
```
dict_values(['Bagas', 'Wibowo'])
```
Nah untuk menampilkan value dari sebuah dictionary, keunggulannya adalah kita dapat mengakses nilai menggunakan key yang sudah didefinisikan. Contohnya saya ingin menampilkan value dari `f_name` dan `l_name` sebagai berikut:

```py
print(dict1.get('f_name'))
print(dict1.get('l_name'))
```

Contoh teknik untuk membuat dictionary lainnya dapat dilakukan dengan mengonversi tipe data lain menjadi dictionary. Untuk itu mari kita coba.

```py
key = ['f_name','l_name','age']
value = ['Bagas','Wibowo',21]
dict1 = dict(zip(key,value))
print(dict1)
```
Output
```
{'f_name': 'Bagas', 'l_name': 'Wibowo', 'age': 21}
```

Lalu seperti yang sudah disebutkan sebelumnya, value dari dictionary dapat beragam, semisal valuenya berupa list seperti contoh berikut:
```py
score = [80,88,90,70]
student = {'name':'Bagas','score':score}
print(student)
```
```
{'name': 'Bagas', 'score': [80, 88, 90, 70]}
```
Lalu bagaimana kita dapat mengaksesnya nilai dari key `score`. Mari kita coba.
```py
score = [80,88,90,70]
student= {'name':'Bagas','score':score}
print(student.get('score'))
```
Output
```
[80, 88, 90, 70]
```
Output yang dihasilkan berupa list, karena nilai dari `score` adalah berupa list. Lalu bisakah kita tetap mengakses elemen dari list tersebut? Jawabannya bisa. Mari kita coba.
```py
score = [80,88,90,70]
student= {'name':'Bagas','score':score}
print(student.get('score')[0])
```
Output
```
80
```
Output yang dihasilkan yaitu elemen pada indeks[0] dari list score tersebut. Selain menggunakan fungsi `.get()` kita dapat mengakses nilai dari sebuah dictionary dapat menggunakan `[]`. Contohnya sebagai berikut:
```py
score = [80,88,90,70]
student= {'name':'Bagas','score':score}
print(student['name'])
print(student['score'])
print(student['score'][0])
```
Output
```
Bagas
[80, 88, 90, 70]
80
```

# Modifikasi Dictionary

Dari cara-cara diatas kita sudah mengetahui bagaimana cara untuk membuat sebuah dictionary. Selanjutnya kita coba belajar bagaimana caranya mengubah isi dari dictionary. Untuk melakukan perubahan pada dictionary kita dapat menggunakan fungsi `.update()`. Mari kita coba.

```py
dict1 = {'name':'Bagas','age':21}
print(dict1)
dict1.update({'last_name':'Wibowo'})
print(dict1)
```
Output
```
{'name': 'Bagas', 'age': 21}
{'name': 'Bagas', 'age': 21, 'last_name': 'Wibowo'}
```
Pada contoh diatas adalah ketika kita ingin menambahkan elemen baru pada sebuah dictionary. Lalu bagaimana jika elemen yang ditambahkan ada banyak? Apakah perlu menambahkan satu-persatu? Kita dapat juga menggabungkan antar dictionary menggunakan fungsi `.update()`. Mari kita coba.

```py
name = {'f_name':'Bagas','l_name':'Wibowo'}
score = {'math':75,'Physic':80,'History':85}
print(name)
name.update(score)
print(name)
```
Output
```
{'f_name': 'Bagas', 'l_name': 'Wibowo'}
{'f_name': 'Bagas', 'l_name': 'Wibowo', 'math': 75, 'Physic': 80, 'History': 85}
```
Cara ini juga bisa digunakan semisal kita ingin mengganti sebuah key dengan key lainnya menggunakan nilai yang sama. Mari kita coba

```py
score = {'math':75,'Physic':80,'History':85}
score.update({'Biology':score.pop('math')})
print(score)
```
Output
```
{'Physic': 80, 'History': 85, 'Biology': 75}
```
Dari cara tersebut kita menggunakan fungsi `.pop()` untuk menghapus elemen yang kita pilih dan memindahkan nilainya kepada key baru yang kita buat.

```py
classroom = {
    'Math': {
        'Bagas': {
            'Score': 80
        },
        'Ari': {
            'Score': 75
        },
        'Wibowo': {
            'Score': 90
        }
    },
    'History': {
        'Bagas': {
            'Score': 87
        },
        'Ari': {
            'Score': 88
        },
        'Wibowo': {
            'Score': 78
        }
    }
}
print(classroom)
```
Pada contoh diatas, kita membuat nested dictionaries. Lalu bagaimana caranya untuk mengakses nilai-nilai yang ada dalam dictionaries tersebut. Mari kita coba

## Melihat mata pelajaran tiap kelas

```py
classroom = {
    'Math': {
        'Bagas': {
            'Score': 80
        },
        'Ari': {
            'Score': 75
        },
        'Wibowo': {
            'Score': 90
        }
    },
    'History': {
        'Bagas': {
            'Score': 87
        },
        'Ari': {
            'Score': 88
        },
        'Wibowo': {
            'Score': 78
        }
    }
}
print(classroom.keys())
```
Output
```
dict_keys(['Math', 'History'])
```

## Melihat siswa yang ada di tiap kelas

```py
classroom = {
    'Math': {
        'Bagas': {
            'Score': 80
        },
        'Ari': {
            'Score': 75
        },
        'Wibowo': {
            'Score': 90
        }
    },
    'History': {
        'Bagas': {
            'Score': 87
        },
        'Ari': {
            'Score': 88
        },
        'Wibowo': {
            'Score': 78
        }
    }
}
for course in classroom.keys():
    print(f'Siswa di Kelas {course}:')
    for student in classroom[course].keys():
        print(student)
```
Output
```
Siswa di Kelas Math:
Bagas
Ari
Wibowo
Siswa di Kelas History:
Bagas
Ari
Wibowo
```

## Menampilkan nilai setiap siswa di kelas

```py
classroom = {
    'Math': {
        'Bagas': {
            'Score': 80
        },
        'Ari': {
            'Score': 75
        },
        'Wibowo': {
            'Score': 90
        }
    },
    'History': {
        'Bagas': {
            'Score': 87
        },
        'Ari': {
            'Score': 88
        },
        'Wibowo': {
            'Score': 78
        }
    }
}
for course in classroom.keys():
    print(f'Siswa di Kelas {course}:')
    for student in classroom[course].keys():
        print(f'{student}({classroom[course][student]["Score"]})')
```
Output
```
Siswa di Kelas Math:
Bagas(80)
Ari(75)
Wibowo(90)
Siswa di Kelas History:
Bagas(87)
Ari(88)
Wibowo(78)
```

# Kesimpulan

Dictionary merupakan salah satu tipe data collection yang ada di Python. Tipe data ini menggunakan konsep `key:value` untuk menyimpan data tiap elemennya. Kita dapat melakukan berbagai teknik untuk menyimpan data menggunakan dictionary ini karena nilai yang dapat ditampung dalam dictionary pun beragam. 

Sekian bahasan kali ini tentang dictionary. Sampai ketemu lagi pada kesempatan berikutnya. Apabila ada kiritk, saran, ataupun masukan dapat menghubungi saya melalui halaman kontak diatas yaa. Terima kasih.