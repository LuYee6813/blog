@echo off
color a
set /p z=日期:
set /p b=文章名字:
set /p t=標籤名稱:

set filename=%z%-%b%.md
copy nul %filename% 


      

echo --- 	         >> %filename%
echo layout: post        >> %filename%
echo title: %b%	         >> %filename%
echo date: %z%    	 >> %filename%
echo Author: LuYee6813   >> %filename%
echo tags: [%t%]	 >> %filename%
echo comments: true	 >> %filename%
echo ---		 >> %filename%

pause 