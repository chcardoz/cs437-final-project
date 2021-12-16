# CS 437 Final Project

## Game Design Document
### Scenes

1. Opening Scene
2. World Scene
3. Death Scene

### Sprites

1. Main Character Cat - White colored cat sprite obtained from Open Game art. The cat came with an animation sprite for simple aniations like walking, punching, kicking and idle. 
2. Enemy Bats - The enemy bats came as an animation sprite too. They have only one animation, which is the looped flying animation and this keep playing indefinitely. 
3. Bush - Non animated sprite assigned to **static body** in Godot with a simple collision box.
4. Dirt Road Tile Set - A tile set with different viewes of the dirt road. A tile set contains tiles for all combinations of how the tile might be placed. The dirt road has no collision shapes on it. 
5. Cliff Tile Set - Another tile set with different views of the cliffs. The cliffs are the onyl environment tiles with collisions shapes on them. 
6. Tree - A simple tree sprite that is assigned to a static body with a collision box. 

### Interactions
1. **Main Character with the World** - The colliders of the player, enemy and the world sit on different collision layers. The reason for using collision layers is because we dont want the enemies colliding with each and triggering the health reduction script. Therefore, the players and enemies only collide with the environment and they don't lose health when they do so. The players slide along world collision objects using a function in Godot called ``move_and_slide()``. 
2. **Main Character with the Enemies** - The interaction between player and enemies is handled using Hitboxes and Hurtboxes. Both the player and the enemy have a hitbox and hurtbox. These two "scenes" are called ``Area2D`` nodes in Godot. In Godot, you can let the script know that another node has entered your collision shape or your area using **signals**. For the enemy's hurtbox, there is a signal when the hitbox of the player has entered it. The same goes for the player's hurtbox. We must also be careful when setting this up because one hitbox can trigger another hitbox. Therefore, the hitboxes and hurtboxes have to be kept on seperate collision layers. 

### Animations
1. **Cat Blend space 2D** - A blend space 2D is a feature of Godot that maps the user input vector to a blend space between animaitons. Therefore, one can interpolated between two animations and Godot fills in the gaps. However, for pixel art, blending is not important. But, having a blend space that maps the input of the user to the character's animations removes the need to use code. The Cat has four states - **Walk** (Idle), **Kick** (Attack), **Punch** (Attack),**Special** (Attack). All of these animations have a left and right counterpart. The animations are taken from a sprite sheet, obtained from (Open game art - put link here)
2. **Bat Animated Sprite** - Because the enemy bat does not respond directly to user input, a blend space was not required. Instead, an animated sprite was used. In Godot, an animated sprite is a combination of a normal sprite and an animation player. Just like the cat, you need to provide a sprite sheet, some offset, and the number of frames. The bat loops through these frames and appears to be flying. The bat sprite sheet was obtained from ().

### Procedural Generation
The following are the steps taken to procedurally generated a random world using a variant of perlin noise in Godot. 
1. The random generator was seeded and a new instance of **OpenSimplexNoise** was created. Open simplex noise is a variant of perlin noise in Godot which has been procedurally generated. The values in the open simplex noise can be used for textures, height maps and world generation. Values in the noise map range from -1 to 1. 
2. For the simplex noise to work for world generation, some parameters have to be tuned. These parameters are - Octaves, period, lacunarity and persistence. High octave values give more detailed noise but take more time to generate. This value was set to 9. Lower period value give more changes in the noise across the same distance. This was set to 4. Lacunarity is the difference in periods between octaves. This was set to 1.5. A persistence value of 1 means all the octaves have the same contribution and this was set to 0.1. 
3. Using the values above, first the cliffs were generated. To put a clif in the map, you have to let the tile map know that you want to place a new tile in this location. So, the x and y values ranged from one corner of the world to another. For each x and y value, the noise value was obtained which ranged from -1 to 1. For the generation of cliffs, there was a condition that the noise value must be lesesr than -0.5 but greater than -1. 
4. The same was done for the dirt road tile set. The generation of dirt roads was subjected to the condition that the noise value has to be between 0.1 and 1. 
5. Next, the environment(trees, bushes) were generated. THe noise values from the simplex were used to make sure that the bushes and trees did not appear where there were clifs and did not spawn in the middle of roads. Another random variable was used as probability of the bush or tree spawning in the location chosen.  
6. Lastly, the enemies were also generated in the same region where the bushes and trees were generated. The enemies could not be generated in the region of the cliffs because the cliffs have colliders that would have blocked the enemies from moving. 

### Level and Experience system
$$\text{Required Exp}(\text{level})=4a+(\text{level})^{b}$$
The above equation is used to calculate the required experience or points for a given level. This equation is a very common experience level. 0

## State Transition Diagram


## User Instructions
To play the game, please run the .exe file in the build folder.
The player can be moved around using the arrow keys
1. Spacebar - To kick
2. X - To punch
3. Z - To perform the special attack. 
