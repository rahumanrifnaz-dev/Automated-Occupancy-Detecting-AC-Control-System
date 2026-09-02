%% Automated Occupancy Detecting AC Control System
% Reference MATLAB simulation derived from the project report/paper.
% Time scaling used by the documented simulation:
%   1 simulation second = 1 real-world minute
% Eco threshold: 15 minutes of continuous vacancy
% Deep Eco / OFF threshold: 60 minutes of continuous vacancy
%
% This script is a reproducible reference implementation. If the original
% project MATLAB source becomes available, keep that source as the primary
% implementation and retain this file only as a documented example.

clear; clc; close all;

%% Simulation timeline (150 simulated seconds = 150 represented minutes)
t = 0:1:150;

%% Example sensor inputs
% 1 = sensor detects occupancy/movement, 0 = no detection.
% The pattern intentionally includes occupied and unoccupied intervals long
% enough to exercise Normal, Eco and OFF states.
pir = zeros(size(t));
mw  = zeros(size(t));

% Occupied: 0-25 min
pir(t <= 25) = 1;
mw(t <= 25)  = 1;

% Partial/stationary detections: 26-40 min
% Microwave continues detecting while PIR intermittently misses movement.
mw(t >= 26 & t <= 40) = 1;
pir(t >= 26 & t <= 40 & mod(t,5)==0) = 1;

% Unoccupied: 41-110 min -> Eco after 15 min, OFF after 60 min
% Reoccupied: 111-135 min
pir(t >= 111 & t <= 135) = 1;
mw(t >= 111 & t <= 135)  = 1;

% Final vacancy: 136-150 min

%% Sensor fusion
% The documentation states that PIR and Microwave sensors are combined.
% For this reference script, occupancy is asserted when either sensor
% detects presence. Modify this rule if the final Simulink implementation
% uses a different fusion strategy.
occupied = (pir | mw);

%% Control-state simulation
% State codes: 2 = Normal, 1 = Eco, 0 = Deep Eco/OFF
state = zeros(size(t));
absence_minutes = 0;

for k = 1:numel(t)
    if occupied(k)
        absence_minutes = 0;
        state(k) = 2;                    % Normal mode
    else
        if k > 1
            absence_minutes = absence_minutes + (t(k)-t(k-1));
        end

        if absence_minutes >= 60
            state(k) = 0;                % Deep Eco / OFF
        elseif absence_minutes >= 15
            state(k) = 1;                % Eco mode
        else
            state(k) = 2;                % Keep Normal during short absence
        end
    end
end

%% Display transition summary
fprintf('Simulation duration: %d represented minutes\n', t(end));
fprintf('Eco threshold: 15 minutes vacancy\n');
fprintf('Deep Eco/OFF threshold: 60 minutes vacancy\n\n');

transition_idx = [1, find(diff(state) ~= 0) + 1];
for idx = transition_idx
    if state(idx) == 2
        label = 'NORMAL';
    elseif state(idx) == 1
        label = 'ECO';
    else
        label = 'DEEP ECO / OFF';
    end
    fprintf('t = %3d min -> %s\n', t(idx), label);
end

%% Plot
figure('Name','Occupancy-Based AC Control Simulation');

subplot(3,1,1);
stairs(t, pir, 'LineWidth', 1.4); hold on;
stairs(t, mw,  'LineWidth', 1.4);
ylim([-0.1 1.1]);
ylabel('Sensor');
legend('PIR','Microwave','Location','best');
grid on;
title('Synthetic Sensor Inputs');

subplot(3,1,2);
stairs(t, occupied, 'LineWidth', 1.5);
ylim([-0.1 1.1]);
ylabel('Occupied');
grid on;
title('Fused Occupancy Signal');

subplot(3,1,3);
stairs(t, state, 'LineWidth', 1.6);
yticks([0 1 2]);
yticklabels({'OFF','Eco','Normal'});
ylabel('AC Mode');
xlabel('Represented time (minutes)');
grid on;
title('Staged AC Control State');

%% Optional: save output figure
% exportgraphics(gcf, fullfile('..','results','figures','control_simulation.png'));
