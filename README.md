# Vex

## TODO List
### High Priority
- Chunking
  - Should be done with only one render call per chunk. OK
  - Should build the vertices on the fly and throw away the block template.

### Medium Priority
- Face Culling AFTER Chunking
  - Check all the side of the block and if one the face is adjacent to another block, don't render the faces.

### Low Priority
- Multitextures
  - Different textures on each side of the blocks.

## Tips and tricks
- Minimize the data inside Block struct to reduce memory footprint.