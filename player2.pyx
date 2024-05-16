import pygame
import random
import colors

class Player(pygame.sprite.Sprite):

    def __init__(self, int x, int y, int width, int height):
        super().__init__()
        self.width = width
        self.height = height
        
        self.rect = pygame.Rect(x, y, self.width, self.height)
        self.image = pygame.Surface((self.width, self.height))

        self.speed = 15
        self.score = 0

    def draw(self, screen):

        self.movement()
        pygame.draw.rect(screen, (255,255,0), self.rect)

    def movement(self):

        keys = pygame.key.get_pressed()

        if keys[pygame.K_LEFT]:
            self.move_x(self.speed * -1)
        if keys[pygame.K_RIGHT]:
            self.move_x(self.speed)

    def move_x(self, int direction):
        self.rect.x += direction

class Ball(pygame.sprite.Sprite):

    def __init__(self, int x, int y, int width, int height, color=(255,255,255)):
        super().__init__()
        self.width = width
        self.height = height

        self.colors = colors.Colors()
        self.color = color

        self.rect = pygame.Rect(x, y, self.width, self.width)
        self.image = pygame.Surface((self.width, self.width))

        self.speed = 10
        self.dirx = 1
        self.diry = -1

    def draw(self, screen):
         
         self.move_x(self.dirx)
         self.move_y(self.diry)
         
         pygame.draw.rect(screen, self.color, self.rect)

    def boxCollision(self, objectBoxes, listBalls):
        for column in objectBoxes:
            for row in column:
                if pygame.sprite.collide_rect(self, row):
                    self.dirx = random.choice([1, -1])
                    self.diry = 1
                    column.remove(row)
                    listBalls.append(Ball(self.rect.x, self.rect.y, self.width, self.height, row.color))

    def collision(self, player, windowSize, listballs):
        if pygame.sprite.collide_rect(self, player):
            self.dirx = random.choice([1, -1])
            self.diry = -1

        if self.rect.x <= 0:
            self.dirx = 1
            self.diry = random.choice([1, -1])
        elif self.rect.x >= windowSize['width'] - self.width:
            self.dirx = -1
            self.diry = random.choice([1, -1])
        elif self.rect.y <= 0:
            self.dirx = random.choice([1, -1])
            self.diry = 1
        elif self.rect.y > windowSize['height']:
            listballs.remove(self)

    def move_x(self, direction):
        self.rect.x += self.speed * direction

    def move_y(self, direction):
        self.rect.y += self.speed * direction

class objectBox(pygame.sprite.Sprite):

    def __init__(self, int x, int y, int width, int height, color=(255,255,255)):
        self.width = width
        self.height = height
        self.color = color
        
        self.rect = pygame.Rect(x, y, self.width, self.height)
        self.image = pygame.Surface((self.width, self.height))

    def draw(self, screen):

        pygame.draw.rect(screen, self.color, self.rect)