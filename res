function traffic_light_UI()
    % Create a figure for the UI
    f = figure('Position', [100, 100, 500, 400], 'Name', 'Traffic Light Simulator', 'NumberTitle', 'off');

    % Create input fields and labels
    uicontrol('Style', 'text', 'Position', [50, 350, 150, 20], 'String', 'Green Light Time (s):');
    greenTime = uicontrol('Style', 'edit', 'Position', [210, 350, 100, 20]);

    uicontrol('Style', 'text', 'Position', [50, 320, 150, 20], 'String', 'Yellow Light Time (s):');
    yellowTime = uicontrol('Style', 'edit', 'Position', [210, 320, 100, 20]);

    uicontrol('Style', 'text', 'Position', [50, 290, 150, 20], 'String', 'Red Light Time (s):');
    redTime = uicontrol('Style', 'edit', 'Position', [210, 290, 100, 20]);

    % Create Start and Stop buttons
    startBtn = uicontrol('Style', 'pushbutton', 'Position', [50, 250, 100, 30], 'String', 'Start', 'Callback', @(src, event) startSimulation(greenTime, yellowTime, redTime));
    stopBtn = uicontrol('Style', 'pushbutton', 'Position', [210, 250, 100, 30], 'String', 'Stop', 'Callback', 'close(gcbf)');

    % Rest of the code (visualization and simulation) goes here...
end

function startSimulation(greenTime, yellowTime, redTime)
    x = str2double(get(greenTime, 'String'));
    y = str2double(get(yellowTime, 'String'));
    z = str2double(get(redTime, 'String'));

    % Call the visualize_traffic_lights_with_pedestrian function with the provided times
    visualize_traffic_lights_with_pedestrian(x, y, z);
end

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
    fill([-2, 2, 2, -2], [2, 2, 10, 10], GREY); % Up road
    fill([-2, -2, 2, 2], [2, -2, -2, 2], GREY);% middle road
    fill([-2, 2, 2, -2], [-2, -2, -10, -10], GREY);% Bottom road

    % Initialize traffic and pedestrian lights
    ns_light = GREEN;
    ew_light = RED;
    ns_ped_light1 = WALK;
    ns_ped_light2 = WALK;
    ew_ped_light1 = DONT_WALK;
    ew_ped_light2 = DONT_WALK;

    while true
        % Draw North-South traffic lights
        draw_traffic_light(0, 2, ns_light);
        draw_traffic_light(0, -2, ns_light);
        draw_pedestrian_light(-3, 4, ns_ped_light1);
        draw_pedestrian_light(3, 4, ns_ped_light2);
        draw_pedestrian_light(3, -4, ns_ped_light1);
        draw_pedestrian_light(-3, -4, ns_ped_light2);

        % Draw East-West traffic lights
        draw_traffic_light(2, 0, ew_light);
        draw_traffic_light(-2, 0, ew_light);
        draw_pedestrian_light(-4, -3, ew_ped_light1);
        draw_pedestrian_light(4, -3, ew_ped_light2);
        draw_pedestrian_light(4, 3, ew_ped_light1);
        draw_pedestrian_light(-4, 3, ew_ped_light2);

        pause(x);
        
           % Change North-South to YELLOW, East-West remains RED
        ns_light = YELLOW;
        ns_ped_light1 = DONT_WALK;
        draw_traffic_light(0, 2, ns_light);
        draw_traffic_light(0, -2, ns_light);
        draw_pedestrian_light(-4, 8, ns_ped_light1);
        draw_pedestrian_light(4, -8, ns_ped_light1);
        pause(y);

        % Change North-South to RED, East-West to GREEN
        ns_light = RED;
        ew_light = GREEN;
        ns_ped_light1 = DONT_WALK;
        ew_ped_light1 = WALK;
        draw_traffic_light(0, 2, ns_light);
        draw_traffic_light(0, -2, ns_light);
        draw_pedestrian_light(-4, 8, ns_ped_light1);
        draw_pedestrian_light(4, -8, ns_ped_light1);
        draw_traffic_light(-2, 0, ew_light);
        draw_traffic_light(2, 0, ew_light);
        draw_pedestrian_light(-8, -4, ew_ped_light1);
        draw_pedestrian_light(8, 4, ew_ped_light1);
        pause(x);

        % Change East-West to YELLOW, North-South remains RED
        ew_light = YELLOW;
        ew_ped_light1 = DONT_WALK;
        draw_traffic_light(0, 2, ew_light);
        draw_traffic_light(0, -2, ew_light);
        draw_pedestrian_light(-8, -4, ew_ped_light1);
        draw_pedestrian_light(8, 4, ew_ped_light1);
        pause(y);

        % Reset lights for next cycle
        ns_light = GREEN;
        ew_light = RED;
        ns_ped_light1 = WALK;
        ew_ped_light1 = DONT_WALK;
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
