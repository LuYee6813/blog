@echo off
color a
set /p z=���:
set /p b=�峹�W�r:
set /p t=���ҦW��:

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