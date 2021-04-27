%opa_opt_rename.m
% modified by KL on 05-23-19

%Transfers unrenamed to NAS1 and deletes from data collection computers
%Copies and renames .001 files to NAS1 opt folder
%Copies and renames .set files to NAS1 opt\setfiles folder
%Copies v-amp files to NAS1 ECG folder
%Copies and renames .mtg file to reg folder based on helmet color

clc
clear all


%% CHANGE THESE!!!!%%
subj='2562';  %4 digit
helmet='blue';  %lowercase brown, green, or blue
protocol=2; %1=CO2 2=no CO2
session='s1';  %'s1' or 's2'
%%

exp='pea'; %name mtg files with pea????.mtg for all data types
expCO2 =['oco';'rss'];
expNoCO2 = ['rsl';'rss'];

mtg_path='\\bi-cnl-nas1\data\pea\reg\';

start_path1='\\BI-CNL-G1\data\pea\';
start_path2='\\BI-CNL-G2\data\pea\';
start_path3='\\BI-CNL-G3\data\pea\';

out_path='\\bi-cnl-nas1\data\pea\opt\';
bu_path='\\files2.beckman.illinois.edu\fabgrat\pea\opt_bu\';

start_path_ekg='\\bi-cnl-eeg1\data\pea\';
end_path_ekg='\\bi-cnl-nas1\data\pea\ECG\';
bu_path_ekg='\\files2.beckman.illinois.edu\fabgrat\pea\ekg_bu\';

dir1='G1mtg1\';   %a
dir2='G2mtg1\';   %b
dir3='G3mtg1\';   %c

dir4='G1mtg2\';   %d 
dir5='G2mtg2\';   %e
dir6='G3mtg2\';   %f

%%
disp('Attempting to copy data to NAS1...')

%check that NAS1 destination directories are empty
dest_list1=dir([out_path dir1  '*.*']);
dest_list2=dir([out_path dir2 '*.*']);
dest_list3=dir([out_path dir3 '*.*']);
dest_list4=dir([out_path dir4 '*.*']);
dest_list5=dir([out_path dir5 '*.*']);
dest_list6=dir([out_path dir6 '*.*']);

dest(1)= length(dest_list1);
dest(2)= length(dest_list2);
dest(3)= length(dest_list3);
dest(4)= length(dest_list4);
dest(5)= length(dest_list5);
dest(6)= length(dest_list6);

nfiles=sum(dest);

if nfiles>12; %. and .. in each of the directories = 12 
    fprintf('Too many files on NAS1, e.g., pea\opt\G1mtg1 \n');
    fprintf('Clear old files before transferring new files \n');
    return
end

list1=dir([start_path1 dir1 '*.*']);
list2=dir([start_path2 dir2 '*.*']);
list3=dir([start_path3 dir3 '*.*']);
list4=dir([start_path1 dir4 '*.*']);
list5=dir([start_path2 dir5 '*.*']);
list6=dir([start_path3 dir6 '*.*']);

%% 1: G1mtg1
mtg_dir=dir1; %can't use dir for variable name
list=list1;
start_path=[start_path1 mtg_dir];
end_path=[out_path mtg_dir];


if length(list)==6 %4 files plus . and .. at the beginning of the list (which is part of a structure, list.name)
    fprintf('Found 4 files in %s \n', start_path)
    fprintf('\n copying to %s \n', end_path)
    for i_file=3:length(list) %skips those . and ..
        in_file=[start_path list(i_file).name];
        out_file=[end_path list(i_file).name]; 
        copyfile(in_file,out_file)
    end   
elseif length(list)> 4
    fprintf('More than 4 boxy files found.  CHECK  %s \n', [start_path])
else
    fprintf('Less than 4 boxy files found.  CHECK  %s \n', [start_path])
end

%Check that files were transferred and then delete from Boxy machine
outlist=dir([end_path  '*.*']);

if length(outlist)==6 %4 files + .\..  %first check that all files were transferred
    for i_file=3:length(outlist)
        in_size=[list(i_file).bytes];   
        out_size=[outlist(i_file).bytes]; 
        if length(out_size)==length(in_size)  %now check that the file size is correct
            in_file=[start_path  list(i_file).name];
            filename=[list(i_file).name];
            delete(in_file)
            fprintf('File transfer successful - Deleting %s from G1 \n', filename) 
        else  fprintf('FILE TRANSFER FAILED.  CHECK  %s \n', [end_path ])
        end
    end   
