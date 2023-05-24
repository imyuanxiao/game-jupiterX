### Summary

This is a group project for a course in University of Bristol. 

Due to my stronger programming skills, I designed the overall framework of the game based on the MVC, created UML diagrams, defined all classes and their methods, and ensured the independence and compatibility of various modules. 

As the main contributor to this project, I contributed more than 80% codes and implemented several critical features, including random map generation, room optimization, collision detection, key listener, player control, UI, factory classes, as well as dealing with daunting tasks that no one else could solve . 

Following is original group report. Personnel information is hidden for privacy.



<div align="center">
   <h1> University  of  Bristol <br/>
   COMSM0110 - Group 7 (2023) <br/></h1>
   <h2>JUPITER X Resource War</h2>
</div>




### Contents
- [2. Introduction](#2-introduction)
- [3. Requirements](#3-requirements)
  - [3.1 Use case diagrams](#31-use-case-diagrams)
  - [3.2 User stories](#32-user-stories)
  - [3.3 Early stages design and ideation process](#33-early-stages-design-and-ideation-process)
- [4. Design](#4-design)
  - [4.1 System architecture](#41-system-architecture)
    - [4.1.1 Game Engine](#411-game-engine)
    - [4.1.2 Game Logic](#412-game-logic)
    - [4.1.3 Data Management](#413-data-management)
    - [4.1.4 Asset Management](#414-asset-management)
    - [4.1.5 Networking](#415-networking)
    - [4.1.6 User Interface](#416-user-interface)
    - [4.1.7 Input Handling](#417-input-handling)
    - [4.1.8 Audio](#418-audio)
  - [4.2 Class diagrams](#42-class-diagrams)
  - [4.3 Behavioural diagrams](#43-behavioural-diagrams)
- [5. Implementation](#5-implementation)
  - [5.1 Randomly generated map and elements](#51-randomly-generated-map-and-elements)
  - [5.2 Collision detection](#52-collision-detection)
  - [5.3 Performance effects](#53-performance-effects)
- [6. Evaluation](#6-evaluation)
  - [6.1 Qualitative evaluation](#61-qualitative-evaluation)
  - [6.2 Quantitative evaluation](#62-quantitative-evaluation)
  - [6.3 How code was tested](#63-how-code-was-tested)
- [7. Process](#7-process)
  - [7.1 Teamwork](#71-teamwork)
  - [7.2 Software](#72-software)
  - [7.3 Team roles](#73-team-roles)
- [8. Conclusion](#8-conclusion)


<br>

## 2. Introduction

Our game is based on the classic roguelike adventure game Spelunky. In the original game, each level is randomly generated, and the player must descend through a series of caves, fighting enemies and collecting treasure.  We decided to take this concept and adapt it to an arcade style game set in space. In keeping with the original our game features randomly generated levels and item drops, but as a twist we added in an unkillable alien ghost who pursues the player throughout every level. Players are dropped onto an alien planet, and they must control a space marine on a quest to collect energy crystals for their dying home world. This planet is rich in resources but full of danger, and the marine must survive against impossible odds for as long as they can, using weapons, teleportation, and super jumps to evade and eliminate their enemies and mine crystals before the ghost catches up…

<p align="center">
  <img width="70%" src="./ReportMaterials/gameplay.gif">
</p>
<br>

## 3. Requirements


### 3.1 Use case diagrams

<p align="center">
  <img width="70%" src="./ReportMaterials/UseCaseDiagram.png">
</p>
<br>
Use case diagrams and user stories are kept in folder 'ReportMaterials' in gitub mainpage for your reference.

https://github.com/UoB-COMSM0110/2023-group-7/tree/main/ReportMaterials


### 3.2 User stories

As a player I want to play a character with different combination of weapons so that have personalized game experience.

As a player I want to explore different dungeons rooms so that experience the joy of unknown.

As a player I want to encounter with different enemies with different skills and difficulty so that devote thought to planning survival routes and game strategies.

As a player I want to discover different items to improve weapon power or make the survival easier so that pay attention to collect item while fighting with monsters and increase fun of the game.

As a player I want to change game difficulties and there are some defined levels so that I can choose them according to my level and make game experience better.

As a player I want to experience permadeath so that I need to make every decision carefully and compete with others for scores.

As a player I want to experience different movement method so that the game has more possibilities and be unexpected rescued from a desperate situation

As a player I want to interact with map elements such as portal so that the game become much more interesting, and I can make strategies with these things.

As a player I want to heal my HP so that there still chances to survive even I make a strategy mistake.

As a player I want to experience a game that the difficulty level increase by time so that the game become more interesting soul-stirring with time going by in the case that the play is used to current difficulty.

As a player I want to pause the game while playing so that I could continue the game after I resolve emergency.

As a player I want to store my game score and compare with other players so that I can be hungrier for score and feel fulfilled when I beat other players.

As a player I want to turn off the game music so that I can focus on the game without being influenced by background music.

As a player I want to check the game tutorial or help at the start menu as well as in the game so that I can learn the operation method when I first play it and check help tips when I forget some operations in game.

As a player I want to be hurt by map elements so that I need to focus on every moment.

As a player I want to pick up items that could increase my score so that I'm more enthusiastic to explore the game.

As a player I want to double jump in the game so that I can move more flexible.

As a developer I want to design a game room and map generation algorithm so that the game has more possibilities and more interesting to explore.

As a developer I want to design several weapons so that the game experience is personalized.

As a developer I want to design background music and different sound effects so that the player could be more immersed into the game.

As a developer I want to have different artistical art and animation design so that the player has better game experience.

As a developer I want to design menus for different settings so that the player could personalize their playing easily.


### 3.3 Early stages design and ideation process

At early stages, each member in the team brought up at least 2 games ideas to develop. We discussed and evaluated all ideas from a wide range of aspects which game we are going to build, for example, the possibilities of twists for each game, potential game users, a more original game, how it works (interactions between enemies and player) etc.

Finally, we reached a consensus of which game to develop as we all agreed on a rough-like game and clearer picture of our game. Initially we have a general aim for our game, for example, game background setting, space mission and exploring, various landscapes (rooms), various enemies, score system, items system etc.


## 4. Design

### 4.1 System architecture


In the realm of game development, system architecture design is a critical aspect, as it provides the essential framework and coordination for the game's diverse components. This design facilitates the scalability, maintainability and it ensures the game can be developed efficiently. Here are some key elements we have taken in account during devising the system architecture of this game:

#### 4.1.1 Game Engine

As required by the assignment brief, the game is design with Processing, instead of relying on pre-built game engines, we have efficiently created a custom game engine. It allowed us to take advantage of the full potential of Processing, like rendering capabilities, animation, interface design. Based on it, the game could be developed efficiently, and different components created by all people in our team could be combined and integrated seamless.

#### 4.1.2 Game Logic

Design the game logic, which includes the rules and mechanics of the game, such as character progression, combat, and level generation. This should be separated from the rendering and engine systems, allowing for easier updates and modifications to the game's core functionality.

- Objective and challenges

The game performance is evaluated by player score, which is calculate by the number of enemies killed, the number of ore mined, number of items acquired. There is a score coefficient based on initial difficulty choice and the score already acquired (increase by 1 every 5000 score). Different enemies correspond to different score. Player has 10 HP at the beginning of the game, you will lose 1 HP every time you touch spine or hurt by enemies. When all HP used up, game over, you can input your name and see ranking. The game target is to survive, collect scores as many as possible. 

- Core gameplay mechanics

Player has the command: move left/right, speed down, interact, pick up item, change weapon, change items, jump, jump off, pause, shoot, use items. 

Crates appears randomly in the room and can be opened with keyboard input “E” and press another time to pick it up, the crate might contain one of the following items: shotgun bullet, split shot bullet, wing (fly 8 seconds), HP diamond (max HP +1) and SPEED diamond (speed up in 5 seconds). 
The yellow board is trampoline, it increases jump heigh when the player stands on it. 

The blue board is portal, stand on it and press key “E”, the player could teleport back and forth between portals. 

Ore is hidden in blocks, use miner gun to attack them and get scores.

Green and red diamonds are randomly distributed in the room, touch to collect them, the green diamonds bring extra marks, and the red diamonds heal 1 HP.

- Game state and transitions

When the game starts up, it enters the default home page, where the player can choose to start, check help page, option page, ranking and quit. And in the game, on the top right corner, there are some buttons: help, music on/off, pause and exit. Game states are defined in Model class, the coordinate of mouse is monitored whether on the button area, when press buttons, it calls controller to change game statues, then the View class render new game picture.

- Artificial Intelligence (AI)

All enemy are controlled by AI algorithms, the unbeatable ghost identifies your coordinate and chase you all game after you leave the first room. All the other enemies have their own space, when the player appears in the area, the monster launch attacks in their way, shooting or melee attack.

- Game balance and difficulty

As required in the assignment brief, there are three preset difficulties, it can be change in the option menu and you can see current difficulty in the game. To make the game more intense and thrilling over time, a hidden difficulty coefficient is applied (increase by 1 every 5000 score). The difficulty is tested to make sure it’s appropriate.

- Event handling and input management

Collision detection is running all the time to make sure the player has valid interaction with monsters or the room. The game monitor mouse and keyboard input to receive player input. All error message is recorded so that when it crashes, the developer could figure out the reason and fix it.

#### 4.1.3 Data Management

The game information is stored locally with array list or csv file. Some data like the map of already explored rooms is reset every time game over and new round start, so that every round the player could explore new map. While some other data like the score and ranking is only initialized when game startup, so that player could see previous game records after several rounds.

#### 4.1.4 Asset Management

The game's assets, such as textures, models, animations, and sound files are imported when game startup and will be called with game start. The file is placed in folder /Moon/Data/imgs.

#### 4.1.5 Networking

Multiplayer is not implemented in current game design phase, so networking is not considered.

#### 4.1.6 User Interface

The user interface is designed with Adobe Photoshop and Adobe Illustrator, all images and buttons are imported at game startup and rendered by View class. Mouse is monitored, when it is released in the button area (judged by coordinates), controller set the corresponding game status and new game picture is rendered by View class. All interfaces are placed in /Moon/Data/imgs/menu, replace the image file with the same name could update the game menu.

#### 4.1.7 Input Handling

The player input is monitored in main class, the keyboard input is not case sensitive and captured by keyReleased() and transformed to lower case, the mouse is captured by mouseReleased(), they will be passed into controlled to do corresponding operation. 

#### 4.1.8 Audio

The background music featured in the game is sourced from "Neon Abyss". Other sound effects, such as shooting, taking damage, and jumping, are obtained from an online resource library: https://588ku.com/. Playing music is relied on Minim, an audio library that provides easy to use classes for playback, recording, analysis, and synthesis of sound. All the mp3 file is loaded at the startup. There is a Boolean game statue “isMusicPlaying” in Model class, it is true by default and can be changed when setIsMusicPlaying(true) is called. When isMusicPlaying is true, the background music will be played.



### 4.2 Class diagrams
<p align="center">
  <img width="90%" src="./ReportMaterials/game_class_diagram.png">
</p>
<br>


### 4.3 Behavioural diagrams

<p align="center">
  <img width="60%" src="./ReportMaterials/CommunicationDiagram.png">
</p>
<br>
Behavioural diagrams are kept in folder 'ReportMaterials' in gitub mainpage for your reference.

https://github.com/UoB-COMSM0110/2023-group-7/tree/main/ReportMaterials

The game is based on MVC model to build. We worked and discussed as a team to decide what are the game mechanics, how the player might behave ( things that player does: exploring unknown areas, mining, using items to deal with various creatures etc.) , what should be displayed on the interface ( the way player communicate with game, HP system, score system , creatures AI etc.).

We illustrated them in class diagrams. Generally, we needed several basic classes to validate the game. Class for view & model & controller, class for random room, class for player, class for various creatures, class for items etc.

## 5. Implementation

We follow the general game developement process to implement our game : planning -- pre-production -- production -- testing -- pre-launch -- release.

We have weekly meeting to summarize what we have done for the project, discussed current difficulties during development for own part, clarified ambiguities, brought up possible new features for games and added them in our process.

During the implementation of our game, we found below 3 main challenges :

### 5.1 Randomly generated map and elements

Our goal with the random generation of rooms, was for every level to look and feel distinctly different. The main problems faced here were ensuring that every room has at least one path the player can follow, and that there are no areas where the player or enemies can get stuck. 

Our solution was to use a pseudo-randomly generated approach. The board size is set to 1160 by 800 pixels and is divided into a grid of 29 by 20 blocks. Each room has a border of 1 block with 6 exits, and the remaining space is then divided into 6 sections, each of 9*9 blocks (see image below). The sections are stored in CSV files, and dictate the placement of normal blocks, jump pads and portals. We carefully designed a large number of different sections and carried out user testing to ensure that they fit together in any combination without obstructing the players movement. 

When each room is generated, 6 sections are chosen at random and used to build the room. The logic for this generation is designed in such a way that no room can contain two identical sections. Next, we optimise the room, adding in some additional special platforms to make gameplay more dynamic. We then scan the room to find suitable locations for elements such as enemies and items. These elements are then added to randomly selected locations. 
<p align="center">
  <img width="90%" src="./ReportMaterials/Map%20diagram.jpg">
</p>
<p align="center">Image showing how level sections are laid out in each room</p>
<br>

<p align="center">
  <img width="60%" src="./ReportMaterials/room-generation.gif">
</p>
<p align="center"> Gif showing how a player can move seemlessly between randomly generated rooms. </p>

### 5.2 Collision detection

Collision detection is one of the most important aspects of our game. We are always looking for better ways of collision detection and keep it constantly updated.

In the beginning, basic collision detection was based on rectangular and rectangular collisions. At that stage, the position and size depended on the floats x, y, width, height and then, for ease of development, it was modified to be determined by the PVector location. We have rewritten the detect method to meet the collision detection of each type of object according to different needs.

For example, if a room in the game is made up of blocks based on matrix coordinates, our algorithm only needs to detect the walls around the object to reduce performance consumption. Also, the improved algorithm can match objects of arbitrary position and size. The effect of a moving object (e.g. player, enemy) being blocked by a wall is achieved by resetting the PVector location of the object and clearing the PVector velocity in the corresponding direction. If the object is blocked by a wall below, then the jump and fall states of the moving object are reset. Different strategies are used for collision detection for the player and the enemy, so that the enemy does not cross the boundary and cause a bug.

It is fair to say that we have spent considerable effort on collision detection and have achieved more than satisfactory results, which have greatly enhanced the gaming experience.

### 5.3 Performance effects

We have spent a lot of time and effort on the presentation to make everything as perfect as possible, like a full-fledged game.

In many cases, we have replaced single image effects with gifs, so that many of the effects are played in a continuous motion picture. By using the DecorationFactory, we can add both temporary and permanent gifs to the room, and set duration, speed, size and location of gifs by using different constructors. For example, when the player dies, the player does not suddenly fall, but has a complete set of movements. There are also different matching gifs for the player and the enemy in different states: for example, when the player or the enemy is attacked, there is a knockback effect; when the player is injured, there is an invincibility time as well as a blinking effect.

Another notable mention is our shooting system. We have used the PVector system instead of the traditional x, y and speed coordinate system. We used the PVector to make the weapon follow the rotation of the mouse position, as well as to ensure that the bullets are fired from the muzzle, again contributing to the hitting effect in the previous section.

## 6. Evaluation

### 6.1 Qualitative evaluation

We used the Think Aloud evaluation method to conduct qualitative testing of the game. We invited test users to explore the game pages and content freely and without guidance from the developers, while asking them to express their thoughts aloud.

During this test, we identified the following issues for improvement (surely that’s not all): the need for more tutorials (including an introduction to the various items and weapons, basic operations, etc.); the need to improve the operations according to habits, e.g. the 'SPACE' and 'W' keys can both be used to 'jump'; the lack of visibility of entrances and exits on the game screen and the need to add guidance; the difficulty of the game needs to be adjusted, for example, players think the drop damage needs to be reduced.

We also found it interesting to note that, because we did not select our test players, there was a significant difference in the feedback on the experience between players with and without relevant gaming experience. It took some time to learn and accept the keys and attack patterns for the first time, so we needed to give enough guidance at the beginning of the game to enhance the experience (otherwise it would have been a disguised way to make it harder and turn off players).

Based on these results, we have decided to improve the guidelines and create a more user-friendly tutorial. We have also adjusted the props and values to correct the difficulty of the game. And also to emphasise the player's goal: to get the highest score they can.

### 6.2 Quantitative evaluation

We gathered ten players to fully conduct that test. The process was as follows: we gave a brief introduction to the game and its operation, the players started to experience the game and finally filled in two forms, System Usability Scale and NASA TLX, based on their real thoughts.

In NASA TLX, we did not use weights for the six dimensions. Combining the scoring data reveals a large variation in the perception of the game's tasks between test users, which may be related to players' gaming experience and their own familiarity with the genre. Combining the independent mean scores for each dimension we find that players generally perceive the level of thinking required and effort required to play the game to be high, and that players are satisfied with their performance.
<p align="center">
  <img width="90%" src="./ReportMaterials/NASA%20TLX.png">
</p>
<br>
With players generally giving relatively good usability ratings (satisfactory scores) in SUS, it is fair to say that our game system has a good track record. This includes the fact that players found our system simple and easy to use and the tasks easy to understand. At the same time, some issues were also reflected, such as the fact that players felt they needed some time and some learning to use it. This echoes the issues reported by users during the Think Aloud evaluation in the previous section.
<p align="center">
  <img width="90%" src="./ReportMaterials/SUS.png">
</p>
<br>

### 6.3 How code was tested

Given that the development is using Processing, we are currently unable to perform further unit testing on the code etc., so we have chosen to focus our testing on user testing.

For user testing, we have used the Think Aloud evaluation, NASA TLX and System Usability Survey (SUS) methods. In the Think Aloud evaluation, we let the testers explore the interface and content of the game without any guidance from the developers and asked them to express their thoughts out loud during the exploration process. We can quantify and analyse the results of the survey to draw conclusions and make the game better and more user-friendly.

Based on the results of the table and the player testimonials we found that, overall, players do not find our game system complicated, but may need some guidance to learn it. Basically, they think we have a strong gameplay and show that they want to play often. It may be necessary to maintain a tense state of operation while playing to keep the game experience going. Happily, almost all players praised our game's graphics and gameplay. Another point that deserves our attention is that, due to the lack of guidance, it seems difficult for players to realise that the goal of our game is to "mine for more points" (rather than to "stay alive").

## 7. Process

### 7.1 Teamwork


We adopted a quite flexible and collaborative approach for game development. Generally, we have a weekly meeting in lab and on teams during holiday, to go through every aspect of the game development, we have one team member jotted down meeting notes each week and assign tasks to team member who is in charge for that in Jira. We posted our questions on teams to get instant feedback or to get support, or to fix bugs, and we committed our work to GitHub so everyone in team could see the changes and monitor our process to ensure our work hit the weekly schedule.

Here are some screenshots for how we collaborated as a team.

- Shared meeting notes
- Shared good ideas
- Shared public methods so others can make full use of the codes and avoid repetition
- Shared good software
- Helped to fix bugs
- Shared the change that might affect everyone’s development to keep everyone stay up to date
  <br></br>
  
  <p align="center">
       <br></br>
      <img src="./ReportMaterials/reportprocess/meeting1.png" alt="Screenshot of meeting notes example - 1">
      <br> Screenshot of meeting notes example - 1
      <br></br>
      <img src="./ReportMaterials/reportprocess/meeting2.png" alt="Screenshot of meeting notes example - 2">
      <br>Screenshot of meeting notes example - 2
      <br></br>
      <img src="./ReportMaterials/reportprocess/goodsoftware.png" alt="Screenshot of sharing good software">
      <br>Screenshot of sharing good software
        <br></br>
      <img src="./ReportMaterials/reportprocess/fixbug.png" alt="Screenshot of helping to fix bug">  
      <br>Screenshot of helping to fix bug
        <br></br>
  </p>

### 7.2 Software

We used various software introduced from the lecture.

- Teams: communication and meeting
- Jira: Assigned tasks and monitored our progress
- UML: Illustrated class diagrams
- Git & GitHub: for version control and committed staged work
- Photoshop: designed certain character in game
- Processing: wrote codes to build the game
  <br></br>

<p align="center">
    <img src="./ReportMaterials/reportprocess/jira.png" alt="Screenshot of using Jira to assign tasks and monitor progress">   
    <br>Screenshot of using Jira to assign tasks and monitor progress
</p>
  <br>
<br>Also please follow below link if you want to check how we collaborate in Jira.</br>

https://uob-group7.atlassian.net/jira/software/projects/GP/boards/1
### 7.3 Team roles

We divided the game into 5 parts at beginning of the project, so everyone can focus on his or her own part. Please find below table as how we assign the team role and also our individual contribution.

| Task                                | To do by | Individual Weight|
| ----------------------------------- | -------- | -------------|
| Rooms & Room Factory                | ***     |1.00          |
| Menu & Setting & BGM                | ***   |0.95          |
| Game framework, Player, Basic props, Collision etc… | Xiao     |1.15          |
| Items & Items Factory               | ***    |0.95          |
| Enemy & Enemy Factory               | *** |0.95          |

Meanwhile, apart from the game, there are some works have been done by different team members:

- kept tracking and pushing the progress to ensure delivery of the game
- jotted down meeting note and shared recap
- Assigned tasks regarding meeting
- Acted as user or found new user to play game and asked for feedback
- Reached out to internet for game design (player, enemies, items, gems & rocks etc..), as we wanted it our game in an extraterrestrial world setting
  <br>

## 8. Conclusion


Overall, the game is basically a 2D platform adventure game and is inspired by Spelunky. But we re-designed the game to make it more originally made by our own. for example, extraterrestrial planet background setting, all elements shown in the game are consistent with the game storyline , completely random generated maps, items, enemies to make the game more fun to play.

From software quality perspective,we think we have met the requirements of game development. Firstly, the game is fun to play. Secondly, the codes have been conformed with our conventions, it's readable and maintainable, and had been tested and reviewed again and again to make it as concise and accurate as we can.

The project is absolutely challenging and here are some tricky challenges that we had in the process:

- Enemies and rooms are generated randomly, it's difficult to make sure enemies were generated legally in the right place
- Various enemy AI
- Collision detection between player and creatures and spikes
- Dynamically display player and enemies

Basically, our approach to solve question is that We brought the questions to meeting and devided them into smaller parts.We proposed a potential viable solution , tested it and revised it , conquered them step by step. Our strategy is that we try to complete the basics of the game and made it functional. Then we improved it and added new features and beatify characters and game interface by each round's sprint.

Thus, we are very proud of the game we have developed, it is thrilling to present our final game for end users to play.
During the process,we not just have gained valuable experience to develop a new game , but also learnt to collaborate as a team. Meanwhile, learnt to make full use of various software to improve efficiency.

Finally, we decided to put below features to our future work as time is limited:

- Phase in user login system which can allow to store users information, play records and rank their scores
- Validate the game for two players, it might be more fun if players can help and interact with each other in space exploration
- Validate the game for connecting internet, so players can share their scores
- More various bosses for player to challenge
- Generate more interesting various secret maps, so players can unlock it and get unexpected bonus
- More enemies and more items that allow player to create new playing methods and play more flexibly
- Provide more items for player to use, like immute death, summon NPC to attack emermies, special shield to help user to reflect the damage etc..
- Provide a bag system so user to check current available items and instructions for them
- A complete introduction of game storyline for user to better understand its background and goal
- Phase in quests system, player can unlock quests to increase their scores or boost its effects
