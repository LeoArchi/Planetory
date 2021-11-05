HUD = {

  draw = function()

    love.graphics.setColor(0.5, 0.5, 0.5, 0.7)
    love.graphics.rectangle('fill', 10, 10, 150, 60)


    love.graphics.setColor(0, 1, 0.2)

    local timeSpeed = TIME_SPEED
    if timeSpeed < 1 then
      love.graphics.print("Time warp x1/" .. 1/timeSpeed, 20, 20)
    else
      love.graphics.print("Time warp x" .. timeSpeed, 20, 20)
    end

    local _zoom = ((1000/647) * ZOOM -3/647)*85
    love.graphics.print("Zoom", 20, 40)

    -- Font de la barre
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle('fill', 65, 40, 85, 15)

    -- Contenu de la barre
    love.graphics.setColor(0, 1, 0.2)
    love.graphics.rectangle('fill', 65, 40, _zoom, 15)

    -- Contour de la barre
    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle('line', 65, 40, 85, 15)

    love.graphics.setColor(0.5, 0.5, 0.5, 0.7)
    love.graphics.rectangle('fill', SCREEN_WIDTH-250-10, SCREEN_HEIGHT/2-400/2, 250, 400)

    love.graphics.setColor(0, 1, 0.2)
    love.graphics.print(Body.getFocusedBody().name, SCREEN_WIDTH-250-10+125, SCREEN_HEIGHT/2-400/2 + 10)

  end

}

return HUD
