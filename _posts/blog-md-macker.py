import pathlib 
from pathlib import Path

title=input("文章名稱:")
date=input("時間(ex:2022-02-02):")
tag=input("標籤:")

current_directory=pathlib.Path(__file__).parent.absolute()
myfile = Path(f'{current_directory}\{date}-{title}.md')
myfile.touch(exist_ok=True)

f = open(myfile,'w')
md_format=f"""---
layout: post
title: {title}
date: {date}
Author: LuYee6813
tags: [{tag}]
toc: true
---"""
f.write(md_format)
f.close()


