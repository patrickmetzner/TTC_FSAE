# Formula SAE Tire Test Consortium - Formula UFSC

The goal of this project is to use the data from the [Formula SAE Tire Test Consortium](http://www.fsaettc.org/) to aid the development of the suspension and steering systems of the prototype developed by Formula UFSC.

# About the project

Well designed automotive suspension and steering systems must be developed taking into account the way the tires perform under different circumstances. With this in mind,  FSAE TTC conducted several tests, where tires were tested in machines like the one below, where it is possible to measure how each tire reacts to different situations. The data is available for Formula SAE teams that join the consortium.

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/calspan.png)


The Matlab code found in the **RunDataCorneringTest.m** file generates 5 figures based on the exampleData.DAT data. Figures 1 and 2 provide a general visualization, so that the user roughly knows what to expect from the data, while Figures 3, 4 and 5 show the 3d graph where **Lateral Force** is plotted against **Slip Angle & Vertical Load** for three different camber angles.

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/Figure%201%20-%20General%20data%20visualization%20-%20Slip%20Anle%20vs.%20Lateral%20Force.pdf)

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/Figure%202%20-%20General%20data%20visualization%20-%20Slip%20Angle%2C%20Lateral%20Force%2C%20Load%2C%20Camber%20%26%20Tire%20Pressure.pdf)

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/Figure%203%20-%20Lateral%20Force%20vs.%20Slip%20Angle%20%26%20Vertical%20Load%20-%20Camber%200.pdf)

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/Figure%204%20-%20Lateral%20Force%20vs.%20Slip%20Angle%20%26%20Vertical%20Load%20-%20Camber%202.pdf)

![Preview-Screens](https://github.com/patrickmetzner/TTC_FSAE/blob/master/Figure%205%20-%20Lateral%20Force%20vs.%20Slip%20Angle%20%26%20Vertical%20Load%20-%20Camber%204.pdf)

**Note that the FSAE TTC files are only available for teams that join the consortium, for this reason, minor changes were made to the axampleData.DAT file in order not to leak private data information concerning the tire model and test round.**