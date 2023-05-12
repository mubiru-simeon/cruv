# CRUV
This project is a test project for qualification for employment at CRUV.
The challenge i was presented is described below.


## Problem statement
On a railroad or ship, a berth is a bed that is typically stacked like bunk beds.
There are five different types of berths available on Indian trains: Lower, Middle, Upper, Side Lower, and Side Upper.

Your objective is to develop a mobile application that, given a seat number, would show the position of the seat and indicate the type of berth it is.
Here is an example of how the app might appear and work, but we encourage you to add any more features that you can think of, which might benefit the app.

https://docs.google.com/document/d/1Y9d2fRfxQHeYqdw6bMC6rZ7YSZblGe1dyeLfzutywfk/edit


## My Solution
I have created a flutter app that uses Hive as the database and stores all data locally offline. I haven't addedan authentication system, due to the urgency of the project, however, i could have easily implemented Firebase Auth. 

There is a drawer where a user can easily switch between Admin and user modes and these enable him to edit the trains available and clear all trains. Each train has multiple seats called Berths and they're all editable in Admin mode, but not in User Mode. 

The berths and trains are stored in the same box, for simplicity, in a Map object. This enables easy updating and searching of the data.

Additionally, i implemented a light theme and dark theme too in the app for a better user experience.

Technologies Used:
Flutter,
Dart,
VS Code (I know it doesn't count as a techstack, but... Enh. Bear with me)
Lots of coffee


## Credits
Built by Simeon. 
Github username: mubiru-simeon