end

%% 2: G2mtg1
mtg_dir=dir2; 
list=list2;
start_path=[start_path2 mtg_dir];
end_path=[out_path mtg_dir];


if length(list)==6 %4 files plus . and .. at the beginning of the list (which is part of a structure, list.name)
    fprintf('Found 4 files in %s \n', start_path)
    fprintf('\n copying to %s \n', end_path)
    for i_file=3:length(list) %skips those . and ..
        in_file=[start_path list(i_file).name];
        out_file=[end_path list(i_file).name]; 
        copyfile(in_file,out_file)
    end   
elseif length(list)> 4
    fprintf('More than 4 boxy files found.  CHECK  %s \n', [start_path ])
else
    fprintf('Less than 4 boxy files found.  CHECK  %s \n', [start_path ])
end

%Check that files were transferred and then delete from Boxy machine
outlist=dir([end_path  '*.*']);

if length(outlist)==6 %4 files + .\..  %first check that all files were transferred
    for i_file=3:length(outlist)
        in_size=[list(i_file).bytes];   
        out_size=[outlist(i_file).bytes]; 
        if length(out_size)==length(in_size)  %now check that the file size is correct
            in_file=[start_path  list(i_file).name];
            filename=[list(i_file).name];
            delete(in_file)
            fprintf('File transfer successful - Deleting %s from G2 \n', filename)   
        else  fprintf('FILE TRANSFER FAILED.  CHECK  %s \n', [end_path mtg_dir])
        end
    end   
end

%% 3: G3mtg1
mtg_dir=dir3; 
list=list3;
start_path=[start_path3 mtg_dir];
end_path=[out_path mtg_dir];


if length(list)==6 %4 files plus . and .. at the beginning of the list (which is part of a structure, list.name)
    fprintf('Found 4 files in %s \n', start_path)
    fprintf('\n copying to %s \n', end_path)
    for i_file=3:length(list) %skips those . and ..
        in_file=[start_path list(i_file).name];
        out_file=[end_path list(i_file).name]; 
        copyfile(in_file,out_file)
    end   
elseif length(list)> 4
    fprintf('More than 4 boxy files found.  CHECK  %s \n', [start_path ])
else
    fprintf('Less than 4 boxy files found.  CHECK  %s \n', [start_path ])
end

%Check that files were transferred and then delete from Boxy machine
outlist=dir([end_path  '*.*']);

if length(outlist)==6 %4 files + .\..  %first check that all files were transferred
    for i_file=3:length(outlist)
        in_size=[list(i_file).bytes];   
        out_size=[outlist(i_file).bytes]; 
        if length(out_size)==length(in_size)  %now check that the file size is correct
            in_file=[start_path  list(i_file).name];
            filename=[list(i_file).name];
            delete(in_file)
            fprintf('File transfer successful - Deleting %s from G3 \n', filename)   
        else  fprintf('FILE TRANSFER FAILED.  CHECK  %s \n', [end_path ])
        end
    end   
end

%% 4: G1mtg2
mtg_dir=dir4; %can't use dir for variable name
list=list4;
start_path=[start_path1 mtg_dir];
end_path=[out_path mtg_dir];


if length(list)==6 %4 files plus . and .. at the beginning of the list (which is part of a structure, list.name)
    fprintf('Found 4 files in %s \n', start_path)
    fprintf('\n copying to %s \n', end_path)
    for i_file=3:length(list) %skips those . and ..
        in_file=[start_path list(i_file).name];
        out_file=[end_path list(i_file).name]; 
        copyfile(in_file,out_file)
    end   
elseif length(list)> 4
    fprintf('More than 4 boxy files found.  CHECK  %s \n', [start_path ])
else
    fprintf('Less than 4 boxy files found.  CHECK  %s \n', [start_path ])
end

%Check that files were transferred and then delete from Boxy machine
outlist=dir([end_path  '*.*']);

