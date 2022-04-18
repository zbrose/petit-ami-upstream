# Petit Ami
Petit Ami is an iOS real-time pocket monster app created in Xcode using Swift.  Users are able to adopt therir very own Ami companion which they can feed, play mini games with, and evolve.

# App screenshot

<img src="https://user-images.githubusercontent.com/95590888/163753871-532c5f59-55f5-40f8-ae8f-a161b56c62c7.png" height="450" />


## User Stories
As a user I want to: 
- Adopt my very own Ami and name it
- Feed and take care of my Ami
- See my Ami's status levels (energy, hunger, age, etc)
- Play mini games with my Ami

## Tech Stack
- Swift
- Realm Database

# General Approach
The first step we took when creating this project was creating a backend that stored a user's Ami on their local storage. After creating the backend, we created a form that would log a user's Ami with a name to the local database. Our next step was to get the stored information to the frontend for the user to see. After successfully displaying the info to the frontend, we created the functionality for the buttons and made sure that it updated the stats in real time. We then tackled the decrementing of the different status bars making sure to store the information on the backend. Instead of hopping around different tasks, we made sure to collaboratively solve any hurdles our team was having to assure it wouldn't create bugs for other functionality of the app. 

# Installation instructions
1. Fork and clone repo 
2. Install repo onto local client
3. Open app with XCode
4. Press file -> add packages
5. Paste this link into the search bar ``` https://github.com/realm/realm-swift ```
6. Inside dependency rule click up to next major version
7. Inside of the left box type 10.19.0 and leave the right box empty (should say 10.19.0 < 0.0.0)
8. Click add package on the bottom right of the screen
9. Check the box for realm and realmswift then hit add package
10. Run app!

# Major Hurdles
Some of the biggest major hurdles was having realm show the data realtime whenever it was changed. Whenever a button was clicked it would log to the database, but not show it to the user. To overcome this we created variables to make it appear as though the data was changing without refreshing the app. An unsolved issue we had was getting realm to communicate with a widget. We wanted to have all of the users stats show, but realm only allowed us to communicate within a certain scope of the app.

## Wireframes
<img width="300" alt="Screen Shot 2022-04-11 at 9 18 52 PM" src="https://user-images.githubusercontent.com/97310057/162879539-f75c5604-ec75-4d4e-a373-4bcd348c3cec.png" >
<img width="300" alt="Screen Shot 2022-04-11 at 9 19 15 PM" src="https://user-images.githubusercontent.com/97310057/162879576-df3c1d9c-690c-4785-850b-fe2e82002e71.png">
<img width="300" alt="Screen Shot 2022-04-11 at 9 19 25 PM" src="https://user-images.githubusercontent.com/97310057/162879590-f5048ad6-fdb6-4430-8db4-2308e9c8cd83.png">
<img width="300" alt="Screen Shot 2022-04-11 at 9 19 31 PM" src="https://user-images.githubusercontent.com/97310057/162879600-10545081-0adc-4e13-89b0-245278a8cf11.png">

## ERD
<img width="300" alt="Screen Shot 2022-04-11 at 9 37 03 PM" src="https://user-images.githubusercontent.com/97310057/162881804-d26d4d53-653d-4b1d-a378-e0eeff3801d9.png">

## MVP
- Users can interact with their Amis (feed, hydrate, evolve)
- See pet status change over time

## Stretch Goals
- Implement original art and music/sound FX
- Users can adopt multiple Amis
- Pet mini games
- Multiplayer functionality
- Evolve tree for pets
- Leaderboards/forums/share pets with other users
- Battling with Amis
- Integrate step counter to walk pet
- Different pet animations and aesthetic outfits

## Sprints
### Tuesday 
- Get repos linked up and upstream working
- Research swift
- Work on backend as group 
### Wednesday
- Finish backend
- Work on front end as group
### Thursday 
- Research and work on stretch goals seperately


## Developers
- Triston J. Palacios
- Bryan Nguyen
- Zach Brose
- Evan Karwowski 

## Resources
- https://realm.io/
- https://www.swift.org/documentation/

