import pygame
from player import objectBox

class Game(pygame.sprite.Sprite):

    def __init__(self, int width, int height, colors):
        super().__init__()
        self.width = width
        self.height = height

        self.colors = colors

        self.rows = 0
        self.columns = 0
        self.listObjectBox = []
        self.listRows = []
        self.generate()

    def draw(self, screen):
        for columns in self.listObjectBox:
            for rows in columns:
                rows.draw(screen)

    def generate(self):
        for _ in range(20):
            for _ in range(7):
                self.listRows.append(objectBox(self.rows, self.columns, self.width, self.height, self.colors.randomColor()))
                self.rows += self.width
            
            self.listObjectBox.append(self.listRows)
            self.listRows = []
            self.rows = 0
            self.columns += self.height