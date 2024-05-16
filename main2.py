import pygame
from player import *
from game import Game
import colors

# game initialize
colors = colors.Colors()
game = Game(50, 20)

pygame.init()

windowSize = {'width': 350, 'height': 500}
screen = pygame.display.set_mode((windowSize['width'], windowSize['height']))
pygame.display.set_caption('Basta')

clock = pygame.time.Clock()
fps = 30

player = Player((windowSize['width'] - 100) / 2, windowSize['height'] - 20, 100, 20)

balls = [
    Ball((windowSize['width'] - 10) / 2, (windowSize['height'] - 10), 10, 10, colors.randomColor())
]

font = pygame.font.SysFont('arial', 30)

def draw():

    screen.fill((0,0,0))

    # objectbox
    game.draw(screen)

    # draw player
    player.draw(screen)

    # draw ball
    for ball in balls:
        ball.draw(screen)
        ball.collision(player, windowSize, balls)
        ball.boxCollision(game.listObjectBox, balls)

    text = font.render(str(round(clock.get_fps(), 2)), True, (255,255,255))
    screen.blit(text, text.get_rect())

    pygame.display.flip()

def main():

    run = True

    while run:
        clock.tick(fps)

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False

        draw()

    pygame.quit()

if __name__=='__main__':
    main()