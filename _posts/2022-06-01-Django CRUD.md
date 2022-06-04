---
layout: post
title: Django 資料庫CRUD 
date: 2022-06-01
Author: LuYee6813
tags: [Django]
toc: true
---
# Django 資料庫CRUD 

## 資料庫模型建立
### 1. 建立資料庫模型
> models.py
```python
from django.db import models
class student(models.Model):
    Name = models.CharField(max_length=20, null=False)
    Sex = models.CharField(max_length=2, default='M', null=False)
    Birthday = models.DateField(null=False)
    Email = models.EmailField(max_length=100, blank=True, default='')
    Phone = models.CharField(max_length=50, blank=True, default='')
    Addr = models.CharField(max_length=255,blank=True, default='')
 
def __str__(self):
    return self.Name
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
    ClassOfficers = '班長'
    data = student.objects.create(Name=Name, Sex=Sex, Birthday=Birthday, Email=Email,Phone=Phone, Addr=Addr) 
    data.save()  #寫入資料庫
```

## 讀取資料(Read)
```python 
def Read(request):
    # 取得student所有資料
    student_all = student.objects.all()
    # 取得名字為root的學生(Get用於單個)
    cName_root_Get = student.objects.get(Name="root")
    # 取得名字為Andy的學生(Filter用於多個)
    cName_Andy_Filter =  student.objects.filter(Name="Andy")
    # 取得幹部為班長的學生

    return render(request,"home.html")
```

## 修改資料(Update)
```python 
def Update(request):
    # 需先取得資料 -> 修改 -> 存擋

    # 一筆資料
    cName_root_Get = student.objects.get(Name="root")
    cName_root_Get.cBirthday = "2022-06-25"
    cName_root_Get.cAddr = "台北市大安區基隆路xxx號"
    cName_root_Get.save() #存檔

    # 多筆資料
    

    return render(request,"home.html")
```

## 刪除資料(Delete)
```python 
def Delete(request):
    
    return render(request,"home.html")
```
