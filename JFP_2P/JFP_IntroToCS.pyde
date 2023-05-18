add_library('minim')

import os
# import random

path = os.getcwd()

RESOLUTION_W = 1080
RESOLUTION_H = 720

walkman = Minim(this)

class Jet:
    def __init__(self, player):
        self.player = player
        self.speed = 3
        self.baseSpeed = 3
        self.y = random(RESOLUTION_H)
        self.diameter = 40
        self.steer = 0
        self.baseSteer = 0.05
        
        self.isDead = False
        self.death_sound = walkman.loadFile(path + '/sounds/death.mp3')
        self.respawn_sound = walkman.loadFile(path + '/sounds/respawn.mp3')
        self.shot_sound = walkman.loadFile(path + '/sounds/shot.mp3')
        self.portal_sound = walkman.loadFile(path + '/sounds/portal.mp3')
        
        # self.deathGif = []
        # self.frame = 0
        # for i in range(1, 20):
        #     frameName = "explosion" + nf(i,3) + ".png"
        #     self.deathGif.append(loadImage(path + '/images/' + frameName))
        
        self.portals = []
        self.ports = 0
        
        for i in range(2):
            self.portals.append(Portal(self.player))
        
        self.bullets = []
        
        if self.player == 0:
            self.img = loadImage(path + '/images/blue.png')
            self.x = RESOLUTION_W/4
            self.angle = 0
            self.keyset = ['W','w','A','a','S','s','D','d']
        elif self.player == 1:
            self.img = loadImage(path + '/images/red.png')
            self.x = RESOLUTION_W*3/4
            self.angle = PI
            self.keyset = [UP,DOWN,LEFT,RIGHT]
    
    def stayCourse(self):
        self.x += (self.speed * cos(self.angle))
        self.y += (self.speed * sin(self.angle))
    
    def stayInBounds(self):
        if self.ports < 2:
            if self.x - self.img.height/2 < 0:
                self.x = self.img.height/2
            elif self.x + self.img.height/2 > width:
                self.x = width - self.img.height/2
                
            if self.y - self.img.width/2 < 0:
                self.y = self.img.width/2
            elif self.y + self.img.width/2 > height:
                self.y = height - self.img.width/2
                
        else:
            if (self.x > self.portals[0].x - self.portals[0].width/2) and (self.x < self.portals[0].x + self.portals[0].width/2):
                # print("between portal width")
                # print(self.y)
                # print(self.img.width/2)
                if (self.y < - self.img.width/2) and (self.portals[0].y == 0):
                    print("entering portal on top wall")
                    self.x = self.portals[1].x
                    self.y = self.portals[1].y
                    self.angle = self.portals[1].plane
                elif (self.y > height) and (self.portals[0].y == height):
                    print("entering portal on bottom wall")
                    self.x = self.portals[1].x
                    self.y = self.portals[1].y
                    self.angle = self.portals[1].plane
                elif ((self.y < self.img.width/2) and (self.portals[0].y == height)) or ((self.y > height) and (self.portals[0].y == 0)):
                    if self.y - self.img.width/2 < 0:
                        self.y = self.img.width/2
                    elif self.y + self.img.width/2 > height:
                        self.y = height - self.img.width/2
                        
            elif (self.x > self.portals[1].x - self.portals[1].width/2) and (self.x < self.portals[1].x + self.portals[1].width/2):
                # print("between portal width")
                # print(self.y)
                # print(self.img.width/2)
                if (self.y < - self.img.width/2) and (self.portals[1].y == 0):
                    print("entering portal on top wall")
                    self.x = self.portals[0].x
                    self.y = self.portals[0].y
                    self.angle = self.portals[0].plane
                elif (self.y > height) and (self.portals[1].y == height):
                    print("entering portal on bottom wall")
                    self.x = self.portals[0].x
                    self.y = self.portals[0].y
                    self.angle = self.portals[0].plane
                elif ((self.y < self.img.width/2) and (self.portals[1].y == height)) or ((self.y > height) and (self.portals[1].y == 0)):
                    if self.y - self.img.width/2 < 0:
                        self.y = self.img.width/2
                    elif self.y + self.img.width/2 > height:
                        self.y = height - self.img.width/2
            
            elif (self.y > self.portals[0].y - self.portals[0].height/2) and (self.y < self.portals[0].y + self.portals[0].height/2):
                # print("between portal height")
                if (self.x < - self.img.height/2) and (self.portals[0].x == 0):
                    self.x = self.portals[1].x
                    self.y = self.portals[1].y
                    self.angle = self.portals[1].plane
                elif (self.x > width) and (self.portals[0].x == width):
                    self.x = self.portals[1].x
                    self.y = self.portals[1].y
                    self.angle = self.portals[1].plane
                elif ((self.x < self.img.height/2) and (self.portals[0].x == width)) or ((self.x > width) and (self.portals[0].x == 0)):
                    if self.x - self.img.height/2 < 0:
                        self.x = self.img.height/2
                    elif self.x + self.img.height/2 > width:
                        self.x = width - self.img.height/2
                
            elif (self.y > self.portals[1].y - self.portals[1].height/2) and (self.y < self.portals[1].y + self.portals[1].height/2):
                # print("between portal height")
                if (self.x < - self.img.height/2) and (self.portals[1].x == 0):
                    self.x = self.portals[0].x
                    self.y = self.portals[0].y
                    self.angle = self.portals[0].plane
                elif (self.x > width) and (self.portals[1].x == width):
                    self.x = self.portals[0].x
                    self.y = self.portals[0].y
                    self.angle = self.portals[0].plane
                elif ((self.x < self.img.height/2) and (self.portals[1].x == width)) or ((self.x > width) and (self.portals[1].x == 0)):
                    if self.x - self.img.height/2 < 0:
                        self.x = self.img.height/2
                    elif self.x + self.img.height/2 > width:
                        self.x = width - self.img.height/2
                    
            else:
                if self.x - self.img.height/2 < 0:
                    self.x = self.img.height/2
                elif self.x + self.img.height/2 > width:
                    self.x = width - self.img.height/2
            
                if self.y - self.img.width/2 < 0:
                    self.y = self.img.width/2
                elif self.y + self.img.width/2 > height:
                    self.y = height - self.img.width/2
        
    def move(self):
        self.stayCourse()
        
        if not self.isDead:
            self.stayInBounds()
        
        self.angle += self.steer
        
    def checkDeath(self, other):
        for i in range(len(other.bullets)):
            if dist(other.bullets[i].x, other.bullets[i].y, self.x, self.y) <= self.diameter/2:
                
                self.isDead = True
                # self.deathAnimation()
                self.death_sound.rewind()
                self.death_sound.play()
                self.x = -500
                self.y = -500
                self.speed = 0
                
                other.bullets[i].x = -50
                other.bullets[i].y = -50
                other.bullets[i].speed = 0
                
                return 1 
        return 0
    
    # def deathAnimation(self):
    #     st = millis()
    #     et = millis()
        
    #     for i in range(19):
    #         while (et - st < 1000):
    #             image(self.deathGif[i % 19], self.x, self.y)
    #             et = millis()
    #         i += 1
    #         st = et
        
    def shootBullets(self):
        bullet = Bullet(self.x, self.y, self.angle)
        self.bullets.append(bullet)
        
    def displayBullets(self, game):
        result = []
        for i in range(len(self.bullets)):
            if self.bullets[i].timeAlive < 200:
                self.bullets[i].move(game)
                self.bullets[i].display()
                result.append(self.bullets[i])
        self.bullets = result
    
    def shootPortals(self):
        self.portals[self.ports % 2] = Portal(self.player, self.x, self.y, self.angle)
        self.ports += 1
        
    def displayPortals(self):
        for i in range(2):
            self.portals[i].move()
            self.portals[i].display()
        
    def display(self, game):
        self.displayBullets(game)
        
        push()
        translate(self.x, self.y)
        rotate(self.angle)
        image(self.img,0,0,40,40)
        pop()
        
        self.displayPortals()
        


