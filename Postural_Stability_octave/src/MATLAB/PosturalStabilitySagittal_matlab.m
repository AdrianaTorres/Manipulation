%% Postural Stability in Sagittal Lifting task: COM deviation from centre of Base of Support

% Based on "Investigation and Analysis of the Effects of Manual Lifting and Carrying Activities on Postural and Gait Stability in Normal Subjects", Mohammed Alamoudi, University of Miami, 2017.

% Code AUTHOR: Yaiza Benito Molpeceres. DATE: January-May 2020.

% No signal segmentation is needed


clear all % Clear variables
close all % Close figures
clc

load('..\tests\data\input\dinamica61_B.mat') 

% LTOE RTOE LHEE RHEE LFOO2 RFOO2 marker trajectories
    LTOE_x = LTOE(:,1)'; 
    LTOE_y = LTOE(:,2)';
    
    RTOE_x = RTOE(:,1)';
    RTOE_y = RTOE(:,2)';
    
    LHEE_x = LHEE(:,1)';
    LHEE_y = LHEE(:,2)';
    LHEE_z = LHEE(:,3)';
    
    RHEE_x = RHEE(:,1)';
    RHEE_y = RHEE(:,2)';
    RHEE_z = RHEE(:,3)';
    
    LFOO2_x = LFOO2(:,1)';
    LFOO2_y = LFOO2(:,2)';
   
    RFOO2_x = RFOO2(:,1)';
    RFOO2_y = RFOO2(:,2)';
    
% Centre of mass 
    % A/P fore-aft direction, thus x axis
    % M/L sideways direction, thus y axis
    
    CoM_ap = ModelData.Raw.(ModelOutput{13})(1,:);  % x
        
    CoM_ml = ModelData.Raw.(ModelOutput{13})(2,:);  % y
    

%% Vertex definition using feet markers coordinates in counterclockwise order: 
% RFOO2 RTOE LTOE LFOO2 LHEE RHEE 

X = [];
for i = 1:frames            
    for j = 1:6 % number of markers that define the BoS
        switch j
            case 1
            X(i,j)= RFOO2_x(i);
            case 2
            X(i,j)= RTOE_x(i);
            case 3
            X(i,j)= LTOE_x(i);
            case 4
            X(i,j)= LFOO2_x(i);
            case 5
            X(i,j)= LHEE_x(i);
            case 6
            X(i,j)= RHEE_x(i);
        end
    end
end

Y = [];

for i = 1:frames 
    for j = 1:6 
        switch j
            case 1
            Y(i,j) = RFOO2_y(i);
            case 2
            Y(i,j)= RTOE_y(i);
            case 3
            Y(i,j)= LTOE_y(i);
            case 4
            Y(i,j)= LFOO2_y(i);
            case 5
            Y(i,j)= LHEE_y(i);
            case 6
            Y(i,j)= RHEE_y(i);
        end
    end
end

%% Centre of Base of Support calculation

for i= 1:frames
    sumaN = 0;
    sumaD= 0;
    sumaN2 = 0;
    
    pgon = polyshape([X(i,3) X(i,5) X(i,6)], [Y(i,3) Y(i,5) Y(i,6)]);
    pgon2 = polyshape([X(i,6) X(i,3) X(i,2)], [Y(i,6) Y(i,3) Y(i,2)]);
    pgon3 = polyshape([X(i,3) X(i,5) X(i,4)], [Y(i,3) Y(i,5) Y(i,4)]);
    pgon4 = polyshape([X(i,6) X(i,2) X(i,1)], [Y(i,6) Y(i,2) Y(i,1)]);
     
    area1 = area(pgon); % triangle 1
    [centroid1_x, centroid1_y] = centroid(pgon);

    area2 = area(pgon2); % triangle 2
    [centroid2_x, centroid2_y] = centroid(pgon2);
 
    area3 = area(pgon3); % triangle 3
    [centroid3_x, centroid3_y] = centroid(pgon3);

    area4 = area(pgon4); % triangle 4
    [centroid4_x, centroid4_y] = centroid(pgon4);

    Area = [area1 area2 area3 area4];
    Centroid = [centroid1_x centroid1_y; centroid2_x centroid2_y; centroid3_x centroid3_y; centroid4_x centroid4_y];
       
    for k = 1:4
        sumaN = sumaN + (Centroid(k,1)*Area(k));  %x
        sumaD = sumaD + Area(k);
    end

    for k = 1:4
        sumaN2 = sumaN2 + (Centroid(k,2)*Area(k));  %x
    end

    CBoS_ap(1,i) = sumaN/sumaD;   %x 
    CBoS_ml(1,i) = sumaN2/sumaD; %y
end


