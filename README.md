# Formula SAE Tire Test Consortium - [Formula UFSC](https://www.instagram.com/formulaufsc/?hl=pt-br)

The goal of this project is to use the data from the [Formula SAE Tire Test Consortium](http://www.fsaettc.org/) to aid the development of the suspension and steering systems of the prototype developed by Formula UFSC.

# About the project

Well designed automotive suspension and steering systems must be developed taking into account the way the tires perform under different circumstances. With this in mind,  FSAE TTC conducted several tests, where tires were tested in machines like the one below, where it is possible to measure how each tire reacts to different situations. The data is available for Formula SAE teams that join the consortium.

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/calspan.png)


The Matlab code found in the **RunDataCorneringTest.m** file generates 5 figures based on the exampleData.DAT data. Figures 1 and 2 provide a general visualization, so that the user roughly knows what to expect from the data, while Figures 3, 4 and 5 show the 3d graph where **Lateral Force** is plotted against **Slip Angle & Vertical Load** for three different camber angles.

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/Figure1.PNG)

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/Figure2.PNG)

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/Figure3.PNG)

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/Figure4.PNG)

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/Figure5.PNG)

**Note that the FSAE TTC files are only available for teams that join the consortium, for this reason, minor changes were made to the axampleData.DAT file in order not to leak private data information concerning the tire model and test round.**