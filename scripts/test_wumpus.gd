extends Node

enum Contents { EMPTY, PLAYER, WUMPUS, PIT, BREEZE, STENCH }
var board_size = 4
var board = []

func _ready():
    initialize_board()
    place_player()
    place_wumpus()
    place_pits()

func initialize_board():
    for x in range(board_size):
        var row = []
        for y in range(board_size):
            row.append(Contents.EMPTY)
        board.append(row)

func place_player():
    board[0][0] = Contents.PLAYER

func place_wumpus():
    var wx = rand_range(1, board_size - 1)
    var wy = rand_range(1, board_size - 1)
    board[wx][wy] = Contents.WUMPUS
    add_breeze_stench(wx, wy)

func place_pits():
    for i in range(int(board_size / 2)):
        var px = rand_range(1, board_size - 1)
        var py = rand_range(1, board_size - 1)
        board[px][py] = Contents.PIT
        add_breeze_stench(px, py)

func add_breeze_stench(x, y):
    for ix in range(-1, 2):
        for iy in range(-1, 2):
            if (x + ix >= 0 and x + ix < board_size) and (y + iy >= 0 and y + iy < board_size):
                if abs(ix) + abs(iy) == 1:
                    if board[x][y] == Contents.WUMPUS:
                        board[x + ix][y + iy] = Contents.STENCH
                    elif board[x][y] == Contents.PIT:
                        board[x + ix][y + iy] = Contents.BREEZE

func move_player(direction):
    var pos = find_player()
    var new_x = pos.x
    var new_y = pos.y

    match direction:
        "up":
            new_y -= 1
        "down":
            new_y += 1
        "left":
            new_x -= 1
        "right":
            new_x += 1

    if new_x >= 0 and new_x < board_size and new_y >= 0 and new_y < board_size:
        board[pos.x][pos.y] = Contents.EMPTY
        board[new_x][new_y] = Contents.PLAYER
        check_game_state(new_x, new_y)

func find_player():
    for x in range(board_size):
        for y in range(board_size):
            if board[x][y] == Contents.PLAYER:
                return Vector2(x, y)
    return Vector2()

func check_game_state(x, y):
    if board[x][y] == Contents.WUMPUS:
        print("Encontrou o Wumpus! Fim de jogo.")
    elif board[x][y] == Contents.PIT:
        print("Caiu em um buraco! Fim de jogo.")
