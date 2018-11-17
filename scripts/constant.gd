extends Node

const MAIN_SCENE = 'res://scenes/main/Main.tscn'
const TITLE_SCENE = 'res://scenes/title/Title.tscn'

const SCREEN = {
    'WIDTH': 700,
    'HEIGHT': 800
}

const WALL_DEPTH = 50

const BAR_COUNT = 10
const BAR_WIDTH = 200
const BAR_POP_SPAN = 3 # 3 second
const BAR_DEPTH = 25

const GRAVITY = 500.0

const PLAYER = {
    'SPEED': {
        'STOP': 1300,
        'FORCE': 600,
        'MIN': 10,
        'MAX': 200
    },
    'JUMP': {
        'MAX_TIME': 0.2,
        'SPEED': 300
    }
}
