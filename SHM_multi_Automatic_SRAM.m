clear;
clear all;
source_dir = pwd
%%
%  files = dir(pwd)
%  dirFlags = [files.isdir]
% % Extract only those that are directories.
% subFolders = files(dirFlags)
% %%
% for i = 1:length(subFolders)
%    try
%    source_files = dir(fullfile(subFolders(i), '*.xlsx'))
%    print(source_files)
%    catch 
%        continue
%    end
% end
%%
source_files = dir(fullfile(source_dir, '*.csv'))
for i = 1:length(source_files)
  
    fileip=(fullfile(source_dir,source_files(i).name)); % input file
%   data= xlsread(fileip)
    if strfind(fileip,'SRM')
    i
    close all
    name  =  fileip
    data2 = xlsread(fileip)
    l =size(data2);  
    colms= l(2); 
    colorstring = 'rgb';
    vin1 = data2(:,1)
    vout1 = data2(:,2)
    B = fliplr( vout1 )
    vin2 = B
    vout2=  vin1
    % figure(2)
    % plot(vin1,vout1)
    % hold on
    % plot(vin2,vout2)

    %% TO get Q - Qbar data
    Q_data = []
    Q_BAR = []
    % % for id=1:2:colms
    %      vin1 = data2(:,1) ; %% Qbar
    %     vout1 = data2(:,id+1);
    %     B = fliplr( vout1 );
    %     vin2 = B      ;    %%Q inv
    %     vout2=  vin1      %% q inve
    % Q_data=  [Q_data vout1];
    % Q_BAR  = [Q_BAR vin2 vout2];
    % figure(2)
    % plot(vin1,vout1)
    % hold on
    % plot(vin2,vout2)
    % end
    %%
    Area= []
    NM = []
       for id =1:2: colms
    %  for id =1:2: 2
        vin1 = data2(:,id) ; %% Qbar
        vout1 = data2(:,id+1);
        B = fliplr( vout1 );
        vin2 = vin1      ;    %%Q inv
        vout2=  B;

    %
    if true
      [Xint,Yint] = polyxpoly(vout1,vin1,vin2,vout2);

    %   [Xint,Yint] = polyxpoly(vout1,vin1,vin2,vout2);
    h = 1e-3;
    SNMwSim = 0;
    if (length(Xint)>1) %intersections number > 1
      while (length(Xint)>1)
          SNMwSim = SNMwSim - h;
          [Xint,Yint] = polyxpoly(vout1,vin1-SNMwSim,vin2+SNMwSim,vout2);
    %       plot(vout1,vin1-SNMwSim,vin2+SNMwSim,vout2)
    %       pause(0.2)
      end
    else % assuming that always we have at least 1 intersection
      while (length(Xint)==1) 
          SNMwSim = SNMwSim + h;
          [Xint,Yint] = polyxpoly(vout1,vin1-SNMwSim,vin2+SNMwSim,vout2);
    %       plot(vout1,vin1-SNMwSim,vin2+SNMwSim,vout2)
    %          pause(0.2)
      end   
    end
    end

    NM = [NM SNMwSim];
    end

    figure(85)
    hold on
    boxplot(abs(NM))
    % saveas(gcf,name + ".png")
    filename = name + "_SRM_Extracted" + ".csv"
    mat = [ abs(NM')];
    csvwrite( filename,mat,1,0); 
   end
end
%%
%  fileip=(fullfile(Interpolated_csv,source_files(i).name)); % input file
% filename = Interpolated_csv + "\" + name + "Q_BAR" + ".csv"
% mat = [ Q_BAR];
% csvwrite( filename,mat,1,0);
%      
% 
% filename = Interpolated_csv + "\" + name + "Q_data" + ".csv"
% mat = [ Q_data];
% csvwrite( filename,mat,1,0);
 
%%

 





