function visualize_traffic_lights_with_pedestrian(x, y, z)
    % x: green light duration (seconds)
    % y: yellow light duration (seconds)
    % z: red light duration (seconds)

    % Define colors
    RED = [1, 0, 0];
    YELLOW = [1, 1, 0];
    GREEN = [0, 1, 0];
    GREY = [0.5, 0.5, 0.5];
    WHITE = [1, 1, 1];

    % Define pedestrian light states
    WALK = GREEN;
    DONT_WALK = RED;

    % Create a figure
    figure;
    axis equal;
    hold on;
    
    % Draw roads
    fill([-10, 10, 10, -10], [2, 2, -2, -2], GREY); % Horizontal road
    fill([-2, 2, 2, -2], [-10, -10, 10, 10], GREY); % Vertical road

    % Initialize traffic and pedestrian lights
    ns_light = GREEN;
    ew_light = RED;
    ns_ped_light = WALK;
    ew_ped_light = DONT_WALK;

    while true
        % Draw North-South traffic lights
        draw_traffic_light(-3, 8, ns_light);
        draw_traffic_light(3, -8, ns_light);
        draw_pedestrian_light(-4, 8, ns_ped_light);
        draw_pedestrian_light(4, -8, ns_ped_light);

        % Draw East-West traffic lights
        draw_traffic_light(-8, -3, ew_light);
        draw_traffic_light(8, 3, ew_light);
        draw_pedestrian_light(-8, -4, ew_ped_light);
        draw_pedestrian_light(8, 4, ew_ped_light);

        pause(x);
        
        % Change North-South to YELLOW, East-West remains RED
        ns_light = YELLOW;
        ns_ped_light = DONT_WALK;
        draw_traffic_light(-3, 8, ns_light);
        draw_traffic_light(3, -8, ns_light);
        draw_pedestrian_light(-4, 8, ns_ped_light);
        draw_pedestrian_light(4, -8, ns_ped_light);
        pause(y);

        % Change North-South to RED, East-West to GREEN
        ns_light = RED;
        ew_light = GREEN;
        ns_ped_light = DONT_WALK;
        ew_ped_light = WALK;
        draw_traffic_light(-3, 8, ns_light);
        draw_traffic_light(3, -8, ns_light);
        draw_pedestrian_light(-4, 8, ns_ped_light);
        draw_pedestrian_light(4, -8, ns_ped_light);
        draw_traffic_light(-8, -3, ew_light);
        draw_traffic_light(8, 3, ew_light);
        draw_pedestrian_light(-8, -4, ew_ped_light);
        draw_pedestrian_light(8, 4, ew_ped_light);
        pause(x);

        % Change East-West to YELLOW, North-South remains RED
        ew_light = YELLOW;
        ew_ped_light = DONT_WALK;
        draw_traffic_light(-8, -3, ew_light);
        draw_traffic_light(8, 3, ew_light);
        draw_pedestrian_light(-8, -4, ew_ped_light);
        draw_pedestrian_light(8, 4, ew_ped_light);
        pause(y);

        % Reset lights for next cycle
        ns_light = GREEN;
        ew_light = RED;
        ns_ped_light = WALK;
        ew_ped_light = DONT_WALK;
    end
end

function draw_traffic_light(x, y, color)
    % Draw traffic light at position (x, y) with the specified color
    rectangle('Position', [x-0.5, y-0.5, 1, 1], 'FaceColor', color, 'EdgeColor', 'k');
end

function draw_pedestrian_light(x, y, color)
    % Draw pedestrian light at position (x, y) with the specified color
    rectangle('Position', [x-0.3, y-0.3, 0.6, 0.6], 'FaceColor', color, 'EdgeColor', 'k');
end
