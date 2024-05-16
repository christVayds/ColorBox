import pygame
from player2 import *
from gameC import Game
import colors

# game initialize
colors = colors.Colors()
game = Game(50, 20, colors)

pygame.init()

cdef windowSize = {'width': 350, 'height': 500}
cdef screen = pygame.display.set_mode((windowSize['width'], windowSize['height']))
pygame.display.set_caption('Basta')

cdef clock = pygame.time.Clock()
cdef int fps = 30

cdef player = Player((windowSize['width'] - 100) / 2, windowSize['height'] - 20, 100, 20)

cdef balls = [
    Ball((windowSize['width'] - 10) / 2, (windowSize['height'] - 10), 10, 10, colors.randomColor())
]

cdef font = pygame.font.SysFont('arial', 30)

cdef void draw():

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

    cdef text = font.render(str(round(clock.get_fps(), 2)), True, (255,255,255))
    screen.blit(text, text.get_rect())

    pygame.display.flip()

def main():

    cdef int run = 1

    while run:
        clock.tick(fps)

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = 0

        draw()

    pygame.quit()

if __name__=='__main__':
    main()