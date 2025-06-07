package main

BlockType :: enum {
    AIR,
    DIRT,
    GRASS
}

// Il faut que je minimise la quantité de données que je stocke là dedans, il faut que je pense à l'hardware.
Block :: struct {
    type: BlockType,
}
