# Coala

## Linker modification 

Change
```
ROM (rx)         : ORIGIN = 0x4400, LENGTH = 0xBB80 /* END=0xFF7F, size 48000 */
```

with 
```
ROM (rx)         : ORIGIN = 0x4400, LENGTH = 0x7B70 /* END=0xBF7F, size 48000 */
PRS (rx)         : ORIGIN = 0xBF70, LENGTH = 0x400f /* END=0xFF7F, size 8016 */
```

## Protected variables 

### Annotation 
All protected variables must be global and annotated with `__p`

### Access 
A protected variable must be written to with `WP(var)`
A protected variable must be read from with `RP(var)`

## TODO
- Port `dataDecompression` to the new Coala version
- Revise applications
- Enhance this README

## Coala VS Alpaca data acquisition

Acquired: `bc`, `ar`, `cem`

Ready to be acquired:

To validate results:

To revise: `cuckoo`

To port (from Coala to Alpaca or vice-versa): `rsa`, `dataDecompression`