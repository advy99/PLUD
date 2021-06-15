Constants = {}

Constants.DEFAULT_WIDTH = 1280
Constants.DEFAULT_HEIGHT = 896
Constants.GAME_HEIGHT = 768

Constants.GRAVITY = 9.81
Constants.PX_PER_METER = 64
Constants.NUMBER_OF_LEVELS = 3

-- Categoría de las fixture, va del 1 al 16
Constants.NIL_CATEGORY = 1
Constants.NIL_GROUP = 1

Constants.PLAYER_GROUP = 2

Constants.PLATFORM_GROUP = 3
-- La categoria 1 es la por defecto de love2d, la NIL_CATEGORY
Constants.PLATFORM_PLAY_CATEGORY = 2
Constants.PLATFORM_PRACTICE_CATEGORY = 3
Constants.PLATFORM_CONFIGURATION_CATEGORY = 4
Constants.PLATFORM_EXIT_CATEGORY = 5
Constants.PLATFORM_SAVE_CONFIG_CATEGORY = 6
Constants.PLATFORM_MENU_CATEGORY = 7
Constants.PLATFORM_BOMB_TAG_CATEGORY = 8
Constants.PLATFORM_VIRUS_FALL_CATEGORY = 9
Constants.PLATFORM_DEATH_BALL_CATEGORY = 10

Constants.OBJECTS_GROUP = 4
Constants.DEATH_BALL_CATEGORY = 2
Constants.VIRUS_CATEGORY = 3


-- Constantes de debug
Constants.DEBUG = false
Constants.SHOW_HITBOX = false

-- Constantes de minijuegos
Constants.BOMB_TAG = 1
Constants.VIRUS_FALL = 2
Constants.DEATH_BALL = 3
Constants.CONFIGURATION_MENU = 4
Constants.EXIT = 5
Constants.MENU = 6
Constants.SAVE_CONFIG = 7
Constants.PRACTICE = 8
Constants.PLAY = 9

Constants.ADD_PLAYER_KEY = "+"
Constants.ADD_PLAYER_KEY_COMBINATION = {"lshift", "="}
Constants.REMOVE_PLAYER_KEY = "-"

Constants.MIN_PLAYERS = 1
Constants.MAX_PLAYERS = 4

Constants.TIME_BETWEEN_MINIGAME = 3