if length(outlist)==6 %4 files + .\..  %first check that all files were transferred
    for i_file=3:length(outlist)
        in_size=[list(i_file).bytes];   
        out_size=[outlist(i_file).bytes]; 
        if length(out_size)==length(in_size)  %now check that the file size is correct
            in_file=[start_path  list(i_file).name];
            filename=[list(i_file).name];
            delete(in_file)
            fprintf('File transfer successful - Deleting %s from G1 \n', filename)   
        else  fprintf('FILE TRANSFER FAILED.  CHECK  %s \n', [end_path ])
        end
    end   
end

%% 5: G2mtg2
mtg_dir=dir5; 
list=list5;
start_path=[start_path2 mtg_dir];
end_path=[out_path mtg_dir];

if length(list)==6 %4 files plus . and .. at the beginning of the list (which is part of a structure, list.name)
    fprintf('Found 4 files in %s \n', start_path)
    fprintf('\n copying to %s \n', end_path)
    for i_file=3:length(list) %skips those . and ..
        in_file=[start_path list(i_file).name];
        out_file=[end_path list(i_file).name]; 
        copyfile(in_file,out_file)
    end   
elseif length(list)> 4
    fprintf('More than 4 boxy files found.  CHECK  %s \n', [start_path ])
else
    fprintf('Less than 4 boxy files found.  CHECK  %s \n', [start_path ])
end

%Check that files were transferred and then delete from Boxy machine
outlist=dir([end_path  '*.*']);

if length(outlist)==6 %4 files + .\..  %first check that all files were transferred
    for i_file=3:length(outlist)
        in_size=[list(i_file).bytes];   
        out_size=[outlist(i_file).bytes]; 
        if length(out_size)==length(in_size)  %now check that the file size is correct
            in_file=[start_path  list(i_file).name];
            filename=[list(i_file).name];
            delete(in_file)
            fprintf('File transfer successful - Deleting %s from G2 \n', filename)   
        else  fprintf('FILE TRANSFER FAILED.  CHECK  %s \n', [end_path ])
        end
    end   
end

%% 6: G3mtg2
mtg_dir=dir6; 
list=list6;
start_path=[start_path3 mtg_dir];
end_path=[out_path mtg_dir];


if length(list)==6 %4 files plus . and .. at the beginning of the list (which is part of a structure, list.name)
    fprintf('Found 4 files in %s \n', start_path)
    fprintf('\n copying to %s \n', end_path)
    for i_file=3:length(list) %skips those . and ..
        in_file=[start_path list(i_file).name];
        out_file=[end_path list(i_file).name]; 
        copyfile(in_file,out_file)
    end   
elseif length(list)> 4
    fprintf('More than 4 boxy files found.  CHECK  %s \n', [start_path ])
else
    fprintf('Less than 4 boxy files found.  CHECK  %s \n', [start_path ])
end

%Check that files were transferred and then delete from Boxy machine
outlist=dir([end_path  '*.*']);

if length(outlist)==6 %4 files + .\..  %first check that all files were transferred
    for i_file=3:length(outlist)
        in_size=[list(i_file).bytes];   
        out_size=[outlist(i_file).bytes]; 
        if length(out_size)==length(in_size)  %now check that the file size is correct
            in_file=[start_path  list(i_file).name];
            filename=[list(i_file).name];
            delete(in_file)
            fprintf('File transfer successful - Deleting %s from G3 \n', filename)   
        else  fprintf('FILE TRANSFER FAILED.  CHECK  %s \n', [end_path ])
        end
    end   
end


%% Now rename and save to opt .001 files
disp('Renaming files on NAS1 and backing up to \\files2...')

% 1: G1mtg1
mtg_dir=dir1;

list=dir([out_path mtg_dir '*.txt']);

