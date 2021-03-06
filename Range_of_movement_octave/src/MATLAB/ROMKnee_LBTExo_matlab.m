%% Range of movement of Knee in Lateral Box Transfer

% Code AUTHOR: Yaiza Benito Molpeceres. DATE: January-May 2020.

% Exoskeleton trials segmentation: 54, 55, 56, 62.
% Five phases shown in figure 1:
    % 1: Subject picks up the box in the sagittal plane (idxO1:idxF1)
    % 2: Subject takes some steps to rotate to the frontal plane (idxF1:idxF2)
    % 3: Subject deposits the box in the frontal plane (idxF2:idxF3)
    % 4: Subject takes some steps to rotate back to the sagittal plane (idxF3:idxF4)
    % 5: Subject deposits the box in the sagittal plane (idxF4:idxF5)


clear all % Clear variables
close all % Close figures
clc

load('..\tests\data\input\dinamica55_B.mat')
           
Ts = 1/Fs;
t_total = (double(frames)*Ts);
t_1000 = 0:(t_total/1000):(t_total-(t_total/1000));

% Normal Ranges of Knee Motion
for i =1:(length(t_1000))
    flex_knee(1,i) = 130; % flexion
    ext_knee(1,i) = -15;   % extension
    intRot_hip(1,i) = 10;   % internal rotation
end

% Feet markers for signal segmentation
LTOE_z = LTOE(:,3)'; 
RTOE_z = RTOE(:,3)';   
%LHEE_z = LHEE(:,3)';  
%RHEE_z = RHEE(:,3)'; 

t= (0:(length(LTOE)-1))*Ts;
%% SEGMENTATION LEFT TOE: 

% Left Toe

[pks, locs] = findpeaks(LTOE_z,'minPeakProminence',10); 
e = locs < 500 | locs > 800;
f = find(e);
locs = locs(f);
pks = pks(f);
%TF1 = islocalmin(LTOE_z, 'FlatSelection', 'first');
%idx = find(TF1);
%flat = idx < locs(1);
%idx_flat = find(flat);

%flat2 = idx < locs(4)& idx > locs(3);
%idx_flat2 = find(flat2);

%flat3 = idx > locs(6);
%idx_flat3 = find(flat3);

% Right Toe 

[pks2, locs2] = findpeaks(RTOE_z,'minPeakProminence',10); 

TF2 = islocalmin(RTOE_z, 'FlatSelection', 'first');
idx2 = find(TF2);
flat4 = idx2 < locs2(1);
idx_flat4 = find(flat4);

flat5 = idx2 > locs2(length(locs2));
idx_flat5 = find(flat5);
flat6 = idx2 > locs2(3)& idx2 < locs2(4);
idx_flat6 = find(flat6);

% Indexes definiton for signal segmentation
idxO1 = 1;
idxF1 = idx2(idx_flat4(length(idx_flat4))); %idxO2
idxF2 = idx2(idx_flat6(1)); %idxO3
idxF3 = idx2(idx_flat6(length(idx_flat6))); %idxO4
idxF4 = idx2(idx_flat5(1)); %idxO5
idxF5 = length(LTOE_z);

% Visualization of the segmentation
figure(3)
plot(t, zscore(LTOE_z));
hold on
plot(t,zscore(RTOE_z));
plot(t,zscore(LTOE_z),'r*', 'MarkerIndices', idxO1);
plot(t,zscore(RTOE_z),'r*', 'MarkerIndices', idxF2);
plot(t,zscore(RTOE_z),'r*', 'MarkerIndices', idxF3); %L
plot(t,zscore(LTOE_z),'r*', 'MarkerIndices', idxF5); 
plot(t,zscore(RTOE_z),'r*', 'MarkerIndices', idxO1);
plot(t,zscore(RTOE_z),'r*', 'MarkerIndices', idxF1);
plot(t,zscore(RTOE_z),'r*', 'MarkerIndices', idxF4); %L
plot(t,zscore(RTOE_z),'r*', 'MarkerIndices', idxF5);
hold off
xlabel('Time in seconds');
ylabel('Angular displacement in degrees');
legend('Left Toe Z', 'Right Toe Z');
title('Segmentation Exoskeleton Trials')


%% Import model data for Knee Relative Angles