class Bullet:
    def __init__(self, x = -100, y = -100, angle = 0):
        self.x = x
        self.y = y
        self.angle = angle
        self.speed = 6
        self.diameter = 8
        self.timeAlive = 0
        
        self.assembledJets = False
        self.jets = []
    
    def move(self, game):
        self.x += (self.speed * cos(self.angle))
        self.y += (self.speed * sin(self.angle))
        self.travelPortals(game)
        self.timeAlive += 1
        
    def travelPortals(self, game):
        if not self.assembledJets:
            self.assembleJets(game)
            
        for jet in self.jets:
            
            if (self.x > jet.portals[0].x - jet.portals[0].width/2) and (self.x < jet.portals[0].x + jet.portals[0].width/2):
                if (self.y < -self.diameter) and (jet.portals[0].y == 0):
                    self.x = jet.portals[1].x
                    self.y = jet.portals[1].y
                    self.angle = jet.portals[1].plane
                elif (self.y > height) and (jet.portals[0].y == height):
                    self.x = jet.portals[1].x
                    self.y = jet.portals[1].y
                    self.angle = jet.portals[1].plane
            
            elif (self.x > jet.portals[1].x - jet.portals[1].width/2) and (self.x < jet.portals[1].x + jet.portals[1].width/2):
                if (self.y < -self.diameter) and (jet.portals[1].y == 0):
                    self.x = jet.portals[0].x
                    self.y = jet.portals[0].y
                    self.angle = jet.portals[0].plane
                elif (self.y > height) and (jet.portals[1].y == height):
                    self.x = jet.portals[0].x
                    self.y = jet.portals[0].y
                    self.angle = jet.portals[0].plane

            elif (self.y > jet.portals[0].y - jet.portals[0].height/2) and (self.y < jet.portals[0].y + jet.portals[0].height/2):
                if (self.x < -self.diameter) and (jet.portals[0].x == 0):
                    self.x = jet.portals[1].x
                    self.y = jet.portals[1].y
                    self.angle = jet.portals[1].plane
                elif (self.x > width) and (jet.portals[0].x == width):
                    self.x = jet.portals[1].x
                    self.y = jet.portals[1].y
                    self.angle = jet.portals[1].plane
            
            elif (self.y > jet.portals[1].y - jet.portals[1].height/2) and (self.y < jet.portals[1].y + jet.portals[1].height/2):
                if (self.x < -self.diameter) and (jet.portals[1].x == 0):
                    self.x = jet.portals[0].x
                    self.y = jet.portals[0].y
                    self.angle = jet.portals[0].plane
                elif (self.x > width) and (jet.portals[1].x == width):
                    self.x = jet.portals[0].x
                    self.y = jet.portals[0].y
                    self.angle = jet.portals[0].plane
        
    def assembleJets(self, game):
        self.jets.append(game.blueJet)
        self.jets.append(game.redJet)
        self.assembledJets = True
    
    def display(self):
        push()
        noStroke()
        fill(250)
        ellipse(self.x, self.y, self.diameter, self.diameter)
        pop()
    