if length(list)==2
    if protocol==1 %CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expCO2(i_file,:) subj 'a.001'];  %oco 1st, rss 2nd      
            bu_file=[bu_path expCO2(i_file,:) subj 'a.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    else %no CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expNoCO2(i_file,:) subj 'a.001'];  %rsl 1st, rss 2nd      
            bu_file=[bu_path expNoCO2(i_file,:) subj 'a.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    end
else
    fprintf('Looking for 2 data blocks! Check %s on NAS1\n', mtg_dir)
end

setlist=dir([out_path mtg_dir '*.set']);
if length(setlist)>0
    if protocol==1 %CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expCO2(i_file,:) subj 'a.001.set'];
            bu_file=[bu_path 'setfiles\' expCO2(i_file,:) subj 'a.001.set'];    
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    else %no CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expNoCO2(i_file,:) subj 'a.001.set'];
            bu_file=[bu_path 'setfiles\' expNoCO2(i_file,:) subj 'a.001.set'];   
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    end
end

% 2: G2mtg1
mtg_dir=dir2;

list=dir([out_path mtg_dir '*.txt']);

if length(list)==2
    if protocol==1 %CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expCO2(i_file,:) subj 'b.001'];  %oco 1st, rss 2nd      
            bu_file=[bu_path expCO2(i_file,:) subj 'b.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    else %no CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expNoCO2(i_file,:) subj 'b.001'];  %rsl 1st, rss 2nd      
            bu_file=[bu_path expNoCO2(i_file,:) subj 'b.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    end
else
    fprintf('Looking for 2 data blocks! Check %s on NAS1\n', mtg_dir)
end

setlist=dir([out_path mtg_dir '*.set']);
if length(setlist)>0
    if protocol==1 %CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expCO2(i_file,:) subj 'b.001.set'];
            bu_file=[bu_path 'setfiles\' expCO2(i_file,:) subj 'b.001.set'];
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    else %no CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expNoCO2(i_file,:) subj 'b.001.set'];
            bu_file=[bu_path 'setfiles\' expNoCO2(i_file,:) subj 'b.001.set'];
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    end
end

% 3: G3mtg1
mtg_dir=dir3;

list=dir([out_path mtg_dir '*.txt']);

if length(list)==2
    if protocol==1 %CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expCO2(i_file,:) subj 'c.001'];  %oco 1st, rss 2nd      
            bu_file=[bu_path expCO2(i_file,:) subj 'c.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    else %no CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expNoCO2(i_file,:) subj 'c.001'];  %rsl 1st, rss 2nd      
            bu_file=[bu_path expNoCO2(i_file,:) subj 'c.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    end
else
    fprintf('Looking for 2 data blocks! Check %s on NAS1\n', mtg_dir)
end

setlist=dir([out_path mtg_dir '*.set']);
if length(setlist)>0
    if protocol==1 %CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expCO2(i_file,:) subj 'c.001.set'];
            bu_file=[bu_path 'setfiles\' expCO2(i_file,:) subj 'c.001.set'];   
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    else %no CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expNoCO2(i_file,:) subj 'c.001.set'];
            bu_file=[bu_path 'setfiles\' expNoCO2(i_file,:) subj 'c.001.set'];  
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    end
end

% 4: G1mtg2
mtg_dir=dir4;

list=dir([out_path mtg_dir '*.txt']);

if length(list)==2
    if protocol==1 %CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expCO2(i_file,:) subj 'd.001'];  %oco 1st, rss 2nd      
            bu_file=[bu_path expCO2(i_file,:) subj 'd.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    else %no CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expNoCO2(i_file,:) subj 'd.001'];  %rsl 1st, rss 2nd      
            bu_file=[bu_path expNoCO2(i_file,:) subj 'd.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    end
else
    fprintf('Looking for 2 data blocks! Check %s on NAS1\n', mtg_dir)
end

setlist=dir([out_path mtg_dir '*.set']);
if length(setlist)>0
    if protocol==1 %CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expCO2(i_file,:) subj 'd.001.set'];
            bu_file=[bu_path 'setfiles\' expCO2(i_file,:) subj 'd.001.set'];    
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    else %no CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expNoCO2(i_file,:) subj 'd.001.set'];
            bu_file=[bu_path 'setfiles\' expNoCO2(i_file,:) subj 'd.001.set'];  
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    end
end

% 5: G2mtg2
mtg_dir=dir5;

list=dir([out_path mtg_dir '*.txt']);

if length(list)==2
    if protocol==1 %CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expCO2(i_file,:) subj 'e.001'];  %oco 1st, rss 2nd      
            bu_file=[bu_path expCO2(i_file,:) subj 'e.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    else %no CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expNoCO2(i_file,:) subj 'e.001'];  %rsl 1st, rss 2nd      
            bu_file=[bu_path expNoCO2(i_file,:) subj 'e.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    end
else
    fprintf('Looking for 2 data blocks! Check %s on NAS1\n', mtg_dir)
end

setlist=dir([out_path mtg_dir '*.set']);
if length(setlist)>0
    if protocol==1 %CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expCO2(i_file,:) subj 'e.001.set'];
            bu_file=[bu_path 'setfiles\' expCO2(i_file,:) subj 'e.001.set'];  
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    else %no CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expNoCO2(i_file,:) subj 'e.001.set'];
            bu_file=[bu_path 'setfiles\' expNoCO2(i_file,:) subj 'e.001.set'];    
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    end
end

% 6: G3mtg2
mtg_dir=dir6;

list=dir([out_path mtg_dir '*.txt']);

if length(list)==2
    if protocol==1 %CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expCO2(i_file,:) subj 'f.001'];  %oco 1st, rss 2nd      
            bu_file=[bu_path expCO2(i_file,:) subj 'f.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    else %no CO2
        for i_file=1:length(list)
            
            in_file=[out_path mtg_dir list(i_file).name];
            out_file=[out_path expNoCO2(i_file,:) subj 'f.001'];  %rsl 1st, rss 2nd      
            bu_file=[bu_path expNoCO2(i_file,:) subj 'f.001'];    
            
            if exist([out_file])~=1          
                copyfile(in_file,out_file);    
                copyfile(in_file,bu_file);
                
            else disp('Opt files already exist!'); return
            end
        end
    end
else
    fprintf('Looking for 2 data blocks! Check %s on NAS1\n', mtg_dir)
end

setlist=dir([out_path mtg_dir '*.set']);
if length(setlist)>0
    if protocol==1 %CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expCO2(i_file,:) subj 'f.001.set'];
            bu_file=[bu_path 'setfiles\' expCO2(i_file,:) subj 'f.001.set'];  
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    else %no CO2
        for i_file=1:length(setlist)
            in_file=[out_path mtg_dir setlist(i_file).name];
            out_file=[out_path 'setfiles\' expNoCO2(i_file,:) subj 'f.001.set'];
            bu_file=[bu_path 'setfiles\' expNoCO2(i_file,:) subj 'f.001.set'];   
            copyfile(in_file,out_file);
            copyfile(in_file,bu_file);
        end
    end
end
% -------------------------------------

%% copy .mtg files
disp(' ')
disp('Copying 6 column .mtg files')

mtg_infile_path=[mtg_path 'mtg_file_masters\'];
mtg_outfile_path=[mtg_path];

switch helmet
    case 'brown'
        infile=[mtg_infile_path 'pea_brown.mtg'];
        outfile=[mtg_outfile_path exp subj '_' session '.mtg'];
        
        fprintf('Copying %s to %s\n',infile,outfile)
        copyfile(infile,outfile);
                
    case 'green'
        infile=[mtg_infile_path 'pea_green.mtg'];
        outfile=[mtg_outfile_path exp subj '_' session '.mtg'];
        
        fprintf('Copying %s to %s\n',infile,outfile)
        copyfile(infile,outfile);

    case 'blue'
        infile=[mtg_infile_path 'pea_blue.mtg'];
        outfile=[mtg_outfile_path exp subj '_' session '.mtg'];
        
        fprintf('Copying %s to %s\n',infile,outfile)
        copyfile(infile,outfile);
end
% 
%% Copy EKG files
 
list=dir([start_path_ekg '*.*']);

    for i_file=3:length(list)
        in_file=[start_path_ekg list(i_file).name];
        out_file=[end_path_ekg list(i_file).name];
        bu_file=[bu_path_ekg list(i_file).name];
         fprintf('Copying %s to %s\n \n',in_file,out_file)
         
        if exist([out_file])~=1
            
        copyfile(in_file,out_file);
        copyfile(in_file,bu_file);
        
        else fprintf('EKG file %s already exists! \n', in_file); 
        end
    end   

disp('Done with transfer');
disp('1. Please check renamed opt (.001)files on NAS1 and then delete unrenamed data in subfolders (e.g., G1mtg1)'); 
disp('2. Please check that .eeg, .amrk, and .ahdr files (12 tot) are on NAS1 and delete from EEG1');

% 