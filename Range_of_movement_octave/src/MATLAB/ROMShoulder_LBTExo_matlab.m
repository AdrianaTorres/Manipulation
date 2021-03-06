%% Range of movement of Shoulder in Lateral Box Transfer

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

load('..\tests\data\input\dinamica56_B.mat')
           
Ts = 1/Fs;
t_total = (double(frames)*Ts);
t_1000 = 0:(t_total/1000):(t_total-(t_total/1000));

% Normal Ranges of Shoulder Motion
for i =1:(length(t_1000))
    flex_shoulder(1,i) = 130; % flexion
    ext_shoulder(1,i) = -30;   % extension
    abd_shoulder(1,i) = -50;   % abduction
    add_shoulder(1,i) = 30;   % adduction
end

% Feet markers for signal segmentation
LTOE_z = LTOE(:,3)'; 
RTOE_z = RTOE(:,3)';   
%LHEE_z = LHEE(:,3)';  
%RHEE_z = RHEE(:,3)'; 


t= 0:(length(LTOE)-1);

%% SEGMENTATION LEFT TOE: 

[pks, locs] = findpeaks(LTOE_z,'minPeakProminence',10,'MinPeakHeight',80);                     
TF1 = islocalmin(LTOE_z, 'FlatSelection', 'first');
idx = find(TF1);
flat = idx < locs(1);
idx_flat = find(flat);

flat2 = idx < locs(3)& idx > locs(2);
idx_flat2 = find(flat2);

flat3 = idx > locs(4);
idx_flat3 = find(flat3);


figure(1)
plot(t, LTOE_z, t(locs), LTOE_z(locs),'o')
hold on
plot(t, LTOE_z,'r*','MarkerIndices',idx(idx_flat(length(idx_flat))));
plot(t, LTOE_z,'r*','MarkerIndices',idx(idx_flat2(3)));                    
plot(t, LTOE_z,'r*','MarkerIndices',idx(idx_flat2(length(idx_flat2))));
plot(t, LTOE_z,'r*','MarkerIndices',idx(idx_flat3(4)));                     
hold off
title('Left Toe');

%% SEGMENTATION RIGHT TOE: 

[pks2, locs2] = findpeaks(RTOE_z,'minPeakProminence',10);

TF2 = islocalmin(RTOE_z, 'FlatSelection', 'first');
idx2 = find(TF2);
flat4 = idx2 < locs2(1);
idx_flat4 = find(flat4);

flat5 = idx2 > locs2(length(locs2));
idx_flat5 = find(flat5);
flat6 = idx2 > locs2(3);
idx_flat6 = find(flat6);

figure(2)
plot(t, RTOE_z, t(locs2), RTOE_z(locs2),'o')
hold on
plot(t, RTOE_z,'r*','MarkerIndices',idx2(idx_flat4(length(idx_flat4))));
plot(t, RTOE_z,'r*','MarkerIndices',idx2(idx_flat6(1)));
plot(t, RTOE_z,'r*','MarkerIndices',idx2(idx_flat5(2))); 
title('Right Toe');

% Indexes definiton for signal segmentation
idxO1 = 1;
idxF1 = idx2(idx_flat4(length(idx_flat4))); %idxO2
idxF2 = idx2(idx_flat6(1)); %idxO3
idxF3 = idx(idx_flat2(length(idx_flat2))); %idxO4
idxF4 = idx(idx_flat3(3)); %idxO5
idxF5 = length(LTOE_z);

figure(3)
plot(t, zscore(LTOE_z));
hold on
plot(t,zscore(RTOE_z));
plot(t,zscore(LTOE_z),'r*', 'MarkerIndices', idxO1);
plot(t,zscore(RTOE_z),'r*', 'MarkerIndices', idxF2);
plot(t,zscore(LTOE_z),'r*', 'MarkerIndices', idxF3);
plot(t,zscore(LTOE_z),'r*', 'MarkerIndices', idxF5);
plot(t,zscore(RTOE_z),'r*', 'MarkerIndices', idxO1);
plot(t,zscore(RTOE_z),'r*', 'MarkerIndices', idxF1);
plot(t,zscore(LTOE_z),'r*', 'MarkerIndices', idxF4);
plot(t,zscore(RTOE_z),'r*', 'MarkerIndices', idxF5);
hold off
legend('Left Toe Z', 'Right Toe Z');
xlabel('Time in frames');
ylabel('Milimetres');
title('Lateral Box Transfer Segmentation for Exoskeleton Trials')

%% Import model data for Shoulder Relative Angles

