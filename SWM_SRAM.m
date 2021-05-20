clear;
clear all;
close all

source_dir = pwd
%%
source_files = dir(fullfile(source_dir, '*.csv'))
% for i = 1:2:2
Mean = [  ]
STD = [ ]
for i = 1:1:length(source_files)
close all
fileip=(fullfile(source_dir,source_files(i).name)) % input file
    if strfind(source_files(i).name,'SWM_Q_')
    Swm_qbar = "SWM_Qbar" + source_files(i).name(6:end)
    fileipQbar=(fullfile(source_dir, Swm_qbar)) % input file
%     fileip=(fullfile(source_dir, 'SWM_Q_R0_L50_s2p3_M33.csv')) % input file
%     fileipQbar=(fullfile(source_dir,'SWM_Qbar_R0_L50_s2p3_M33.csv')) % input file

    

name= fileip

data2 = xlsread(fileip)
data2qb = xlsread(fileipQbar)
l =size(data2);  
colms= l(2); 
colorstring = 'rgb'; 
vin1 = data2(:,3)
vout1 = data2(:,4)
B = fliplr( vout1 )
vin2 = B
vout2=  vin1

vin1qb = data2qb(:,3)
vout1qb = data2qb(:,4)

% figure(22)
% plot(vin2,vout2)
% hold on
% plot(vin1qb,vout1qb)
% plot(vin2,vout2)

%%
try
NM = []
for id =1:2: colms

    vin1 = data2(:,id) ; %% Qbar
    vout1 = data2(:,id+1);
    B = fliplr( vout1 );
    vin2 = B      ;    %%Q inv
    vout2=  vin1 ;
    
vin1qb = data2qb(:,id);
vout1qb = data2qb(:,id+1);
    
    X1 = vin1qb
    Y1 = vout1qb
    X2 = vin2
    Y2  = vout2
    
% figure(22)
% hold on
% plot(X1,Y1)
% hold on
% plot(X2,Y2)

max_mar1 = -1
max_mar2 = -1
max_mar = -1
limit = 0.001
%
for i = 1:length(X1)
    for j =1:length(X2)
        if (Y2(j)<Y1(i)) && (X2(j)<X1(i)) && (abs((X1(i)-X2(j))-(Y1(i)-Y2(j)))<limit)
            area = (X1(i)-X2(j))*(Y1(i)-Y2(j))
           
            if (abs((X1(i)-X2(j))-(Y1(i)-Y2(j)))<limit)  
                y= abs((X1(i)-X2(j))-(Y1(i)-Y2(j)))
            end
            
            if area > max_mar
                 max_mar = area
                 max_mar1 = [X1(i),Y1(i)]
                 max_mar2 = [X2(j),Y2(j)]
              end   
        end 
    end
end
SNM =sqrt(area)
NM = [NM SNM]
end

figure(85)
hold on
boxplot(NM)
saveas(gcf,name(1:end-4) +".png")
%%
% fileip=(fullfile(Interpolated_csv,source_files(i).name)); % input file
% filename = "SRAm_SRM_r0"   + "__Q_BAR" + ".csv"
% mat = [ Q_BAR];
% csvwrite( filename,mat,1,0);
%      
% 
% filename =    "SRAm_SRM_r0" + "__Q_data" + ".csv"
% mat = [ Q_data];
% csvwrite( filename,mat,1,0);
 
filename =  name(1:end-4)+  "SRAm_SWM_r0" + "_NM" + ".csv"
mat = [ abs(NM')];
csvwrite( filename,mat,1,0);
catch 
    disp("error")
end
        try
 
            Mean = [Mean mean(NM)]
            STD = [STD std(NM)]
        catch 
            Mean = [Mean 0]
            STD = [STD 0]
        end
    end
end
%%
 
% end





