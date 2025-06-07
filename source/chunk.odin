package main

import "core:fmt"

MAX_BLOCKS :: 16

Chunk :: struct {
    blocks: [MAX_BLOCKS * MAX_BLOCKS * MAX_BLOCKS]Block
}

// Init le chunk avec de la terre.
chunk_init_with_dirt :: proc(chunk: ^Chunk) {
    for x := 0; x < MAX_BLOCKS; x += 1 {
        for y := 0; y < MAX_BLOCKS; y += 1 {
            for z := 0; z < MAX_BLOCKS; z += 1 {
                chunk.blocks[x + MAX_BLOCKS * z + (MAX_BLOCKS * MAX_BLOCKS) * y].type = .DIRT
            }
        }
    }
}

chunk_get_all_blocks_position :: proc(chunk: Chunk) -> [][3]f32 {
    positions: [dynamic][3]f32

    for x := 0; x < MAX_BLOCKS; x += 1 {
        for y := 0; y < MAX_BLOCKS; y += 1 {
            for z := 0; z < MAX_BLOCKS; z += 1 {
                block_pos := [3]f32 {f32(x), f32(y), f32(z)}
                append(&positions, block_pos)
            }
        }
    }

    return positions[:]
}

chunk_get_block_at_position :: proc(chunk: Chunk, x, y, z: int) -> Block {
    if x >= MAX_BLOCKS || y >= MAX_BLOCKS || z >= MAX_BLOCKS {
        fmt.println("Hors de l'array")
        return chunk.blocks[(x - 1) + MAX_BLOCKS * (z - 1) + (MAX_BLOCKS * MAX_BLOCKS) * (y - 1)]
    }

    return chunk.blocks[x + MAX_BLOCKS * z + (MAX_BLOCKS * MAX_BLOCKS) * y];
}

chunk_meshing :: proc(chunk: Chunk) -> ([][3]f32, [][2]f32) {
    block_vertices_template := []f32 {
        -0.5, -0.5, -0.5,
         0.5, -0.5, -0.5,
         0.5,  0.5, -0.5,
         0.5,  0.5, -0.5,
        -0.5,  0.5, -0.5,
        -0.5, -0.5, -0.5,

        -0.5, -0.5,  0.5,
         0.5, -0.5,  0.5,
         0.5,  0.5,  0.5,
         0.5,  0.5,  0.5,
        -0.5,  0.5,  0.5,
        -0.5, -0.5,  0.5,

        -0.5,  0.5,  0.5,
        -0.5,  0.5, -0.5,
        -0.5, -0.5, -0.5,
        -0.5, -0.5, -0.5,
        -0.5, -0.5,  0.5,
        -0.5,  0.5,  0.5,

         0.5,  0.5,  0.5,
         0.5,  0.5, -0.5,
         0.5, -0.5, -0.5,
         0.5, -0.5, -0.5,
         0.5, -0.5,  0.5,
         0.5,  0.5,  0.5,

        -0.5, -0.5, -0.5,
         0.5, -0.5, -0.5,
         0.5, -0.5,  0.5,
         0.5, -0.5,  0.5,
        -0.5, -0.5,  0.5,
        -0.5, -0.5, -0.5,

        -0.5,  0.5, -0.5,
         0.5,  0.5, -0.5,
         0.5,  0.5,  0.5,
         0.5,  0.5,  0.5,
        -0.5,  0.5,  0.5,
        -0.5,  0.5, -0.5
    }

    block_textures_template := []f32 {
        0.0, 0.0,
        1.0, 0.0,
        1.0, 1.0,
        1.0, 1.0,
        0.0, 1.0,
        0.0, 0.0,

        0.0, 0.0,
        1.0, 0.0,
        1.0, 1.0,
        1.0, 1.0,
        0.0, 1.0,
        0.0, 0.0,

        1.0, 0.0,
        1.0, 1.0,
        0.0, 1.0,
        0.0, 1.0,
        0.0, 0.0,
        1.0, 0.0,

        1.0, 0.0,
        1.0, 1.0,
        0.0, 1.0,
        0.0, 1.0,
        0.0, 0.0,
        1.0, 0.0,

        0.0, 1.0,
        1.0, 1.0,
        1.0, 0.0,
        1.0, 0.0,
        0.0, 0.0,
        0.0, 1.0,

        0.0, 1.0,
        1.0, 1.0,
        1.0, 0.0,
        1.0, 0.0,
        0.0, 0.0,
        0.0, 1.0,
    }

    vertices: [dynamic][3]f32
    textures: [dynamic][2]f32

    for x := 0; x < MAX_BLOCKS; x += 1 {
        for y := 0; y < MAX_BLOCKS; y += 1 {
            for z := 0; z < MAX_BLOCKS; z += 1 {
                current_block := chunk_get_block_at_position(chunk, x, y, z)

                if current_block.type == .AIR {
                    // Pas besoin de faire un meshing pour l'air, c'est invisible.
                    continue
                }

                for i := 0; i < len(block_vertices_template) / 3; i += 1 {
                    vx: f32 = block_vertices_template[i * 3 + 0]
                    vy: f32 = block_vertices_template[i * 3 + 1]
                    vz: f32 = block_vertices_template[i * 3 + 2]

                    u: f32 = block_textures_template[i * 2 + 0]
                    v: f32 = block_textures_template[i * 2 + 1]

                    triangle := [3]f32 {vx + f32(x), vy + f32(y), vz + f32(z)}
                    texture := [2]f32 {u, v}

                    append(&vertices, triangle)
                    append(&textures, texture)
                }
            }
        }
    }

    return vertices[:], textures[:]
}

// Fais un render du chunk.
chunk_render_all_cubes :: proc(chunk: ^Chunk) {

}

chunk_render_one_call :: proc(chunk: ^Chunk) {

}