% Shoulder  
        RShoulderAngles_x = ModelData.Raw.(ModelOutput{9})(1,:); 
        RShoulderAngles_y = ModelData.Raw.(ModelOutput{9})(2,:);
        RShoulderAngles_z = ModelData.Raw.(ModelOutput{9})(3,:);
        

        LShoulderAngles_x = ModelData.Raw.(ModelOutput{10})(1,:);
        LShoulderAngles_y = ModelData.Raw.(ModelOutput{10})(2,:);
        LShoulderAngles_z = ModelData.Raw.(ModelOutput{10})(3,:);
        

%% Shoulder signals visualization before going through segmentation

figure(4)
frames = length(LTOE_z);
% (1:(frames/1000):frames)  si frames>1000
% (1:(frames/1000):frames+(frames/1000)) si frames<1000
% +(frames/1000)
plot(t_1000,RShoulderAngles_x(1:(frames/1000):frames)); 
hold on 
plot(t_1000, flex_shoulder,'--',t_1000, ext_shoulder,'--'); 
legend({'x', 'Normal range of flexion-extension'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');
%ylim([-100 160]);
title('Right Shoulder angles: Flexo-Extension');

figure(5)
plot(t_1000, RShoulderAngles_y(1:(frames/1000):frames));
hold on 
plot(t_1000, abd_shoulder,'--',t_1000, add_shoulder,'--'); 
legend({'y', 'Normal range of abduction-adduction'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');
ylim([-60 100]);
title('Right Shoulder angles: Abduction-Adduction');

figure(6)
plot(t_1000, RShoulderAngles_z(1:(frames/1000):frames));
legend({'z'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');
%ylim([-70 50]);
title('Right Shoulder angles: Internal-External Rotation');

figure(7)
% (1:(frames/1000):frames)  si frames>1000
% (1:(frames/1000):frames+(frames/1000)) si frames<1000
% +(frames/1000)
plot(t_1000,LShoulderAngles_x(1:(frames/1000):frames)); 
hold on 
plot(t_1000, flex_shoulder,'--',t_1000, ext_shoulder,'--'); 
legend({'x', 'Normal range of flexion-extension'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');
%ylim([-100 160]);
title('Left Shoulder angles: Flexo-Extension');

figure(8)
plot(t_1000, LShoulderAngles_y(1:(frames/1000):frames));
hold on 
plot(t_1000, abd_shoulder,'--',t_1000, add_shoulder,'--'); 
legend({'y', 'Normal range of abduction-adduction'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');
ylim([-60 100]);
title('Left Shoulder angles: Abduction-Adduction');

figure(9)
plot(t_1000, LShoulderAngles_z(1:(frames/1000):frames));
legend({'z', 'Normal range of internal-external rotation'},'Location','best');
xlabel('Time in seconds (%1000 lifting cycle)'); %tanto por mil 
ylabel('Degrees');
%ylim([-70 80]);
title('Left Shoulder angles: Internal-External Rotation');

%figure(3)
%plot(t ,RShoulderAngles_x, t, RShoulderAngles_y, t, RShoulderAngles_z);
%legend('x','y','z');
%xlabel('time in frames'); % frames totales del trial
%title('Right Shoulder angles');

%figure(4)
%plot(t,LShoulderAngles_x, t, LShoulderAngles_y, t, LShoulderAngles_z);   
%legend('x','y','z');
%xlabel('time in frames'); % frames totales del trial
%title('Left Shoulder angles');

%% Signal Segmentation

% Right Shoulder 

phase1_RShoulder_x = RShoulderAngles_x(idxO1:idxF1);  
phase1_RShoulder_y = RShoulderAngles_y(idxO1:idxF1);
phase1_RShoulder_z = RShoulderAngles_z(idxO1:idxF1);

phase2_RShoulder_x = RShoulderAngles_x(idxF1:idxF2); 
phase2_RShoulder_y = RShoulderAngles_y(idxF1:idxF2);
phase2_RShoulder_z = RShoulderAngles_z(idxF1:idxF2);

phase3_RShoulder_x = RShoulderAngles_x(idxF2:idxF3);
phase3_RShoulder_y = RShoulderAngles_y(idxF2:idxF3);
phase3_RShoulder_z = RShoulderAngles_z(idxF2:idxF3);

phase4_RShoulder_x = RShoulderAngles_x(idxF3:idxF4); 
phase4_RShoulder_y = RShoulderAngles_y(idxF3:idxF4);
phase4_RShoulder_z = RShoulderAngles_z(idxF3:idxF4);

phase5_RShoulder_x = RShoulderAngles_x(idxF4:idxF5); 
phase5_RShoulder_y = RShoulderAngles_y(idxF4:idxF5);
phase5_RShoulder_z = RShoulderAngles_z(idxF4:idxF5);

% Left Shoulder

phase1_LShoulder_x = LShoulderAngles_x(idxO1:idxF1);
phase1_LShoulder_y = LShoulderAngles_y(idxO1:idxF1);
phase1_LShoulder_z = LShoulderAngles_z(idxO1:idxF1);

phase2_LShoulder_x = LShoulderAngles_x(idxF1:idxF2);
phase2_LShoulder_y = LShoulderAngles_y(idxF1:idxF2);
phase2_LShoulder_z = LShoulderAngles_z(idxF1:idxF2);

phase3_LShoulder_x = LShoulderAngles_x(idxF2:idxF3);
phase3_LShoulder_y = LShoulderAngles_y(idxF2:idxF3);
phase3_LShoulder_z = LShoulderAngles_z(idxF2:idxF3);

phase4_LShoulder_x = LShoulderAngles_x(idxF3:idxF4);
phase4_LShoulder_y = LShoulderAngles_y(idxF3:idxF4);
phase4_LShoulder_z = LShoulderAngles_z(idxF3:idxF4);

phase5_LShoulder_x = LShoulderAngles_x(idxF4:idxF5);
phase5_LShoulder_y = LShoulderAngles_y(idxF4:idxF5);
phase5_LShoulder_z = LShoulderAngles_z(idxF4:idxF5);

%% time vectors definition

t2 = 0:1:(length(phase3_RShoulder_x)-1);
t3 = 0:1:(length(phase1_RShoulder_x)-1);
t4 = 0:1:(length(phase2_RShoulder_x)-1);
t5 = 0:1:(length(phase4_RShoulder_x)-1);
t6 = 0:1:(length(phase5_RShoulder_x)-1);

% Right Shoulder figures: MOVEMENT SEGMENTED INTO THE 4 PHASES

figure(10)
subplot(5,1,1)
plot (t3, phase1_RShoulder_x, t3, phase1_RShoulder_y, '--',t3,phase1_RShoulder_z, '.');
legend('x','y','z')
xlabel('Time in frames'); 
ylabel('Degrees');
title('RIGHT ANGLES: Phase 1'); % Picking up the box sagittal plane
subplot(5,1,2)
plot(t4, phase2_RShoulder_x,t4,phase2_RShoulder_y, '--',t4,phase2_RShoulder_z, '.');
legend('x','y','z')
xlabel('Time in frames'); 
ylabel('Degrees');
title('Phase 2'); % Taking steps from sagittal to frontal
subplot(5,1,3)
plot(t2, phase3_RShoulder_x, t2, phase3_RShoulder_y,'--', t2, phase3_RShoulder_z, '.');
legend('x','y','z')
xlabel('Time in frames'); 
ylabel('Degrees');
title('Phase 3'); % Placing the box frontal plane
subplot(5,1,4)
plot(t5, phase4_RShoulder_x, t5, phase4_RShoulder_y,'--', t5, phase4_RShoulder_z, '.');
legend('x','y','z')
xlabel('Time in frames'); 
ylabel('Degrees');
title('Phase 4'); % Taking steps from frontal to sagittal
subplot(5,1,5)
plot(t6, phase5_RShoulder_x, t6, phase5_RShoulder_y,'--', t6, phase5_RShoulder_z, '.');
legend('x','y','z')
xlabel('Time in frames'); 
ylabel('Degrees');
title('Phase 5'); % Placing the box sagittal plane again

% Left Shoulder figures: MOVEMENT SEGMENTED INTO THE 4 PHASES

figure(11)
subplot(5,1,1)
plot (t3, phase1_LShoulder_x, t3, phase1_LShoulder_y, '--',t3,phase1_LShoulder_z, '.');
legend('x','y','z')
xlabel('Time in frames'); 
ylabel('Degrees');
title('LEFT ANGLES: Phase 1'); % Picking up the box sagittal plane
subplot(5,1,2)
plot(t4, phase2_LShoulder_x,t4, phase2_LShoulder_y, '--',t4, phase2_LShoulder_z, '.');
legend('x','y','z')
xlabel('Time in frames'); 
ylabel('Degrees');
title('Phase 2'); % Taking steps from sagittal to frontal
subplot(5,1,3)
plot(t2, phase3_LShoulder_x, t2, phase3_LShoulder_y,'--', t2, phase3_LShoulder_z, '.');
legend('x','y','z')
xlabel('Time in frames'); 
ylabel('Degrees');
title('Phase 3'); % Placing the box frontal plane
subplot(5,1,4)
plot(t5, phase4_LShoulder_x, t5, phase4_LShoulder_y,'--', t5, phase4_LShoulder_z, '.');
legend('x','y','z')
xlabel('Time in frames'); 
ylabel('Degrees');
title('Phase 4'); % Taking steps from frontal to sagittal
subplot(5,1,5)
plot(t6, phase5_LShoulder_x, t6, phase5_LShoulder_y,'--', t6, phase5_LShoulder_z, '.');
legend('x','y','z')
xlabel('Time in frames'); 
ylabel('Degrees');
title('Phase 5'); % Placing the box sagittal plane again


%% ROM calculation

% Right Shoulder

RShoulder_ph1(:,1) = phase1_RShoulder_x;
RShoulder_ph1(:,2) = phase1_RShoulder_y;
RShoulder_ph1(:,3) = phase1_RShoulder_z;

RShoulder_ph2(:,1) = phase2_RShoulder_x;
RShoulder_ph2(:,2) = phase2_RShoulder_y;
RShoulder_ph2(:,3) = phase2_RShoulder_z;

RShoulder_ph3(:,1) = phase3_RShoulder_x;
RShoulder_ph3(:,2) = phase3_RShoulder_y;
RShoulder_ph3(:,3) = phase3_RShoulder_z;

RShoulder_ph4(:,1) = phase4_RShoulder_x;
RShoulder_ph4(:,2) = phase4_RShoulder_y;
RShoulder_ph4(:,3) = phase4_RShoulder_z;

RShoulder_ph5(:,1) = phase5_RShoulder_x;
RShoulder_ph5(:,2) = phase5_RShoulder_y;
RShoulder_ph5(:,3) = phase5_RShoulder_z;


RShoulder_ph1_max = max(RShoulder_ph1);
RShoulder_ph1_min = min(RShoulder_ph1);

RShoulder_ph2_max = max(RShoulder_ph2);
RShoulder_ph2_min = min(RShoulder_ph2);

RShoulder_ph3_max = max(RShoulder_ph3);
RShoulder_ph3_min = min(RShoulder_ph3);

RShoulder_ph4_max = max(RShoulder_ph4);
RShoulder_ph4_min = min(RShoulder_ph4);

RShoulder_ph5_max = max(RShoulder_ph5);
RShoulder_ph5_min = min(RShoulder_ph5);

for i = 1:length(RShoulder_ph1_max)
    RShoulder_ph1_ROM(1,i) = RShoulder_ph1_max(i)- RShoulder_ph1_min(i);
end

for i = 1:length(RShoulder_ph1_max)
    RShoulder_ph2_ROM(1,i) = RShoulder_ph2_max(i)- RShoulder_ph2_min(i);
end

for i = 1:length(RShoulder_ph1_max)
    RShoulder_ph3_ROM(1,i) = RShoulder_ph3_max(i)- RShoulder_ph3_min(i);
end

for i = 1:length(RShoulder_ph1_max)
    RShoulder_ph4_ROM(1,i) = RShoulder_ph4_max(i)- RShoulder_ph4_min(i);
end

for i = 1:length(RShoulder_ph1_max)
    RShoulder_ph5_ROM(1,i) = RShoulder_ph5_max(i)- RShoulder_ph5_min(i);
end

% Left Shoulder

LShoulder_ph1(:,1) = phase1_LShoulder_x;
LShoulder_ph1(:,2) = phase1_LShoulder_y;
LShoulder_ph1(:,3) = phase1_LShoulder_z;

LShoulder_ph2(:,1) = phase2_LShoulder_x;
LShoulder_ph2(:,2) = phase2_LShoulder_y;
LShoulder_ph2(:,3) = phase2_LShoulder_z;

LShoulder_ph3(:,1) = phase3_LShoulder_x;
LShoulder_ph3(:,2) = phase3_LShoulder_y;
LShoulder_ph3(:,3) = phase3_LShoulder_z;

LShoulder_ph4(:,1) = phase4_LShoulder_x;
LShoulder_ph4(:,2) = phase4_LShoulder_y;
LShoulder_ph4(:,3) = phase4_LShoulder_z;

LShoulder_ph5(:,1) = phase5_LShoulder_x;
LShoulder_ph5(:,2) = phase5_LShoulder_y;
LShoulder_ph5(:,3) = phase5_LShoulder_z;


LShoulder_ph1_max = max(LShoulder_ph1);
LShoulder_ph1_min = min(LShoulder_ph1);

LShoulder_ph2_max = max(LShoulder_ph2);
LShoulder_ph2_min = min(LShoulder_ph2);

LShoulder_ph3_max = max(LShoulder_ph3);
LShoulder_ph3_min = min(LShoulder_ph3);

LShoulder_ph4_max = max(LShoulder_ph4);
LShoulder_ph4_min = min(LShoulder_ph4);

LShoulder_ph5_max = max(LShoulder_ph5);
LShoulder_ph5_min = min(LShoulder_ph5);

for i = 1:length(RShoulder_ph1_max)
    LShoulder_ph1_ROM(1,i) = LShoulder_ph1_max(i)- LShoulder_ph1_min(i);
end

for i = 1:length(RShoulder_ph1_max)
    LShoulder_ph2_ROM(1,i) = LShoulder_ph2_max(i)- LShoulder_ph2_min(i);
end

for i = 1:length(RShoulder_ph1_max)
    LShoulder_ph3_ROM(1,i) = LShoulder_ph3_max(i)- LShoulder_ph3_min(i);
end

for i = 1:length(RShoulder_ph1_max)
    LShoulder_ph4_ROM(1,i) = LShoulder_ph4_max(i)- LShoulder_ph4_min(i);
end

for i = 1:length(RShoulder_ph1_max)
    LShoulder_ph5_ROM(1,i) = LShoulder_ph5_max(i)- LShoulder_ph5_min(i);
end

% Total ROM Shoulder Angles

RShoulder_total(:,1) = RShoulderAngles_x;
RShoulder_total(:,2) = RShoulderAngles_y;
RShoulder_total(:,3) = RShoulderAngles_z;

RShoulder_total_max = max(RShoulder_total);
RShoulder_total_min = min(RShoulder_total);

for i = 1:length(RShoulder_total_max)
    RShoulder_total_ROM(1,i) = RShoulder_total_max(i)- RShoulder_total_min(i);
end

LShoulder_total(:,1) = LShoulderAngles_x;
LShoulder_total(:,2) = LShoulderAngles_y;
LShoulder_total(:,3) = LShoulderAngles_z;

LShoulder_total_max = max(LShoulder_total);
LShoulder_total_min = min(LShoulder_total);

for i = 1:length(LShoulder_total_max)
    LShoulder_total_ROM(1,i) = LShoulder_total_max(i)- LShoulder_total_min(i);
end

ROM_Right_Shoulder = table([RShoulder_ph1_ROM(1);RShoulder_ph2_ROM(1);RShoulder_ph3_ROM(1);RShoulder_ph4_ROM(1); RShoulder_ph5_ROM(1)],[RShoulder_ph1_ROM(2);RShoulder_ph2_ROM(2);RShoulder_ph3_ROM(2);RShoulder_ph4_ROM(2); RShoulder_ph5_ROM(2)],[RShoulder_ph1_ROM(3);RShoulder_ph2_ROM(3);RShoulder_ph3_ROM(3);RShoulder_ph4_ROM(3); RShoulder_ph5_ROM(3)],'VariableNames',{'X','Y','Z'},'RowNames',{'Phase 1','Phase 2','Phase 3', 'Phase 4', 'Phase 5'})

ROM_Left_Shoulder = table([LShoulder_ph1_ROM(1);LShoulder_ph2_ROM(1);LShoulder_ph3_ROM(1);LShoulder_ph4_ROM(1); LShoulder_ph5_ROM(1)],[LShoulder_ph1_ROM(2);LShoulder_ph2_ROM(2);LShoulder_ph3_ROM(2);LShoulder_ph4_ROM(2); LShoulder_ph5_ROM(2)],[LShoulder_ph1_ROM(3);LShoulder_ph2_ROM(3);LShoulder_ph3_ROM(3);LShoulder_ph4_ROM(3); LShoulder_ph5_ROM(3)],'VariableNames',{'X','Y','Z'},'RowNames',{'Phase 1','Phase 2','Phase 3', 'Phase 4', 'Phase 5'})

TotalROM_Shoulder = table([RShoulder_total_ROM(1); LShoulder_total_ROM(1)],[RShoulder_total_ROM(2); LShoulder_total_ROM(2)],[RShoulder_total_ROM(3); LShoulder_total_ROM(3)],'VariableNames',{'X','Y','Z'},'RowNames',{'Right','Left'})

