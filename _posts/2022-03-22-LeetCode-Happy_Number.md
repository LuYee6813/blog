---
layout: post
title: Happy Number
date: 2022-03-22
Author: LuYee6813
tags: [LeetCode]
toc: true
---

## 1. 題目
Write an algorithm to determine if a number is “happy”.

A happy number is a number defined by the following process: Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.

Example:
```
Input: 19
Output: true
```

Explanation:

- 1*1 + 9*9 = 82
- 8*8 + 2*2 = 68
- 6*6 + 8*8 = 100
- 1*1 + 0*0 + 0*0 = 1

## 2. 思路
因為不是Happy number的話會進入迴圈(loops endlessly in a cycle) 所以可想到![floyd’s cycle detection](https://en.wikipedia.org/wiki/Cycle_detection)

## 3.解題
```C
int check_happy(int target)
{    
    int sum = (target % 10)*(target % 10);    
    /* Chech digit */
    while ((target / 10) > 0) {              
        target /= 10;
        sum += (target % 10)*(target % 10);
    }
    
    return sum;
}

bool isHappy(int n)
{
    int fast = n, slow = n;
    do {  
        /* slow calculate once per round*/
        slow = check_happy(slow);
        /* fast calculate two times per round*/
        fast = check_happy(fast);
        fast = check_happy(fast);
        if (slow == 1 || fast == 1)        
            return true;        
    } while (slow != fast);  

    return  false;
}
```