class Portal(Bullet):
    def __init__(self, player, x = -100, y = -100, angle = 0):
        Bullet.__init__(self, x, y, angle)
        self.player = player
        self.speed = 6.5
        self.diameter = 10
        self.height = 60
        self.width = 10
        self.plane = 0
        
    def move(self):
        self.x += (self.speed * cos(self.angle))
        self.y += (self.speed * sin(self.angle))
        
    def hitWall(self):
        if self.x - self.diameter/2 <= 0:
            self.x = 0
            self.width = 10
            self.height = 60
            self.plane = 0
            return True
        elif self.x + self.diameter/2 >= width:
            self.x = width
            self.width = 10
            self.height = 60
            self.plane = -PI
            return True
        elif self.y - self.diameter/2 <= 0:
            self.y = 0
            self.width = 60
            self.height = 10
            self.plane = PI/2
            return True
        elif self.y + self.diameter/2 >= height:
            self.y = height
            self.width = 60
            self.height = 10
            self.plane = -PI/2
            return True
        
        return False
        
    def display(self):
        push()
        noStroke()
        if self.player == 0:
            fill(0,0,255)
        elif self.player == 1:
            fill(255,0,0)
            
        if not self.hitWall():
            ellipse(self.x, self.y, self.diameter, self.diameter-5)
            
        else:
            self.speed = 0
            rect(self.x, self.y, self.width, self.height)
        
        pop()
            
        
            

