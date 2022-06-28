---
layout: post
title: picoCTF GET aHEAD [20points]
date: 2022-03-19
Author: LuYee6813
tags: [Write-Ups]
comments: true
toc: true
---

# GET aHEAD - 20points

看原始碼發現有GET 和 POST兩種方法

```html
<!doctype html>
<html>
<head>
    <title>Red</title>
    <link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<style>body {background-color: red;}</style>
</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<div class="panel panel-primary" style="margin-top:50px">
						<div class="panel-heading">
							<h3 class="panel-title" style="color:red">Red</h3>
						</div>
						<div class="panel-body">
							<form action="index.php" method="GET">
								<input type="submit" value="Choose Red"/>
							</form>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="panel panel-primary" style="margin-top:50px">
						<div class="panel-heading">
							<h3 class="panel-title" style="color:blue">Blue</h3>
						</div>
						<div class="panel-body">
							<form action="index.php" method="POST">
								<input type="submit" value="Choose Blue"/>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>

```

提示說明 嘗試使用其他方法

>使用curl 指定HEAD方法
![](https://i.imgur.com/QeQ4Bhk.png)

    Flag: picoCTF{r3j3ct_th3_du4l1ty_cca66bd3}



