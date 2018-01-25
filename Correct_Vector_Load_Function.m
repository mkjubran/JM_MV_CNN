function [FNames, Classified]=Correct_Vector_Load_Function(filename_Filename,filename_Classifier)


%% Load file contents ...
fid1 = fopen(filename_Filename,'r') ;
fid2 = fopen(filename_Classifier,'r') ;
cnt=1;
tline1 = fgetl(fid1);
tline2 = fgetl(fid2);
FNames=tline1;
Classified=double(tline2)-48;
while ( ischar(tline1) & ischar(tline2) )
    tline1 = fgetl(fid1);
    tline2 = fgetl(fid2);
    FNames_temp=tline1;
    while length(FNames_temp)>size(FNames,2)
        L=size(FNames,1);
        for i=1:L
         A(i,:)=blanks(length(FNames_temp)-size(FNames,2));
        end
        FNames=[FNames A]; 
    end
    FNames(cnt,1:length(FNames_temp))=FNames_temp;
    Classified(cnt)=double(tline2)-48;
    cnt=cnt+1;
end
FNames=FNames(1:(size(FNames)-1),:);
Classified=Classified(1:(end-1))';
fclose(fid1);
fclose(fid2);