class Game:
    def __init__(self):
        self.st = millis()
        self.blink = 1
        self.blueJet = Jet(0)
        self.redJet = Jet(1)
        
        self.blueScore = 0
        self.redScore = 0
        self.winScore = 5
        
        self.screen = 0
        
        self.menu_bg = loadImage(path + '/images/menu_bg.jpg')
        self.bg = loadImage(path + '/images/bg.jpg')
        
        self.menu_theme = walkman.loadFile(path + '/sounds/menu_theme.mp3')
        self.menu_theme.loop()
        
        self.playThemeCalled = False
        
        self.end_theme = walkman.loadFile(path + '/sounds/end_theme.mp3')
        
        self.gameOver = False
        
    def update(self):
        self.redScore += self.blueJet.checkDeath(self.redJet)
        self.blueJet.move()
        self.blueScore += self.redJet.checkDeath(self.blueJet)
        self.redJet.move()
        
        
    def display(self):
        if self.screen == 0:
            self.menuScreen()
        elif self.screen == 1:
            self.menu_theme.close()
            self.playScreen()
        elif self.screen == 2:
            self.play_theme.close()
            self.endScreen()
            self.end_theme.play()
            
    def menuScreen(self):
        image(self.menu_bg, width/2, height/2)
        textAlign(CENTER)
        textSize(45)
        fill(255)
        text("Jet Fighter Portal", width/2, height/2)
        textSize(22)

        self.et = millis()
        if self.et - self.st > 800:
            self.blink = (self.blink + 1) % 2
            self.st = self.et
            
        if self.blink == 1:
            text("Press any key to start", width/2, height-250)
        
    def playScreen(self):
        
        if not self.playThemeCalled:
            self.playTheme()
            
        image(self.bg, width/2, height/2)
        
        if not self.gameOver:
            self.update()
            
        self.blueJet.display(self)
        self.redJet.display(self)
        
        textAlign(CENTER)
        textSize(35)
        fill(0,0,255)
        text(self.blueScore, width/4, 80)
        fill(255)
        text('-', width/2, 80)
        fill(255,0,0)
        text(self.redScore, width*3/4, 80)
        
        if (self.blueScore == self.winScore) or (self.redScore == self.winScore):
            delay(200)
            self.screen = 2
            self.gameOver = True
            
    def playTheme(self):
        self.play_theme = walkman.loadFile(path + '/sounds/play_theme.mp3')
        self.play_theme.loop()
        self.playThemeCalled = True
        
    def endScreen(self):
        image(self.menu_bg, width/2, height/2)
        textAlign(CENTER)
        textSize(35)
        
        if self.blueScore >= self.winScore:
            fill(0,0,255)
            text('BLUE', width*13/32, height/2)
            
        elif self.redScore >= self.winScore:
            fill(255,0,0)
            text('RED', width*3/8, height/2)
            
        fill(255)
        text('WINS!', width*19/32, height/2)
        textSize(20)
        self.et = millis()
        if self.et - self.st > 800:
            self.blink = (self.blink + 1) % 2
            self.st = self.et
            
        if self.blink == 1:
            text("Press ENTER to restart.", width/2, height*3/4)
        
        
        
game = Game()

def setup():
    size(RESOLUTION_W, RESOLUTION_H)
    rectMode(CENTER)
    imageMode(CENTER)
    
    font = createFont(path + '/PressStart2P.ttf', 32)
    textFont(font)
    



def draw():
    game.display()
    
def keyPressed():
    global game
    
    if keyCode in game.redJet.keyset:
        
        if game.redJet.isDead:
            game.redJet.respawn_sound.rewind()
            game.redJet.respawn_sound.play()
            game.redJet.x = width*3/4
            game.redJet.y = random(height)
            game.redJet.angle = PI
            game.redJet.isDead = False
            game.redJet.speed = game.redJet.baseSpeed
        
        if keyCode == UP:
            game.redJet.shootBullets()
            game.redJet.shot_sound.rewind()
            game.redJet.shot_sound.play()

        elif keyCode == DOWN:
            game.redJet.shootPortals()
            game.redJet.portal_sound.rewind()
            game.redJet.portal_sound.play()
            
        if keyCode == LEFT:
            game.redJet.steer = -game.redJet.baseSteer
        elif keyCode == RIGHT:
            game.redJet.steer = game.redJet.baseSteer
            
    
    if key in game.blueJet.keyset:

        if game.blueJet.isDead:
            game.blueJet.respawn_sound.rewind()
            game.blueJet.respawn_sound.play()
            game.blueJet.x = width/4
            game.blueJet.y = random(height)
            game.blueJet.angle = 0
            game.blueJet.isDead = False
            game.blueJet.speed = game.blueJet.baseSpeed
            
        if key == 'w' or key == 'W':
            game.blueJet.shootBullets()
            game.blueJet.shot_sound.rewind()
            game.blueJet.shot_sound.play()
            
        elif key == 's' or key == 'S':
            game.blueJet.shootPortals()
            game.blueJet.portal_sound.rewind()
            game.blueJet.portal_sound.play()
            
        if key == 'a' or key == 'A':
            game.blueJet.steer = -game.blueJet.baseSteer
        elif key == 'd' or key == 'D':
            game.blueJet.steer = game.blueJet.baseSteer
    
    if game.screen == 0:
        game.screen = 1
        
    if (game.gameOver) and (key == ENTER):
        game.end_theme.close()
        game = Game()
        
def keyReleased():
    
    if keyCode == LEFT or keyCode == RIGHT:
        game.redJet.steer = 0
    
    if (key == 'a' or key == 'A') or (key == 'd' or key =='D'):
        game.blueJet.steer = 0
        

    
