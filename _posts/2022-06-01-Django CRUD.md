---
layout: post
title: Django 資料庫CRUD 
date: 2022-06-01
Author: LuYee6813
tags: [Django]
toc: true
---

## 資料庫模型建立
### 1. 建立資料庫模型


>models.py
```python
from django.db import models
class student(models.Model):
    Name = models.CharField(max_length=20, null=False)
    Sex = models.CharField(max_length=2, default='M', null=False)
    Birthday = models.DateField(null=False)
    Email = models.EmailField(max_length=100, blank=True, default='')
    Phone = models.CharField(max_length=50, blank=True, default='')
    Addr = models.CharField(max_length=255,blank=True, default='')
    Class = models.CharField(max_length=255,blank=True,default='')
    ClassOfficers = models.CharField(max_length=255,blank=True,default='')
    Commendation = models.IntegerField(null=False,blank=True,default=0)

    def __str__(self):
        return self.Name

    # max_length代表最大長度20字元
    # default='M'代表預設值為M
    # null=False代表不可空白
    # blank=True代表預設空字串
    # editable代表是否可顯示，預設為True
    # unique代表是否為唯一值，預設為False
```

### 2. 建立migration資料檔

```
python manage.py makemigrations
```

### 3. 模型與資料庫同步

```
python manage.py migrate
```

### 4. 註冊於admin管理後台

>admin.py
```python
from django.contrib import admin
from studentsapp.models import student
admin.site.register(student,studentAdmin)
```

### 5. 建立後台管理使用者

```
python manage.py createsuperuser
```

### 6. 啟動伺服器

```
python manage.py runserver
```


## 新增資料(Create)
```python 
def Create(request):
    Name = 'Andy'
    Sex =  'M'
    Birthday =  '2022-02-02'
    Email = 'Andy@gmail.com'
    Phone =  '0987654321'
    Addr =  '新北市三重區xx路xx號x樓'
    Class = '301'
    ClassOfficers = '班長'
    data = student.objects.create(Name=Name, Sex=Sex, Birthday=Birthday, Email=Email,Phone=Phone, Addr=Addr,Class=Class,
    ClassOfficers=ClassOfficers) 
    data.save()  #寫入資料庫

    return render(request,"home.html",locals())
```

## 讀取資料(Read)
```python 
def Read(request):
    # 取得student所有資料
    student_all = student.objects.all()
    # 取得名字為root的學生(Get用於單個)
    Name_root_Get = student.objects.get(Name="root")
    # 取得名字為Andy的學生(Filter用於多個)
    Name_Andy_Filter =  student.objects.filter(Name="Andy")
    # 取得幹部為班長的學生
    ClassOfficers_Filter = student.objects.filter(ClassOfficers="班長")

    return render(request,"home.html",locals())
```

## 修改資料(Update)
```python 
def Update(request):
    # 需先取得資料 -> 修改 -> 存擋

    # 修改一筆
    Name_root_Get = student.objects.get(Name="root")
    Name_root_Get.Birthday = "2022-06-25"
    Name_root_Get.Addr = "台北市大安區基隆路xxx號"
    Name_root_Get.save() #存檔

    # 修改多筆
    ClassOfficers＿Filter = student.objects.filter(ClassOfficers="班長")
    for x in ClassOfficers_Filter:
        x.Commendation += 1 # 嘉獎+1
    ClassOfficers_Filter.save() 

    return render(request,"home.html",locals())
```

## 刪除資料(Delete)
```python 
def Delete(request):
    # 需先取得資料 -> 刪除

    # 刪除一筆
    Name_root_Get = student.objects.get(Name="root")
    Name_root_Get.delete()

    # 刪除多筆
    Name_Andy_Filter = student.objects.filter(Name="Andy")
    Name_Andy_Filter.delete()

    return render(request,"home.html",locals())
```
