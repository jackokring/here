# Here

A game in `godot` using some free art tiles and audio resources. The aim being
to make gameplay be more important than graphical or audio complexity. For
example this would mean a low resolution screen, and use any GPU for entity
AI CUDA or similar.

The base development system is a hybrid of Termux/arm64 and Mint/x86_64. This
then implies some adaptivity of resources from the outset, which should auto
regulate the complexity and speed of any algorithms.

Testing is via keyboard and Generic SNES style controller. The mouse maybe
later used depending on an Android release, and better ways of navigation of
the menu system.

Compilation for Steam seems to be distro agnostic, and so I don't think any
problems will be found there. GDExtension is unlikely to be used initially
as this creates a potential multiple build and config issue.

On the issue of using the default VGA resolution for that retro feel. This
gives support for a wide range of systems, but some may not like the wide
borders or "non-immersive" windowed mode. This is not a primary concern
as it can be adjusted in later, or special builds.

## TODO

- [ ] Edit and compact tile maps.
- [ ] Add boundaries to play field.
- [ ] Add keyboard and joystick motions.
- [ ] Add pause GUI.
- [ ] Add path navigation to tiles.
- [ ] Add simple motion AI player.
- [ ] Add collision groups.
- [ ] Add sky.
- [ ] Add death respawn scoring.
- [ ] Add HUD.
- [ ] Add level generator.
- [ ] Add lives and game loop.

## TODO Improvements

- [ ] Add alternate AIs and other types of AI player.
- [ ] Add network play.
- [ ] Add animations.
- [ ] Add audio.
- [ ] Add lore and instructions into pause GUI.
- [ ] Improve pause and config GUI.
- [ ] Add humour.
- [ ] Add text AI interaction system.

## TODO Publish

- [ ] Publish open version.
- [ ] Check and publish Steam.
- [ ] Check and publish Android.
