# DefFX
A collection of useful shader effects made ready to be used with the Defold game engine

## Usage
Download the shaders you wish to use and add them to your project. Each shader has different potential usage. There are shaders which could be used for sprites, text, and as post processing effects. Making shader versions for features like spine animations is possible.

## Gotchas
You may wish to adjust, or merge multiple shader files together for your projects to improve batching and lower draw calls and then make your single shader be able to do multiple effects or single effects at once based on variables sent to the shader programs.

## Sprite Ready Shaders
These shaders can be added to sprites. You may need to send data to the shader program over time such as a timer value so check the associated demos for each.

## Post Processing Effect Shaders
These shaders are meant to be applied to render targets. Generally this means ou draw your game layers to the render target, and then apply the post processing shader effect. Using these effects requires a custom render script.
