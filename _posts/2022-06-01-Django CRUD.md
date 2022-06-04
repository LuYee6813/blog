---
layout: post
title: Django 資料庫CRUD 
date: 2022-06-01
Author: LuYee6813
tags: [Django]
toc: true
---

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
