clear;clc

%������ȡ�ļ�
file1 = dir('F:\����ʡ����ͼ��\���\Years');
filedata = [];
for n = 3 : length(file1)-2
    temp = dir(['F:\����ʡ����ͼ��\���\Years\',file1(n).name]);
    filedata = [filedata;temp];
end

for i = 1 : length(filedata)
    if filedata(i).name(1) == '.'
        filedata(i,:) = [];
    end
    if i == length(filedata)
        break
    end
end

for i = 1 : length(filedata)
    if filedata(i).name(1) == '..'
        filedata(i,:) = [];
    end
    if i == length(filedata)
        break
    end
end

%------15cm���£�nyyzz=11108��-----------
c = 1; c3 = 1;
for i = 1 : length(filedata)
    if str2num(filedata(i).name(2:6)) == 11113
        fid1 = fopen([filedata(i).folder,'\',filedata(i).name],'rb');
        %---------��ȡ������--------
        a(1,c) = fread(fid1,1,'uint32');%̨վ��վ��4�ֽ�Longint��
        a(2,c) = fread(fid1,1,'uint32');%�ļ�˵���е�xnyyzz����4�ֽ�Longint��
        %---------��ȡ������----------
        r = 3;
        for ii = 1:150
            a(r,c) = fread(fid1,1,'uint32');
            a(r,c+1) = fread(fid1,1,'uint32');
            a(r,c+2) = fread(fid1,1,'uint16');
            r = r + 1;
        end
        c = c + 3;
        %---------��ȡ���ݼ�¼��--------
        for mm = 1:152
            if a(mm,c-3)==0
                break
            end
        end
        rr = 1;
        for j = 1 : (mm-3)*30
            b(rr,c3) = fread(fid1,1,'uint8');
            if mod(b(rr,c3),10) == 4
                b(rr,c3+1) = fread(fid1,1,'uint32');
            elseif b(rr,c3) == 242
                b(rr,c3) = fread(fid1,1,'uint16');
                b(rr,c3) = NaN;
            elseif mod(b(rr,c3),10) == 2
                b(rr,c3+1) = fread(fid1,1,'uint16');
            elseif b(rr,c3) == 0
                break
            end
            rr = rr + 1;
        end
        c3 = c3 + 2;
        fclose(fid1);
    end
end

%-------д����txt-------
fid = fopen('F:\����ʡ����ͼ��\������\a320cm���£�nyyzz=11113��.txt','w');
[mmm,nnn]=size(a);
for i=1:1:mmm
    for j=1:1:nnn
        if j==nnn
            fprintf(fid,'%f\n',a(i,j));
        else
            fprintf(fid,'%f\t',a(i,j));
        end
    end
end
fclose(fid);

fid = fopen('F:\����ʡ����ͼ��\������\b320cm���£�nyyzz=11113��.txt','w');
[mmm,nnn]=size(b);
for i=1:1:mmm
    for j=1:1:nnn
        if j==nnn
            fprintf(fid,'%f\n',b(i,j));
        else
            fprintf(fid,'%f\t',b(i,j));
        end
    end
end
fclose(fid);


% %--------���㣨��С���㣩--------
% c = 1;n = 1;
% for c = 1 : 3 : 258
%     for r = 1 : 150
%         if a(r,c) == 0
%             break
%         elseif r == 1
%             data(1,n) = a(r,c);
%         elseif r == 2
%             data(2,n) = a(r,c);
%             m = 3;
%         else
%             data(r,n) = a(r,c);
%         end
%     end
%     n = n + 14;
% end
% 
% 
% 
% 
% %--------���ӻ�����--------
% for i = 1:858
%     for j = 1:2:172
%         if b(i,j) == 12
%             bb(i,(j+1)/2) = b(i,j+1)*0.1;
%         elseif b(i,j) == 242
%             bb(i,(j+1)/2) = NaN;
%         end
%     end
% end
% 
% m = 1;
% for i = 1:3:258
%     for j = 1:152
%         data(j,m) = a(j,i);
%     end
%     m = m + 14;
% end
% 
% for i = 1 : 86
%     h = 3;lie = 14*(i-1)+2;
%     for j = 1 : 858
%         data(h,lie) = bb(j,i);
%         if lie == 14*(i)
%             h = h + 1;
%             lie = 14*(i-1)+2;
%         else
%             lie = lie + 1;
%         end
%     end
% end