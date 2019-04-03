clear all;
clc;

% 在弹出窗口中选择需要转换的文件
[FileName,PathName] = uigetfile('*','Select the Txt files');
fid1 = fopen([PathName FileName]);
if fid1 == -1
    ('Error opening the file');
end

% 获取文件的总行数
count = 0;
tline = fgetl(fid1);
while ischar(tline)
    %disp(tline)
    tline = fgetl(fid1);
    count = count + 1;
end

% 重定位到文件头，读取每一行，存入元胞数组s
frewind(fid1);
n = 1;
s = cell(count,1);
while 1
    nextline = fgetl(fid1);
    if ~ischar(nextline)
        break;
    end
    %disp(nextline);
    s{n} = sscanf(nextline,'%[^!]');
    %fprintf('%s\n',s{n});
    n = n + 1;
end
fclose(fid1);

% 将符合条件的对应行存入元胞数组S，并转换成矩阵M
i = 1;
%S = cell(i,1);
for n = 1:count-1
    if s{n,1}(6) ~= s{n+1,1}(6)
        S{i,1} = s{n,1};
        i = i + 1;
    else
        continue
    end
end
S{i,1} = s{count,1};
M = cell2mat(S);

% 将结果写入'*_filtered.txt'文件输出在与原文件相同的目录下
name = regexp(FileName,'\.','split');
OutputFileName = strcat(char(name(1)),'_filtered.txt');
fid2 = fopen([PathName OutputFileName],'w');
[row,column] = size(M);
for j = 1:row
    fprintf(fid2,'%s\n',M(j,:));
end
fclose(fid2);

fprintf(1,'Completed!\nFile:\n%s\nhas been created in path:\n%s.',OutputFileName,PathName);
t=array2table(M)