%% "Postural stability in the A/P and M/L directions are measured as the normalized distance of the deviation of the CoM with respect to the vertical and 
% horizontal distance between the CBoS and the edge of the BoS,respectively."

% V: Distance from CBoS to the straight line formed by the points LTOE and RTOE
        % A(x1,y1) is LTOE_x(i) and LTOE_y(i), where i indicates the frame
        % B(x2, y2) is RTOE_x(i) and RTOE_y(i)
             
        % CBoS_ap(1,i) is the x component
        % CBos_ml(1,i) is the y component
        
V =[];
for i = 1:frames 
    x1 = LTOE_x(i); 
    y1 = LTOE_y(i);
    x2 = RTOE_x(i);
    y2 = RTOE_y(i);
    
    A = -((y2-y1)/(x2-x1));                 % calculating general or implicit equation of the line
    B = 1;
    C = -y1 + ((y2-y1)/(x2-x1)*x1);

    if A<0
    A = A*(-1);
    B = B*(-1);
    C = C*(-1);
    end
    
    V(1,i) = (abs(A*CBoS_ap(1,i) + B*CBoS_ml(1,i) + C) / sqrt(A^2 + B^2));
end
     

% H: Distance from CBoS to the straight line formed by the points RFOO2 and RHEE
H =[];
for i = 1:frames 
    x3 = RFOO2_x(i); 
    y3 = RFOO2_y(i);
    x4 = RHEE_x(i);
    y4 = RHEE_y(i);
    
    D = -((y4-y3)/(x4-x3));                      % calculating general or implicit equation of the line
    E = 1;
    F = -y3 + ((y4-y3)/(x4-x3)*x3);

    if D<0
    D = D*(-1);
    E = E*(-1);
    F = F*(-1);
    end
    
    H(1,i) = (abs(D*CBoS_ap(1,i) + E*CBoS_ml(1,i) + F) / sqrt(D^2 + E^2));
end
 

     
%% Postural Stability Measures

AP_dev = [];
ML_dev = [];
Total_dev =[];

for i =1:frames
    AP_dev(1,i) = abs(CBoS_ap(1,i) - CoM_ap(1,i));  % The deviation of the CoM from CBoS in the fore-aft/ anterior-posterior direction at frame i. 

    ML_dev(1,i) = abs(CBoS_ml(1,i) - CoM_ml(1,i));  % The deviation of the CoM from CBoS in the medio-lateral direction at frame i.

    Total_dev(1,i) = sqrt((AP_dev(1,i))^2 + (ML_dev(1,i))^2);   % The total deviation of the CoM from the CBoS at frame i.
end

% "At the end of a trial of an experiment, all the values for AP_dev calculated at each frame should be averaged by dividing it by the number of 
% frames in order to get a value that represents the stability for that trial."

    % Mean postural stability of the trial 
    AP_dev_mean = mean(AP_dev(1,:)); 
    
    ML_dev_mean = mean(ML_dev(1,:));
    
    Total_dev_mean = mean(Total_dev(1,:));
    
%% Postural Stability values


PS_AP = [];
PS_ML = [];
PS_Total = [];
for i =1:frames
PS_AP(1,i) = (AP_dev(1,i)/V(1,i));
PosturalStability_AP = mean(PS_AP(1,:))*100;
end
for i =1:frames
PS_ML(1,i) = (ML_dev(1,i)/H(1,i));
PosturalStability_ML = mean(PS_ML(1,:))*100;
end



%% BoS visualization at last frame of the phase

figure(1)
plot(pgon,'FaceColor','green')
hold on
plot(centroid1_x, centroid1_y,'g*')
hold on
plot(pgon2,'FaceColor','yellow')
hold on
plot(centroid2_x, centroid2_y,'y*')
hold on
plot(pgon3,'FaceColor','red')
hold on
plot(centroid3_x, centroid3_y,'r*','linewidth', 1.25)
hold on
plot(pgon4,'FaceColor','cyan')
hold on
plot(centroid4_x, centroid4_y,'c*','linewidth', 1.25)
hold on
plot(CBoS_ap(1,frames), CBoS_ml(1,frames),'ko','linewidth', 1.25)
hold on
plot(CoM_ap(1,frames), CoM_ml(1,frames), 'b+', 'linewidth', 1.25)
xlabel('Millimetres');
ylabel('Millimetres');
title('Example of Base of Support Representation');

PS = table([AP_dev_mean;  ML_dev_mean;  Total_dev_mean; PosturalStability_AP; PosturalStability_ML],'VariableNames',{'Postural_Stability_Measures'},'RowNames',{'Average A/P Deviation (mm)','Average M/L Deviation (mm)','Average Total Deviation (mm)','Postural Stability (A/P)','Postural Stability(M/L)'})


     

