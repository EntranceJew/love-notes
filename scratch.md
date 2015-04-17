# Scratch
I don't know what's happening so I'm just gonna put stuff here.

## Speed up your mapPixel functions with FFI
You should probably use a shader for this.
* [link](https://github.com/slime73/love-snippets/blob/master/ImageData-FFI/imagedata-ffi.lua)

## sapper's grayscale shader colorizer
```lua
pDraw = love.graphics.newShader([[
    extern Image pal;
    extern number size;
    vec4 effect(vec4 c,Image tex,vec2 tx,vec2 pc){
        vec4 cr = Texel(tex,tx);
        vec4 r = Texel(pal,vec2(cr.r+(.5 / size),.5));
        return vec4(r.r,r.g,r.b,cr.a);
    }
]])
```

```lua
function palConvert(image,palette)
    local img,pal = image:getData(),palette:getData()
    img:mapPixel(function(x,y,r,g,b,a)
        local wid = pal:getWidth()
        for i=1,wid do
            local pix = {pal:getPixel(i-1,0)}
            if tEqual(pix,{r,g,b,a}) then
                local n = math.max(((i-1) * wid)-1,0)
                return n,n,n,255
            end
        end
        return 0,0,0,0
    end)
    return love.graphics.newImage(img)
end
```

## A Palette Shader
* [link](http://kpulv.com/368/Index_Palette_Shader/)

## Simple Conway Implementations
* [link](https://love2d.org/forums/viewtopic.php?f=5&t=40669)

## Rectangular Decomposition
Turn a bunch of rectangles into smaller rectangles.
* [node.js implementation](https://github.com/mikolalysenko/rectangle-decomposition)
* [lua implementation](https://love2d.org/forums/viewtopic.php?p=179044#p179044)