% Knee  
        RKneeAngles_x = ModelData.Raw.(ModelOutput{3})(1,:); 
        RKneeAngles_y = ModelData.Raw.(ModelOutput{3})(2,:);
        RKneeAngles_z = ModelData.Raw.(ModelOutput{3})(3,:);
        

        LKneeAngles_x = ModelData.Raw.(ModelOutput{4})(1,:);
        LKneeAngles_y = ModelData.Raw.(ModelOutput{4})(2,:);
        LKneeAngles_z = ModelData.Raw.(ModelOutput{4})(3,:);
        

%% Knee signals visualization before going through segmentation

figure(4)
frames = length(LTOE_z);
% (1:(frames/1000):frames)  si frames>1000
% (1:(frames/1000):frames+(frames/1000)) si frames<1000
% +(frames/1000)
plot(t_1000,RKneeAngles_x(1:(frames/1000):frames)); 
hold on 
plot(t_1000, flex_knee,'--',t_1000, ext_knee,'--'); 
legend({'x', 'Normal range of flexion-extension'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');
%ylim([-100 160]);
title('Right Knee angles: Flexo-Extension');

figure(5)
plot(t_1000, RKneeAngles_y(1:(frames/1000):frames));
legend({'y'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');  
%ylim([-70 50]);
title('Right Knee angles: Abduction-Adduction');

figure(6)
plot(t_1000, RKneeAngles_z(1:(frames/1000):frames));
hold on 
plot(t_1000, intRot_hip,'--'); 
legend({'z', 'Normal range of internal rotation'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil  
ylabel('Degrees');
%ylim([-70 20]);
title('Right Knee angles: Internal-External Rotation');

figure(7)
% (1:(frames/1000):frames)  si frames>1000
% (1:(frames/1000):frames+(frames/1000)) si frames<1000
% +(frames/1000)
plot(t_1000,LKneeAngles_x(1:(frames/1000):frames)); 
hold on 
plot(t_1000, flex_knee,'--',t_1000, ext_knee,'--'); 
legend({'x', 'Normal range of flexion-extension'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');
%ylim([-100 160]);
title('Left Knee angles: Flexo-Extension');

figure(8)
plot(t_1000, LKneeAngles_y(1:(frames/1000):frames));
legend({'y'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');
%ylim([-70 50]);
title('Left Knee angles: Abduction-Adduction');

figure(9)
plot(t_1000, LKneeAngles_z(1:(frames/1000):frames));
hold on 
plot(t_1000, intRot_hip,'--'); 
legend({'z', 'Normal range of internal rotation'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');
%ylim([-70 80]);
title('Left Knee angles: Internal-External Rotation');

%figure(3)
%plot(t ,RKneeAngles_x, t, RKneeAngles_y, t, RKneeAngles_z);
%legend('x','y','z');
%xlabel('time in frames'); % frames totales del trial
%title('Right Knee angles');

%figure(4)
%plot(t,LKneeAngles_x, t, LKneeAngles_y, t, LKneeAngles_z);   
%legend('x','y','z');
%xlabel('time in frames'); % frames totales del trial
%title('Left Knee angles');

%% Signal Segmentation

% Right Knee 

phase1_RKnee_x = RKneeAngles_x(idxO1:idxF1);  
phase1_RKnee_y = RKneeAngles_y(idxO1:idxF1);
phase1_RKnee_z = RKneeAngles_z(idxO1:idxF1);

phase2_RKnee_x = RKneeAngles_x(idxF1:idxF2); 
phase2_RKnee_y = RKneeAngles_y(idxF1:idxF2);
phase2_RKnee_z = RKneeAngles_z(idxF1:idxF2);

phase3_RKnee_x = RKneeAngles_x(idxF2:idxF3);
phase3_RKnee_y = RKneeAngles_y(idxF2:idxF3);
phase3_RKnee_z = RKneeAngles_z(idxF2:idxF3);

phase4_RKnee_x = RKneeAngles_x(idxF3:idxF4); 
phase4_RKnee_y = RKneeAngles_y(idxF3:idxF4);
phase4_RKnee_z = RKneeAngles_z(idxF3:idxF4);

phase5_RKnee_x = RKneeAngles_x(idxF4:idxF5); 
phase5_RKnee_y = RKneeAngles_y(idxF4:idxF5);
phase5_RKnee_z = RKneeAngles_z(idxF4:idxF5);

% Left Knee

phase1_LKnee_x = LKneeAngles_x(idxO1:idxF1);
phase1_LKnee_y = LKneeAngles_y(idxO1:idxF1);
phase1_LKnee_z = LKneeAngles_z(idxO1:idxF1);

phase2_LKnee_x = LKneeAngles_x(idxF1:idxF2);
phase2_LKnee_y = LKneeAngles_y(idxF1:idxF2);
phase2_LKnee_z = LKneeAngles_z(idxF1:idxF2);

phase3_LKnee_x = LKneeAngles_x(idxF2:idxF3);
phase3_LKnee_y = LKneeAngles_y(idxF2:idxF3);
phase3_LKnee_z = LKneeAngles_z(idxF2:idxF3);

phase4_LKnee_x = LKneeAngles_x(idxF3:idxF4);
phase4_LKnee_y = LKneeAngles_y(idxF3:idxF4);
phase4_LKnee_z = LKneeAngles_z(idxF3:idxF4);

phase5_LKnee_x = LKneeAngles_x(idxF4:idxF5);
phase5_LKnee_y = LKneeAngles_y(idxF4:idxF5);
phase5_LKnee_z = LKneeAngles_z(idxF4:idxF5);

%% time vectors definition

t2 = 0:1:(length(phase3_RKnee_x)-1);
t3 = 0:1:(length(phase1_RKnee_x)-1);
t4 = 0:1:(length(phase2_RKnee_x)-1);
t5 = 0:1:(length(phase4_RKnee_x)-1);
t6 = 0:1:(length(phase5_RKnee_x)-1);

% Right Knee figures: MOVEMENT SEGMENTED INTO THE 4 PHASES

figure(10)
subplot(5,1,1)
plot (t3, phase1_RKnee_x, t3, phase1_RKnee_y, '--',t3,phase1_RKnee_z, '.');
legend('x','y','z')
xlabel('Time in frames');
ylabel('Degrees');
title('RIGHT ANGLES: Phase 1'); % Picking up the box sagittal plane
subplot(5,1,2)
plot(t4, phase2_RKnee_x,t4,phase2_RKnee_y, '--',t4,phase2_RKnee_z, '.');
legend('x','y','z')
xlabel('Time in frames');
ylabel('Degrees');
title('Phase 2'); % Taking steps from sagittal to frontal
subplot(5,1,3)
plot(t2, phase3_RKnee_x, t2, phase3_RKnee_y,'--', t2, phase3_RKnee_z, '.');
legend('x','y','z')
xlabel('Time in frames');
ylabel('Degrees');
title('Phase 3'); % Placing the box frontal plane
subplot(5,1,4)
plot(t5, phase4_RKnee_x, t5, phase4_RKnee_y,'--', t5, phase4_RKnee_z, '.');
legend('x','y','z')
xlabel('Time in frames');
ylabel('Degrees');
title('Phase 4'); % Taking steps from frontal to sagittal
subplot(5,1,5)
plot(t6, phase5_RKnee_x, t6, phase5_RKnee_y,'--', t6, phase5_RKnee_z, '.');
legend('x','y','z')
xlabel('Time in frames');
ylabel('Degrees');
title('Phase 5'); % Placing the box sagittal plane again

% Left Knee figures: MOVEMENT SEGMENTED INTO THE 4 PHASES

figure(11)
subplot(5,1,1)
plot (t3, phase1_LKnee_x, t3, phase1_LKnee_y, '--',t3,phase1_LKnee_z, '.');
legend('x','y','z')
xlabel('Time in frames');
ylabel('Degrees');
title('LEFT ANGLES: Phase 1'); % Picking up the box sagittal plane
subplot(5,1,2)
plot(t4, phase2_LKnee_x,t4, phase2_LKnee_y, '--',t4, phase2_LKnee_z, '.');
legend('x','y','z')
xlabel('Time in frames');
ylabel('Degrees');
title('Phase 2'); % Taking steps from sagittal to frontal
subplot(5,1,3)
plot(t2, phase3_LKnee_x, t2, phase3_LKnee_y,'--', t2, phase3_LKnee_z, '.');
legend('x','y','z')
xlabel('Time in frames');
ylabel('Degrees');
title('Phase 3'); % Placing the box frontal plane
subplot(5,1,4)
plot(t5, phase4_LKnee_x, t5, phase4_LKnee_y,'--', t5, phase4_LKnee_z, '.');
legend('x','y','z')
xlabel('Time in frames');
ylabel('Degrees');
title('Phase 4'); % Taking steps from frontal to sagittal
subplot(5,1,5)
plot(t6, phase5_LKnee_x, t6, phase5_LKnee_y,'--', t6, phase5_LKnee_z, '.');
legend('x','y','z')
xlabel('Time in frames');
ylabel('Degrees');
title('Phase 5'); % Placing the box sagittal plane again


%% ROM calculation

% Right Knee

RKnee_ph1(:,1) = phase1_RKnee_x;
RKnee_ph1(:,2) = phase1_RKnee_y;
RKnee_ph1(:,3) = phase1_RKnee_z;

RKnee_ph2(:,1) = phase2_RKnee_x;
RKnee_ph2(:,2) = phase2_RKnee_y;
RKnee_ph2(:,3) = phase2_RKnee_z;

RKnee_ph3(:,1) = phase3_RKnee_x;
RKnee_ph3(:,2) = phase3_RKnee_y;
RKnee_ph3(:,3) = phase3_RKnee_z;

RKnee_ph4(:,1) = phase4_RKnee_x;
RKnee_ph4(:,2) = phase4_RKnee_y;
RKnee_ph4(:,3) = phase4_RKnee_z;

RKnee_ph5(:,1) = phase5_RKnee_x;
RKnee_ph5(:,2) = phase5_RKnee_y;
RKnee_ph5(:,3) = phase5_RKnee_z;


RKnee_ph1_max = max(RKnee_ph1);
RKnee_ph1_min = min(RKnee_ph1);

RKnee_ph2_max = max(RKnee_ph2);
RKnee_ph2_min = min(RKnee_ph2);

RKnee_ph3_max = max(RKnee_ph3);
RKnee_ph3_min = min(RKnee_ph3);

RKnee_ph4_max = max(RKnee_ph4);
RKnee_ph4_min = min(RKnee_ph4);

RKnee_ph5_max = max(RKnee_ph5);
RKnee_ph5_min = min(RKnee_ph5);

for i = 1:length(RKnee_ph1_max)
    RKnee_ph1_ROM(1,i) = RKnee_ph1_max(i)- RKnee_ph1_min(i);
end

for i = 1:length(RKnee_ph1_max)
    RKnee_ph2_ROM(1,i) = RKnee_ph2_max(i)- RKnee_ph2_min(i);
end

for i = 1:length(RKnee_ph1_max)
    RKnee_ph3_ROM(1,i) = RKnee_ph3_max(i)- RKnee_ph3_min(i);
end

for i = 1:length(RKnee_ph1_max)
    RKnee_ph4_ROM(1,i) = RKnee_ph4_max(i)- RKnee_ph4_min(i);
end

for i = 1:length(RKnee_ph1_max)
    RKnee_ph5_ROM(1,i) = RKnee_ph5_max(i)- RKnee_ph5_min(i);
end

% Left Knee

LKnee_ph1(:,1) = phase1_LKnee_x;
LKnee_ph1(:,2) = phase1_LKnee_y;
LKnee_ph1(:,3) = phase1_LKnee_z;

LKnee_ph2(:,1) = phase2_LKnee_x;
LKnee_ph2(:,2) = phase2_LKnee_y;
LKnee_ph2(:,3) = phase2_LKnee_z;

LKnee_ph3(:,1) = phase3_LKnee_x;
LKnee_ph3(:,2) = phase3_LKnee_y;
LKnee_ph3(:,3) = phase3_LKnee_z;

LKnee_ph4(:,1) = phase4_LKnee_x;
LKnee_ph4(:,2) = phase4_LKnee_y;
LKnee_ph4(:,3) = phase4_LKnee_z;

LKnee_ph5(:,1) = phase5_LKnee_x;
LKnee_ph5(:,2) = phase5_LKnee_y;
LKnee_ph5(:,3) = phase5_LKnee_z;


LKnee_ph1_max = max(LKnee_ph1);
LKnee_ph1_min = min(LKnee_ph1);

LKnee_ph2_max = max(LKnee_ph2);
LKnee_ph2_min = min(LKnee_ph2);

LKnee_ph3_max = max(LKnee_ph3);
LKnee_ph3_min = min(LKnee_ph3);

LKnee_ph4_max = max(LKnee_ph4);
LKnee_ph4_min = min(LKnee_ph4);

LKnee_ph5_max = max(LKnee_ph5);
LKnee_ph5_min = min(LKnee_ph5);

for i = 1:length(RKnee_ph1_max)
    LKnee_ph1_ROM(1,i) = LKnee_ph1_max(i)- LKnee_ph1_min(i);
end

for i = 1:length(RKnee_ph1_max)
    LKnee_ph2_ROM(1,i) = LKnee_ph2_max(i)- LKnee_ph2_min(i);
end

for i = 1:length(RKnee_ph1_max)
    LKnee_ph3_ROM(1,i) = LKnee_ph3_max(i)- LKnee_ph3_min(i);
end

for i = 1:length(RKnee_ph1_max)
    LKnee_ph4_ROM(1,i) = LKnee_ph4_max(i)- LKnee_ph4_min(i);
end

for i = 1:length(RKnee_ph1_max)
    LKnee_ph5_ROM(1,i) = LKnee_ph5_max(i)- LKnee_ph5_min(i);
end

% Total ROM Knee Angles

RKnee_total(:,1) = RKneeAngles_x;
RKnee_total(:,2) = RKneeAngles_y;
RKnee_total(:,3) = RKneeAngles_z;

RKnee_total_max = max(RKnee_total);
RKnee_total_min = min(RKnee_total);

for i = 1:length(RKnee_total_max)
    RKnee_total_ROM(1,i) = RKnee_total_max(i)- RKnee_total_min(i);
end

LKnee_total(:,1) = LKneeAngles_x;
LKnee_total(:,2) = LKneeAngles_y;
LKnee_total(:,3) = LKneeAngles_z;

LKnee_total_max = max(LKnee_total);
LKnee_total_min = min(LKnee_total);

for i = 1:length(LKnee_total_max)
    LKnee_total_ROM(1,i) = LKnee_total_max(i)- LKnee_total_min(i);
end

ROM_Right_Knee = table([RKnee_ph1_ROM(1);RKnee_ph2_ROM(1);RKnee_ph3_ROM(1);RKnee_ph4_ROM(1); RKnee_ph5_ROM(1)],[RKnee_ph1_ROM(2);RKnee_ph2_ROM(2);RKnee_ph3_ROM(2);RKnee_ph4_ROM(2); RKnee_ph5_ROM(2)],[RKnee_ph1_ROM(3);RKnee_ph2_ROM(3);RKnee_ph3_ROM(3);RKnee_ph4_ROM(3); RKnee_ph5_ROM(3)],'VariableNames',{'X','Y','Z'},'RowNames',{'Phase 1','Phase 2','Phase 3', 'Phase 4', 'Phase 5'})

ROM_Left_Knee = table([LKnee_ph1_ROM(1);LKnee_ph2_ROM(1);LKnee_ph3_ROM(1);LKnee_ph4_ROM(1); LKnee_ph5_ROM(1)],[LKnee_ph1_ROM(2);LKnee_ph2_ROM(2);LKnee_ph3_ROM(2);LKnee_ph4_ROM(2); LKnee_ph5_ROM(2)],[LKnee_ph1_ROM(3);LKnee_ph2_ROM(3);LKnee_ph3_ROM(3);LKnee_ph4_ROM(3); LKnee_ph5_ROM(3)],'VariableNames',{'X','Y','Z'},'RowNames',{'Phase 1','Phase 2','Phase 3', 'Phase 4', 'Phase 5'})

TotalROM_Knee = table([RKnee_total_ROM(1); LKnee_total_ROM(1)],[RKnee_total_ROM(2); LKnee_total_ROM(2)],[RKnee_total_ROM(3); LKnee_total_ROM(3)],'VariableNames',{'X','Y','Z'},'RowNames',{'Right','Left'})

