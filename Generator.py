from pickle import TRUE
import pygame, sys, random as r
from pygame.locals import *
from math import pi, sin
import numpy as np
import time
import re
import os

#screen dimentions
width, height = 500, 500
#decay multiplicative factor
dd = 0.99995
# time step                  
dt = 0.02 
# velocity of the image rendering                    
speed = 20
#dispersion parameter for axes shifting
std = 0.00015                 
#max range for amplitudes and frequencies
maxA = 4                       
#path for saving the images
PATH = "."
last_number = 0
first_save = TRUE 

def scale(length):
    while True:
        a1,a2=r.randint(-maxA,maxA),r.randint(-maxA,maxA)
        max=abs(a1)+abs(a2)
        if max > 0: break
    return a1,a2,length/(2*max)

steps = 0
pygame.init()
pygame.event.set_allowed([QUIT, KEYDOWN])
screen = pygame.display.set_mode((width,height), DOUBLEBUF)
screen.set_alpha(None)

fg=(255,0,0) #Init colors
init_time = time.time() #Start time
while True:
    ax1,ax2,xscale=scale(width)
    ay1,ay2,yscale=scale(height)
    normal_multi = np.random.multivariate_normal(np.zeros(4), [[r.random()*std if i == j else 0 for i in range(4)] for j in range(4)])
    #Sin waves frequencies
    fx1, fx2 =  r.randint(1,maxA) + normal_multi[0], r.randint(1,maxA) + normal_multi[1] 
    fy1, fy2 =  r.randint(1,maxA) + normal_multi[2], r.randint(1,maxA) + normal_multi[3]
    #Angle shitf
    px1, px2 =  r.uniform(0,2*pi), r.uniform(0,2*pi) 
    py1, py2 =  r.uniform(0,2*pi), r.uniform(0,2*pi)

    #initial decay factor (multiplicative identity)
    dec = 1.0
    #initial sine wave angle
    t = 0.0
    #cheking if its the first iteration    
    first=True
    while dec > 0.015:
        
        #current values for x and by waves sum
        x = xscale * dec * (ax1*sin(t * fx1 + px1) + ax2*sin(t * fx2 + px2)) + width/2
        y = yscale * dec * (ay1*sin(t * fy1 + py1) + ay2*sin(t * fy2 + py2)) + height/2
        #decayment 
        dec *= dd
        
        if not first:
            #random colors by using discrete uniform probality distribution on the interval [0, 255]
            fg = (r.randint(0, 255), r.randint(0, 255), r.randint(0, 255))
            pygame.draw.aaline(screen, fg, (x, y), (prev_x, prev_y), 1)
        
        else:
            first = False
            #setting first x and y values as previous ones
            prev_x = x
            prev_y = y
            continue #going to the begginning of the while loop (nothing to render at this point)
 
        #storing last x and y values to keep interpolating
        prev_x = x              
        prev_y = y

        #updating the figure every time the number of steps given is a multiple of the speed
        if not steps%speed: 
            pygame.display.update() 
            #restarting the steps so it does not get to big
            steps=0

        #increasing steps and angle    
        steps += 1
        t += dt
    
    #saving image
    if first_save:
        file_names = os.listdir(PATH)
        file_names = list(filter(lambda x: x.split(PATH)[-1] == "jpg", file_names))
        file_names.sort()
        last_name = file_names[-1]
        del file_names
        last_number = int(re.findall("\d+", last_name)[0])
        first_save = not first_save
    
    last_number += 1
    img_name = f"oscilatorio{last_number}.jpg"
    pygame.image.save(screen, img_name)

    if time.time() - init_time > 5:
        sys.exit()
    screen.fill((0,0,0))